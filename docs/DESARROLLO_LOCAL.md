# 🚀 Guía de Desarrollo Local - SOCHIMT

Esta guía te ayudará a configurar y probar tu sitio web localmente mientras mantiene la conexión con Supabase, sin afectar la versión de producción en GitHub.

## 📋 Índice

1. [Requisitos Previos](#requisitos-previos)
2. [Configuración Inicial](#configuración-inicial)
3. [Iniciar Servidor Local](#iniciar-servidor-local)
4. [Verificar Conexión con Supabase](#verificar-conexión-con-supabase)
5. [Mejores Prácticas](#mejores-prácticas)
6. [Troubleshooting](#troubleshooting)

---

## 📦 Requisitos Previos

- **Navegador Web moderno** (Chrome, Firefox, Edge)
- **Editor de código** (VS Code, Sublime, etc.)
- **Servidor HTTP local** (varias opciones disponibles)

---

## ⚙️ Configuración Inicial

### 1. **Actualizar archivos de autenticación**

Los nuevos archivos ya están creados en tu proyecto:

- ✅ `config.js` - Maneja configuraciones de entorno (dev/prod)
- ✅ `auth-updated.js` - Versión mejorada con soporte multi-entorno

### 2. **Reemplazar auth.js actual**

**Opción A: Backup + Reemplazo (Recomendado)**

```bash
# En PowerShell
cd D:\2025\Sociedad_Transfusional
Copy-Item auth.js auth.js.backup
Copy-Item auth-updated.js auth.js
```

**Opción B: Mantener ambos archivos**

Puedes mantener `auth.js` original y usar `auth-updated.js` solo en desarrollo, cambiando las referencias en tus HTML.

### 3. **Actualizar tus páginas HTML**

En **TODAS** las páginas que usan autenticación (`index.html`, `login-socios.html`, `dashboard-socios.html`, etc.), agrega **ANTES** de `auth.js`:

```html
<!-- Configuración de entorno -->
<script src="config.js"></script>

<!-- Supabase Client -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<!-- Sistema de autenticación -->
<script src="auth.js"></script>
```

---

## 🖥️ Iniciar Servidor Local

**IMPORTANTE:** No puedes simplemente abrir el archivo HTML directamente. Necesitas un servidor HTTP local.

### **Opción 1: Live Server (VS Code) - MÁS FÁCIL** ⭐

1. Instala la extensión **"Live Server"** en VS Code
2. Haz clic derecho en `index.html`
3. Selecciona **"Open with Live Server"**
4. Tu navegador abrirá automáticamente en `http://127.0.0.1:5500`

### **Opción 2: Python HTTP Server**

```bash
# Python 3
cd D:\2025\Sociedad_Transfusional
python -m http.server 8000

# Luego abre: http://localhost:8000
```

### **Opción 3: Node.js http-server**

```bash
# Instalar globalmente (una sola vez)
npm install -g http-server

# Ejecutar
cd D:\2025\Sociedad_Transfusional
http-server -p 8000

# Abrir: http://localhost:8000
```

### **Opción 4: PHP Built-in Server**

```bash
cd D:\2025\Sociedad_Transfusional
php -S localhost:8000

# Abrir: http://localhost:8000
```

---

## ✅ Verificar Conexión con Supabase

### 1. **Abrir la Consola del Navegador**

- Chrome/Edge: `F12` o `Ctrl + Shift + I`
- Firefox: `F12` o `Ctrl + Shift + K`

### 2. **Buscar mensajes de configuración**

Deberías ver algo como:

```
🔧 Configuración cargada:
   📍 Entorno: development
   🏠 Local: true
   🐛 Debug: true
   🔗 Supabase URL: https://dkohwhosputnxismgkon.supabase.co

🚀 MODO DESARROLLO ACTIVADO
⚠️  Estás usando la base de datos de PRODUCCIÓN en modo LOCAL
💡 Ten cuidado con los cambios que realices

✅ Auth.js cargado correctamente
```

### 3. **Verificar badge visual**

En la esquina inferior derecha deberías ver un badge que dice:

```
🧪 MODO DESARROLLO
```

### 4. **Probar autenticación**

1. Ve a `Área de Socios`
2. Intenta hacer login
3. Revisa la consola para ver logs detallados:

```
🔐 [21:30:45] Intentando login para: test@example.com
✅ [21:30:46] Login exitoso: test@example.com
📝 [21:30:46] Actualizando perfil del socio: abc-123-def
```

---

## 🎯 Mejores Prácticas

### **1. Siempre usa el servidor local**

❌ **NO:** `file:///D:/2025/Sociedad_Transfusional/index.html`  
✅ **SÍ:** `http://localhost:8000/index.html`

### **2. Monitorea la consola**

El modo debug te mostrará:
- ✅ Operaciones exitosas
- ❌ Errores de conexión
- ⚠️ Advertencias
- 🔄 Cambios de estado de autenticación

### **3. Prueba con usuarios de testing**

Si es posible, crea usuarios específicos para testing:
- `test@sochimt.cl`
- `dev@sochimt.cl`

### **4. No hagas cambios destructivos**

Recuerda que estás usando la **MISMA base de datos** que producción:
- ✅ Prueba lecturas y consultas
- ✅ Prueba logins
- ⚠️ Ten cuidado con actualizaciones
- ❌ Evita eliminar datos

### **5. Usa Git para control de versiones**

```bash
# Antes de hacer cambios
git checkout -b feature/nueva-funcionalidad

# Después de probar localmente
git add .
git commit -m "feat: nueva funcionalidad probada localmente"

# Solo cuando estés seguro
git push origin feature/nueva-funcionalidad
```

---

## 🔧 Troubleshooting

### **Problema: CORS Error**

```
Access to fetch at 'https://...supabase.co' from origin 'null' has been blocked
```

**Solución:** Estás abriendo el archivo directamente. Usa un servidor HTTP local.

---

### **Problema: Supabase no está definido**

```
Unconfigured error: supabase is not defined
```

**Solución:** Asegúrate de que el script de Supabase se carga ANTES de `config.js`:

```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="config.js"></script>
<script src="auth.js"></script>
```

---

### **Problema: No veo el badge de desarrollo**

**Solución:** 
1. Verifica que `config.js` esté cargado correctamente
2. Abre la consola y escribe: `window.CONFIG`
3. Deberías ver el objeto de configuración

---

### **Problema: Los cambios no se reflejan**

**Solución:**
1. Limpia la caché del navegador: `Ctrl + Shift + R` (hard reload)
2. O abre en modo incógnito
3. Si usas Live Server, guarda el archivo para que recargue automáticamente

---

### **Problema: Cannot read property 'auth' of undefined**

**Solución:**
Verifica el orden de carga de scripts:
1. Supabase CDN
2. config.js
3. auth.js
4. Tu código

---

## 🔒 Seguridad en Desarrollo

### **Datos sensibles**

- Las credenciales de Supabase ya están en `config.js`
- Este archivo **NO debe** incluirse en repositorios públicos
- Agrega `config.js` a `.gitignore` si planeas hacer el repo público

### **Archivo .gitignore recomendado**

```gitignore
# Configuración local
config.js
.env
.env.local

# Node modules
node_modules/

# Logs
*.log
npm-debug.log*

# OS
.DS_Store
Thumbs.db
```

---

## 🎨 Flujo de Trabajo Recomendado

1. **Desarrolla localmente** con servidor HTTP
2. **Prueba cambios** visuales y funcionales
3. **Verifica en consola** que Supabase funciona correctamente
4. **Haz commit** de los cambios validados
5. **Push a GitHub** cuando estés satisfecho
6. **Verifica en producción** que todo funcione

---

## 📞 Necesitas Ayuda?

Si tienes problemas:

1. Revisa la consola del navegador (F12)
2. Busca mensajes de error específicos
3. Verifica que el servidor local esté corriendo
4. Confirma que todos los scripts se cargan en orden

---

## 🎉 Todo Listo!

Ahora puedes:

✅ Probar cambios localmente  
✅ Conectarte a Supabase sin problemas  
✅ Ver logs detallados en desarrollo  
✅ Implementar nuevas funcionalidades de forma segura  

**¡Feliz desarrollo! 🚀**
