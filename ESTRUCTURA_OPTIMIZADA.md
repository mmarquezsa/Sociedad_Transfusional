# Estructura Optimizada del Proyecto SOCHIMT

**Última actualización**: Noviembre 2024
**Versión**: 2.0 (Optimizada)
**Autor**: Marcelo Márquez-Sandoval

---

## 📂 Estructura de Directorios Optimizada

```
Sociedad_Transfusional/
│
├── 📄 Archivos de Configuración Raíz
│   ├── .env                        # Variables de entorno (NO SUBIR A GIT)
│   ├── .gitignore                  # Archivos ignorados por Git
│   ├── package.json                # Dependencias Node.js
│   ├── package-lock.json           # Lock de dependencias
│   ├── netlify.toml                # Configuración Netlify deployment
│   ├── sitemap.xml                 # Mapa del sitio para SEO
│   ├── README.md                   # Documentación principal (ESTE ARCHIVO)
│   └── ESTRUCTURA_OPTIMIZADA.md    # Estructura del proyecto (actualizada)
│
├── 🌐 PÁGINAS HTML - PORTAL PÚBLICO
│   ├── index.html                  # Página de inicio (185KB) ⭐
│   ├── contacto.html               # Formulario de contacto (16KB)
│   └── colaboraciones.html         # Página de colaboraciones (19KB)
│
├── 👥 PÁGINAS HTML - SISTEMA DE SOCIOS
│   ├── login-socios.html           # Login autenticación (17KB)
│   ├── registro-socios.html        # Registro multi-paso (55KB)
│   ├── dashboard-socios.html       # Dashboard socios (30KB)
│   ├── gestion-miembros-base.html  # Panel admin gestión (44KB)
│   ├── seccion_directorio.html     # Directorio público (10KB)
│   └── seccion_miembros.html       # Sección miembros (17KB)
│
├── 📰 PÁGINAS HTML - ADMINISTRACIÓN
│   └── gestion_noticias.html       # Panel admin noticias (44KB)
│
├── 💻 js/                          # JavaScript del Proyecto
│   ├── auth.js                     # Sistema de autenticación Supabase (14KB)
│   └── config.js                   # Configuración Supabase (4KB)
│
├── 🎨 images/                      # Recursos Visuales Organizados
│   ├── logos/                      # Logos Institucionales
│   │   ├── _ Main Logo 1.3.png    # Logo principal SOCHIMT (113KB)
│   │   └── Transparent_logo.png    # Logo con transparencia (128KB)
│   │
│   ├── banners/                    # Imágenes de Banner y Cabecera
│   │   ├── Sociedad.png           # Banner principal (2.9MB)
│   │   ├── Sociedad.jpg           # Banner JPG optimizado (62KB)
│   │   ├── Sobre_nosotros_sochimt.png # Banner sobre nosotros (2.3MB)
│   │   └── TMS.png                 # Banner TMS (2.6MB)
│   │
│   ├── icons/                      # Iconos de Redes Sociales
│   │   ├── facebook.png           # Icono Facebook (7KB)
│   │   └── youtube.png             # Icono YouTube (3KB)
│   │
│   ├── favicons/                   # Favicons del Sitio
│   │   ├── favicon.ico             # Favicon principal (15KB)
│   │   ├── apple-touch-icon.png    # Apple iOS (19KB)
│   │   ├── android-chrome-192x192.png # Android 192x192 (21KB)
│   │   └── android-chrome-512x512.png # Android 512x512 (81KB)
│   │
│   └── convenios/                  # Logos de Instituciones Colaboradoras
│       ├── universidad-central-logo.png   # (placeholder)
│       └── cfb-logo.png                   # (placeholder)
│
├── 🎬 media/                       # Contenido Multimedia
│   └── Intro_Sochimt.mp4          # Video institucional (10.9MB)
│
├── ☁️ netlify/functions/          # Serverless Functions (Netlify)
│   └── noticias.js                 # API de noticias (serverless)
│
├── 🗄️ sql/                         # Scripts de Base de Datos (Supabase)
│   ├── setup_sistema_completo.sql           # Setup completo BD (17KB) ⭐
│   ├── setup_miembros_table.sql             # Tabla socios (3KB)
│   ├── configurar_roles_admin.sql           # Roles y permisos admin (5KB)
│   ├── CREAR_POLITICAS_RLS_ADMIN.sql       # Políticas RLS seguridad (4KB)
│   ├── crear_usuario_marcelo.sql            # Usuario de prueba (6KB)
│   ├── datos_ejemplo_SIMPLE_miembros.sql    # Datos de ejemplo (7KB)
│   ├── datos_ejemplo_solicitud_membresia.sql # Solicitudes ejemplo (7KB)
│   ├── INSERTAR_SOLICITUDES_PENDIENTES.sql  # Solicitudes pendientes (6KB)
│   ├── INSERTAR_SOLICITUDES_PENDIENTES_CORREGIDO.sql # Corregido (4KB)
│   ├── QUERIES_RAPIDAS_COPIAR_PEGAR.sql    # Queries útiles (8KB)
│   └── SOLUCION_FOREIGN_KEY.sql             # Fix foreign keys (3KB)
│
├── 📚 docs/                        # Documentación Técnica
│   ├── ARQUITECTURA_COMPLETA.md            # Arquitectura sistema (20KB)
│   ├── CHECKLIST_INICIO.md                 # Checklist verificación (7KB)
│   ├── CONFIGURACION_SUPABASE_STORAGE.md   # Config Storage (9KB)
│   ├── CREAR_USUARIO_PRUEBA.md             # Crear usuarios prueba (10KB)
│   ├── DESARROLLO_LOCAL.md                 # Guía desarrollo local (7KB)
│   ├── GUIA_PROBAR_SOLICITUD_MEMBRESIA.md  # Testing membresías (9KB)
│   ├── INSTRUCCIONES_MIEMBROS.md           # Manual miembros (6KB)
│   ├── INSTRUCCIONES_RAPIDAS.txt           # Quick start (8KB)
│   ├── MEJORAS_SUGERIDAS.md                # Roadmap mejoras (14KB)
│   ├── PASOS_CONFIGURACION.md              # Pasos setup (5KB)
│   ├── README_DESARROLLO.md                # README dev (11KB)
│   ├── README_PROYECTO_COMPLETO.md         # README completo (11KB)
│   ├── RESUMEN_SISTEMA_ROLES.md            # Sistema de roles (10KB)
│   └── SISTEMA_COMPLETO_LISTO.md           # Sistema listo (11KB)
│
├── 🔧 scripts/utils/               # Scripts Auxiliares
│   ├── convert_to_members.py       # Convertir datos miembros
│   └── start-local.ps1             # Script inicio local Windows
│
├── 📦 assets/                      # Assets Adicionales
│   └── (futuros CSS, JS, fonts)
│
├── 🔄 Backup_Ok/                   # Backups Locales (NO SUBIR)
│   ├── gestion_noticias.html       # Backup gestión noticias
│   ├── index.html                  # Backup index antiguo
│   └── noticias.js                 # Backup noticias API
│
├── 🔒 Carpetas de Sistema (NO SUBIR A GIT)
│   ├── .git/                       # Repositorio Git
│   ├── .github/                    # GitHub Actions workflows
│   ├── .vscode/                    # Configuración VS Code
│   └── node_modules/               # Dependencias Node (npm install)
│
└── 🚫 Archivos Eliminados en Optimización
    ├── .claude/                    # ❌ Carpeta Claude removida
    ├── auth-updated.js             # ❌ Versión desactualizada
    ├── test-supabase.html          # ❌ Archivo de prueba
    └── netflify/ (typo)            # ❌ Renombrado a netlify/
```

