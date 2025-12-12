// Netlify Function para enviar emails de contacto usando Resend
const templates = require('./email-templates');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Método no permitido' }) };
  }

  try {
    const data = JSON.parse(event.body);
    const { nombre, email, telefono, motivo, region, mensaje } = data;

    if (!nombre || !email || !mensaje) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Faltan campos requeridos' }) };
    }

    const RESEND_API_KEY = process.env.RESEND_API_KEY;
    if (!RESEND_API_KEY) {
      return { statusCode: 500, body: JSON.stringify({ error: 'Error de configuración' }) };
    }

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
        reply_to: email,
        subject: `Nuevo mensaje de contacto - ${motivo || 'Consulta General'}`,
        html: templates.contactoAdmin({ nombre, email, telefono, motivo, region, mensaje })
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
        to: [email],
        subject: '¡Mensaje Recibido! - SOCHIMT',
        html: templates.contactoUsuario({ nombre })
      })
    });

    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ success: true, message: 'Mensaje enviado correctamente' })
    };

  } catch (error) {
    console.error('Error:', error);
    return { statusCode: 500, body: JSON.stringify({ error: 'Error al procesar' }) };
  }
};
