-- ============================================
-- DIAGNÓSTICO DE POLÍTICAS RLS
-- ============================================
-- Este script verifica el estado actual de las políticas RLS

-- 1. Verificar si RLS está habilitado en la tabla socios
SELECT
  tablename,
  rowsecurity
FROM pg_tables
WHERE tablename = 'socios';

-- 2. Ver todas las políticas actuales
SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'socios'
ORDER BY policyname;

-- 3. Ver estructura de la tabla socios
SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'socios'
ORDER BY ordinal_position;

-- ============================================
-- RESULTADOS ESPERADOS:
-- ============================================
-- Query 1: rowsecurity debe ser TRUE
-- Query 2: Debe mostrar 5 políticas:
--   - "Admin puede ver todos los socios" (SELECT)
--   - "Lectura pública de socios activos" (SELECT)
--   - "Permitir registro de nuevos socios" (INSERT)
--   - "Socios actualizan su perfil" (UPDATE)
--   - "Socios pueden ver su propia información" (SELECT)
-- Query 3: Debe mostrar todas las columnas necesarias
