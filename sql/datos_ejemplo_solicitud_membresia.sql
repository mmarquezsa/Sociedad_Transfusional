-- ============================================
-- DATOS DE EJEMPLO: SOLICITUD DE MEMBRESÍA
-- Para probar el flujo de aprobación de nuevos miembros
-- ============================================

-- IMPORTANTE: Este script crea un usuario de ejemplo en estado 'pendiente'
-- que puede ser aprobado por un administrador cambiando el estado a 'activo'

-- ============================================
-- PASO 1: Crear usuario en auth.users (MANUAL)
-- ============================================
-- NOTA: Este paso debe hacerse desde la UI de Supabase Auth
-- o usando la función signup de Supabase
-- Email: juan.perez.test@gmail.com
-- Password: [definir temporalmente en la UI]
-- 
-- Una vez creado, obtener el UUID del usuario desde:
-- Authentication > Users > copiar el ID del usuario

-- ============================================
-- PASO 2: Insertar datos del socio con estado PENDIENTE
-- ============================================

-- OPCIÓN A: Si ya tienes el UUID del usuario de auth.users
-- Reemplaza 'USUARIO_UUID_AQUI' con el UUID real del usuario creado

INSERT INTO socios (
  id,
  email,
  nombre_completo,
  rut,
  especialidad,
  ciudad,
  telefono,
  estado,
  tipo_membresia,
  fecha_ingreso,
  fecha_vencimiento,
  recibir_newsletter,
  categorias_interes,
  created_at,
  updated_at
) VALUES (
  'USUARIO_UUID_AQUI'::UUID, -- Reemplazar con UUID real
  'juan.perez.test@gmail.com',
  'Juan Alberto Pérez González',
  '12.345.678-9',
  'Tecnólogo Médico - Medicina Transfusional',
  'Santiago',
  '+56 9 8765 4321',
  'pendiente', -- Estado inicial: PENDIENTE de aprobación
  'regular',
  CURRENT_DATE,
  CURRENT_DATE + INTERVAL '1 year',
  true,
  ARRAY['Inmunohematología', 'Selección de Donantes', 'Medicina Transfusional'],
  NOW(),
  NOW()
);

-- ============================================
-- MÁS EJEMPLOS DE SOLICITUDES PENDIENTES
-- ============================================

-- Ejemplo 2: Estudiante
INSERT INTO socios (
  id,
  email,
  nombre_completo,
  rut,
  especialidad,
  ciudad,
  telefono,
  estado,
  tipo_membresia,
  fecha_ingreso,
  fecha_vencimiento,
  recibir_newsletter,
  categorias_interes
) VALUES (
  'USUARIO_UUID_ESTUDIANTE'::UUID, -- Reemplazar con UUID real
  'maria.silva.estudiante@gmail.com',
  'María Fernanda Silva Rojas',
  '23.456.789-0',
  'Estudiante de Tecnología Médica',
  'Valparaíso',
  '+56 9 7654 3210',
  'pendiente',
  'estudiante',
  CURRENT_DATE,
  CURRENT_DATE + INTERVAL '6 months',
  true,
  ARRAY['Banco de Sangre', 'Hemoterapia']
);

-- Ejemplo 3: Profesional con experiencia
INSERT INTO socios (
  id,
  email,
  nombre_completo,
  rut,
  especialidad,
  ciudad,
  telefono,
  estado,
  tipo_membresia,
  fecha_ingreso,
  fecha_vencimiento,
  recibir_newsletter,
  categorias_interes
) VALUES (
  'USUARIO_UUID_PROFESIONAL'::UUID, -- Reemplazar con UUID real
  'carlos.rodriguez.tm@gmail.com',
  'Carlos Eduardo Rodríguez Muñoz',
  '34.567.890-1',
  'Tecnólogo Médico - Inmunohematología',
  'Concepción',
  '+56 9 6543 2109',
  'pendiente',
  'regular',
  CURRENT_DATE,
  CURRENT_DATE + INTERVAL '1 year',
  true,
  ARRAY['Inmunohematología', 'Terapia Celular', 'Aféresis']
);

-- ============================================
-- CONSULTAS ÚTILES PARA ADMINISTRADORES
-- ============================================

