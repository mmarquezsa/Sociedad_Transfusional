-- ========================================
-- CREAR USUARIO DE PRUEBA: Marcelo
-- ========================================
-- Usuario: marcelo@sochimt.cl
-- Contraseña: marcelo
-- ========================================

-- PASO 1: Crear usuario en Supabase Auth
-- NOTA: Este paso debe hacerse desde el Dashboard de Supabase en:
-- Authentication → Users → Add user
-- Email: marcelo@sochimt.cl
-- Password: marcelo
-- Email confirm: YES (marcar como confirmado)

-- Después de crear el usuario en Auth, obtén su UUID y reemplázalo abajo

-- ========================================
-- PASO 2: Insertar datos en tabla socios
-- ========================================

INSERT INTO public.socios (
  id,                           -- UUID del usuario creado en Auth
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
  fecha_aprobacion,
  fecha_vencimiento,
  recibir_newsletter,
  created_at,
  updated_at
) VALUES (
  'REEMPLAZAR_CON_UUID_DE_AUTH',  -- ⚠️ IMPORTANTE: Reemplazar con el UUID del usuario
  'Marcelo Márquez Salinas',
  '12.345.678-9',
  '1985-03-15',
  'Masculino',
  'marcelo@sochimt.cl',
  '+56 9 1234 5678',
  'Tecnólogo Médico',
  'Universidad de Chile',
  'TM-12345',
  15,
  'Hospital Clínico Universidad de Chile',
  'Jefe Banco de Sangre',
  'A',
  'activo',
  'activo',                       -- Estado activo para poder acceder
  '2025-01-01',
  '2025-01-02',
  '2026-01-01',                   -- Válido por 1 año
  true,
  NOW(),
  NOW()
);

-- ========================================
-- PASO 3: Verificar que el usuario fue creado
-- ========================================

SELECT 
  id,
  nombre_completo,
  email,
  estado,
  tipo_membresia,
  fecha_vencimiento
FROM public.socios 
WHERE email = 'marcelo@sochimt.cl';

-- ========================================
-- OPCIONAL: Agregar estadísticas de ejemplo
-- ========================================

-- Nota: Estas tablas deben existir primero
-- Si no existen, crear las tablas necesarias:

-- Tabla para conversaciones con Gotita
CREATE TABLE IF NOT EXISTS public.conversaciones_gotita (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  socio_id UUID REFERENCES public.socios(id) ON DELETE CASCADE,
  pregunta TEXT NOT NULL,
  respuesta TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla para inscripciones a eventos
CREATE TABLE IF NOT EXISTS public.inscripciones (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  socio_id UUID REFERENCES public.socios(id) ON DELETE CASCADE,
  evento_id UUID,
  fecha_inscripcion TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  estado VARCHAR(50) DEFAULT 'confirmada'
);

-- Tabla para certificaciones
CREATE TABLE IF NOT EXISTS public.certificaciones (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  socio_id UUID REFERENCES public.socios(id) ON DELETE CASCADE,
  nombre_certificacion VARCHAR(255) NOT NULL,
  fecha_emision DATE NOT NULL,
  codigo_verificacion VARCHAR(100) UNIQUE,
  creditos_cme INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- INSTRUCCIONES DE USO
-- ========================================

/*
PASO A PASO PARA CREAR EL USUARIO:

1. Ve al Dashboard de Supabase:
   https://supabase.com/dashboard/project/dkohwhosputnxismgkon

2. Navega a: Authentication → Users

3. Click en "Add user" (manual)

4. Completa:
   - Email: marcelo@sochimt.cl
   - Password: marcelo
   - Auto Confirm User: ✅ (marcar)

5. Click en "Create user"

6. Copia el UUID del usuario creado (aparece en la columna ID)

7. Ve a: Table Editor → socios

8. Click en "Insert" → "Insert row"
   O ejecuta este SQL reemplazando el UUID:

   INSERT INTO public.socios (
     id,
     nombre_completo,
     rut,
     email,
     estado,
     tipo_membresia
   ) VALUES (
     'UUID_AQUI',
     'Marcelo Márquez Salinas',
     '12.345.678-9',
     'marcelo@sochimt.cl',
     'activo',
     'activo'
   );

9. Listo! Ya puedes iniciar sesión con:
   - Usuario: marcelo@sochimt.cl
   - Contraseña: marcelo

*/

-- ========================================
-- MÉTODO ALTERNATIVO: Script SQL Completo
-- ========================================

-- Si tienes acceso al SQL Editor en Supabase, ejecuta esto:

DO $$
DECLARE
  nuevo_user_id UUID;
BEGIN
  -- Genera un nuevo UUID
  nuevo_user_id := gen_random_uuid();
  
  -- Inserta en tabla socios
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
    fecha_aprobacion,
    fecha_vencimiento,
    recibir_newsletter
  ) VALUES (
    nuevo_user_id,
    'Marcelo Márquez Salinas',
    '12.345.678-9',
    '1985-03-15',
    'Masculino',
    'marcelo@sochimt.cl',
    '+56 9 1234 5678',
    'Tecnólogo Médico',
    'Universidad de Chile',
    'TM-12345',
    15,
    'Hospital Clínico Universidad de Chile',
    'Jefe Banco de Sangre',
    'A',
    'activo',
    'activo',
    '2025-01-01',
    '2025-01-02',
    '2026-01-01',
    true
  );
  
  RAISE NOTICE 'Usuario creado con ID: %', nuevo_user_id;
  RAISE NOTICE 'IMPORTANTE: Ahora debes crear el usuario en Auth con este mismo UUID';
END $$;

-- ========================================
-- VERIFICACIÓN FINAL
-- ========================================

-- Ejecuta esto para verificar que todo está correcto:
SELECT 
  s.id,
  s.nombre_completo,
  s.email,
  s.estado,
  s.tipo_membresia,
  s.fecha_vencimiento,
  CASE 
    WHEN s.fecha_vencimiento > NOW() THEN 'Activo ✅'
    ELSE 'Vencido ❌'
  END as estado_membresia
FROM public.socios s
WHERE s.email = 'marcelo@sochimt.cl';
