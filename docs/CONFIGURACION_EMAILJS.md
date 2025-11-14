# Configuración de EmailJS para Formulario de Contacto

## ¿Qué es EmailJS?
EmailJS es un servicio gratuito que permite enviar emails directamente desde JavaScript sin necesidad de un servidor backend. Ofrece **200 emails gratis al mes**, suficiente para la mayoría de sitios web.

## Paso 1: Crear Cuenta en EmailJS

1. Ve a [https://www.emailjs.com/](https://www.emailjs.com/)
2. Haz clic en "Sign Up" (Registrarse)
3. Crea una cuenta usando tu email (puedes usar contacto@sochimt.cl)
4. Verifica tu email

## Paso 2: Conectar tu Servicio de Email

1. Una vez dentro, ve a "Email Services" en el menú lateral
2. Haz clic en "Add New Service"
3. Selecciona tu proveedor de email (recomendado: Gmail)
4. Sigue las instrucciones para conectar tu cuenta de Gmail
5. **Copia el SERVICE_ID** que aparece (ej: "service_abc123")

## Paso 3: Crear Template para SOCHIMT (Email Principal)

1. Ve a "Email Templates" en el menú lateral
2. Haz clic en "Create New Template"
3. Usa esta configuración:

**Nombre del Template:** "SOCHIMT - Contacto Web"

**Subject (Asunto):**
```
[Contacto Web] {{motivo}} - {{from_name}}
```

**Content (Contenido del email):**
```
Nuevo mensaje desde el formulario de contacto de SOCHIMT

-----------------------------------
INFORMACIÓN DEL CONTACTO
-----------------------------------
Nombre: {{from_name}}
Email: {{from_email}}
Teléfono: {{telefono}}
Región: {{region}}
Motivo: {{motivo}}

-----------------------------------
MENSAJE
-----------------------------------
{{message}}

-----------------------------------
Responder a: {{reply_to}}
```

**To Email:** contacto@sochimt.cl

4. Haz clic en "Save"
5. **Copia el TEMPLATE_ID** (ej: "template_xyz789")

## Paso 4: Crear Template de Auto-Respuesta

1. Crea otro template nuevo
2. Usa esta configuración:

**Nombre del Template:** "SOCHIMT - Confirmación Auto-Respuesta"

**Subject (Asunto):**
```
Confirmación de Contacto - SOCHIMT
```

**Content (Contenido del email):**
```
Estimado/a {{to_name}},

Hemos recibido tu mensaje correctamente. Nuestro equipo revisará tu consulta y nos comunicaremos contigo a la brevedad.

Gracias por contactar a la Sociedad Chilena de Medicina Transfusional.

Saludos cordiales,
Equipo SOCHIMT

---
Sociedad Chilena de Medicina Transfusional
Web: https://sochimt.cl
Email: contacto@sochimt.cl
```

**To Email:** {{to_email}}

3. Haz clic en "Save"
4. **Copia el TEMPLATE_ID** de este template (ej: "template_auto123")

## Paso 5: Obtener tu Public Key

1. Ve a "Account" → "General" en el menú
2. Busca la sección "Public Key"
3. **Copia tu PUBLIC_KEY** (ej: "user_abc123xyz")

## Paso 6: Actualizar el código en contacto.html

Abre el archivo `contacto.html` y busca estas líneas (alrededor de la línea 261):

```javascript
emailjs.init('TU_PUBLIC_KEY');
```

Reemplaza con:
```javascript
emailjs.init('tu_public_key_real_aqui');
```

Luego busca estas líneas (alrededor de la línea 298 y 311):

```javascript
emailjs.send('TU_SERVICE_ID', 'TU_TEMPLATE_ID', templateParams)
```

Reemplaza con:
```javascript
emailjs.send('tu_service_id', 'tu_template_id_principal', templateParams)
```

Y:
```javascript
return emailjs.send('TU_SERVICE_ID', 'TU_AUTOREPLY_TEMPLATE_ID', autoReplyParams);
```

Reemplaza con:
```javascript
return emailjs.send('tu_service_id', 'tu_template_id_autoreply', autoReplyParams);
```

## Ejemplo de Reemplazo Completo

**ANTES:**
```javascript
emailjs.init('TU_PUBLIC_KEY');
...
emailjs.send('TU_SERVICE_ID', 'TU_TEMPLATE_ID', templateParams)
...
return emailjs.send('TU_SERVICE_ID', 'TU_AUTOREPLY_TEMPLATE_ID', autoReplyParams);
```

**DESPUÉS:**
```javascript
emailjs.init('user_abc123xyz');
...
emailjs.send('service_gmail123', 'template_contacto456', templateParams)
...
return emailjs.send('service_gmail123', 'template_autoreply789', autoReplyParams);
```

## Verificar que Funciona

1. Abre [contacto.html](../contacto.html) en tu navegador
2. Llena el formulario de contacto
3. Haz clic en "Enviar Mensaje"
4. Deberías ver:
   - El botón cambia a un spinner de carga
   - Después aparece "✓ Mensaje Enviado" en verde
   - Recibes un email en contacto@sochimt.cl con el mensaje
   - El usuario recibe un email de confirmación automática

## Límites del Plan Gratuito

- **200 emails por mes** (gratis)
- Si necesitas más, puedes actualizar a plan pagado ($15/mes por 1000 emails)

## Solución de Problemas

### Error: "emailjs is not defined"
- Verifica que la línea `<script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>` esté en el `<head>` del HTML

### Emails no llegan
- Verifica que los IDs estén correctos
- Revisa la consola del navegador (F12) para ver errores
- Verifica en EmailJS Dashboard → "Email Log" para ver el estado de los emails

### Email de auto-respuesta no llega al usuario
- Verifica que el template de auto-respuesta tenga `{{to_email}}` en el campo "To Email"
- Revisa la carpeta de spam del usuario

## Soporte

Si tienes problemas, puedes:
- Ver la documentación de EmailJS: https://www.emailjs.com/docs/
- Contactar soporte de EmailJS: support@emailjs.com
- Ver el Email Log en tu dashboard de EmailJS para debug

---

**¡Listo!** Ahora tu formulario de contacto enviará emails automáticamente y gratis, con confirmación al usuario.
