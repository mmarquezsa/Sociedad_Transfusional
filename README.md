# SOCHIMT - Sociedad Chilena de Medicina Transfusional

Portal web oficial de la Sociedad Chilena de Medicina Transfusional (SOCHIMT), una plataforma integral para la gestión de socios, eventos, noticias y recursos educativos en el ámbito de la medicina transfusional en Chile.

---

## 👨‍💻 Autor y Propietario

**Marcelo Márquez-Sandoval**
Desarrollador Full Stack y propietario del sistema SOCHIMT

📧 Contacto: [email protegido]
🔗 GitHub: [perfil de desarrollador]

© 2024-2025 Marcelo Márquez-Sandoval. Todos los derechos reservados.

---

## 📋 Descripción del Proyecto

SOCHIMT es un sistema web completo que incluye:

- 🏠 **Portal Público**: Página principal con información institucional
- 👥 **Sistema de Socios**: Registro, login y dashboard para miembros
- 📰 **Gestión de Noticias**: Panel administrativo para publicar contenido
- 📅 **Gestión de Eventos**: Sistema de inscripción y calendario
- 🤖 **Chatbot IA "Gotita"**: Asistente virtual especializado (en desarrollo)
- 📚 **Biblioteca de Recursos**: Repositorio de material educativo
- 🎓 **Certificaciones**: Sistema de emisión y validación de certificados
- 🤝 **Convenios**: Gestión de colaboraciones institucionales

---

## 🚀 Tecnologías Utilizadas

### Frontend
- **HTML5** - Estructura semántica
- **TailwindCSS** - Framework CSS utility-first
- **JavaScript Vanilla** - Interactividad y lógica de negocio

### Backend & Base de Datos
- **Supabase** - Backend as a Service (BaaS)
  - PostgreSQL Database
  - Authentication & Authorization
  - Row Level Security (RLS)
  - Storage para archivos
  - Realtime subscriptions

### Deployment & CI/CD
- **Netlify** - Hosting y despliegue continuo
- **Netlify Functions** - Serverless functions para API
- **Git** - Control de versiones

### Herramientas de Desarrollo
- **VS Code** - Editor de código
- **GitHub** - Repositorio de código

---

## 📁 Estructura del Proyecto

```
Sociedad_Transfusional/
│
├── 📄 Archivos de Configuración
│   ├── .gitignore              # Archivos ignorados por Git
│   ├── .env                    # Variables de entorno (NO SUBIR A GIT)
│   ├── package.json            # Dependencias Node.js
│   ├── netlify.toml            # Configuración de Netlify
│   └── sitemap.xml             # Mapa del sitio para SEO
│
├── 🌐 Páginas HTML Principales
│   ├── index.html              # Página de inicio
│   ├── contacto.html           # Formulario de contacto
│   ├── colaboraciones.html     # Página de colaboraciones
│   └── gestion_noticias.html  # Panel admin de noticias
│
├── 👥 Sistema de Socios
│   ├── login-socios.html       # Login para miembros
│   ├── registro-socios.html    # Registro multi-paso
│   ├── dashboard-socios.html   # Dashboard de socios
│   ├── gestion-miembros-base.html # Panel gestión miembros
│   ├── seccion_directorio.html # Directorio público
│   └── seccion_miembros.html   # Sección miembros
│
├── 💻 JavaScript
│   ├── js/
│   │   ├── auth.js             # Sistema de autenticación
│   │   └── config.js           # Configuración Supabase
│   └── netlify/functions/
│       └── noticias.js         # API serverless de noticias
│
├── 🎨 Assets
│   ├── images/
│   │   ├── logos/              # Logos institucionales
│   │   ├── banners/            # Imágenes de banner
│   │   ├── icons/              # Iconos sociales
│   │   └── favicons/           # Favicons del sitio
│   ├── media/
│   │   └── Intro_Sochimt.mp4  # Video institucional
│   └── assets/                 # CSS y JS adicionales
│
├── 🗄️ Base de Datos
│   └── sql/
│       ├── setup_sistema_completo.sql # Setup completo BD
│       ├── configurar_roles_admin.sql # Roles y permisos
│       └── ...                 # Scripts SQL adicionales
│
├── 📚 Documentación
│   └── docs/
│       ├── ARQUITECTURA_COMPLETA.md
│       ├── DESARROLLO_LOCAL.md
│       └── ...                 # Documentación técnica
│
└── 🔧 Scripts Auxiliares
    └── scripts/utils/
        ├── convert_to_members.py
        └── start-local.ps1
```

---

