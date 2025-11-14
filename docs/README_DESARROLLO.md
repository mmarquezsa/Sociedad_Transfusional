# 🚀 Sistema de Desarrollo Local - SOCHIMT

## ✅ ¿Qué se ha configurado?

Tu sitio web ahora tiene un **sistema de entornos múltiples** que detecta automáticamente si estás en **local** o **producción** y se conecta a Supabase en ambos casos.

---

## 📁 Archivos Creados

### **Nuevos archivos:**
1. ✅ `config.js` - Gestión de entornos (dev/prod)
2. ✅ `auth-updated.js` - Sistema de autenticación mejorado
3. ✅ `test-supabase.html` - Página de pruebas de conexión
4. ✅ `start-local.ps1` - Script de inicio rápido
5. ✅ `DESARROLLO_LOCAL.md` - Documentación completa
6. ✅ `README_DESARROLLO.md` - Este archivo

### **Archivos actualizados:**
- ✅ `index.html` - Agregados scripts de Supabase
- ✅ `login-socios.html` - Ya actualizado anteriormente

---

## 🎯 Inicio Rápido (3 pasos)

### **Paso 1: Iniciar servidor local**

#### Opción A - Script PowerShell (Recomendado):
```powershell
cd D:\2025\Sociedad_Transfusional
.\start-local.ps1
```

#### Opción B - Python:
```powershell
cd D:\2025\Sociedad_Transfusional
python -m http.server 8000
```

#### Opción C - VS Code Live Server:
1. Abre VS Code
2. Instala extensión "Live Server"
3. Click derecho en `index.html` → "Open with Live Server"

---

### **Paso 2: Abrir en navegador**

Una vez iniciado el servidor, abre:

- **🏠 Página principal:** `http://localhost:8000/index.html`
- **🧪 Página de pruebas:** `http://localhost:8000/test-supabase.html`
- **🔐 Área de socios:** `http://localhost:8000/login-socios.html`

---

### **Paso 3: Verificar conexión**

1. Abre la **consola del navegador** (F12)
2. Deberías ver:
   ```
   🔧 Configuración cargada:
      📍 Entorno: development
      🏠 Local: true
      🐛 Debug: true
      🔗 Supabase URL: https://dkohwhosputnxismgkon.supabase.co
   
   🚀 MODO DESARROLLO ACTIVADO
   ✅ Supabase Client inicializado para index.html
   ```

3. Verás un **badge en la esquina inferior derecha:** 🧪 MODO DESARROLLO

---

## 🧪 Pruebas de Conexión

### **Opción 1: Página de Pruebas Automática**

Visita: `http://localhost:8000/test-supabase.html`

Esta página te permite:
- ✅ Verificar configuración de entorno
- ✅ Probar conexión a Supabase
- ✅ Verificar autenticación
- ✅ Consultar base de datos
- ✅ Ver logs en tiempo real

### **Opción 2: Consola del Navegador**

```javascript
// Verificar configuración
console.log(CONFIG);

// Probar consulta a Supabase
const { data, error } = await supabaseClient
  .from('miembros')
  .select('*')
  .limit(1);

console.log('Datos:', data);
console.log('Error:', error);
```

---

## 🔄 Flujo de Trabajo Recomendado

```
┌─────────────────────────────────────────────────┐
│  1. DESARROLLO LOCAL                            │
│     - Edita archivos en Windsurf/VS Code       │
│     - Prueba en http://localhost:8000           │
│     - Verifica consola del navegador            │
└─────────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────┐
│  2. PRUEBAS                                     │
│     - Usa test-supabase.html                    │
│     - Verifica funcionalidad                    │
│     - Revisa logs de debug                      │
└─────────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────┐
│  3. COMMIT A GIT                                │
│     git add .                                   │
│     git commit -m "feat: nueva funcionalidad"   │
└─────────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────┐
│  4. PUSH A GITHUB                               │
│     git push origin main                        │
└─────────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────┐
│  5. VERIFICAR EN PRODUCCIÓN                     │
│     - GitHub Pages se actualiza automáticamente │
│     - Sin badge de desarrollo                   │
│     - Sin logs de debug                         │
└─────────────────────────────────────────────────┘
```

---

## 🔍 Diferencias Entre Entornos

| Característica | LOCAL (Development) | PRODUCCIÓN |
|----------------|---------------------|------------|
| **URL** | localhost:8000 | github.io / sochimt.cl |
| **Debug Logs** | ✅ Activados | ❌ Desactivados |
| **Badge Visual** | ✅ Visible | ❌ Oculto |
| **Consola** | Logs detallados | Logs mínimos |
| **Supabase** | Misma BD | Misma BD |

**⚠️ IMPORTANTE:** Ambos entornos usan la **MISMA base de datos de producción**.

---

## 📊 Características del Sistema

### **Detección Automática de Entorno**

El archivo `config.js` detecta automáticamente:

