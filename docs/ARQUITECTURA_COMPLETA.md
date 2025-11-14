# 🏗️ Arquitectura Completa - SOCHIMT Platform

## 🎯 Visión General

Plataforma profesional con dos niveles de acceso:
- **🌐 Público:** Información general, noticias básicas, contacto
- **👤 Socios (Login requerido):** IA Gotita, blog completo, eventos, certificaciones, recursos premium

---

## 🤖 IA "Gotita" - Asistente Especializado

### **Concepto**
IA conversacional especializada en medicina transfusional, enfocada en **selección de donantes**.

### **Características Principales**

#### **1. Personalidad y Branding**
- **Nombre:** Gotita 💧
- **Avatar:** Gota de sangre amigable y profesional
- **Tono:** Profesional pero accesible, empático
- **Especialización:** Selección de donantes, criterios de elegibilidad, protocolos transfusionales

#### **2. Capacidades**
- ✅ Consultas sobre criterios de selección de donantes
- ✅ Evaluación de elegibilidad según cuestionarios
- ✅ Referencias a guías y protocolos vigentes
- ✅ Casos clínicos interactivos
- ✅ Historial de conversaciones guardado
- ✅ Citas de fuentes científicas
- ✅ Idioma: Español chileno

#### **3. Tecnología**

**Opción A: OpenAI GPT-4** (Recomendado)
```javascript
// Implementación con system prompt especializado
const systemPrompt = `Eres "Gotita", un asistente de IA especializado en medicina transfusional de SOCHIMT (Sociedad Chilena de Medicina Transfusional).

ESPECIALIZACIÓN: Selección de donantes de sangre
CONOCIMIENTOS:
- Criterios de elegibilidad para donación de sangre
- Contraindicaciones temporales y permanentes
- Protocolos de evaluación pre-donación
- Normativas chilenas (Minsal)
- Guías internacionales (AABB, WHO)

PERSONALIDAD:
- Profesional pero cercano
- Empático y paciente
- Preciso en la información
- Siempre recomienda consultar con profesionales cuando sea necesario

FORMATO DE RESPUESTA:
- Clara y estructurada
- Con referencias cuando sea posible
- Casos complejos: sugerir consulta con especialista
- Incluir disclaimer cuando corresponda

IDIOMA: Español chileno

Cuando no estés seguro de algo, di "Recomiendo consultar con el médico transfusionista de tu centro" en lugar de adivinar.`;
```

**Opción B: Anthropic API** (Excelente para contextos largos)
- Ventaja: Mejor comprensión de documentos médicos extensos
- Modelos de lenguaje avanzados

**Opción C: Gemini Pro** (Google)
- Ventaja: Gratuito con buenos límites
- Multimodal (puede analizar imágenes)

#### **4. Integración con Base de Conocimientos**

**Tabla Supabase:**
```sql
CREATE TABLE base_conocimientos (
  id BIGSERIAL PRIMARY KEY,
  titulo VARCHAR(500),
  categoria VARCHAR(100), -- 'criterios_seleccion', 'contraindicaciones', 'protocolos'
  contenido TEXT,
  fuente VARCHAR(500),
  url_referencia TEXT,
  fecha_actualizacion DATE,
  palabras_clave TEXT[],
  vector_embedding vector(1536), -- Para búsqueda semántica
  activo BOOLEAN DEFAULT true
);

CREATE INDEX idx_conocimientos_categoria ON base_conocimientos(categoria);
CREATE INDEX idx_conocimientos_vector ON base_conocimientos USING ivfflat (vector_embedding vector_cosine_ops);
```

#### **5. Historial de Conversaciones**
```sql
CREATE TABLE conversaciones_gotita (
  id BIGSERIAL PRIMARY KEY,
  socio_id BIGINT REFERENCES socios(id),
  session_id UUID DEFAULT gen_random_uuid(),
  mensaje_usuario TEXT NOT NULL,
  respuesta_gotita TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT NOW(),
  tokens_usados INT,
  fuentes_citadas TEXT[]
);
```

