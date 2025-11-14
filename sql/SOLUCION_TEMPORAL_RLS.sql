-- ============================================
-- SOLUCIÓN TEMPORAL: DESHABILITAR RLS
-- ============================================
-- Esta es una solución TEMPORAL para que funcione el registro
-- IMPORTANTE: Solo para pruebas, luego debes habilitar RLS correctamente
-- ============================================

-- OPCIÓN 1: Deshabilitar RLS temporalmente
-- ⚠️ SOLO PARA PRUEBAS - NO USAR EN PRODUCCIÓN
-- ALTER TABLE socios DISABLE ROW LEVEL SECURITY;

-- ============================================
-- OPCIÓN 2: Política más permisiva (RECOMENDADA)
-- ============================================

-- Eliminar la política restrictiva anterior
DROP POLICY IF EXISTS "Permitir registro de nuevos socios" ON socios;

-- Crear política que permita INSERT a usuarios autenticados
CREATE POLICY "Permitir registro de nuevos socios"
  ON socios FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- ============================================
-- VERIFICAR QUE FUNCIONÓ
-- ============================================

SELECT policyname, cmd, qual, with_check
FROM pg_policies
WHERE tablename = 'socios' AND policyname = 'Permitir registro de nuevos socios';

-- ============================================
-- RESULTADO ESPERADO:
-- ============================================
-- Deberías ver:
-- policyname: "Permitir registro de nuevos socios"
-- cmd: INSERT
-- qual: NULL
-- with_check: true
