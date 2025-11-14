-- ================================================
-- CONFIGURACIÓN DE ROLES DE ADMINISTRACIÓN
-- Sociedad Chilena de Medicina Transfusional (SOCHIMT)
-- ================================================

-- PASO 1: Agregar campo 'rol' a la tabla socios
-- ================================================

-- Agregar columna rol si no existe
ALTER TABLE public.socios 
ADD COLUMN IF NOT EXISTS rol VARCHAR(20) DEFAULT 'socio';

-- Agregar comentario a la columna
COMMENT ON COLUMN public.socios.rol IS 'Rol del usuario: socio, supervisor, admin';

-- Crear índice para búsquedas por rol
CREATE INDEX IF NOT EXISTS idx_socios_rol ON public.socios(rol);


-- PASO 2: Configurar usuarios administradores
-- ================================================

-- Actualizar rol de Marcelo (marcelo@sochimt.cl) a admin
UPDATE public.socios
SET rol = 'admin'
WHERE email = 'marcelo@sochimt.cl';

-- Crear o actualizar usuario mmarquezsa@gmail.com como admin
-- IMPORTANTE: Primero debes crear este usuario en Authentication si no existe

-- Si ya existe en la tabla socios:
UPDATE public.socios
SET rol = 'admin'
WHERE email = 'mmarquezsa@gmail.com';

-- Si NO existe, debes crearlo manualmente en Authentication primero,
-- luego ejecutar este INSERT con el UUID del usuario de Auth:
/*
INSERT INTO public.socios (
  id,  -- UUID del usuario de Authentication
  nombre_completo,
  email,
  rol,
  estado,
  tipo_membresia,
  fecha_postulacion,
  fecha_vencimiento
) VALUES (
  'UUID_DEL_USUARIO_AUTH',  -- Reemplazar con el UUID real
  'Marcelo Márquez Salinas',
  'mmarquezsa@gmail.com',
  'admin',
  'activo',
  'activo',
  CURRENT_DATE,
  CURRENT_DATE + INTERVAL '1 year'
);
*/


-- PASO 3: Verificar configuración
-- ================================================

-- Ver todos los usuarios con rol admin o supervisor
SELECT 
  id,
  nombre_completo,
  email,
  rol,
  estado,
  tipo_membresia,
  fecha_vencimiento
FROM public.socios
WHERE rol IN ('admin', 'supervisor')
ORDER BY rol, email;


-- PASO 4: Valores válidos para roles
-- ================================================

-- Los roles válidos son:
-- 'socio'      : Usuario regular, solo puede visualizar contenido
-- 'supervisor' : Puede agregar y editar contenido (artículos, eventos, recursos)
-- 'admin'      : Acceso completo, puede gestionar socios y todo el contenido


-- PASO 5: Ejemplos de uso
-- ================================================

-- Promover un socio a supervisor
-- UPDATE public.socios SET rol = 'supervisor' WHERE email = 'usuario@ejemplo.com';

-- Degradar un supervisor a socio regular
-- UPDATE public.socios SET rol = 'socio' WHERE email = 'usuario@ejemplo.com';

-- Ver todos los usuarios por rol
-- SELECT rol, COUNT(*) as cantidad FROM public.socios GROUP BY rol ORDER BY rol;


-- ================================================
-- INSTRUCCIONES DE IMPLEMENTACIÓN
-- ================================================

/*
📋 PASOS PARA EJECUTAR:

1. Ve a Supabase Dashboard → SQL Editor
2. Ejecuta la sección PASO 1 para agregar el campo 'rol'
3. Ejecuta la sección PASO 2 para configurar los admins
4. Ejecuta la sección PASO 3 para verificar

⚠️ IMPORTANTE:

- El campo 'rol' se establece por defecto como 'socio' para usuarios nuevos
- Solo 'marcelo@sochimt.cl' y 'mmarquezsa@gmail.com' son administradores
- Los administradores pueden ver el "Panel de Administración" en el dashboard
- Los socios regulares solo ven el contenido sin opciones de edición

🔐 CONTROL DE ACCESO:

La validación de roles se hace en dos niveles:

1. Por EMAIL (hardcoded):
   - marcelo@sochimt.cl
   - mmarquezsa@gmail.com

2. Por CAMPO 'rol' en la tabla:
   - admin
   - supervisor

Si el usuario cumple CUALQUIERA de estas condiciones, verá el panel de admin.

📊 ROLES Y PERMISOS:

┌─────────────┬───────────┬──────────────┬──────────────┐
│ Función     │ Socio     │ Supervisor   │ Admin        │
├─────────────┼───────────┼──────────────┼──────────────┤
│ Ver         │ ✅        │ ✅           │ ✅           │
│ Artículos   │ Lectura   │ Crear/Editar │ Crear/Editar │
│ Eventos     │ Inscribir │ Crear/Editar │ Crear/Editar │
│ Recursos    │ Descargar │ Subir/Editar │ Subir/Editar │
│ Socios      │ ❌        │ ❌           │ Gestionar    │
└─────────────┴───────────┴──────────────┴──────────────┘

🚀 PRÓXIMOS PASOS:

Una vez configurados los roles, los próximos desarrollos serán:

1. Sistema de gestión de artículos (CMS)
2. Sistema de gestión de eventos
3. Sistema de gestión de recursos (upload de PDFs)
4. Panel de gestión de socios (solo admin)

Cada uno de estos sistemas verificará el rol antes de permitir ediciones.
*/
