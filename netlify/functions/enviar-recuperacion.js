// Netlify Function para enviar emails de recuperación de contraseña usando Resend
const templates = require('./email-templates');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Método no permitido' }) };
  }

  try {
    const data = JSON.parse(event.body);
    const { nombre, email, codigo } = data;

    if (!email || !codigo) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Faltan campos requeridos' }) };
    }

    const RESEND_API_KEY = process.env.RESEND_API_KEY;
    if (!RESEND_API_KEY) {
      return { statusCode: 500, body: JSON.stringify({ error: 'Error de configuración' }) };
    }

    // Email de recuperación al usuario
    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'SOCHIMT <contacto@sochimt.cl>',
        to: [email],
        subject: 'Código de Recuperación - SOCHIMT',
        html: templates.recuperacionPassword({ nombre: nombre || 'Usuario', codigo })
      })
    });

    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ success: true, message: 'Código enviado correctamente' })
    };

  } catch (error) {
    console.error('Error:', error);
    return { statusCode: 500, body: JSON.stringify({ error: 'Error al procesar' }) };
  }
};
