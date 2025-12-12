// Netlify Function para enviar emails de registro de socios usando Resend
const templates = require('./email-templates');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Método no permitido' }) };
  }

  try {
    const data = JSON.parse(event.body);
    const { nombre, rut, email, telefono, profesion, especialidad, institucion, region, tipoMembresia, mensaje } = data;

    if (!nombre || !email || !rut) {
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
        subject: `Nueva solicitud de socio - ${nombre}`,
        html: templates.registroSocioAdmin({ nombre, rut, email, telefono, profesion, especialidad, institucion, region, tipoMembresia, mensaje })
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
        subject: '¡Solicitud de Membresía Recibida! - SOCHIMT',
        html: templates.registroSocioUsuario({ nombre })
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
