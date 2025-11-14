# Template EmailJS - Registro de Nuevos Socios

## Instrucciones para crear el Template en EmailJS

1. Ve al dashboard de EmailJS: https://dashboard.emailjs.com/
2. Haz clic en **"Email Templates"** en el menú lateral
3. Haz clic en **"Create New Template"**
4. Copia y pega la configuración a continuación

---

## Configuración del Template

### Nombre del Template
```
SOCHIMT - Registro Nuevo Socio
```

### Template ID
```
template_registro_socio
```
**(Importante: Usa exactamente este ID, ya está configurado en el código)**

### Subject (Asunto)
```
Nueva Postulación de Socio - {{nombre_completo}}
```

### From Name
```
Sistema SOCHIMT
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
      max-width: 700px;
      margin: 20px auto;
      background: white;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    .header {
      background: linear-gradient(135deg, #2563eb 0%, #dc2626 100%);
      padding: 40px 30px;
      text-align: center;
      color: white;
    }
    .logo {
      width: 100px;
      height: 100px;
      margin: 0 auto 15px;
      background: white;
      border-radius: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    .header h1 {
      margin: 0;
      font-size: 28px;
      font-weight: 800;
      text-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .header p {
      margin: 8px 0 0;
      opacity: 0.95;
      font-size: 16px;
    }
    .content {
      padding: 40px 30px;
    }
    .alert {
      background: linear-gradient(135deg, #10b981 0%, #059669 100%);
      color: white;
      padding: 20px;
      border-radius: 12px;
      margin-bottom: 30px;
      text-align: center;
      font-weight: 600;
      font-size: 18px;
      box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
    }
    .section {
      margin-bottom: 35px;
    }
    .section-title {
      font-size: 20px;
      font-weight: 800;
      color: #2563eb;
      margin-bottom: 15px;
      padding-bottom: 10px;
      border-bottom: 3px solid #2563eb;
    }
    .info-table {
      width: 100%;
      border-collapse: collapse;
    }
    .info-table tr {
      border-bottom: 1px solid #e5e7eb;
    }
    .info-table tr:last-child {
      border-bottom: none;
    }
    .info-table td {
      padding: 12px 0;
    }
    .info-table td:first-child {
      font-weight: 600;
      color: #4b5563;
      width: 40%;
    }
    .info-table td:last-child {
      color: #1f2937;
    }
    .documents-box {
      background: #f9fafb;
      border: 2px solid #e5e7eb;
      border-radius: 12px;
      padding: 20px;
      margin-top: 20px;
    }
    .doc-link {
      display: block;
      padding: 12px 16px;
      margin: 8px 0;
      background: white;
      border: 2px solid #2563eb;
      border-radius: 8px;
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }
    .doc-link:hover {
      background: #2563eb;
      color: white;
    }
    .footer {
      background: #1f2937;
      color: #9ca3af;
      text-align: center;
      padding: 30px;
      font-size: 14px;
    }
    .footer p {
      margin: 5px 0;
    }
    .badge {
      display: inline-block;
      padding: 6px 14px;
      background: linear-gradient(135deg, #dc2626, #b91c1c);
      color: white;
      border-radius: 20px;
      font-weight: 700;
      font-size: 14px;
      margin-top: 5px;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Header -->
    <div class="header">
      <div class="logo">
        <img src="https://i.imgur.com/Qen87Xc.png" alt="SOCHIMT Logo" style="width: 80px; height: 80px; object-fit: contain;">
      </div>
      <h1>NUEVA POSTULACIÓN</h1>
      <p>Sociedad Chilena de Medicina Transfusional</p>
    </div>

    <!-- Content -->
    <div class="content">
      <!-- Alert -->
      <div class="alert">
        ✅ Se ha recibido una nueva postulación de socio
      </div>

      <!-- Datos Personales -->
      <div class="section">
        <div class="section-title">👤 DATOS PERSONALES</div>
        <table class="info-table">
          <tr>
            <td>Nombre Completo:</td>
            <td><strong>{{nombre_completo}}</strong></td>
          </tr>
          <tr>
            <td>RUT:</td>
            <td>{{rut}}</td>
          </tr>
          <tr>
            <td>Fecha de Nacimiento:</td>
            <td>{{fecha_nacimiento}}</td>
          </tr>
          <tr>
            <td>Sexo:</td>
            <td>{{sexo}}</td>
          </tr>
          <tr>
            <td>Email:</td>
            <td>{{email}}</td>
          </tr>
          <tr>
            <td>Teléfono:</td>
            <td>{{telefono}}</td>
          </tr>
        </table>
      </div>

      <!-- Información Profesional -->
      <div class="section">
        <div class="section-title">🎓 INFORMACIÓN PROFESIONAL</div>
        <table class="info-table">
          <tr>
            <td>Profesión / Título:</td>
            <td><strong>{{profesion}}</strong></td>
          </tr>
          <tr>
            <td>Universidad:</td>
            <td>{{universidad}}</td>
          </tr>
          <tr>
            <td>Registro SIS:</td>
            <td>{{registro_sis}}</td>
          </tr>
          <tr>
            <td>Años de Experiencia:</td>
            <td>{{anos_experiencia}} años</td>
          </tr>
          <tr>
            <td>Institución:</td>
            <td>{{institucion}}</td>
          </tr>
          <tr>
            <td>Cargo Actual:</td>
            <td>{{cargo}}</td>
          </tr>
        </table>
      </div>

      <!-- Categoría y Patrocinadores -->
      <div class="section">
        <div class="section-title">📌 CATEGORÍA DE POSTULACIÓN</div>
        <p style="margin: 0;"><span class="badge">{{categoria}}</span></p>

        <div style="margin-top: 20px;">
          <table class="info-table">
            <tr>
              <td>Patrocinador 1:</td>
              <td>{{patrocinador1}}</td>
            </tr>
            <tr>
              <td>Patrocinador 2:</td>
              <td>{{patrocinador2}}</td>
            </tr>
          </table>
        </div>
      </div>

      <!-- Documentos Adjuntos -->
      <div class="section">
        <div class="section-title">📎 DOCUMENTOS ADJUNTOS</div>
        <div class="documents-box">
          <p style="margin-top: 0; color: #6b7280; font-size: 14px;">
            Haz clic en los enlaces para acceder a los documentos:
          </p>

          <a href="{{url_cv}}" target="_blank" class="doc-link">
            📄 Currículum Vitae
          </a>

          <a href="{{url_antecedentes}}" target="_blank" class="doc-link">
            🛡️ Certificado de Antecedentes
          </a>

          <a href="{{url_registro_sis}}" target="_blank" class="doc-link">
            ✅ Certificado Registro SIS
          </a>

          <a href="{{url_firma_patrocinadores}}" target="_blank" class="doc-link">
            ✍️ Firma de Patrocinadores
          </a>

          <a href="{{url_otro}}" target="_blank" class="doc-link">
            📋 Otro Documento
          </a>
        </div>
      </div>

      <!-- Información Adicional -->
      <div class="section">
        <div class="section-title">ℹ️ INFORMACIÓN ADICIONAL</div>
        <table class="info-table">
          <tr>
            <td>Fecha de Postulación:</td>
            <td>{{fecha_postulacion}}</td>
          </tr>
          <tr>
            <td>Recibir Newsletter:</td>
            <td>{{recibir_newsletter}}</td>
          </tr>
          <tr>
            <td>Carpeta Documentos:</td>
            <td><code style="background: #f3f4f6; padding: 4px 8px; border-radius: 4px; font-size: 12px;">{{carpeta_documentos}}</code></td>
          </tr>
        </table>
      </div>

      <!-- Acciones Siguientes -->
      <div style="background: #fef3c7; border-left: 4px solid #f59e0b; padding: 20px; border-radius: 8px; margin-top: 30px;">
        <h3 style="margin-top: 0; color: #92400e; font-size: 16px;">⚠️ Acciones Requeridas</h3>
        <ul style="margin: 10px 0; color: #92400e; line-height: 1.8;">
          <li>Revisar toda la información proporcionada</li>
          <li>Verificar los documentos adjuntos</li>
          <li>Validar los patrocinadores (si aplica)</li>
          <li>Aprobar o rechazar la postulación en el sistema</li>
          <li>Notificar al postulante sobre la decisión</li>
        </ul>
      </div>
    </div>

    <!-- Footer -->
    <div class="footer">
      <p style="margin-bottom: 10px;"><strong>Sociedad Chilena de Medicina Transfusional</strong></p>
      <p>Este es un mensaje automático del sistema de gestión de socios</p>
      <p style="margin-top: 15px; font-size: 12px;">
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

### Datos Personales
- `{{nombre_completo}}`
- `{{rut}}`
- `{{fecha_nacimiento}}`
- `{{sexo}}`
- `{{email}}`
- `{{telefono}}`

### Información Profesional
- `{{profesion}}`
- `{{universidad}}`
- `{{registro_sis}}`
- `{{anos_experiencia}}`
- `{{institucion}}`
- `{{cargo}}`

### Categoría
- `{{categoria}}`
- `{{patrocinador1}}`
- `{{patrocinador2}}`

### Documentos
- `{{url_cv}}`
- `{{url_antecedentes}}`
- `{{url_registro_sis}}`
- `{{url_firma_patrocinadores}}`
- `{{url_otro}}`

### Información Adicional
- `{{fecha_postulacion}}`
- `{{recibir_newsletter}}`
- `{{carpeta_documentos}}`
- `{{to_email}}`
- `{{subject}}`

---

## Pasos Finales

1. **Guarda el template** en EmailJS
2. **Verifica que el Template ID sea exactamente:** `template_registro_socio`
3. **Prueba el template** usando la función "Test" de EmailJS
4. **Asegúrate** de que el Service ID `service_7uxenu4` esté activo

---

## Funcionamiento

Cuando un usuario complete el formulario de registro:

1. ✅ Los datos se guardan en Supabase
2. 📤 Los documentos se suben a Supabase Storage
3. 📧 Se envía un email a `contacto@sochimt.cl` con:
   - Toda la información del postulante
   - Enlaces directos a los documentos
   - Detalles de categoría y patrocinadores
4. ✅ El usuario recibe confirmación en pantalla

---

**¿Necesitas ayuda?**

Si tienes problemas con la configuración, revisa:
- Que el Template ID sea exactamente `template_registro_socio`
- Que todas las variables `{{}}` estén correctamente escritas
- Que el Service ID esté activo y verificado
- Que tu cuenta de EmailJS esté verificada
