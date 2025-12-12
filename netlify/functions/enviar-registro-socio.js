// Netlify Function para enviar emails de registro de socios usando Resend
const templates = require('./email-templates');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Método no permitido' }) };
  }

  try {
    const data = JSON.parse(event.body);

    if (!data.nombreCompleto || !data.email || !data.rut) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Faltan campos requeridos' }) };
    }

    const RESEND_API_KEY = process.env.RESEND_API_KEY;
    if (!RESEND_API_KEY) {
      return { statusCode: 500, body: JSON.stringify({ error: 'Error de configuración' }) };
    }

    // Determinar nombre de categoría
    const categoriaNombre = data.categoria === 'A' ? 'Categoría A - Socio Activo' :
                            data.categoria === 'B' ? 'Categoría B - Socio Adherente' :
                            'Categoría C - Socio Estudiante';

    // Construir HTML del email para admin con todos los datos
    const adminEmailHtml = `
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"></head>
<body style="margin: 0; padding: 20px; background-color: #f1f5f9; font-family: Arial, sans-serif;">
  <div style="max-width: 700px; margin: 0 auto; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">

    <div style="background: linear-gradient(135deg, #2563eb 0%, #06b6d4 100%); padding: 30px; text-align: center;">
      <h1 style="color: white; margin: 0; font-size: 24px;">Nueva Postulación de Socio</h1>
      <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0;">${categoriaNombre}</p>
    </div>

    <div style="padding: 30px;">

      <!-- Datos Personales -->
      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; border-bottom: 2px solid #2563eb; padding-bottom: 10px;">👤 Datos Personales</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr><td style="padding: 8px 0; color: #64748b; width: 150px;">Nombre Completo:</td><td style="color: #1e293b; font-weight: 600;">${data.nombreCompleto}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">RUT:</td><td style="color: #1e293b;">${data.rut}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Fecha Nacimiento:</td><td style="color: #1e293b;">${data.fechaNacimiento || 'No especificada'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Sexo:</td><td style="color: #1e293b;">${data.sexo || 'No especificado'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Email:</td><td style="color: #1e293b;"><a href="mailto:${data.email}" style="color: #2563eb;">${data.email}</a></td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Teléfono:</td><td style="color: #1e293b;">${data.telefono || 'No proporcionado'}</td></tr>
        </table>
      </div>

      <!-- Información Profesional -->
      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; border-bottom: 2px solid #10b981; padding-bottom: 10px;">💼 Información Profesional</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr><td style="padding: 8px 0; color: #64748b; width: 150px;">Profesión:</td><td style="color: #1e293b;">${data.profesion || 'No especificada'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Universidad:</td><td style="color: #1e293b;">${data.universidad || 'No especificada'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Registro SIS:</td><td style="color: #1e293b;">${data.registroSis || 'No especificado'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Años Experiencia:</td><td style="color: #1e293b;">${data.anosExperiencia || 'No especificado'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Institución:</td><td style="color: #1e293b;">${data.institucion || 'No especificada'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b;">Cargo:</td><td style="color: #1e293b;">${data.cargo || 'No especificado'}</td></tr>
        </table>
      </div>

      <!-- Patrocinadores (si aplica) -->
      ${data.patrocinador1Nombre ? `
      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; border-bottom: 2px solid #f59e0b; padding-bottom: 10px;">🤝 Patrocinadores</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr><td style="padding: 8px 0; color: #64748b; width: 150px;">Patrocinador 1:</td><td style="color: #1e293b;">${data.patrocinador1Nombre} (RUT: ${data.patrocinador1Rut || 'N/A'})</td></tr>
          ${data.patrocinador2Nombre ? `<tr><td style="padding: 8px 0; color: #64748b;">Patrocinador 2:</td><td style="color: #1e293b;">${data.patrocinador2Nombre} (RUT: ${data.patrocinador2Rut || 'N/A'})</td></tr>` : ''}
        </table>
      </div>
      ` : ''}

      <!-- Enlaces a Documentos -->
      <div style="background: #fef3c7; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #92400e; margin: 0 0 15px 0;">📎 Documentos Adjuntos</h3>
        <ul style="color: #92400e; margin: 0; padding-left: 20px; line-height: 2;">
          ${data.urlCV ? `<li><a href="${data.urlCV}" style="color: #2563eb;">Curriculum Vitae</a></li>` : '<li>CV: No adjuntado</li>'}
          ${data.urlAntecedentes ? `<li><a href="${data.urlAntecedentes}" style="color: #2563eb;">Antecedentes</a></li>` : '<li>Antecedentes: No adjuntado</li>'}
          ${data.urlRegistroSIS ? `<li><a href="${data.urlRegistroSIS}" style="color: #2563eb;">Registro SIS</a></li>` : '<li>Registro SIS: No adjuntado</li>'}
          ${data.urlFirmaPatrocinadores ? `<li><a href="${data.urlFirmaPatrocinadores}" style="color: #2563eb;">Firma Patrocinadores</a></li>` : ''}
          ${data.urlOtro ? `<li><a href="${data.urlOtro}" style="color: #2563eb;">Otro documento</a></li>` : ''}
        </ul>
        ${data.carpetaDocumentos ? `<p style="margin: 15px 0 0 0; font-size: 13px;"><strong>Carpeta:</strong> <a href="${data.carpetaDocumentos}" style="color: #2563eb;">${data.carpetaDocumentos}</a></p>` : ''}
      </div>

      <!-- Info adicional -->
      <div style="background: #f1f5f9; border-radius: 12px; padding: 15px; text-align: center;">
        <p style="margin: 0; color: #64748b; font-size: 13px;">
          <strong>Fecha postulación:</strong> ${data.fechaPostulacion || new Date().toLocaleDateString('es-CL')} |
          <strong>Newsletter:</strong> ${data.recibirNewsletter ? 'Sí' : 'No'}
        </p>
      </div>

    </div>

    <div style="background: #1e293b; padding: 20px; text-align: center;">
      <p style="color: #94a3b8; font-size: 12px; margin: 0;">© 2025 SOCHIMT - Sociedad Chilena de Medicina Transfusional</p>
    </div>

  </div>
</body>
</html>
    `;

    // Email 1: Notificación a SOCHIMT
    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'SOCHIMT <contacto@sochimt.cl>',
        to: ['contacto@sochimt.cl'],
        reply_to: data.email,
        subject: `Nueva Postulación de Socio - ${data.nombreCompleto} - ${categoriaNombre}`,
        html: adminEmailHtml
      })
    });

    // Email 2: Confirmación al usuario
    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'SOCHIMT <contacto@sochimt.cl>',
        to: [data.email],
        subject: '¡Solicitud de Membresía Recibida! - SOCHIMT',
        html: templates.registroSocioUsuario({ nombre: data.nombreCompleto })
      })
    });

    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ success: true, message: 'Solicitud enviada correctamente' })
    };

  } catch (error) {
    console.error('Error:', error);
    return { statusCode: 500, body: JSON.stringify({ error: 'Error al procesar' }) };
  }
};
