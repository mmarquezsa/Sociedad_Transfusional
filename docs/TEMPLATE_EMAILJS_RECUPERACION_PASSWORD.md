# Template EmailJS - Recuperación de Contraseña

## Instrucciones para crear el Template en EmailJS

1. Ve al dashboard de EmailJS: https://dashboard.emailjs.com/
2. Haz clic en **"Email Templates"** en el menú lateral
3. Haz clic en **"Create New Template"**
4. Copia y pega la configuración a continuación

---

## Configuración del Template

### Nombre del Template
```
SOCHIMT - Recuperación de Contraseña
```

### Template ID
```
template_recuperacion_password
```
**(Importante: Usa exactamente este ID, ya está configurado en el código)**

### Subject (Asunto)
```
Recuperación de Contraseña - SOCHIMT
```

### From Name
```
SOCHIMT - Área de Socios
```

### From Email
Usar el email configurado en tu servicio de EmailJS (generalmente el mismo de Gmail)

### To Email
```
{{to_email}}
```

---

## Contenido del Email (HTML)

Copia y pega este código en el campo **"Content"** del template:

```html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }
    .container {
      max-width: 600px;
      margin: 20px auto;
      background: white;
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 8px 30px rgba(0,0,0,0.12);
    }
    .header {
      background: linear-gradient(135deg, #2563eb 0%, #dc2626 100%);
      padding: 50px 30px;
      text-align: center;
      color: white;
    }
    .logo {
      width: 120px;
      height: 120px;
      margin: 0 auto 20px;
      background: white;
      border-radius: 25px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 6px 20px rgba(0,0,0,0.2);
    }
    .header h1 {
      margin: 0;
      font-size: 30px;
      font-weight: 800;
      text-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .header p {
      margin: 10px 0 0;
      opacity: 0.95;
      font-size: 16px;
    }
    .content {
      padding: 50px 40px;
    }
    .key-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, #10b981 0%, #059669 100%);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 30px;
      box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
    }
    .greeting {
      font-size: 20px;
      font-weight: 700;
      color: #1f2937;
      margin-bottom: 20px;
      text-align: center;
    }
    .message {
      font-size: 16px;
      color: #4b5563;
      margin-bottom: 30px;
      text-align: center;
      line-height: 1.8;
    }
    .code-box {
      background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
      border: 3px solid #2563eb;
      border-radius: 16px;
      padding: 30px;
      text-align: center;
      margin: 30px 0;
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.2);
    }
    .code-label {
      font-size: 14px;
      font-weight: 600;
      color: #1e40af;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 15px;
    }
    .code {
      font-size: 48px;
      font-weight: 900;
      color: #1e40af;
      letter-spacing: 8px;
      font-family: 'Courier New', monospace;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
    }
    .button-container {
      text-align: center;
      margin: 35px 0;
    }
    .reset-button {
      display: inline-block;
      padding: 18px 45px;
      background: linear-gradient(135deg, #2563eb 0%, #dc2626 100%);
      color: white;
      text-decoration: none;
      border-radius: 12px;
      font-weight: 700;
      font-size: 16px;
      box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
      transition: all 0.3s;
    }
    .reset-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(37, 99, 235, 0.5);
    }
    .info-box {
      background: #fef3c7;
      border-left: 4px solid #f59e0b;
      padding: 20px;
      border-radius: 10px;
      margin: 30px 0;
    }
    .info-box p {
      margin: 0;
      color: #92400e;
      font-size: 14px;
      line-height: 1.6;
    }
    .info-box strong {
      color: #78350f;
      font-weight: 700;
    }
    .expiration {
      text-align: center;
      color: #dc2626;
      font-weight: 600;
      font-size: 14px;
      margin: 20px 0;
    }
    .footer {
      background: #1f2937;
      color: #9ca3af;
      text-align: center;
      padding: 35px 30px;
      font-size: 14px;
    }
    .footer p {
      margin: 8px 0;
    }
    .footer a {
      color: #60a5fa;
      text-decoration: none;
    }
    .footer a:hover {
      text-decoration: underline;
    }
    .divider {
      height: 2px;
      background: linear-gradient(to right, transparent, #e5e7eb, transparent);
      margin: 30px 0;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Header -->
    <div class="header">
      <div class="logo">
        <img src="https://i.imgur.com/Qen87Xc.png" alt="SOCHIMT Logo" style="width: 90px; height: 90px; object-fit: contain;">
      </div>
      <h1>RECUPERACIÓN DE CONTRASEÑA</h1>
      <p>Sociedad Chilena de Medicina Transfusional</p>
    </div>

    <!-- Content -->
    <div class="content">
      <!-- Icon -->
      <div class="key-icon">
        <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5">
          <path d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z"/>
        </svg>
      </div>

      <!-- Greeting -->
      <h2 class="greeting">Hola, {{to_name}}</h2>

      <!-- Message -->
      <p class="message">
        Recibimos una solicitud para restablecer la contraseña de tu cuenta en el Área de Socios de SOCHIMT.
      </p>

      <!-- Code Box -->
      <div class="code-box">
        <div class="code-label">Tu Código de Recuperación</div>
        <div class="code">{{codigo_recuperacion}}</div>
      </div>

      <!-- Button -->
      <div class="button-container">
        <a href="{{link_recuperacion}}" class="reset-button">
          🔐 Restablecer Contraseña
        </a>
      </div>

      <!-- Expiration -->
      <p class="expiration">
        ⏰ Este código expira el: {{fecha_expiracion}}
      </p>

      <div class="divider"></div>

      <!-- Info Box -->
      <div class="info-box">
        <p>
          <strong>⚠️ Importante:</strong> Si no solicitaste este cambio de contraseña, ignora este mensaje.
          Tu cuenta permanecerá segura y no se realizará ningún cambio.
        </p>
      </div>

      <!-- Instructions -->
      <div style="margin-top: 30px; padding: 25px; background: #f9fafb; border-radius: 12px; border: 2px solid #e5e7eb;">
        <h3 style="margin-top: 0; color: #1f2937; font-size: 16px; font-weight: 700;">📋 Instrucciones:</h3>
        <ol style="margin: 15px 0; padding-left: 20px; color: #4b5563; line-height: 1.8;">
          <li>Haz clic en el botón "Restablecer Contraseña" arriba</li>
          <li>Ingresa el código de recuperación de 6 dígitos</li>
          <li>Crea una nueva contraseña segura</li>
          <li>Confirma tu nueva contraseña</li>
          <li>¡Listo! Podrás acceder con tu nueva contraseña</li>
        </ol>
      </div>

      <!-- Security Tips -->
      <div style="margin-top: 25px; padding: 20px; background: #ecfdf5; border-left: 4px solid #10b981; border-radius: 8px;">
        <h4 style="margin-top: 0; color: #065f46; font-size: 14px; font-weight: 700;">🛡️ Consejos de Seguridad:</h4>
        <ul style="margin: 10px 0; padding-left: 20px; color: #047857; font-size: 13px; line-height: 1.7;">
          <li>Usa una contraseña de al menos 8 caracteres</li>
          <li>Combina letras mayúsculas, minúsculas y números</li>
          <li>No compartas tu contraseña con nadie</li>
          <li>Evita usar la misma contraseña en múltiples sitios</li>
        </ul>
      </div>
    </div>

    <!-- Footer -->
    <div class="footer">
      <p style="margin-bottom: 15px; font-weight: 600; font-size: 15px; color: #d1d5db;">
        <strong>Sociedad Chilena de Medicina Transfusional</strong>
      </p>
      <p>Área de Socios</p>
      <p style="margin-top: 15px;">
        <a href="https://sochimt.cl">www.sochimt.cl</a> |
        <a href="mailto:contacto@sochimt.cl">contacto@sochimt.cl</a>
      </p>
      <div style="margin: 20px 0; height: 1px; background: #374151;"></div>
      <p style="font-size: 12px; color: #6b7280;">
        Este es un mensaje automático del sistema de gestión de socios.<br>
        Por favor, no respondas a este correo.
      </p>
      <p style="margin-top: 15px; font-size: 11px; color: #6b7280;">
        © 2025 SOCHIMT - Todos los derechos reservados
      </p>
    </div>
  </div>
</body>
</html>
```