## ⚙️ Instalación y Configuración

### Prerrequisitos
- Node.js 16+ instalado
- Cuenta en Supabase
- Cuenta en Netlify (opcional para deploy)
- Git instalado

### 1. Clonar el Repositorio
```bash
git clone [URL_DEL_REPOSITORIO]
cd Sociedad_Transfusional
```

### 2. Instalar Dependencias
```bash
npm install
```

### 3. Configurar Variables de Entorno

Crear archivo `.env` en la raíz del proyecto:

```env
SUPABASE_URL=tu_url_de_supabase
SUPABASE_ANON_KEY=tu_clave_anonima_de_supabase
```

### 4. Configurar Base de Datos en Supabase

1. Ir a Supabase Dashboard → SQL Editor
2. Ejecutar los scripts SQL en este orden:
   - `sql/setup_sistema_completo.sql`
   - `sql/configurar_roles_admin.sql`
   - `sql/CREAR_POLITICAS_RLS_ADMIN.sql`

### 5. Actualizar Configuración

Editar `js/config.js` con tus credenciales de Supabase:

```javascript
const SUPABASE_URL = 'https://tu-proyecto.supabase.co';
const SUPABASE_ANON_KEY = 'tu_clave_anonima_aqui';
```

### 6. Ejecutar en Local

**Windows:**
```powershell
.\scripts\utils\start-local.ps1
```

**Linux/Mac:**
```bash
npx http-server -p 8080
# o
python3 -m http.server 8080
```

Abrir navegador en `http://localhost:8080`

---

## 🚀 Deployment en Netlify

### Opción 1: Conectar con GitHub
1. Push del código a GitHub
2. Ir a Netlify Dashboard
3. "New site from Git"
4. Seleccionar repositorio
5. Configurar variables de entorno (SUPABASE_URL, SUPABASE_ANON_KEY)
6. Deploy automático

### Opción 2: Deploy Manual con CLI
```bash
npm install -g netlify-cli
netlify login
netlify init
netlify deploy --prod
```

---

## 📊 Funcionalidades Principales

### 🏠 Portal Público
- Página de inicio con diseño moderno y responsive
- Carrusel de noticias dinámico integrado con Supabase
- Sección de convenios con modales interactivos
- Formulario de contacto con envío de emails
- Mapa interactivo de Chile con macrozonas
- Directorio público de miembros
- Sección "Sobre Nosotros"

### 👥 Sistema de Socios
- **Registro Multi-paso**: Formulario con validación en tiempo real
- **Login Seguro**: Autenticación con Supabase Auth y JWT
- **Dashboard Personalizado**: Panel de control para cada socio
- **Gestión de Perfil**: Edición de información personal y avatar
- **Niveles de Membresía**: Socio activo, honorario, estudiante, etc.
- **Historial de Actividades**: Registro de participación en eventos

### 📰 Sistema de Noticias
- Panel administrativo CRUD completo
- Editor de contenido enriquecido
- Categorización y etiquetas
- Publicación programada
- Integración con carrusel en homepage
- Gestión de imágenes destacadas

### 🤝 Convenios y Colaboraciones
- Gestión de convenios institucionales
- Modales con información detallada de beneficios
- Sistema de descuentos para socios
- Contacto directo con instituciones colaboradoras

---

## 🔐 Seguridad

### Implementaciones de Seguridad
- ✅ Row Level Security (RLS) en todas las tablas de Supabase
- ✅ Autenticación JWT con Supabase Auth
- ✅ Validación de formularios en frontend y backend
- ✅ Variables de entorno para credenciales sensibles
- ✅ HTTPS obligatorio en producción
- ✅ Sanitización de inputs para prevenir XSS
- ✅ Políticas de acceso basadas en roles

### Roles de Usuario
- **Público**: Acceso a páginas públicas solamente
- **Socio**: Acceso a dashboard y recursos exclusivos
- **Admin**: Gestión completa del sistema

---

## 🗄️ Base de Datos (Supabase)

### Tablas Principales
1. **socios** - Información completa de miembros
2. **articulos** - Blog y noticias
3. **eventos** - Calendario de eventos
4. **inscripciones** - Registro a eventos
5. **recursos** - Biblioteca de materiales
6. **certificaciones** - Sistema de certificados
7. **base_conocimientos** - Base para IA Gotita
8. **conversaciones_gotita** - Historial del chatbot
9. **suscriptores_newsletter** - Gestión de newsletter
10. **logs_acceso** - Auditoría del sistema

---

## 📧 Configuración de Emails