#### **6. UI del Chat**
```html
<!-- Widget flotante de Gotita -->
<div id="gotita-widget" class="fixed bottom-6 right-6 z-50">
  <!-- Botón flotante -->
  <button id="gotita-toggle" class="relative">
    <div class="w-16 h-16 bg-gradient-to-br from-red-500 to-red-600 rounded-full shadow-2xl flex items-center justify-center animate-bounce-subtle">
      <span class="text-3xl">💧</span>
    </div>
    <div class="absolute -top-1 -right-1 w-6 h-6 bg-green-500 rounded-full border-2 border-white"></div>
  </button>

  <!-- Ventana de chat -->
  <div id="gotita-chat" class="hidden absolute bottom-20 right-0 w-96 h-[600px] bg-white rounded-2xl shadow-2xl flex flex-col">
    <!-- Header -->
    <div class="bg-gradient-to-r from-red-500 to-red-600 text-white p-4 rounded-t-2xl flex items-center justify-between">
      <div class="flex items-center space-x-3">
        <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
          <span class="text-2xl">💧</span>
        </div>
        <div>
          <h3 class="font-bold">Gotita</h3>
          <p class="text-xs text-white/80">Asistente de Selección de Donantes</p>
        </div>
      </div>
      <button id="close-gotita" class="text-white/80 hover:text-white">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>

    <!-- Mensajes -->
    <div id="chat-messages" class="flex-1 overflow-y-auto p-4 space-y-4 bg-gray-50">
      <!-- Mensaje de bienvenida -->
      <div class="flex items-start space-x-2">
        <div class="w-8 h-8 bg-red-500 rounded-full flex items-center justify-center flex-shrink-0">
          <span>💧</span>
        </div>
        <div class="bg-white rounded-2xl rounded-tl-none p-3 shadow-sm max-w-[80%]">
          <p class="text-sm text-gray-800">
            ¡Hola! Soy Gotita 💧, tu asistente especializado en selección de donantes.
            ¿En qué puedo ayudarte hoy?
          </p>
          <p class="text-xs text-gray-500 mt-2">
            Ejemplos: "¿Puede donar alguien con diabetes?" • "Criterios para donación de plaquetas" • "Contraindicaciones temporales"
          </p>
        </div>
      </div>
    </div>

    <!-- Input -->
    <div class="p-4 border-t bg-white rounded-b-2xl">
      <form id="gotita-form" class="flex space-x-2">
        <input 
          type="text" 
          id="gotita-input" 
          placeholder="Escribe tu consulta..." 
          class="flex-1 px-4 py-3 border-2 border-gray-200 rounded-full focus:border-red-500 focus:outline-none"
          required
        >
        <button 
          type="submit" 
          class="bg-red-500 hover:bg-red-600 text-white p-3 rounded-full transition-colors"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
          </svg>
        </button>
      </form>
      <p class="text-xs text-gray-500 mt-2 text-center">
        🔒 Solo para socios de SOCHIMT
      </p>
    </div>
  </div>
</div>
```

---

## 🔐 Sistema de Autenticación de Socios

### **1. Tabla de Socios**
```sql
CREATE TABLE socios (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  nombre_completo VARCHAR(255) NOT NULL,
  rut VARCHAR(20) UNIQUE,
  especialidad VARCHAR(100),
  ciudad VARCHAR(100),
  telefono VARCHAR(20),
  foto_perfil_url TEXT,
  
  -- Estado de membresía
  estado VARCHAR(50) DEFAULT 'pendiente', -- 'pendiente', 'activo', 'suspendido', 'inactivo'
  tipo_membresia VARCHAR(50) DEFAULT 'regular', -- 'regular', 'estudiante', 'honorario', 'vitalicio'
  fecha_ingreso DATE,
  fecha_vencimiento DATE,
  
  -- Verificación
  email_verificado BOOLEAN DEFAULT false,
  token_verificacion VARCHAR(100),
  
  -- Preferencias
  recibir_newsletter BOOLEAN DEFAULT true,
  categorias_interes TEXT[],
  
  -- Metadata
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  ultimo_acceso TIMESTAMP
);

-- Índices
CREATE INDEX idx_socios_email ON socios(email);
CREATE INDEX idx_socios_estado ON socios(estado);
CREATE INDEX idx_socios_rut ON socios(rut);
```