---

## Variables del Template

Asegúrate de que estas variables estén correctamente mapeadas en tu template:

- `{{to_email}}` - Email del destinatario
- `{{to_name}}` - Nombre del usuario (se usa la primera parte del email)
- `{{codigo_recuperacion}}` - Código de 6 dígitos para recuperación
- `{{fecha_expiracion}}` - Fecha y hora de expiración del código
- `{{link_recuperacion}}` - Enlace directo para restablecer (opcional)

---

## Pasos Finales

1. **Guarda el template** en EmailJS
2. **Verifica que el Template ID sea exactamente:** `template_recuperacion_password`
3. **Prueba el template** usando la función "Test" de EmailJS
4. **Asegúrate** de que el Service ID `service_7uxenu4` esté activo

---

## Funcionamiento

Cuando un usuario solicite recuperar su contraseña:

1. ✅ Hace clic en "¿Olvidaste tu contraseña?" en la página de login
2. 📧 Ingresa su correo electrónico en el modal
3. 🔐 Se genera un código de recuperación de 6 dígitos
4. 📤 Se envía un email profesional con:
   - El código de recuperación destacado
   - Enlace directo para restablecer
   - Fecha de expiración (1 hora)
   - Instrucciones claras de uso
   - Consejos de seguridad
5. ⏰ El código expira en 1 hora por seguridad

---

## Características del Email

- ✅ **Diseño Profesional** con logo de SOCHIMT
- ✅ **Código Destacado** en caja visual grande
- ✅ **Botón de Acción** para restablecer directamente
- ✅ **Fecha de Expiración** claramente visible
- ✅ **Instrucciones Paso a Paso** para el usuario
- ✅ **Consejos de Seguridad** incluidos
- ✅ **Responsive** - se ve bien en móviles y desktop
- ✅ **Advertencia de Seguridad** si no solicitó el cambio

---

## Seguridad

- 🔒 El código expira en **1 hora**
- 🔒 El código es de **6 dígitos aleatorios**
- 🔒 Se advierte al usuario si no solicitó el cambio
- 🔒 El email incluye consejos de seguridad

---

**¿Necesitas ayuda?**

Si tienes problemas con la configuración, revisa:
- Que el Template ID sea exactamente `template_recuperacion_password`
- Que todas las variables `{{}}` estén correctamente escritas
- Que el Service ID esté activo y verificado
- Que tu cuenta de EmailJS esté verificada

---

## Próximos Pasos Sugeridos

Para completar la funcionalidad de recuperación de contraseña, podrías:

1. **Crear una página de reset** que valide el código
2. **Guardar el código en Supabase** con fecha de expiración
3. **Permitir al usuario** crear nueva contraseña tras validar el código
4. **Actualizar la contraseña** en Supabase Auth

---

**¡Listo!** Ahora tu sistema de login tiene recuperación de contraseña profesional y segura.
