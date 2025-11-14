# 🚀 Guía Paso a Paso: Ejecutar Script en Supabase

## ❌ Problema Actual

Ves este error en la consola del navegador:
```
Error de Supabase: Object
infinite recursion detected in policy for relation "socios"
```

**Causa:** Las políticas RLS (Row Level Security) de la tabla `socios` están mal configuradas y causan un bucle infinito.

**Solución:** Ejecutar el script SQL que corrige las políticas.

---

## 📋 Pasos Detallados

### **Paso 1: Abrir Supabase Dashboard**

1. Abre tu navegador
2. Ve a: **https://app.supabase.com**
3. Inicia sesión si es necesario
4. Selecciona tu proyecto: **mmarquezsa's Project**

---

### **Paso 2: Ir al SQL Editor**

En el menú lateral izquierdo de Supabase, busca y haz clic en:

```
🗄️ SQL Editor
```

Es el **tercer icono** desde arriba (parece una base de datos con un símbolo de terminal).

---

### **Paso 3: Crear Nueva Query**

1. En la parte superior derecha, haz clic en el botón:
   ```
   + New query
   ```

2. Te aparecerá un editor de SQL vacío

---

### **Paso 4: Copiar el Script**

1. Abre el archivo en tu computadora:
   ```
   D:\2025\Sociedad_Transfusional\sql\SETUP_COMPLETO_NUEVOS_SOCIOS.sql
   ```

2. Selecciona **TODO el contenido** del archivo:
   - Presiona `Ctrl + A` (seleccionar todo)
   - Presiona `Ctrl + C` (copiar)

3. O simplemente copia desde la línea 1 hasta la línea 362 (todo el archivo)

---

### **Paso 5: Pegar en Supabase**

1. Vuelve a la pestaña de Supabase con el SQL Editor abierto

2. Haz clic dentro del editor (el área grande de texto)

3. Pega el código:
   - Presiona `Ctrl + V`

4. Deberías ver todo el script pegado (362 líneas de código SQL)

---

### **Paso 6: Ejecutar el Script**

1. En la esquina inferior derecha del editor, busca el botón:
   ```
   ▶ RUN
   ```

2. Haz clic en **RUN** (o presiona `Ctrl + Enter`)

3. **Espera** unos segundos mientras se ejecuta

---

### **Paso 7: Verificar Resultados**

Después de ejecutar, deberías ver **múltiples paneles de resultados** en la parte inferior:

#### ✅ **Resultado 1-7: DROP POLICY**
```
Success. No rows returned
```
Esto significa que las políticas antiguas se eliminaron correctamente.

#### ✅ **Resultado 8-10: CREATE POLICY**
```
Success. No rows returned
```
Las nuevas políticas se crearon sin errores.

#### ✅ **Resultado 11: INSERT INTO socios**
```
Success. 12 rows affected
```
Se insertaron 12 socios de prueba.

#### ✅ **Resultado 12: Verificación de datos**
Deberías ver una tabla como esta:
```
total_socios_nuevos | fecha_mas_antigua | fecha_mas_reciente
        12          |   2025-08-10      |   2025-11-07
```

#### ✅ **Resultado 13: Lista de socios**
Una tabla mostrando los 12 socios con sus nombres, especialidades, ciudades, etc.

#### ✅ **Resultado 14: Políticas RLS**
Tres políticas:
- Lectura pública de socios activos
- Socios actualizan su perfil
- Permitir registro de nuevos socios

#### ✅ **Resultado 15-16: Estadísticas**
Conteo de socios por ciudad y especialidad.

---

### **Paso 8: Si hay Errores**

#### Error: "policy already exists"
**Solución:** Una política ya existe. Ejecuta solo esta parte primero:
```sql
DROP POLICY IF EXISTS "Lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Socios actualizan su perfil" ON socios;
DROP POLICY IF EXISTS "Permitir registro de nuevos socios" ON socios;
```
Luego ejecuta el script completo nuevamente.

#### Error: "duplicate key value violates unique constraint"
**Solución:** Los emails de prueba ya existen. Ejecuta esto primero:
```sql
DELETE FROM socios WHERE email LIKE '%@hospital.cl' OR email LIKE '%@clinica.cl';
```
Luego ejecuta el script completo nuevamente.

---

### **Paso 9: Verificar en la Página Web**

1. Vuelve a tu navegador con la página `index.html` abierta

2. **Refresca la página** con `F5` o `Ctrl + R`

3. Desplázate hasta la sección **"Bienvenidos a la Familia SOCHIMT"**

