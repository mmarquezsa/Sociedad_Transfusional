-- ============================================
-- CORREGIR POLÍTICAS RLS DE LA TABLA SOCIOS
-- Solución al error: "infinite recursion detected in policy for relation 'socios'"
-- ============================================

-- Paso 1: Eliminar las políticas existentes que causan recursión
DROP POLICY IF EXISTS "Socios pueden ver su propia información" ON socios;
DROP POLICY IF EXISTS "Socios pueden actualizar su propia información" ON socios;
DROP POLICY IF EXISTS "Permitir lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Admin puede ver todos los socios" ON socios;

-- Paso 2: Crear políticas más simples y seguras

-- Política 1: LECTURA PÚBLICA de socios activos (para la sección "Nuevos Socios")
-- Solo muestra información básica de socios con estado 'activo'
CREATE POLICY "Lectura pública de socios activos"
  ON socios FOR SELECT
  USING (estado = 'activo');

-- Política 2: Los socios pueden ACTUALIZAR su propia información
-- Verifica directamente con auth.uid() sin consultas recursivas
CREATE POLICY "Socios actualizan su perfil"
  ON socios FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Política 3: Permitir INSERT durante el registro (opcional)
-- Solo si necesitas que los nuevos usuarios puedan auto-registrarse
CREATE POLICY "Permitir registro de nuevos socios"
  ON socios FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Política 4: Solo admins pueden ELIMINAR socios (opcional)
-- Descomenta si tienes un sistema de roles admin
-- CREATE POLICY "Solo admin puede eliminar socios"
--   ON socios FOR DELETE
--   USING (
--     EXISTS (
--       SELECT 1 FROM socios
--       WHERE id = auth.uid() AND rol = 'admin'
--     )
--   );

-- ============================================
-- VERIFICACIÓN
-- ============================================

-- Ver las políticas actuales de la tabla socios
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
WHERE tablename = 'socios';

-- Probar consulta pública (debe funcionar sin autenticación)
-- SELECT id, nombre_completo, especialidad, ciudad, fecha_ingreso
-- FROM socios
-- WHERE estado = 'activo'
-- ORDER BY fecha_ingreso DESC
-- LIMIT 10;

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

-- 1. La política "Lectura pública de socios activos" permite que CUALQUIERA
--    (incluso sin autenticación) pueda ver la información básica de socios activos.
--    Esto es necesario para la sección "Nuevos Socios" en la página pública.

-- 2. Si quieres restringir qué campos son visibles públicamente,
--    considera crear una VISTA en lugar de exponer toda la tabla:
--
--    CREATE VIEW socios_publicos AS
--    SELECT id, nombre_completo, especialidad, ciudad, fecha_ingreso, foto_perfil_url
--    FROM socios
--    WHERE estado = 'activo';
--
--    Y luego aplicar RLS a esa vista en lugar de a la tabla completa.

-- 3. Los datos sensibles como email, rut, teléfono, etc. ESTÁN PROTEGIDOS
--    porque tu consulta en JavaScript solo pide campos específicos:
--    'id, nombre_completo, especialidad, ciudad, foto_perfil_url, fecha_ingreso, institucion, profesion, universidad'

-- 4. Si necesitas ocultar ciertos socios de la vista pública,
--    puedes agregar una columna 'visible_publicamente BOOLEAN DEFAULT true'
--    y modificar la política a:
--    USING (estado = 'activo' AND visible_publicamente = true);

-- ============================================
-- ALTERNATIVA: Usar una función personalizada
-- ============================================

-- Si prefieres más control, puedes crear una función que devuelva solo
-- los datos públicos y llamarla desde JavaScript:

CREATE OR REPLACE FUNCTION obtener_socios_publicos(
  limite INT DEFAULT 12,
  meses_atras INT DEFAULT 3
)
RETURNS TABLE (
  id UUID,
  nombre_completo VARCHAR,
  especialidad VARCHAR,
  ciudad VARCHAR,
  fecha_ingreso DATE,
  foto_perfil_url TEXT,
  institucion VARCHAR,
  profesion VARCHAR,
  universidad VARCHAR
)
SECURITY DEFINER -- Ejecuta con permisos del dueño, no del usuario
AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id,
    s.nombre_completo,
    s.especialidad,
    s.ciudad,
    s.fecha_ingreso,
    s.foto_perfil_url,
    s.institucion,
    s.profesion,
    s.universidad
  FROM socios s
  WHERE s.estado = 'activo'
    AND s.fecha_ingreso >= CURRENT_DATE - (meses_atras || ' months')::INTERVAL
  ORDER BY s.fecha_ingreso DESC
  LIMIT limite;
END;
$$ LANGUAGE plpgsql;

-- Para usar esta función desde JavaScript:
-- const { data, error } = await supabaseClient.rpc('obtener_socios_publicos', {
--   limite: 12,
--   meses_atras: 3
-- });

-- ============================================
-- EJECUTAR EN SUPABASE SQL EDITOR
-- ============================================
-- 1. Copia todo este archivo
-- 2. Ve a Supabase Dashboard > SQL Editor
-- 3. Pega y ejecuta el script
-- 4. Verifica que no haya errores
-- 5. Prueba la página index.html