-- Ver todas las solicitudes pendientes
SELECT 
  id,
  nombre_completo,
  email,
  rut,
  especialidad,
  ciudad,
  tipo_membresia,
  fecha_ingreso,
  created_at
FROM socios
WHERE estado = 'pendiente'
ORDER BY created_at DESC;

-- ============================================
-- APROBAR UNA SOLICITUD (Acción del Administrador)
-- ============================================

-- Para aprobar, cambiar el estado de 'pendiente' a 'activo'
-- Reemplazar 'USUARIO_UUID_AQUI' con el UUID del socio a aprobar

UPDATE socios 
SET 
  estado = 'activo',
  updated_at = NOW()
WHERE id = 'USUARIO_UUID_AQUI'::UUID
  AND estado = 'pendiente';

-- ============================================
-- RECHAZAR UNA SOLICITUD (Opcional)
-- ============================================

UPDATE socios 
SET 
  estado = 'inactivo',
  updated_at = NOW()
WHERE id = 'USUARIO_UUID_AQUI'::UUID
  AND estado = 'pendiente';

-- ============================================
-- AGREGAR AL LISTADO PÚBLICO DE MIEMBROS
-- ============================================

-- Después de aprobar, opcionalmente agregar a la tabla 'miembros'
-- para que aparezca en la sección pública de la web

INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
)
SELECT 
  nombre_completo,
  especialidad,
  'Miembro activo de SOCHIMT especializado en ' || especialidad,
  fecha_ingreso,
  ciudad,
  'sochimt'
FROM socios
WHERE id = 'USUARIO_UUID_AQUI'::UUID
  AND estado = 'activo';

-- ============================================
-- ESTADÍSTICAS DE SOLICITUDES
-- ============================================

SELECT 
  estado,
  tipo_membresia,
  COUNT(*) as total
FROM socios
GROUP BY estado, tipo_membresia
ORDER BY estado, tipo_membresia;

-- ============================================
-- VER PERFIL COMPLETO DE UN SOCIO
-- ============================================

SELECT 
  s.*,
  -- Contar inscripciones a eventos
  (SELECT COUNT(*) FROM inscripciones WHERE socio_id = s.id) as total_eventos,
  -- Contar conversaciones con Gotita
  (SELECT COUNT(*) FROM conversaciones_gotita WHERE socio_id = s.id) as consultas_gotita,
  -- Contar certificaciones
  (SELECT COUNT(*) FROM certificaciones WHERE socio_id = s.id) as total_certificaciones
FROM socios s
WHERE s.id = 'USUARIO_UUID_AQUI'::UUID;

-- ============================================
-- NOTAS IMPORTANTES PARA EL FLUJO COMPLETO
-- ============================================

/*
FLUJO COMPLETO DE APROBACIÓN:

1. Usuario se registra en registro-socios.html
   - Se crea automáticamente en auth.users (Supabase Auth)
   - Se inserta en tabla 'socios' con estado='pendiente'

2. Administrador revisa solicitudes pendientes:
   SELECT * FROM socios WHERE estado = 'pendiente';

3. Administrador APRUEBA la solicitud:
   UPDATE socios SET estado = 'activo' WHERE id = '...';

4. (Opcional) Agregar a listado público de miembros:
   INSERT INTO miembros SELECT ... FROM socios WHERE id = '...';

5. Usuario puede ahora:
   - Iniciar sesión en login-socios.html
   - Acceder al área de socios
   - Ver contenido premium
   - Inscribirse a eventos
   - Usar Gotita IA
   - Descargar recursos exclusivos

PARA TESTING SIN CREAR USUARIOS EN AUTH:
Si quieres probar solo con datos de ejemplo sin autenticación,
puedes insertar directamente en la tabla 'miembros' (no requiere auth):

INSERT INTO miembros (nombre, especialidad, descripcion, fecha_ingreso, ciudad, color_avatar) 
VALUES (
  'Juan Pérez (TEST)',
  'Tecnólogo Médico',
  'Miembro de prueba para testing',
  CURRENT_DATE,
  'Santiago',
  'sochimt'
);
*/