4. **Deberías ver:**
   - ✅ **12 socios** en formato de tarjetas
   - ✅ Carrusel funcional con flechas de navegación
   - ✅ Estadísticas: "12 Nuevos Socios, 12 Ciudades, 6 Especialidades"
   - ✅ Badge "NUEVO" en algunos socios
   - ✅ **Sin errores** en la consola del navegador

---

## 🔍 Cómo Verificar que Funcionó

### En la Consola del Navegador (F12):

**ANTES (con error):**
```
❌ Error de Supabase: Object
   infinite recursion detected in policy for relation "socios"
```

**DESPUÉS (sin error):**
```
✅ 12 nuevos socios cargados correctamente
✅ Supabase Client inicializado para index.html
```

---

## 📸 Captura de Pantalla Esperada

Deberías ver algo así en la sección "Nuevos Socios":

```
╔══════════════════════════════════════════════════════════════╗
║        Bienvenidos a la Familia SOCHIMT                      ║
║  Conoce a los profesionales que se han unido recientemente   ║
╠══════════════════════════════════════════════════════════════╣
║                                                               ║
║  [Estadísticas]  12 Nuevos Socios | 12 Ciudades | 6 Esp.    ║
║                                                               ║
║  ┌──────────┐  ┌──────────┐  ┌──────────┐                  ║
║  │  [NUEVO] │  │  [NUEVO] │  │          │                  ║
║  │   🧑‍⚕️    │  │   🧑‍⚕️    │  │   🧑‍⚕️    │                  ║
║  │ Dra. C.  │  │ TM. R.   │  │ Dra. A.  │                  ║
║  │ Martínez │  │ González │  │ Silva    │                  ║
║  │          │  │          │  │          │                  ║
║  │ Medicina │  │ Inmuno-  │  │ Hemato-  │                  ║
║  │ Transf.  │  │ hemato.  │  │ logía    │                  ║
║  │          │  │          │  │          │                  ║
║  │ 🏥 Hosp. │  │ 🏥 Hosp. │  │ 🏥 Hosp. │                  ║
║  │ Clínico  │  │ Carlos   │  │ G.Grant  │                  ║
║  │          │  │          │  │          │                  ║
║  │ 📍 Stgo  │  │ 📍 Valpo │  │ 📍 Conce │                  ║
║  └──────────┘  └──────────┘  └──────────┘                  ║
║                                                               ║
║     [◄ Anterior]              [Siguiente ►]                  ║
╚══════════════════════════════════════════════════════════════╝
```

---

## 🆘 ¿Sigues con Problemas?

### Opción 1: Verificar Políticas Actuales

Ejecuta esto en Supabase SQL Editor:
```sql
SELECT policyname, cmd
FROM pg_policies
WHERE tablename = 'socios';
```

Deberías ver 3 políticas:
1. `Lectura pública de socios activos` - SELECT
2. `Socios actualizan su perfil` - UPDATE
3. `Permitir registro de nuevos socios` - INSERT

### Opción 2: Verificar Datos

Ejecuta esto en Supabase SQL Editor:
```sql
SELECT COUNT(*) as total
FROM socios
WHERE estado = 'activo'
  AND fecha_ingreso >= CURRENT_DATE - INTERVAL '3 months';
```

Debería devolver: `total: 12`

### Opción 3: Eliminar TODO y Empezar de Nuevo

Si nada funciona, ejecuta esto para limpiar todo:
```sql
-- Eliminar todas las políticas
DROP POLICY IF EXISTS "Lectura pública de socios activos" ON socios;
DROP POLICY IF EXISTS "Socios actualizan su perfil" ON socios;
DROP POLICY IF EXISTS "Permitir registro de nuevos socios" ON socios;

-- Eliminar socios de prueba
DELETE FROM socios WHERE email LIKE '%@hospital.cl';

-- Deshabilitar RLS temporalmente (solo para testing)
ALTER TABLE socios DISABLE ROW LEVEL SECURITY;
```

Luego ejecuta el script completo nuevamente.

---

## 📞 Contacto

Si después de seguir todos estos pasos aún tienes el error, necesito que me compartas:

1. **Screenshot del resultado** después de ejecutar el script en Supabase
2. **Screenshot de la consola** del navegador (F12 > Console)
3. **Mensaje de error exacto** que aparece

---

## ✅ Checklist Final

- [ ] Abrí Supabase Dashboard
- [ ] Fui al SQL Editor
- [ ] Copié el script completo
- [ ] Pegué y ejecuté el script
- [ ] Vi "Success" en los resultados
- [ ] Vi "12 rows affected" en el INSERT
- [ ] Refresqué la página index.html
- [ ] Veo los 12 socios nuevos
- [ ] No hay errores en la consola

---

**Fecha de creación:** 2025-11-10
**Archivo relacionado:** `sql/SETUP_COMPLETO_NUEVOS_SOCIOS.sql`