---

## 🎯 Cambios Realizados en la Optimización

### ✅ Archivos Movidos y Reorganizados

| Archivo Original | Nueva Ubicación | Razón |
|-----------------|-----------------|-------|
| `_ Main Logo 1.3.png` | `images/logos/` | Organización de logos |
| `Transparent_logo.png` | `images/logos/` | Organización de logos |
| `Sociedad.png` | `images/banners/` | Separación de banners |
| `Sociedad.jpg` | `images/banners/` | Separación de banners |
| `facebook.png` | `images/icons/` | Iconos sociales agrupados |
| `youtube.png` | `images/icons/` | Iconos sociales agrupados |
| `favicon.ico` | `images/favicons/` | Favicons centralizados |
| `apple-touch-icon.png` | `images/favicons/` | Favicons iOS |
| `android-chrome-*.png` | `images/favicons/` | Favicons Android |
| `Intro_Sochimt.mp4` | `media/` | Multimedia separada |
| `auth.js` | `js/` | JavaScript centralizado |
| `config.js` | `js/` | JavaScript centralizado |
| `convert_to_members.py` | `scripts/utils/` | Scripts auxiliares |
| `start-local.ps1` | `scripts/utils/` | Scripts auxiliares |

### ❌ Archivos Eliminados

- `.claude/` - Carpeta de herramienta de desarrollo no necesaria
- `auth-updated.js` - Versión desactualizada, redundante con `auth.js`
- `test-supabase.html` - Archivo de prueba no necesario en producción

