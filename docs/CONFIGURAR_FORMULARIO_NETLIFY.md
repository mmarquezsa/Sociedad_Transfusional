# 📧 Configurar Notificaciones de Formulario en Netlify

## ✅ Lo que ya está implementado

El formulario de inscripción al conversatorio ya está configurado con **Netlify Forms** y funcionará automáticamente cuando subas los cambios a tu repositorio de GitHub y Netlify detecte el nuevo despliegue.

### Características implementadas:
- ✅ Formulario con atributo `data-netlify="true"`
- ✅ Protección anti-spam con honeypot
- ✅ Mensajes de éxito/error en tiempo real
- ✅ Spinner de carga durante el envío
- ✅ Validación de campos requeridos

---

## 🚀 Pasos para Activar las Notificaciones por Email

### **Paso 1: Hacer Deploy de los Cambios**

1. **Sube los cambios a GitHub**:
   ```bash
   git add .
   git commit -m "Agregar formulario Netlify y actualizar macrozonas"
   git push origin main
   ```

2. **Netlify detectará automáticamente** los cambios y hará el despliegue.

---

### **Paso 2: Configurar Notificaciones por Email en Netlify**

Una vez desplegado el sitio:

1. **Accede al Dashboard de Netlify**:
   - Ve a [https://app.netlify.com](https://app.netlify.com)
   - Selecciona tu sitio (proyecto SOCHIMT)

2. **Ir a la sección de Formularios**:
   - En el menú lateral, busca **"Forms"**
   - Verás el formulario `conversatorio-inscripcion` después del primer envío de prueba

3. **Configurar Notificaciones por Email**:
   - Haz clic en **"Settings"** o **"Form notifications"**
   - Selecciona **"Add notification"**
   - Elige **"Email notification"**
   - En el campo **"Email to notify"**, ingresa: **contacto@sochimt.cl**
   - Haz clic en **"Save"**

4. **Personalizar el Email (opcional)**:
   - Puedes personalizar el asunto del correo
   - Por defecto será: "New form submission from [nombre del formulario]"

---

## 📨 Formato del Email que Recibirás

Cuando alguien se inscriba, recibirás un email en **contacto@sochimt.cl** con este formato:

```
De: team@netlify.com
Para: contacto@sochimt.cl
Asunto: New submission from conversatorio-inscripcion

Form name: conversatorio-inscripcion
Submission date: [fecha y hora]

Conversatorio: 4° Conversatorio SOCHIMT - Donación de Sangre
Nombre: [nombre del usuario]
Correo: [correo del usuario]
Institución: [institución]
Mensaje: [mensaje opcional]

View all submissions: [link al dashboard de Netlify]
```

---

## 🎯 Verificar que Funciona

### **Prueba 1: Envío de Formulario**

1. Abre tu sitio en producción
2. Haz clic en **"Inscribirme sin costo"** en la sección del conversatorio
3. Llena el formulario con datos de prueba
4. Haz clic en **"Enviar solicitud"**
5. Deberías ver:
   - Un spinner de carga
   - Mensaje de éxito: "¡Inscripción enviada exitosamente!"
   - El modal se cerrará automáticamente después de 4 segundos

### **Prueba 2: Verificar en Netlify Dashboard**

1. Ve a **Netlify Dashboard > Forms**
2. Deberías ver el formulario `conversatorio-inscripcion`
3. Haz clic para ver las **submissions** (envíos)
4. Verás todos los datos enviados

### **Prueba 3: Verificar Email**

1. Revisa tu correo **contacto@sochimt.cl**
2. Deberías recibir un email de Netlify con los datos del formulario
3. Si no llega, revisa la carpeta de spam

---

## 🔧 Solución de Problemas

### **El formulario no aparece en Netlify**
- **Causa**: Netlify necesita detectar al menos 1 envío de formulario antes de mostrarlo en el dashboard
- **Solución**: Haz un envío de prueba desde el sitio en producción (no desde localhost)

### **No recibo emails**
- **Causa**: Notificaciones no configuradas
- **Solución**: Configura las notificaciones siguiendo el **Paso 2** arriba

### **Aparece "Error al enviar la inscripción"**
- **Causa**: El formulario podría no estar correctamente configurado con Netlify
- **Solución**: Verifica que:
  - El atributo `data-netlify="true"` está en el `<form>`
  - El campo `<input type="hidden" name="form-name" value="conversatorio-inscripcion" />` está presente
  - El sitio está desplegado en Netlify (no funciona en localhost)

---

## 📊 Ver Todos los Envíos en Netlify

Puedes ver todos los envíos del formulario en:
1. **Netlify Dashboard > Forms**
2. Haz clic en `conversatorio-inscripcion`
3. Verás una tabla con:
   - Fecha y hora de envío
   - Nombre
   - Correo
   - Institución
   - Mensaje
4. Puedes **exportar los datos a CSV** para análisis

---

## 🎉 Ventajas de Netlify Forms

✅ **Gratis** hasta 100 envíos/mes (plan gratuito)
✅ **Sin backend** necesario - todo es automático
✅ **Anti-spam** integrado con honeypot
✅ **Almacenamiento** de todos los envíos en Netlify
✅ **Notificaciones** por email automáticas
✅ **Exportable** a CSV o webhook para integraciones

---

## 📞 Contacto

Si tienes problemas con la configuración:
1. Verifica que los cambios estén en GitHub y desplegados en Netlify
2. Haz una prueba de envío desde el sitio en producción
3. Revisa la consola del navegador (F12) para ver errores

---

**Última actualización:** 2025-11-10
**Responsable:** Equipo Web SOCHIMT