### **2. Sistema de Sesiones**
```sql
CREATE TABLE sesiones_socios (
  id BIGSERIAL PRIMARY KEY,
  socio_id BIGINT REFERENCES socios(id) ON DELETE CASCADE,
  token VARCHAR(255) UNIQUE NOT NULL,
  ip_address VARCHAR(50),
  user_agent TEXT,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_sesiones_token ON sesiones_socios(token);
CREATE INDEX idx_sesiones_socio ON sesiones_socios(socio_id);
```

### **3. Logs de Acceso**
```sql
CREATE TABLE logs_acceso (
  id BIGSERIAL PRIMARY KEY,
  socio_id BIGINT REFERENCES socios(id),
  accion VARCHAR(100), -- 'login', 'logout', 'acceso_contenido', 'consulta_gotita'
  recurso_accedido VARCHAR(500),
  ip_address VARCHAR(50),
  timestamp TIMESTAMP DEFAULT NOW()
);
```

### **4. Implementación de Login**

**HTML - Página de Login:**
```html
<!DOCTYPE html>
<html lang="es">
<head>
  <title>Área de Socios - SOCHIMT</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-red-50 to-blue-50 min-h-screen">
  
  <!-- Login Form -->
  <div class="min-h-screen flex items-center justify-center p-4">
    <div class="bg-white rounded-3xl shadow-2xl max-w-md w-full p-8">
      
      <!-- Logo y Header -->
      <div class="text-center mb-8">
        <div class="w-20 h-20 bg-gradient-to-br from-red-500 to-red-600 rounded-2xl flex items-center justify-center mx-auto mb-4">
          <span class="text-4xl">💧</span>
        </div>
        <h1 class="text-3xl font-black text-gray-800">Área de Socios</h1>
        <p class="text-gray-600 mt-2">SOCHIMT - Acceso Exclusivo</p>
      </div>

      <!-- Formulario -->
      <form id="login-form" class="space-y-6">
        
        <div>
          <label class="block text-sm font-bold text-gray-700 mb-2">
            📧 Email
          </label>
          <input 
            type="email" 
            id="email" 
            required 
            class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-red-500 focus:outline-none"
            placeholder="tu@email.com"
          >
        </div>

        <div>
          <label class="block text-sm font-bold text-gray-700 mb-2">
            🔐 Contraseña
          </label>
          <input 
            type="password" 
            id="password" 
            required 
            class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-red-500 focus:outline-none"
            placeholder="••••••••"
          >
        </div>

        <div class="flex items-center justify-between">
          <label class="flex items-center">
            <input type="checkbox" class="mr-2">
            <span class="text-sm text-gray-600">Recordarme</span>
          </label>
          <a href="#" class="text-sm text-red-600 hover:text-red-700 font-medium">
            ¿Olvidaste tu contraseña?
          </a>
        </div>

        <button 
          type="submit" 
          class="w-full bg-gradient-to-r from-red-500 to-red-600 text-white py-4 rounded-xl font-bold text-lg hover:from-red-600 hover:to-red-700 transition-all shadow-lg hover:shadow-xl transform hover:scale-105"
        >
          🚀 Iniciar Sesión
        </button>

        <div class="text-center">
          <p class="text-gray-600 text-sm">
            ¿No eres socio aún? 
            <a href="#socios" class="text-red-600 hover:text-red-700 font-bold">
              Únete ahora
            </a>
          </p>
        </div>
      </form>

      <!-- Características del área de socios -->
      <div class="mt-8 p-4 bg-gray-50 rounded-xl">
        <h3 class="font-bold text-gray-800 mb-3 text-center">
          Beneficios Exclusivos 🎁
        </h3>
        <ul class="space-y-2 text-sm text-gray-600">
          <li class="flex items-center">
            <svg class="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            IA Gotita 💧 - Consultas especializadas
          </li>
          <li class="flex items-center">
            <svg class="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            Artículos y casos clínicos completos
          </li>
          <li class="flex items-center">
            <svg class="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            Inscripción a eventos y webinars
          </li>
          <li class="flex items-center">
            <svg class="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            Recursos y protocolos descargables
          </li>
          <li class="flex items-center">
            <svg class="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
            </svg>
            Certificaciones y créditos
          </li>
        </ul>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
  <script src="auth.js"></script>
</body>
</html>
```

