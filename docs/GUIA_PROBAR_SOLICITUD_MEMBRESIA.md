# 🎯 GUÍA PASO A PASO: Probar Solicitud y Aprobación de Membresía

## 📋 Objetivo
Cargar datos de ejemplo en Supabase para probar el flujo completo de aprobación de nuevos miembros.

---

## 🚀 OPCIÓN 1: Prueba Rápida (Solo Visualización)

**✅ Úsalo si solo quieres ver cómo se visualizan los nuevos miembros en la web**

### Paso 1: Abre Supabase
1. Ingresa a [app.supabase.com](https://app.supabase.com)
2. Selecciona tu proyecto **Sociedad Transfusional**
3. Ve a **SQL Editor** (icono de rayo ⚡ en el menú lateral)

### Paso 2: Copia y Pega el SQL
1. Abre el archivo: `datos_ejemplo_SIMPLE_miembros.sql`
2. Copia **TODO** el contenido del bloque de INSERT (líneas 10-100)
3. Pégalo en el SQL Editor de Supabase

### Paso 3: Ejecuta el Script
1. Click en el botón **"Run"** (▶️) o presiona `Ctrl + Enter`
2. Deberías ver: **"Success. No rows returned"** ✅

### Paso 4: Verifica los Datos
1. Ve a **Table Editor** (icono de tabla 📊 en el menú lateral)
2. Selecciona la tabla **`miembros`**
3. Deberías ver los nuevos miembros con fechas de ingreso recientes

### Paso 5: Visualiza en la Web
1. Abre tu archivo `index.html` en el navegador
2. Ve a la sección **"Miembros"**
3. Los nuevos miembros deberían aparecer automáticamente 🎉

---

## 🔐 OPCIÓN 2: Flujo Completo con Autenticación

**✅ Úsalo para probar el flujo completo: Registro → Aprobación → Login → Área de Socios**

### Paso 1: Crear Usuario en Supabase Auth

#### 1.1 Ir a Authentication
1. En Supabase Dashboard, ve a **Authentication** (icono de usuario 👤)
2. Click en la pestaña **Users**
3. Click en **"Add user"** (+ Invite)

#### 1.2 Crear el usuario de prueba
```
Email: juan.perez.test@gmail.com
Password: SochiMT2025! (temporal)
☑ Auto Confirm User (marcar esta opción)
```
4. Click en **"Send invitation"** o **"Create user"**

#### 1.3 Copiar el UUID del usuario
1. Una vez creado, aparecerá en la lista de usuarios
2. Haz click en el usuario
3. **COPIA** el **User UID** (algo como: `550e8400-e29b-41d4-a716-446655440000`)
4. Guárdalo en un bloc de notas temporalmente

### Paso 2: Insertar Datos del Socio en Estado PENDIENTE

#### 2.1 Ir al SQL Editor
1. Ve a **SQL Editor**
2. Crea una nueva query

#### 2.2 Pega este SQL (REEMPLAZA EL UUID)
```sql
-- REEMPLAZA 'TU_UUID_AQUI' con el UUID que copiaste en el paso 1.3
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
  'TU_UUID_AQUI'::UUID, -- 👈 REEMPLAZAR AQUÍ
  'juan.perez.test@gmail.com',
  'Juan Alberto Pérez González',
  '12.345.678-9',
  'Tecnólogo Médico - Medicina Transfusional',
  'Santiago',
  '+56 9 8765 4321',
  'pendiente', -- 👈 ESTADO: PENDIENTE
  'regular',
  CURRENT_DATE,
  CURRENT_DATE + INTERVAL '1 year',
  true,
  ARRAY['Inmunohematología', 'Selección de Donantes', 'Medicina Transfusional']
);
```

#### 2.3 Ejecutar
1. Click en **"Run"**
2. Deberías ver: **"Success. No rows returned"** ✅

### Paso 3: Ver Solicitudes Pendientes (Como Administrador)

#### 3.1 Consultar solicitudes pendientes
```sql
SELECT 
  id,
  nombre_completo,
  email,
  rut,
  especialidad,
  ciudad,
  tipo_membresia,
  estado,
  fecha_ingreso,
  created_at
FROM socios
WHERE estado = 'pendiente'
ORDER BY created_at DESC;
```

Deberías ver la solicitud de **Juan Alberto Pérez González** con estado **"pendiente"** ✅

### Paso 4: APROBAR la Solicitud (Acción del Administrador)

#### 4.1 Aprobar cambiando el estado
```sql
-- REEMPLAZA 'TU_UUID_AQUI' con el UUID del socio
UPDATE socios 
SET 
  estado = 'activo', -- 👈 CAMBIAR A ACTIVO
  updated_at = NOW()
WHERE id = 'TU_UUID_AQUI'::UUID
  AND estado = 'pendiente';
```

#### 4.2 Verificar aprobación
```sql
SELECT 
  nombre_completo,
  email,
  estado,
  tipo_membresia,
  fecha_ingreso
FROM socios
WHERE id = 'TU_UUID_AQUI'::UUID;
```

Deberías ver **estado = 'activo'** ✅

### Paso 5: (Opcional) Agregar al Listado Público de Miembros

```sql
-- REEMPLAZA 'TU_UUID_AQUI' con el UUID del socio aprobado
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
  'Especialista en ' || especialidad || '. Miembro activo de SOCHIMT.',
  fecha_ingreso,
  ciudad,
  'sochimt'
FROM socios
WHERE id = 'TU_UUID_AQUI'::UUID
  AND estado = 'activo';
```

### Paso 6: Probar el Login

#### 6.1 Ir a la web
1. Abre `login-socios.html` en tu navegador

#### 6.2 Iniciar sesión
```
Email: juan.perez.test@gmail.com
Password: SochiMT2025!
```

3. Deberías poder iniciar sesión exitosamente ✅
4. El usuario ahora tiene acceso a:
   - ✅ Área de Socios
   - ✅ Contenido Premium
   - ✅ Gotita IA
   - ✅ Eventos exclusivos
   - ✅ Recursos descargables

---

## 📊 CONSULTAS ÚTILES PARA ADMINISTRADORES

### Ver todas las solicitudes por estado
```sql
SELECT 
  estado,
  COUNT(*) as total
FROM socios
GROUP BY estado
ORDER BY estado;
```

### Ver solicitudes recientes (últimos 7 días)
```sql
SELECT 
  nombre_completo,
  email,
  especialidad,
  ciudad,
  estado,
  created_at
FROM socios
WHERE created_at >= NOW() - INTERVAL '7 days'
ORDER BY created_at DESC;
```

### Ver miembros activos con membresía por vencer
```sql
SELECT 
  nombre_completo,
  email,
  tipo_membresia,
  fecha_vencimiento,
  DATE_PART('day', fecha_vencimiento - CURRENT_DATE) as dias_restantes
FROM socios
WHERE estado = 'activo'
  AND fecha_vencimiento IS NOT NULL
  AND fecha_vencimiento <= CURRENT_DATE + INTERVAL '30 days'
ORDER BY fecha_vencimiento ASC;
```

### Estadísticas generales
```sql
SELECT 
  COUNT(*) as total_socios,
  COUNT(*) FILTER (WHERE estado = 'activo') as activos,
  COUNT(*) FILTER (WHERE estado = 'pendiente') as pendientes,
  COUNT(*) FILTER (WHERE estado = 'suspendido') as suspendidos,
  COUNT(*) FILTER (WHERE estado = 'inactivo') as inactivos,
  COUNT(*) FILTER (WHERE tipo_membresia = 'estudiante') as estudiantes,
  COUNT(*) FILTER (WHERE tipo_membresia = 'regular') as regulares,
  COUNT(*) FILTER (WHERE tipo_membresia = 'vitalicio') as vitalicios
FROM socios;
```

---

## 🎨 PERSONALIZACIÓN DE AVATARES

### Colores disponibles
```sql
-- Actualizar color de avatar
UPDATE miembros 
SET color_avatar = 'medical' -- opciones: 'sochimt', 'medical', 'purple'
WHERE nombre = 'Juan Alberto Pérez González';
```

### Agregar foto personalizada
```sql
-- Usar servicio de avatares automático
UPDATE miembros 
SET url_foto = 'https://ui-avatars.com/api/?name=' || REPLACE(nombre, ' ', '+') || '&background=2563eb&color=fff&size=200'
WHERE id = 1;

-- O usar una imagen real
UPDATE miembros 
SET url_foto = 'https://ejemplo.com/fotos/juan-perez.jpg'
WHERE nombre = 'Juan Alberto Pérez González';
```

---

## 🧹 LIMPIAR DATOS DE PRUEBA

### Eliminar miembros de prueba
```sql
-- CUIDADO: Esto elimina los datos de ejemplo
DELETE FROM miembros 
WHERE nombre LIKE '%TEST%' 
   OR nombre LIKE '%Ejemplo%'
   OR nombre IN ('Juan Alberto Pérez González', 'María Fernanda Silva Rojas');
```

### Eliminar socios de prueba
```sql
-- Primero eliminar el usuario de Authentication manualmente
-- Luego esto eliminará en cascada el registro de socios
-- O puedes hacer:
DELETE FROM socios 
WHERE email LIKE '%test%' 
   OR email LIKE '%ejemplo%';
```

---

## 🐛 TROUBLESHOOTING

### ❌ Error: "violates row-level security policy"
**Solución:** Las políticas RLS están activas. Ejecuta las queries desde el SQL Editor de Supabase Dashboard (no desde tu aplicación web).

### ❌ Error: "duplicate key value"
**Solución:** Ya existe un registro con ese email o UUID. Cambia el email o verifica si ya existe.

### ❌ No aparecen los miembros en la web
**Solución:** 
1. Verifica que la tabla `miembros` tenga datos (Table Editor)
2. Revisa la consola del navegador (F12) para errores de JavaScript
3. Verifica que las políticas RLS permitan lectura pública

### ❌ No puedo hacer login
**Solución:**
1. Verifica que el usuario esté en Authentication > Users
2. Verifica que el estado en tabla `socios` sea 'activo'
3. Verifica que el email y password sean correctos
4. Revisa que "Auto Confirm User" esté marcado

---

## 📝 RESUMEN DEL FLUJO COMPLETO

```
1. Usuario se registra en registro-socios.html
   ↓
2. Se crea en auth.users (Supabase Auth)
   ↓
3. Se inserta en tabla socios con estado='pendiente'
   ↓
4. Administrador ve solicitudes pendientes
   ↓
5. Administrador aprueba: UPDATE socios SET estado='activo'
   ↓
6. (Opcional) Se agrega a tabla miembros (listado público)
   ↓
7. Usuario puede hacer login
   ↓
8. Usuario accede a área de socios y contenido premium
   ✅ ¡Flujo completado!
```

---

## 📧 Contacto y Soporte

Si tienes problemas ejecutando estos scripts:
1. Revisa los logs en Supabase Dashboard
2. Verifica las políticas RLS en cada tabla
3. Asegúrate de tener permisos de administrador en el proyecto

---

**¡Listo! Ahora puedes probar el flujo completo de membresías en tu sistema SOCHIMT** 🎉