### 🔄 Carpetas Renombradas

- `netflify/` → `netlify/` - Corrección de typo en nombre

### 📝 Referencias Actualizadas

Se actualizaron todas las referencias en archivos HTML:
- `"_ Main Logo 1.3.png"` → `"images/logos/_ Main Logo 1.3.png"`
- `"auth.js"` → `"js/auth.js"`
- `"config.js"` → `"js/config.js"`
- Y todas las demás rutas de recursos

---

## 📊 Tamaño del Proyecto

### Por Categoría

| Categoría | Tamaño Aproximado |
|-----------|-------------------|
| **HTML** (13 archivos) | ~450 KB |
| **JavaScript** (2 archivos) | ~18 KB |
| **SQL** (12 archivos) | ~75 KB |
| **Documentación** (16 archivos MD) | ~160 KB |
| **Imágenes** | ~8 MB |
| **Video** | ~11 MB |
| **Favicons** | ~136 KB |
| **node_modules** | ~varios MB (no se sube) |

**Total del repositorio** (sin node_modules): **~20-22 MB**

---

## 🚀 Beneficios de la Nueva Estructura

### 1. **Organización Clara**
- ✅ Todos los recursos visuales en `/images` con subcarpetas temáticas
- ✅ JavaScript centralizado en `/js`
- ✅ Multimedia separada en `/media`
- ✅ Scripts de utilidad en `/scripts/utils`

### 2. **Mantenibilidad Mejorada**
- ✅ Fácil localización de archivos por categoría
- ✅ Nomenclatura consistente de carpetas
- ✅ Eliminación de redundancias

### 3. **Performance**
- ✅ Archivos organizados facilitan caching
- ✅ Separación de assets por tipo
- ✅ Fácil identificación de recursos pesados para optimización

### 4. **Despliegue Optimizado**
- ✅ Estructura compatible con Netlify
- ✅ Carpetas de sistema excluidas del deploy
- ✅ Variables de entorno separadas del código

---

## 🔍 Flujo de Archivos por Funcionalidad

### 🏠 Portal Público
**Archivos principales:**
- `index.html` - Página principal
- `contacto.html` - Formulario de contacto
- `colaboraciones.html` - Convenios institucionales

**Recursos utilizados:**
- `images/logos/` - Logo SOCHIMT
- `images/banners/` - Imágenes de secciones
- `media/Intro_Sochimt.mp4` - Video institucional
- `images/icons/` - Redes sociales

**JavaScript:**
- Integración con Supabase (noticias, eventos)
- Mapa interactivo de Chile
- Carrusel de noticias

---

### 🔐 Sistema de Autenticación
**Archivos principales:**
- `login-socios.html` - Login
- `registro-socios.html` - Registro multi-paso

**JavaScript:**
- `js/auth.js` - Lógica de autenticación
- `js/config.js` - Credenciales Supabase

**SQL:**
- `sql/configurar_roles_admin.sql` - Roles
- `sql/CREAR_POLITICAS_RLS_ADMIN.sql` - Seguridad RLS

---

### 👨‍💼 Portal de Socios
**Archivos principales:**
- `dashboard-socios.html` - Dashboard
- `gestion-miembros-base.html` - Gestión de miembros

**JavaScript:**
- `js/auth.js` - Validación de sesión
- `js/config.js` - Conexión a BD

**SQL:**
- `sql/setup_miembros_table.sql` - Tabla socios
- `sql/datos_ejemplo_SIMPLE_miembros.sql` - Datos de prueba

---

### 📰 Sistema de Noticias
**Archivos principales:**
- `gestion_noticias.html` - Panel admin
- Integrado en `index.html` - Carrusel público

**Serverless:**
- `netlify/functions/noticias.js` - API serverless

**SQL:**
- Tabla `articulos` en `sql/setup_sistema_completo.sql`

---

## 🗄️ Base de Datos (Supabase)

### Tablas del Sistema

