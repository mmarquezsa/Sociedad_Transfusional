-- ============================================
-- CREAR POLÍTICAS RLS PARA ADMINISTRADORES
-- ============================================

-- Problema: Los administradores no pueden ver solicitudes pendientes
-- Solución: Crear políticas que permitan a admins ver TODOS los socios

-- ============================================
-- PASO 1: Eliminar políticas existentes restrictivas (si existen)
-- ============================================

DROP POLICY IF EXISTS "Socios pueden ver su propia información" ON public.socios;
DROP POLICY IF EXISTS "Socios pueden actualizar su propia información" ON public.socios;

-- ============================================
-- PASO 2: Crear políticas nuevas más permisivas
-- ============================================

-- Política 1: Los administradores pueden ver TODOS los socios
CREATE POLICY "Administradores pueden ver todos los socios"
ON public.socios
FOR SELECT
USING (
  -- Permitir si el usuario autenticado es admin
  EXISTS (
    SELECT 1 FROM public.socios
    WHERE id = auth.uid()
    AND (rol = 'admin' OR rol = 'supervisor' OR email IN ('marcelo@sochimt.cl', 'mmarquezsa@gmail.com'))
  )
  OR
  -- O si el socio está viendo su propia información
  auth.uid() = id
);

-- Política 2: Los administradores pueden actualizar TODOS los socios
CREATE POLICY "Administradores pueden actualizar todos los socios"
ON public.socios
FOR UPDATE
USING (
  EXISTS (
    SELECT 1 FROM public.socios
    WHERE id = auth.uid()
    AND (rol = 'admin' OR rol = 'supervisor' OR email IN ('marcelo@sochimt.cl', 'mmarquezsa@gmail.com'))
  )
  OR
  auth.uid() = id
);

-- Política 3: Los socios pueden actualizar su propia información
CREATE POLICY "Socios pueden actualizar su propio perfil"
ON public.socios
FOR UPDATE
USING (auth.uid() = id);

-- Política 4: Permitir INSERT para registro público (sin autenticación)
CREATE POLICY "Permitir registro público"
ON public.socios
FOR INSERT
WITH CHECK (true);

-- ============================================
-- PASO 3: Verificar que las políticas se crearon
-- ============================================

SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd
FROM pg_policies
WHERE tablename = 'socios'
ORDER BY policyname;

-- ============================================
-- VERIFICAR ACCESO COMO ADMIN
-- ============================================

-- Esta query debería funcionar cuando estés logueado como marcelo@sochimt.cl
SELECT 
  id,
  nombre_completo,
  email,
  estado,
  tipo_membresia,
  fecha_postulacion
FROM public.socios
WHERE estado = 'pendiente'
ORDER BY created_at DESC;

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
✅ POLÍTICAS CREADAS:

1. "Administradores pueden ver todos los socios"
   - Permite a admins/supervisores ver TODOS los registros
   - Los socios regulares solo ven su propio registro

2. "Administradores pueden actualizar todos los socios"
   - Permite a admins aprobar/rechazar solicitudes
   - Permite a admins editar cualquier socio

3. "Socios pueden actualizar su propio perfil"
   - Los socios pueden editar su propia información

4. "Permitir registro público"
   - Permite que cualquiera se registre (sin login)
   - Necesario para el formulario de postulación

🔐 USUARIOS ADMIN:
- marcelo@sochimt.cl (hardcoded)
- mmarquezsa@gmail.com (hardcoded)
- Cualquier socio con rol='admin' o rol='supervisor'

📝 CÓMO FUNCIONA:
Cuando haces login como marcelo@sochimt.cl, la política:
1. Verifica que tu email está en la lista de admins
2. Te permite ver TODOS los socios (incluidos pendientes)
3. Te permite actualizar cualquier socio

Si el usuario NO es admin, solo ve su propio registro.
*/
