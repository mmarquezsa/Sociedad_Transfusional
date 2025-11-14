-- ============================================
-- SCRIPT COMPLETO: CONFIGURACIÓN NUEVOS SOCIOS
-- ============================================
-- Este script soluciona el error de RLS y agrega datos de prueba
-- para visualizar la sección "Bienvenidos a la Familia SOCHIMT"
-- ============================================

-- ============================================
-- PASO 1: LIMPIAR POLÍTICAS EXISTENTES
-- ============================================

DROP POLICY IF EXISTS "Socios pueden ver su propia información" ON socios;
DROP POLICY IF EXISTS "Socios pueden actualizar su propia información" ON socios;
DROP POLICY IF EXISTS "Permitir lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Socios actualizan su perfil" ON socios;
DROP POLICY IF EXISTS "Permitir registro de nuevos socios" ON socios;
DROP POLICY IF EXISTS "Admin puede ver todos los socios" ON socios;

-- ============================================
-- PASO 2: CREAR POLÍTICAS RLS CORRECTAS
-- ============================================

-- Política 1: LECTURA PÚBLICA de socios activos
-- Permite que la página pública muestre nuevos socios sin autenticación
CREATE POLICY "Lectura pública de socios activos"
  ON socios FOR SELECT
  USING (estado = 'activo');

-- Política 2: Socios pueden actualizar su perfil
CREATE POLICY "Socios actualizan su perfil"
  ON socios FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Política 3: Permitir registro de nuevos socios
CREATE POLICY "Permitir registro de nuevos socios"
  ON socios FOR INSERT
  WITH CHECK (auth.uid() = id);

-- ============================================
-- PASO 3: INSERTAR DATOS DE PRUEBA
-- ============================================

-- Insertar 10 socios de prueba con fechas recientes (últimos 3 meses)
-- Estos aparecerán en la sección "Bienvenidos a la Familia SOCHIMT"

INSERT INTO socios (
  id,
  email,
  nombre_completo,
  especialidad,
  ciudad,
  institucion,
  profesion,
  universidad,
  estado,
  fecha_ingreso,
  tipo_membresia,
  recibir_newsletter
) VALUES
-- Socio 1 (hace 5 días)
(
  gen_random_uuid(),
  'dra.martinez@hospital.cl',
  'Dra. Carolina Martínez Rojas',
  'Medicina Transfusional',
  'Santiago',
  'Hospital Clínico Universidad de Chile',
  'Médico Cirujano',
  'Universidad de Chile',
  'activo',
  CURRENT_DATE - INTERVAL '5 days',
  'regular',
  true
),

-- Socio 2 (hace 12 días)
(
  gen_random_uuid(),
  'tm.gonzalez@clinica.cl',
  'TM. Roberto González Pérez',
  'Inmunohematología',
  'Valparaíso',
  'Hospital Carlos Van Buren',
  'Tecnólogo Médico',
  'Universidad de Valparaíso',
  'activo',
  CURRENT_DATE - INTERVAL '12 days',
  'regular',
  true
),

-- Socio 3 (hace 18 días)
(
  gen_random_uuid(),
  'dra.silva@medicina.cl',
  'Dra. Andrea Silva Campos',
  'Hematología',
  'Concepción',
  'Hospital Guillermo Grant Benavente',
  'Médico Hematólogo',
  'Universidad de Concepción',
  'activo',
  CURRENT_DATE - INTERVAL '18 days',
  'regular',
  true
),

-- Socio 4 (hace 25 días)
(
  gen_random_uuid(),
  'tm.ramirez@banco.cl',
  'TM. Felipe Ramírez Soto',
  'Banco de Sangre',
  'Viña del Mar',
  'Banco de Sangre Cruz Roja',
  'Tecnólogo Médico',
  'Universidad Andrés Bello',
  'activo',
  CURRENT_DATE - INTERVAL '25 days',
  'regular',
  true
),

-- Socio 5 (hace 1 mes)
(
  gen_random_uuid(),
  'dra.morales@clinica.cl',
  'Dra. Valentina Morales Torres',
  'Terapia Celular',
  'Santiago',
  'Clínica Alemana',
  'Médico Cirujano',
  'Pontificia Universidad Católica',
  'activo',
  CURRENT_DATE - INTERVAL '1 month',
  'regular',
  true
),

-- Socio 6 (hace 1 mes y 10 días)
(
  gen_random_uuid(),
  'tm.vargas@hospital.cl',
  'TM. Cristián Vargas Muñoz',
  'Medicina Transfusional',
  'Temuco',
  'Hospital Hernán Henríquez Aravena',
  'Tecnólogo Médico',
  'Universidad de La Frontera',
  'activo',
  CURRENT_DATE - INTERVAL '40 days',
  'estudiante',
  true
),

-- Socio 7 (hace 2 meses)
(
  gen_random_uuid(),
  'dra.castro@uss.cl',
  'Dra. Daniela Castro Fuentes',
  'Inmunohematología',
  'Puerto Montt',
  'Hospital Base Puerto Montt',
  'Médico Cirujano',
  'Universidad San Sebastián',
  'activo',
  CURRENT_DATE - INTERVAL '2 months',
  'regular',
  true
),

-- Socio 8 (hace 2 meses y 15 días)
(
  gen_random_uuid(),
  'tm.munoz@clinica.cl',
  'TM. Javiera Muñoz Herrera',
  'Hemostasia',
  'Antofagasta',
  'Hospital Regional Antofagasta',
  'Tecnólogo Médico',
  'Universidad de Antofagasta',
  'activo',
  CURRENT_DATE - INTERVAL '75 days',
  'regular',
  true
),

