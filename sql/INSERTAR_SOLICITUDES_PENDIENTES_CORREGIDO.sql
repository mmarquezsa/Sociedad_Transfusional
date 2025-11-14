-- ============================================
-- INSERTAR SOLICITUDES PENDIENTES - VERSIÓN CORREGIDA
-- ============================================

-- ⚠️ IMPORTANTE: tipo_membresia debe ser: 'regular', 'estudiante', 'honorario', 'vitalicio'
-- El estado 'pendiente' solo va en el campo 'estado', NO en 'tipo_membresia'

-- ============================================
-- SOLICITUD #1: Juan Pérez (Tecnólogo Médico)
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
  tipo_membresia,  -- 👈 USAR: 'regular', 'estudiante', etc.
  estado,          -- 👈 AQUÍ sí va 'pendiente'
  fecha_postulacion,
  recibir_newsletter
) VALUES (
  gen_random_uuid(),
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
  'regular',     -- 👈 TIPO: regular, estudiante, honorario, vitalicio
  'pendiente',   -- 👈 ESTADO: pendiente, activo, suspendido, inactivo
  CURRENT_DATE,
  true
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
  0,
  'Hospital Carlos Van Buren',
  'Estudiante en Práctica',
  'B',
  'estudiante',  -- 👈 Tipo estudiante
  'pendiente',
  CURRENT_DATE - INTERVAL '1 day',
  true
);

-- ============================================
-- SOLICITUD #3: Dr. Carlos Rodríguez
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
  'regular',
  'pendiente',
  CURRENT_DATE - INTERVAL '2 days',
  true
);

-- ============================================
-- VERIFICAR QUE SE INSERTARON
-- ============================================

SELECT 
  id,
  nombre_completo,
  email,
  rut,
  profesion,
  tipo_membresia,  -- regular, estudiante, etc.
  estado,          -- pendiente
  fecha_postulacion,
  created_at
FROM public.socios
WHERE estado = 'pendiente'
ORDER BY created_at DESC;

-- ============================================
-- RESUMEN DE VALORES PERMITIDOS
-- ============================================

/*
CAMPO: tipo_membresia
✅ Valores permitidos:
  - 'regular'    : Miembro regular
  - 'estudiante' : Estudiante
  - 'honorario'  : Miembro honorario
  - 'vitalicio'  : Miembro vitalicio

CAMPO: estado
✅ Valores permitidos:
  - 'pendiente'  : Solicitud pendiente de aprobación
  - 'activo'     : Membresía activa
  - 'suspendido' : Membresía suspendida
  - 'inactivo'   : Membresía inactiva

❌ NO USAR 'pendiente' en tipo_membresia
✅ USAR 'pendiente' solo en estado
*/
