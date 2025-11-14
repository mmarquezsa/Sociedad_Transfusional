-- ============================================
-- SOLUCIÓN: ERROR 401 AL REGISTRAR NUEVOS SOCIOS
-- ============================================
-- Este script soluciona el error "Error al crear perfil de socio"
-- que ocurre por políticas RLS incorrectas
-- ============================================

-- PASO 1: Verificar que RLS esté habilitado
-- ============================================
-- RLS debe estar habilitado para la seguridad, pero con las políticas correctas

ALTER TABLE socios ENABLE ROW LEVEL SECURITY;

-- ============================================
-- PASO 2: ELIMINAR POLÍTICAS ANTIGUAS
-- ============================================
DROP POLICY IF EXISTS "Lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Socios actualizan su perfil" ON socios;
DROP POLICY IF EXISTS "Permitir registro de nuevos socios" ON socios;
DROP POLICY IF EXISTS "Admin puede ver todos los socios" ON socios;
DROP POLICY IF EXISTS "Socios pueden ver su propia información" ON socios;
DROP POLICY IF EXISTS "Permitir lectura pública de socios activos" ON socios;

-- ============================================
-- PASO 3: CREAR POLÍTICAS CORRECTAS
-- ============================================

-- Política 1: LECTURA PÚBLICA de socios activos
-- Permite que la página pública muestre nuevos socios
CREATE POLICY "Lectura pública de socios activos"
  ON socios FOR SELECT
  USING (estado = 'activo');

-- Política 2: Socios pueden VER su propia información
CREATE POLICY "Socios pueden ver su propia información"
  ON socios FOR SELECT
  USING (auth.uid() = id);

-- Política 3: Socios pueden ACTUALIZAR su perfil
CREATE POLICY "Socios actualizan su perfil"
  ON socios FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Política 4: PERMITIR REGISTRO de nuevos socios
-- ⚠️ CRÍTICA: Esta es la que soluciona el error 401
CREATE POLICY "Permitir registro de nuevos socios"
  ON socios FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Política 5: Admin puede ver TODOS los socios
-- (Opcional - solo si tienes un rol admin configurado)
CREATE POLICY "Admin puede ver todos los socios"
  ON socios FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM auth.users
      WHERE auth.users.id = auth.uid()
      AND (auth.users.raw_user_meta_data->>'role')::text = 'admin'
    )
  );

-- ============================================
-- PASO 4: VERIFICAR POLÍTICAS
-- ============================================

-- Ver todas las políticas activas
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

-- ============================================
-- PASO 5: VERIFICAR COLUMNAS DE LA TABLA
-- ============================================

-- Asegurarse de que todas las columnas necesarias existan
-- Si falta alguna columna, agrégala

DO $$
BEGIN
  -- Verificar y agregar columnas si no existen
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'rut') THEN
    ALTER TABLE socios ADD COLUMN rut VARCHAR(12);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'fecha_nacimiento') THEN
    ALTER TABLE socios ADD COLUMN fecha_nacimiento DATE;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'sexo') THEN
    ALTER TABLE socios ADD COLUMN sexo VARCHAR(20);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'telefono') THEN
    ALTER TABLE socios ADD COLUMN telefono VARCHAR(20);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'universidad') THEN
    ALTER TABLE socios ADD COLUMN universidad TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'registro_sis') THEN
    ALTER TABLE socios ADD COLUMN registro_sis VARCHAR(50);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'anos_experiencia') THEN
    ALTER TABLE socios ADD COLUMN anos_experiencia INTEGER;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'categoria') THEN
    ALTER TABLE socios ADD COLUMN categoria VARCHAR(1);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'patrocinador1_nombre') THEN
    ALTER TABLE socios ADD COLUMN patrocinador1_nombre TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'patrocinador1_rut') THEN
    ALTER TABLE socios ADD COLUMN patrocinador1_rut VARCHAR(12);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'patrocinador2_nombre') THEN
    ALTER TABLE socios ADD COLUMN patrocinador2_nombre TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'patrocinador2_rut') THEN
    ALTER TABLE socios ADD COLUMN patrocinador2_rut VARCHAR(12);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'url_cv') THEN
    ALTER TABLE socios ADD COLUMN url_cv TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'url_antecedentes') THEN
    ALTER TABLE socios ADD COLUMN url_antecedentes TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'url_registro_sis') THEN
    ALTER TABLE socios ADD COLUMN url_registro_sis TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'url_firma_patrocinadores') THEN
    ALTER TABLE socios ADD COLUMN url_firma_patrocinadores TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'url_otro_documento') THEN
    ALTER TABLE socios ADD COLUMN url_otro_documento TEXT;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'carpeta_documentos') THEN
    ALTER TABLE socios ADD COLUMN carpeta_documentos VARCHAR(255);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'recibir_newsletter') THEN
    ALTER TABLE socios ADD COLUMN recibir_newsletter BOOLEAN DEFAULT false;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'fecha_postulacion') THEN
    ALTER TABLE socios ADD COLUMN fecha_postulacion DATE;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_name = 'socios' AND column_name = 'fecha_ingreso') THEN
    ALTER TABLE socios ADD COLUMN fecha_ingreso DATE DEFAULT CURRENT_DATE;
  END IF;
END $$;

-- ============================================
-- PASO 6: VERIFICAR ESTRUCTURA FINAL
-- ============================================

-- Ver todas las columnas de la tabla socios
SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'socios'
ORDER BY ordinal_position;

-- ============================================
-- RESULTADO ESPERADO
-- ============================================

-- Después de ejecutar este script:
-- ✅ Las políticas RLS estarán configuradas correctamente
-- ✅ El registro de nuevos socios funcionará sin error 401
-- ✅ Los socios podrán ver y actualizar su propio perfil
-- ✅ La página pública mostrará socios activos
-- ✅ Todas las columnas necesarias existirán

-- ============================================
-- INSTRUCCIONES DE USO
-- ============================================

-- 1. Ve a https://supabase.com/dashboard
-- 2. Selecciona tu proyecto SOCHIMT
-- 3. Ve a "SQL Editor" en el menú lateral
-- 4. Haz clic en "New query"
-- 5. Copia y pega TODO este script
-- 6. Haz clic en "RUN" (botón verde abajo a la derecha)
-- 7. Espera a que termine (verás "Success" en verde)
-- 8. Vuelve al formulario de registro y prueba de nuevo

-- ============================================
-- PRUEBA DEL REGISTRO
-- ============================================

-- Después de ejecutar este script, prueba registrar un nuevo socio:
-- 1. Abre: registro-socios.html
-- 2. Llena todos los campos del formulario
-- 3. Adjunta los documentos requeridos
-- 4. Haz clic en "Enviar Solicitud"
-- 5. Deberías ver "Registro Exitoso" sin errores

-- Si aún hay problemas, verifica en la consola del navegador (F12)
-- y revisa los mensajes de error

-- FIN DEL SCRIPT
