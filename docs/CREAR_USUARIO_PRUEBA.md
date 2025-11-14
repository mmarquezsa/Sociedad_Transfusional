# 👤 Crear Usuario de Prueba - Marcelo

## 🎯 Credenciales del Usuario

```
Email: marcelo@sochimt.cl
Contraseña: marcelo
```

---

## 📝 Pasos para Crear el Usuario (Método Rápido)

### **Opción 1: Desde Supabase Dashboard (Recomendado - 2 minutos)**

#### **Paso 1: Crear en Authentication**

1. Ve a: https://supabase.com/dashboard/project/dkohwhosputnxismgkon
2. Click en **Authentication** en el menú lateral
3. Click en **Users**
4. Click en **Add user** (botón verde arriba a la derecha)
5. Selecciona **"Create new user"**
6. Completa el formulario:
   ```
   Email: marcelo@sochimt.cl
   Password: marcelo
   Auto Confirm User: ✅ (IMPORTANTE: marcar esta casilla)
   ```
7. Click en **"Create user"**
8. **¡COPIA EL UUID!** Aparece en la columna "ID" (ejemplo: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`)

#### **Paso 2: Agregar a Tabla Socios**

1. En el mismo Dashboard, ve a **Table Editor**
2. Selecciona la tabla **`socios`**
3. Click en **"Insert"** → **"Insert row"**
4. Completa los campos:

```
id: [PEGA AQUÍ EL UUID QUE COPIASTE]
nombre_completo: Marcelo Márquez Salinas
rut: 12.345.678-9
fecha_nacimiento: 1985-03-15
sexo: Masculino
email: marcelo@sochimt.cl
telefono: +56 9 1234 5678
profesion: Tecnólogo Médico
universidad: Universidad de Chile
registro_sis: TM-12345
anos_experiencia: 15
institucion: Hospital Clínico Universidad de Chile
cargo: Jefe Banco de Sangre
categoria: A
tipo_membresia: activo
estado: activo
rol: admin
fecha_postulacion: 2025-01-01
fecha_aprobacion: 2025-01-02
fecha_vencimiento: 2026-01-01
recibir_newsletter: true
```

5. Click en **"Save"**

#### **Paso 3: Verificar**

Ejecuta este query en **SQL Editor**:

```sql
SELECT 
  id,
  nombre_completo,
  email,
  estado,
  tipo_membresia,
  fecha_vencimiento
FROM public.socios 
WHERE email = 'marcelo@sochimt.cl';
```

Deberías ver el registro de Marcelo.

---

### **Opción 2: Usando SQL (Para usuarios avanzados - 1 minuto)**

1. Ve a **SQL Editor** en Supabase
2. Ejecuta este script (reemplaza `TU_UUID_AQUI` con el UUID del usuario de Auth):

```sql
-- Primero crea el usuario en Authentication (paso manual)
-- Luego ejecuta esto con su UUID:

INSERT INTO public.socios (
  id,
  nombre_completo,
  rut,
  fecha_nacimiento,
  sexo,
  email,
  telefono,
  profesion,
  universidad,
  registro_sis,
  anos_experiencia,
  institucion,
  cargo,
  categoria,
  tipo_membresia,
  estado,
  fecha_postulacion,
  fecha_aprobacion,
  fecha_vencimiento,
  recibir_newsletter
) VALUES (
  'TU_UUID_AQUI',  -- ⚠️ Reemplazar
  'Marcelo Márquez Salinas',
  '12.345.678-9',
  '1985-03-15',
  'Masculino',
  'marcelo@sochimt.cl',
  '+56 9 1234 5678',
  'Tecnólogo Médico',
  'Universidad de Chile',
  'TM-12345',
  15,
  'Hospital Clínico Universidad de Chile',
  'Jefe Banco de Sangre',
  'A',
  'activo',
  'activo',
  '2025-01-01',
  '2025-01-02',
  '2026-01-01',
  true
);
```

---

## 🧪 Probar el Sistema

### **1. Probar Login Local**

```powershell
# Inicia el servidor
cd D:\2025\Sociedad_Transfusional
.\start-local.ps1

# Abre en navegador
http://localhost:8000/login-socios.html
```

**Ingresa:**
- Email: `marcelo@sochimt.cl`
- Contraseña: `marcelo`

### **2. Probar Login en Producción**

```
https://[tu-dominio-github-pages]/login-socios.html
```

Mismas credenciales.

---

## ✅ Lo que Verás al Iniciar Sesión

### **Dashboard Principal:**

1. **Banner de Bienvenida:**
   - "¡Bienvenido/a de vuelta! 👋"
   - "Buenos días/tardes/noches, Marcelo"
   - Estado: ✅ Activo
   - "Válida por XXX días más"

2. **Estadísticas (4 tarjetas):**
   - 💬 Consultas a Gotita: 0
   - 📅 Eventos Inscritos: 0
   - 📚 Artículos Leídos: 0
   - 🎓 Certificaciones: 0

3. **Beneficios Exclusivos (sección principal):**
   
   ```
   Beneficios Exclusivos
   
   💧 IA Gotita
      Consultas especializadas ilimitadas
   
   📚 Blog Premium
      Artículos y casos clínicos completos
   
   📅 Eventos
      Inscripción prioritaria con descuentos
   
   📥 Recursos
      Biblioteca de guías y protocolos
   
   🎓 Certificaciones
      Validación y tracking de créditos
   ```

4. **Tarjetas de Acceso Rápido:**
   - IA Gotita
   - Artículos Premium
   - Eventos
   - Recursos
   - Certificaciones
   - Mi Perfil

5. **Actividad Reciente:**
   - (vacía por ahora)

---

## 🎨 Funcionalidades Implementadas

### **✅ Completas:**
- Login/Logout
- Dashboard con beneficios exclusivos
- Estadísticas en tiempo real
- Verificación de membresía
- Diseño responsive

### **🚧 En Desarrollo:**
- IA Gotita (chatbot)
- Blog Premium
- Sistema de eventos
- Biblioteca de recursos
- Certificaciones

---

## 🔧 Troubleshooting

### **Error: "Invalid login credentials"**

**Causa:** El usuario no existe en Authentication o la contraseña es incorrecta.

**Solución:**
1. Verifica que el usuario existe en Authentication
2. Verifica que está marcado como "Confirmed"
3. Intenta resetear la contraseña

---

### **Error: "User not found in database"**

**Causa:** El usuario existe en Auth pero no en la tabla `socios`.

**Solución:**
1. Verifica que el UUID en la tabla `socios` coincide con el de Auth
2. Ejecuta el query de verificación:
   ```sql
   SELECT * FROM socios WHERE email = 'marcelo@sochimt.cl';
   ```

---

### **Error: "Membresía vencida"**

**Causa:** La fecha de vencimiento es anterior a hoy.

**Solución:**
Actualiza la fecha de vencimiento:
```sql
UPDATE socios 
SET fecha_vencimiento = '2026-12-31'
WHERE email = 'marcelo@sochimt.cl';
```

---

### **No aparecen las estadísticas**

**Causa:** Las tablas auxiliares no existen.

**Solución:**
Crea las tablas necesarias (ver archivo `crear_usuario_marcelo.sql`):
- `conversaciones_gotita`
- `inscripciones`
- `certificaciones`

---

## 📊 Estructura de Datos

### **Tabla: socios**

```sql
CREATE TABLE IF NOT EXISTS public.socios (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  nombre_completo VARCHAR(255) NOT NULL,
  rut VARCHAR(12) UNIQUE NOT NULL,
  fecha_nacimiento DATE,
  sexo VARCHAR(20),
  email VARCHAR(255) UNIQUE NOT NULL,
  telefono VARCHAR(20),
  profesion VARCHAR(255),
  universidad VARCHAR(255),
  registro_sis VARCHAR(100),
  anos_experiencia INTEGER,
  institucion VARCHAR(255),
  cargo VARCHAR(255),
  categoria VARCHAR(1),
  tipo_membresia VARCHAR(50),
  estado VARCHAR(50) DEFAULT 'pendiente',
  fecha_postulacion DATE,
  fecha_aprobacion DATE,
  fecha_vencimiento DATE,
  recibir_newsletter BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

---

## 🚀 Próximos Pasos

Una vez que el usuario Marcelo esté creado y funcionando:

1. **Desarrollar IA Gotita:**
   - Integración con OpenAI/Claude
   - Interfaz de chat
   - Historial de conversaciones

2. **Sistema de Blog Premium:**
   - Crear tabla de artículos
   - Sistema de categorías
   - Marcar artículos como leídos

3. **Sistema de Eventos:**
   - Calendario de eventos
   - Inscripciones
   - Descuentos para socios

4. **Biblioteca de Recursos:**
   - Upload de PDFs
   - Categorización
   - Búsqueda y filtros

5. **Certificaciones:**
   - Generar certificados PDF
   - Códigos de verificación
   - Tracking de créditos CME

---

## 📞 Soporte

Si tienes problemas:

1. Revisa la consola del navegador (F12)
2. Revisa los logs de Supabase
3. Verifica que las credenciales sean correctas
4. Asegúrate de que el usuario esté confirmado en Auth

---

## 👑 Panel de Administración

### **¿Qué es el Panel de Administración?**

Es una sección especial visible **SOLO** para usuarios con rol de administrador o supervisor.

### **Usuarios Administradores:**

Por defecto, estos correos tienen permisos de administrador:
- ✅ `marcelo@sochimt.cl`
- ✅ `mmarquezsa@gmail.com`

### **Roles Disponibles:**

| Rol | Permisos | Descripción |
|-----|----------|-------------|
| **👤 Socio** | Solo lectura | Puede ver y usar los beneficios, pero no editar contenido |
| **🔧 Supervisor** | Gestionar contenido | Puede agregar/editar artículos, eventos y recursos |
| **👑 Admin** | Control total | Puede gestionar todo: contenido, socios, roles |

### **Funciones del Panel de Administración:**

Cuando inicies sesión como administrador, verás 4 secciones:

1. **📝 Gestionar Artículos**
   - Crear y editar artículos del blog premium
   - Categorías y tags
   - Editor WYSIWYG
   - Programar publicaciones

2. **📅 Gestionar Eventos**
   - Crear webinars, cursos y congresos
   - Configurar inscripciones
   - Establecer descuentos para socios
   - Envío automático de certificados

3. **📥 Gestionar Recursos**
   - Subir PDFs y documentos
   - Categorías y etiquetas
   - Control de acceso
   - Estadísticas de descargas

4. **👥 Gestionar Socios** *(solo admin)*
   - Aprobar solicitudes de membresía
   - Editar perfiles de socios
   - Gestionar estados y vencimientos
   - Enviar notificaciones

### **Cómo Asignar Roles:**

```sql
-- Promover a supervisor
UPDATE public.socios 
SET rol = 'supervisor' 
WHERE email = 'usuario@ejemplo.com';

-- Promover a admin
UPDATE public.socios 
SET rol = 'admin' 
WHERE email = 'usuario@ejemplo.com';

-- Regresar a socio regular
UPDATE public.socios 
SET rol = 'socio' 
WHERE email = 'usuario@ejemplo.com';
```

Ver archivo: `configurar_roles_admin.sql` para más detalles.

---

## 🎉 ¡Listo!

Tu usuario de prueba **Marcelo** está configurado y listo para usar.

**Credenciales:**
- 📧 Email: `marcelo@sochimt.cl`
- 🔑 Contraseña: `marcelo`
- 👑 Rol: **Administrador**

**URL de Login:**
- Local: `http://localhost:8000/login-socios.html`
- Producción: `https://[tu-dominio]/login-socios.html`

**Al iniciar sesión verás:**
- ✅ Dashboard de socio
- ✅ Panel de Administración (corona dorada 👑)
- ✅ Opciones para gestionar contenido
