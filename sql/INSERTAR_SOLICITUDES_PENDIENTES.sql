-- ============================================
-- INSERTAR SOLICITUDES PENDIENTES EN TABLA SOCIOS
-- Para probar el sistema de aprobación desde dashboard
-- ============================================

-- IMPORTANTE: Estas solicitudes NO requieren crear usuarios en Auth primero
-- porque están en estado 'pendiente'
-- Una vez aprobadas, se debe crear el usuario en Authentication

-- ============================================
-- SOLICITUD #1: Juan Pérez (Tecnólogo Médico)
-- ============================================

INSERT INTO public.socios (
  id,  -- Usamos un UUID temporal
  nombre_completo,
  rut,
  fecha_nacimiento,
  sexo,
  email,
  telefono,
  profesion,
  universidad,
  registro_sis,
  anos_experiencia,
  institucion,
  cargo,
  categoria,
  tipo_membresia,
  estado,  -- 👈 PENDIENTE
  fecha_postulacion,
  recibir_newsletter,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),  -- Genera UUID automático
  'Juan Alberto Pérez González',
  '12.345.678-9',
  '1985-06-15',
  'Masculino',
  'juan.perez.test@gmail.com',
  '+56 9 8765 4321',
  'Tecnólogo Médico',
  'Universidad de Chile',
  'TM-54321',
  8,
  'Hospital San Juan de Dios',
  'Tecnólogo Médico Banco de Sangre',
  'A',
  'pendiente',  -- 👈 ESTADO: PENDIENTE
  'pendiente',  -- 👈 TIPO: PENDIENTE
  CURRENT_DATE,
  true,
  NOW(),
  NOW()
);

-- ============================================
-- SOLICITUD #2: María Silva (Estudiante)
-- ============================================

INSERT INTO public.socios (
  id,
  nombre_completo,
  rut,
  fecha_nacimiento,
  sexo,
  email,
  telefono,
  profesion,
  universidad,
  registro_sis,
  anos_experiencia,
  institucion,
  cargo,
  categoria,
  tipo_membresia,
  estado,
  fecha_postulacion,
  recibir_newsletter
) VALUES (
  gen_random_uuid(),
  'María Fernanda Silva Rojas',
  '23.456.789-0',
  '1998-03-22',
  'Femenino',
  'maria.silva.estudiante@gmail.com',
  '+56 9 7654 3210',
  'Estudiante de Tecnología Médica',
  'Universidad de Valparaíso',
  NULL,
  0,
  'Hospital Carlos Van Buren',
  'Estudiante en Práctica',
  'B',
  'pendiente',
  'pendiente',
  CURRENT_DATE - INTERVAL '1 day',  -- Postulación de ayer
  true
);

-- ============================================
-- SOLICITUD #3: Carlos Rodríguez (Profesional con experiencia)
-- ============================================

INSERT INTO public.socios (
  id,
  nombre_completo,
  rut,
  fecha_nacimiento,
  sexo,
  email,
  telefono,
  profesion,
  universidad,
  registro_sis,
  anos_experiencia,
  institucion,
  cargo,
  categoria,
  tipo_membresia,
  estado,
  fecha_postulacion,
  recibir_newsletter
) VALUES (
  gen_random_uuid(),
  'Dr. Carlos Eduardo Rodríguez Muñoz',
  '34.567.890-1',
  '1980-11-08',
  'Masculino',
  'carlos.rodriguez.tm@gmail.com',
  '+56 9 6543 2109',
  'Médico Hematólogo',
  'Universidad de Concepción',
  'MED-98765',
  12,
  'Hospital Regional de Concepción',
  'Jefe Servicio Hemoterapia',
  'A',
  'pendiente',
  'pendiente',
  CURRENT_DATE - INTERVAL '2 days',  -- Postulación hace 2 días
  true
);

-- ============================================
-- VERIFICAR SOLICITUDES PENDIENTES
-- ============================================

-- Ver todas las solicitudes pendientes
SELECT 
  id,
  nombre_completo,
  email,
  rut,
  profesion,
  institucion,
  estado,
  tipo_membresia,
  fecha_postulacion,
  created_at,
  DATE_PART('day', NOW() - created_at) as dias_desde_postulacion
FROM public.socios
WHERE estado = 'pendiente'
ORDER BY created_at DESC;

-- ============================================
-- CONTAR SOLICITUDES POR ESTADO
-- ============================================

SELECT 
  estado,
  COUNT(*) as total,
  STRING_AGG(nombre_completo, ', ') as nombres
FROM public.socios
GROUP BY estado
ORDER BY 
  CASE estado
    WHEN 'pendiente' THEN 1
    WHEN 'activo' THEN 2
    WHEN 'suspendido' THEN 3
    WHEN 'inactivo' THEN 4
  END;

-- ============================================
-- APROBAR UNA SOLICITUD (Ejemplo)
-- ============================================

-- Para aprobar desde el SQL Editor:
/*
UPDATE public.socios 
SET 
  estado = 'activo',
  tipo_membresia = 'activo',
  fecha_aprobacion = CURRENT_DATE,
  fecha_vencimiento = CURRENT_DATE + INTERVAL '1 year',
  updated_at = NOW()
WHERE email = 'juan.perez.test@gmail.com'
  AND estado = 'pendiente';
*/

-- ============================================
-- RECHAZAR UNA SOLICITUD (Ejemplo)
-- ============================================

/*
UPDATE public.socios 
SET 
  estado = 'rechazado',
  updated_at = NOW()
WHERE email = 'juan.perez.test@gmail.com'
  AND estado = 'pendiente';
*/

-- ============================================
-- ELIMINAR SOLICITUDES DE PRUEBA
-- ============================================

-- Si necesitas limpiar las solicitudes de prueba:
/*
DELETE FROM public.socios 
WHERE email IN (
  'juan.perez.test@gmail.com',
  'maria.silva.estudiante@gmail.com',
  'carlos.rodriguez.tm@gmail.com'
);
*/

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
📌 FLUJO CORRECTO:

1. Usuario completa formulario en registro-socios.html
2. Se crea registro en tabla 'socios' con estado='pendiente'
3. Administrador ve solicitudes en dashboard-socios.html
4. Administrador APRUEBA o RECHAZA
5. Si aprueba:
   - estado cambia a 'activo'
   - Se envía email de bienvenida
   - Se crean credenciales de acceso
6. Usuario puede hacer login en login-socios.html

🔍 PARA VER EN TU DASHBOARD:

1. Ejecuta este script en Supabase SQL Editor
2. Ve a tu dashboard: dashboard-socios.html
3. Inicia sesión con: marcelo@sochimt.cl
4. Deberías ver el Panel de Administración
5. Click en "Gestionar Socios" (si existe)
6. Verás las 3 solicitudes pendientes

⚠️ IMPORTANTE:

- Estos registros NO tienen usuario en Authentication
- Solo existen en la tabla 'socios'
- Después de aprobar, debes crear el usuario en Auth
- O implementar un sistema que lo haga automáticamente

🎯 PRÓXIMO PASO:

Necesitas crear la interfaz en dashboard-socios.html
que muestre y gestione estas solicitudes pendientes.
*/