1. **socios** - Información completa de miembros
2. **base_conocimientos** - Base para IA Gotita
3. **conversaciones_gotita** - Historial chat IA
4. **articulos** - Blog y noticias
5. **eventos** - Calendario de eventos
6. **inscripciones** - Registro a eventos
7. **recursos** - Biblioteca de documentos
8. **certificaciones** - Sistema de certificados
9. **suscriptores_newsletter** - Newsletter
10. **logs_acceso** - Auditoría de accesos

### Scripts de Configuración (Orden de Ejecución)

1. `setup_sistema_completo.sql` - Crear todas las tablas
2. `configurar_roles_admin.sql` - Configurar roles y permisos
3. `CREAR_POLITICAS_RLS_ADMIN.sql` - Aplicar seguridad RLS
4. `crear_usuario_marcelo.sql` - Crear usuario admin de prueba
5. `datos_ejemplo_SIMPLE_miembros.sql` - Poblar con datos de ejemplo

---

## 📋 Checklist de Verificación Post-Optimización

### ✅ Archivos Movidos
- [x] Logos movidos a `images/logos/`
- [x] Banners movidos a `images/banners/`
- [x] Iconos movidos a `images/icons/`
- [x] Favicons movidos a `images/favicons/`
- [x] Video movido a `media/`
- [x] JavaScript movido a `js/`
- [x] Scripts movidos a `scripts/utils/`

### ✅ Referencias Actualizadas
- [x] Referencias en `index.html`
- [x] Referencias en `registro-socios.html`
- [x] Referencias en `dashboard-socios.html`
- [x] Referencias en `login-socios.html`
- [x] Referencias en otros archivos HTML

### ✅ Archivos Eliminados
- [x] `.claude/` eliminado
- [x] `auth-updated.js` eliminado
- [x] `test-supabase.html` eliminado

### ✅ Carpetas Corregidas
- [x] `netflify/` renombrado a `netlify/`

### ✅ Documentación
- [x] README.md actualizado con autoría
- [x] ESTRUCTURA_OPTIMIZADA.md creado
- [x] Licencia y derechos de autor claros

---

## 🔄 Próximos Pasos

### Inmediatos
1. ✅ Probar sitio localmente con nuevas rutas
2. ⏳ Verificar conexiones Supabase funcionan correctamente
3. ⏳ Probar formularios de contacto y registro
4. ⏳ Verificar envío de emails

### Corto Plazo
- [ ] Optimizar imágenes grandes (comprimir PNGs)
- [ ] Implementar lazy loading para imágenes
- [ ] Minificar JavaScript y CSS
- [ ] Configurar CDN para recursos estáticos

### Mediano Plazo
- [ ] Implementar sistema de build (Webpack/Vite)
- [ ] Agregar testing automatizado
- [ ] Configurar CI/CD pipeline
- [ ] Implementar monitoreo de errores

---

## 🎓 Convenciones de Nombres

### Archivos HTML
- **Formato**: `nombre-con-guiones.html` (kebab-case)
- **Ejemplos**: `gestion-miembros-base.html`, `registro-socios.html`

### Archivos JavaScript
- **Formato**: `nombre-con-guiones.js` (kebab-case)
- **Ejemplos**: `auth.js`, `config.js`

### Archivos SQL
- **Scripts importantes**: `MAYUSCULAS_CON_GUIONES.sql`
- **Scripts auxiliares**: `minusculas_con_guiones.sql`
- **Ejemplos**: `CREAR_POLITICAS_RLS_ADMIN.sql`, `setup_miembros_table.sql`

### Carpetas
- **Formato**: `minusculas` sin guiones
- **Ejemplos**: `docs`, `sql`, `images`, `scripts`

### Subcarpetas
- **Formato**: `minusculas` descriptivas
- **Ejemplos**: `logos`, `banners`, `icons`, `utils`

---

## 🔒 Seguridad y Buenas Prácticas

### Archivos que NO deben subirse a Git
```
.env
node_modules/
.vscode/
Backup_Ok/
.DS_Store
*.log
```

### Variables Sensibles (en `.env`)
```
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

### Permisos de Archivos
- Scripts `.ps1` y `.py` deben ser ejecutables
- Archivos de configuración deben ser de solo lectura en producción

---

## 📞 Información del Proyecto

**Proyecto**: Portal Web SOCHIMT
**Autor y Propietario**: Marcelo Márquez-Sandoval
**Cliente**: Sociedad Chilena de Medicina Transfusional
**Versión**: 1.0.0 (Estructura 2.0)
**Última Optimización**: Noviembre 2024

---

**© 2024-2025 Marcelo Márquez-Sandoval. Todos los derechos reservados.**
