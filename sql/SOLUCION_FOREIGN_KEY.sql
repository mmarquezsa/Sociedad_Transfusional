-- ============================================
-- SOLUCIÓN AL ERROR DE FOREIGN KEY
-- ============================================

-- El problema: La tabla socios tiene un FK constraint que requiere
-- que el ID exista en auth.users primero

-- ============================================
-- OPCIÓN A: Hacer el campo 'id' NULLABLE
-- ============================================

-- Paso 1: Eliminar el constraint de FK existente
ALTER TABLE public.socios 
DROP CONSTRAINT IF EXISTS socios_id_fkey;

-- Paso 2: Hacer que el campo ID sea nullable
ALTER TABLE public.socios 
ALTER COLUMN id DROP NOT NULL;

-- Paso 3: Cambiar el tipo de ID a permitir NULL o UUID generado
-- (Ya debería ser UUID, solo aseguramos que puede ser NULL)

-- Ahora podemos insertar solicitudes SIN crear usuario en Auth primero
-- ============================================

-- INSERTAR SOLICITUDES PENDIENTES (sin FK constraint)

INSERT INTO public.socios (
  nombre_completo,
  rut,
  fecha_nacimiento,
  sexo,
  email,
  telefono,
  profesion,
  universidad,
  anos_experiencia,
  institucion,
  cargo,
  categoria,
  tipo_membresia,
  estado,
  fecha_postulacion,
  recibir_newsletter
) VALUES 
('Juan Alberto Pérez González', '12.345.678-9', 
 '1985-06-15', 'Masculino', 'juan.perez.test@gmail.com', '+56 9 8765 4321',
 'Tecnólogo Médico', 'Universidad de Chile', 8, 'Hospital San Juan de Dios',
 'Tecnólogo Médico Banco de Sangre', 'A', 'regular', 'pendiente', CURRENT_DATE, true),

('María Fernanda Silva Rojas', '23.456.789-0',
 '1998-03-22', 'Femenino', 'maria.silva.estudiante@gmail.com', '+56 9 7654 3210',
 'Estudiante TM', 'Universidad de Valparaíso', 0, 'Hospital Van Buren',
 'Estudiante en Práctica', 'B', 'estudiante', 'pendiente', CURRENT_DATE - INTERVAL '1 day', true),

('Dr. Carlos Eduardo Rodríguez', '34.567.890-1',
 '1980-11-08', 'Masculino', 'carlos.rodriguez@gmail.com', '+56 9 6543 2109',
 'Médico Hematólogo', 'U. Concepción', 12, 'Hospital Regional',
 'Jefe Hemoterapia', 'A', 'regular', 'pendiente', CURRENT_DATE - INTERVAL '2 days', true);

-- Verificar
SELECT * FROM public.socios WHERE estado = 'pendiente';

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
Con esta solución:
✅ Puedes insertar solicitudes sin crear usuario en Auth
✅ El campo 'id' quedará NULL para solicitudes pendientes
✅ Cuando apruebes, debes crear el usuario en Auth y actualizar el ID

Flujo:
1. Usuario postula → Se inserta con id=NULL, estado='pendiente'
2. Admin aprueba → Crea usuario en Auth → Actualiza el id
3. Usuario hace login → Usa las credenciales creadas

ALTERNATIVA:
Si prefieres mantener el FK constraint, tendrías que:
1. Crear primero el usuario en Authentication
2. Copiar su UUID
3. Insertar en socios con ese UUID
*/

-- ============================================
-- RESTAURAR EL FK CONSTRAINT (OPCIONAL)
-- ============================================

-- Si después quieres restaurar la relación:
/*
ALTER TABLE public.socios 
ADD CONSTRAINT socios_id_fkey 
FOREIGN KEY (id) 
REFERENCES auth.users(id) 
ON DELETE CASCADE;
*/