**JavaScript - auth.js:**
```javascript
// Configuración de Supabase
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// Login
document.getElementById('login-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;
  
  try {
    // Usar Supabase Auth
    const { data, error } = await supabaseClient.auth.signInWithPassword({
      email: email,
      password: password
    });
    
    if (error) throw error;
    
    // Guardar sesión
    localStorage.setItem('socio_token', data.session.access_token);
    localStorage.setItem('socio_data', JSON.stringify(data.user));
    
    // Registrar log de acceso
    await supabaseClient.from('logs_acceso').insert({
      socio_id: data.user.id,
      accion: 'login',
      ip_address: await getClientIP()
    });
    
    // Redirigir al dashboard
    window.location.href = 'dashboard-socios.html';
    
  } catch (error) {
    showNotification('Error: ' + error.message, 'error');
  }
});

// Verificar si hay sesión activa
function checkAuth() {
  const token = localStorage.getItem('socio_token');
  if (!token) {
    window.location.href = 'login-socios.html';
  }
  return token;
}

// Logout
function logout() {
  localStorage.removeItem('socio_token');
  localStorage.removeItem('socio_data');
  window.location.href = 'index.html';
}
```

---

## 📊 Dashboard de Socios

### **Estructura del Dashboard:**
```html
<div class="dashboard-grid">
  
  <!-- Bienvenida personalizada -->
  <section class="welcome-section">
    <h1>¡Bienvenido/a, Dr. Juan Pérez! 👋</h1>
    <p>Estado: <span class="badge-activo">Activo</span></p>
    <p>Membresía válida hasta: 31/12/2025</p>
  </section>

  <!-- Acceso rápido a Gotita -->
  <section class="gotita-card">
    <div class="icon">💧</div>
    <h3>Consulta a Gotita</h3>
    <p>Tu asistente de IA especializado</p>
    <button onclick="openGotita()">Iniciar Consulta</button>
  </section>

  <!-- Próximos eventos -->
  <section class="eventos-section">
    <h3>Próximos Eventos</h3>
    <!-- Lista de eventos con botón de inscripción -->
  </section>

  <!-- Artículos recientes -->
  <section class="articulos-section">
    <h3>Últimos Artículos</h3>
    <!-- Grid de artículos -->
  </section>

  <!-- Recursos descargables -->
  <section class="recursos-section">
    <h3>Recursos</h3>
    <!-- Lista de PDFs, guías, protocolos -->
  </section>

  <!-- Mis certificaciones -->
  <section class="certificaciones-section">
    <h3>Mis Certificaciones</h3>
    <!-- Lista de certificaciones obtenidas -->
  </section>

</div>
```

---

## 🚀 Plan de Implementación por Fases

### **FASE 1: Fundamentos (1-2 semanas)**
- ✅ Sistema de autenticación con Supabase Auth
- ✅ Tabla de socios y permisos
- ✅ Página de login responsive
- ✅ Dashboard básico de socios
- ✅ Middleware de protección de rutas