El sistema utiliza:
- **Netlify Forms** para formularios públicos
- **Supabase Functions** para emails transaccionales
- Envío de notificaciones de:
  - Formulario de contacto
  - Solicitudes de membresía
  - Confirmaciones de eventos
  - Bienvenida a nuevos socios

---

## 🧪 Testing y Usuario de Prueba

### Crear Usuario de Prueba
Ver archivo: `sql/crear_usuario_marcelo.sql`

### Datos de Ejemplo
Ejecutar: `sql/datos_ejemplo_SIMPLE_miembros.sql`

### Flujo de Prueba Recomendado
1. ✅ Registrarse como nuevo socio
2. ✅ Verificar email de confirmación
3. ✅ Hacer login en el sistema
4. ✅ Acceder al dashboard de socio
5. ✅ Editar perfil y subir avatar
6. ✅ Visualizar convenios y beneficios
7. ✅ Inscribirse a un evento

---

## 📝 Roadmap y Próximas Mejoras

### ✅ Completado
- [x] Portal público con diseño responsive
- [x] Sistema de autenticación y autorización
- [x] Dashboard de socios funcional
- [x] Gestión de noticias
- [x] Sistema de convenios institucionales
- [x] Mapa interactivo de Chile

### 🚧 En Desarrollo
- [ ] Integración de chatbot IA "Gotita"
- [ ] Calendario interactivo de eventos
- [ ] Sistema de certificaciones digitales
- [ ] Biblioteca de recursos con búsqueda avanzada

### 📋 Backlog
- [ ] Sistema de pagos online para membresías
- [ ] App móvil nativa (React Native)
- [ ] Sistema de notificaciones push
- [ ] Newsletter automatizado
- [ ] Foro de discusión entre socios
- [ ] Videoteca de conferencias
- [ ] Sistema de mentorías
- [ ] Integración con redes sociales

---

## 🤝 Contribuciones y Colaboraciones

Este proyecto es de propiedad privada de **Marcelo Márquez-Sandoval**.

Para consultas, colaboraciones o solicitudes de características, contactar directamente al propietario.

---

## 📄 Licencia

**© 2024-2025 Marcelo Márquez-Sandoval. Todos los derechos reservados.**

Este proyecto es propiedad privada. No se permite la reproducción, distribución o uso sin autorización expresa y por escrito del propietario.

El código fuente, diseño, arquitectura y documentación son propiedad exclusiva de Marcelo Márquez-Sandoval.

---

## 📞 Contacto

**Desarrollador y Propietario**: Marcelo Márquez-Sandoval

**Organización Cliente**: SOCHIMT - Sociedad Chilena de Medicina Transfusional
**Sitio Web**: [www.sochimt.cl](https://www.sochimt.cl)
**Email**: contacto@sochimt.cl

---

## 🏆 Créditos

- **Desarrollo, Diseño y Arquitectura**: Marcelo Márquez-Sandoval
- **Framework CSS**: TailwindCSS
- **Backend as a Service**: Supabase
- **Hosting & CI/CD**: Netlify
- **Cliente**: SOCHIMT - Sociedad Chilena de Medicina Transfusional

---

## 📈 Estadísticas del Proyecto

- **Líneas de Código**: ~15,000+ líneas
- **Archivos HTML**: 13 páginas
- **Scripts SQL**: 12 archivos de base de datos
- **Documentación**: 15+ archivos MD
- **Imágenes y Media**: ~20 MB de recursos
- **Tiempo de Desarrollo**: 6+ meses

---

## 📚 Documentación Adicional

Para documentación técnica detallada, consultar la carpeta `/docs`:

- [ARQUITECTURA_COMPLETA.md](docs/ARQUITECTURA_COMPLETA.md) - Arquitectura del sistema
- [DESARROLLO_LOCAL.md](docs/DESARROLLO_LOCAL.md) - Guía de desarrollo
- [CONFIGURACION_SUPABASE_STORAGE.md](docs/CONFIGURACION_SUPABASE_STORAGE.md) - Storage
- [RESUMEN_SISTEMA_ROLES.md](docs/RESUMEN_SISTEMA_ROLES.md) - Sistema de roles
- [MEJORAS_SUGERIDAS.md](docs/MEJORAS_SUGERIDAS.md) - Roadmap detallado

---

**Última actualización**: Noviembre 2024
**Versión**: 1.0.0
**Estado**: ✅ En Producción

---

**Desarrollado con ❤️ y dedicación por Marcelo Márquez-Sandoval**
**Para la comunidad médica de medicina transfusional en Chile**