```javascript
✅ Local:      localhost, 127.0.0.1, file://
✅ Desarrollo: Cualquier dominio que no sea producción
✅ Producción: github.io, sochimt.cl
```

### **Logs Condicionales**

En desarrollo verás:
```
🔐 [21:30:45] Intentando login para: user@example.com
✅ [21:30:46] Login exitoso: user@example.com
📝 [21:30:46] Actualizando perfil del socio
```

En producción: **No se muestran logs sensibles**

### **Badge Visual**

En desarrollo aparece en la esquina inferior derecha:

```
┌─────────────────────┐
│ 🧪 MODO DESARROLLO  │
└─────────────────────┘
```

---

## 🛠️ Comandos Útiles

### **Iniciar servidor:**
```powershell
# PowerShell Script
.\start-local.ps1

# Python
python -m http.server 8000

# Node.js (si tienes http-server instalado)
http-server -p 8000
```

### **Ver archivos modificados:**
```bash
git status
```

### **Commit y push:**
```bash
git add .
git commit -m "descripción del cambio"
git push origin main
```

### **Limpiar caché del navegador:**
```
Ctrl + Shift + R  (Windows/Linux)
Cmd + Shift + R   (Mac)
```

---

## 🐛 Troubleshooting

### **Problema: "supabase is not defined"**

**Solución:** Verifica que los scripts estén en orden:

```html
<!-- 1. Supabase CDN -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<!-- 2. Config -->
<script src="config.js"></script>

<!-- 3. Tu código -->
<script>
  const { createClient } = supabase;
  const supabaseClient = createClient(...);
</script>
```

---

### **Problema: "CONFIG is not defined"**

**Solución:** El archivo `config.js` no se cargó. Verifica:

1. Que el archivo existe en: `D:\2025\Sociedad_Transfusional\config.js`
2. Que el servidor esté corriendo
3. Que la URL sea `http://localhost:8000` (no `file://`)

---

### **Problema: CORS Error**

```
Access to fetch at '...' from origin 'null' has been blocked
```

**Solución:** Estás abriendo el archivo directamente. **Debes usar un servidor HTTP**.

---

### **Problema: Los cambios no se ven**

**Solución:**
1. Guarda el archivo (Ctrl+S)
2. Limpia caché: `Ctrl + Shift + R`
3. Abre en modo incógnito
4. Si usas Live Server, debería recargar automáticamente

---

## 📝 Archivos Importantes

```
D:\2025\Sociedad_Transfusional\
│
├── config.js                  ← Configuración de entornos
├── auth.js                    ← Sistema de autenticación (original)
├── auth-updated.js            ← Sistema de autenticación (mejorado)
├── test-supabase.html         ← Página de pruebas
├── start-local.ps1            ← Script inicio rápido
│
├── index.html                 ← Página principal (actualizada)
├── login-socios.html          ← Login (actualizado)
├── dashboard-socios.html      ← Dashboard de socios
│
├── DESARROLLO_LOCAL.md        ← Documentación detallada
└── README_DESARROLLO.md       ← Este archivo
```

---

## ⚡ Próximos Pasos

1. ✅ **Ejecuta el servidor local**
2. ✅ **Abre test-supabase.html**
3. ✅ **Haz click en "Test Conexión"**
4. ✅ **Verifica que aparezcan checkmarks verdes**
5. ✅ **Navega a index.html y verifica que se cargan los miembros**

---

## 🔒 Seguridad

### **⚠️ IMPORTANTE:**

- El archivo `config.js` contiene las credenciales de Supabase
- Si planeas hacer el repositorio **público**, agrega a `.gitignore`:

```gitignore
# Credenciales
config.js
.env
.env.local

# Node
node_modules/

# Logs
*.log
```

---

## 📞 ¿Necesitas Ayuda?

1. **Revisa la consola del navegador** (F12) para errores
2. **Usa la página de pruebas:** `test-supabase.html`
3. **Lee la documentación completa:** `DESARROLLO_LOCAL.md`

---

## ✨ Características Adicionales

### **Sistema de Logs Inteligente**

Solo en desarrollo:
```javascript
log('🔐', 'Usuario autenticado:', user.email);
log('❌', 'Error de conexión:', error);
log('✅', 'Operación exitosa');
```

### **Badge Removible**

El badge de desarrollo se puede cerrar haciendo click en él.

### **Fallback Automático**

Si `config.js` no carga, el sistema usa credenciales por defecto.

---

## 🎉 ¡Todo Listo!

Tu entorno de desarrollo local está **100% configurado** y listo para usar.

**Comandos rápidos:**

```powershell
# 1. Iniciar
cd D:\2025\Sociedad_Transfusional
.\start-local.ps1

# 2. Abrir navegador en:
http://localhost:8000/test-supabase.html

# 3. Hacer pruebas y desarrollar

# 4. Cuando termines, commit:
git add .
git commit -m "tu mensaje"
git push
```

**¡Feliz desarrollo! 🚀**