### **FASE 2: IA Gotita (1 semana)**
- ✅ Integración con OpenAI API
- ✅ System prompt especializado
- ✅ Widget de chat flotante
- ✅ Base de conocimientos inicial
- ✅ Historial de conversaciones

### **FASE 3: Contenido Premium (2-3 semanas)**
- ✅ Blog/Artículos con editor rico
- ✅ Sistema de comentarios
- ✅ Categorías y tags
- ✅ Búsqueda de artículos

### **FASE 4: Eventos y Calendario (2 semanas)**
- ✅ Calendario interactivo
- ✅ Sistema de inscripciones
- ✅ Emails de confirmación
- ✅ Integración con Google Calendar

### **FASE 5: Recursos y Certificaciones (1-2 semanas)**
- ✅ Biblioteca de recursos
- ✅ Sistema de descargas tracking
- ✅ Generador de certificados PDF
- ✅ Validación online de certificados

### **FASE 6: Newsletter y Comunicaciones (1 semana)**
- ✅ Sistema de suscripción
- ✅ Templates de emails
- ✅ Segmentación de audiencia
- ✅ Métricas de apertura

---

## 💰 Costos Estimados (Mensual)

| Servicio | Costo (USD/mes) | Notas |
|----------|----------------|-------|
| **Supabase** | $0-25 | Gratis hasta 500MB DB + 2GB storage |
| **OpenAI API (Gotita)** | $20-100 | Depende del uso (~1000-5000 consultas/mes) |
| **Vercel/Netlify Hosting** | $0-20 | Gratis para proyectos pequeños |
| **SendGrid (Emails)** | $0-15 | Gratis hasta 100 emails/día |
| **Cloudflare CDN** | $0 | Gratis |
| **Dominio** | $1-2 | ~$15/año |
| **TOTAL** | **$21-162/mes** | Escalable según uso |

---

## 📈 Métricas y Analytics

### **Métricas Clave:**
- 👥 **Socios activos** vs inactivos
- 💬 **Uso de Gotita**: Consultas/día, temas más consultados
- 📚 **Engagement de contenido**: Artículos más leídos, tiempo de lectura
- 🎟️ **Eventos**: Tasa de inscripción, asistencia real
- 📥 **Descargas**: Recursos más populares
- 📧 **Newsletter**: Tasa de apertura, CTR

### **Dashboard de Analytics:**
```sql
-- Vista consolidada
CREATE VIEW analytics_dashboard AS
SELECT 
  (SELECT COUNT(*) FROM socios WHERE estado = 'activo') as socios_activos,
  (SELECT COUNT(*) FROM conversaciones_gotita WHERE timestamp > NOW() - INTERVAL '30 days') as consultas_gotita_mes,
  (SELECT COUNT(*) FROM articulos_leidos WHERE fecha_lectura > NOW() - INTERVAL '30 days') as articulos_leidos_mes,
  (SELECT COUNT(*) FROM inscripciones WHERE fecha_inscripcion > NOW() - INTERVAL '30 days') as inscripciones_mes,
  (SELECT COUNT(*) FROM descargas_recursos WHERE fecha_descarga > NOW() - INTERVAL '30 days') as descargas_mes;
```

---

## 🔒 Seguridad y Privacidad

### **Medidas Implementadas:**
1. **Encriptación**: Contraseñas con bcrypt
2. **Tokens JWT**: Para sesiones seguras
3. **Rate Limiting**: Prevenir abuso de Gotita
4. **GDPR Compliance**: Consentimiento de datos
5. **Auditoría**: Logs de todos los accesos
6. **2FA (Opcional)**: Autenticación de dos factores

---

¿Empezamos con la Fase 1 (Autenticación) o prefieres que implemente directamente el widget de Gotita? 🚀💧