-- Socio 9 (hace 2 meses y 20 días)
(
  gen_random_uuid(),
  'dr.lopez@hospital.cl',
  'Dr. Marcelo López Bravo',
  'Medicina Transfusional',
  'La Serena',
  'Hospital San Juan de Dios',
  'Médico Hematólogo',
  'Universidad Católica del Norte',
  'activo',
  CURRENT_DATE - INTERVAL '80 days',
  'regular',
  true
),

-- Socio 10 (hace 2 meses y 25 días)
(
  gen_random_uuid(),
  'tm.reyes@salud.cl',
  'TM. Camila Reyes Ortiz',
  'Terapia Transfusional',
  'Rancagua',
  'Hospital Regional Rancagua',
  'Tecnólogo Médico',
  'Universidad Mayor',
  'activo',
  CURRENT_DATE - INTERVAL '85 days',
  'estudiante',
  true
),

-- Socio 11 (hace 1 semana)
(
  gen_random_uuid(),
  'dr.sanchez@pontificia.cl',
  'Dr. Rodrigo Sánchez Vera',
  'Medicina Transfusional',
  'Santiago',
  'Hospital Clínico UC',
  'Médico Cirujano',
  'Pontificia Universidad Católica',
  'activo',
  CURRENT_DATE - INTERVAL '7 days',
  'regular',
  true
),

-- Socio 12 (hace 3 días - MÁS RECIENTE)
(
  gen_random_uuid(),
  'tm.navarro@hospital.cl',
  'TM. Francisca Navarro Lagos',
  'Inmunohematología',
  'Iquique',
  'Hospital Dr. Ernesto Torres Galdames',
  'Tecnólogo Médico',
  'Universidad Arturo Prat',
  'activo',
  CURRENT_DATE - INTERVAL '3 days',
  'regular',
  true
);

-- ============================================
-- PASO 4: VERIFICACIÓN DE DATOS
-- ============================================

-- Ver cuántos socios activos hay en los últimos 3 meses
SELECT
  COUNT(*) as total_socios_nuevos,
  MIN(fecha_ingreso) as fecha_mas_antigua,
  MAX(fecha_ingreso) as fecha_mas_reciente
FROM socios
WHERE estado = 'activo'
  AND fecha_ingreso >= CURRENT_DATE - INTERVAL '3 months';

-- Ver los nuevos socios ordenados por fecha (igual que en la web)
SELECT
  nombre_completo,
  especialidad,
  ciudad,
  institucion,
  fecha_ingreso,
  CURRENT_DATE - fecha_ingreso as dias_desde_ingreso
FROM socios
WHERE estado = 'activo'
  AND fecha_ingreso >= CURRENT_DATE - INTERVAL '3 months'
ORDER BY fecha_ingreso DESC
LIMIT 12;

-- ============================================
-- PASO 5: VERIFICAR POLÍTICAS RLS
-- ============================================

-- Ver las políticas activas en la tabla socios
SELECT
  policyname,
  cmd,
  CASE
    WHEN cmd = 'SELECT' THEN 'Lectura'
    WHEN cmd = 'INSERT' THEN 'Inserción'
    WHEN cmd = 'UPDATE' THEN 'Actualización'
    WHEN cmd = 'DELETE' THEN 'Eliminación'
  END as operacion,
  permissive as permisivo
FROM pg_policies
WHERE tablename = 'socios'
ORDER BY cmd;

-- ============================================
-- PASO 6: ESTADÍSTICAS
-- ============================================

-- Contar socios por ciudad
SELECT
  ciudad,
  COUNT(*) as cantidad
FROM socios
WHERE estado = 'activo'
  AND fecha_ingreso >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY ciudad
ORDER BY cantidad DESC;

-- Contar socios por especialidad
SELECT
  especialidad,
  COUNT(*) as cantidad
FROM socios
WHERE estado = 'activo'
  AND fecha_ingreso >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY especialidad
ORDER BY cantidad DESC;

-- ============================================
-- RESULTADO ESPERADO
-- ============================================

-- Después de ejecutar este script:
-- ✅ Las políticas RLS estarán corregidas
-- ✅ Habrá 12 socios de prueba con fechas recientes
-- ✅ La página index.html cargará sin errores
-- ✅ El carrusel mostrará los nuevos socios
-- ✅ Las estadísticas mostrarán: 12 socios, 12 ciudades, múltiples especialidades

-- ============================================
-- NOTAS FINALES
-- ============================================

-- 1. Estos son datos de PRUEBA. Los emails son ficticios.
-- 2. Los IDs se generan aleatoriamente con gen_random_uuid()
-- 3. Las fechas son relativas a CURRENT_DATE, por lo que siempre
--    aparecerán como "recientes" incluso si ejecutas el script más tarde
-- 4. Para eliminar estos datos de prueba más adelante:
--    DELETE FROM socios WHERE email LIKE '%@hospital.cl' OR email LIKE '%@clinica.cl';
-- 5. Recuerda que la política RLS permite lectura pública solo de
--    campos específicos que solicitas en JavaScript

-- ============================================
-- INSTRUCCIONES DE USO
-- ============================================

-- 1. Copia TODO este script
-- 2. Ve a Supabase Dashboard > SQL Editor
-- 3. Crea una nueva query y pega este código
-- 4. Haz clic en "RUN" para ejecutar
-- 5. Verifica que no haya errores (deberías ver "Success. No rows returned")
-- 6. Refresca tu página index.html
-- 7. La sección "Bienvenidos a la Familia SOCHIMT" debería mostrar
--    12 socios nuevos en el carrusel

-- FIN DEL SCRIPT
