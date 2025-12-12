// Netlify Function para enviar emails de inscripción usando Resend
// API Key se configura en Netlify: Site Settings > Environment Variables > RESEND_API_KEY

exports.handler = async (event) => {
  // Solo permitir POST
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Método no permitido' })
    };
  }

  try {
    const data = JSON.parse(event.body);
    const { nombre, correo, institucion, mensaje, conversatorio } = data;

    // Validar campos requeridos
    if (!nombre || !correo || !institucion) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: 'Faltan campos requeridos' })
      };
    }

    const RESEND_API_KEY = process.env.RESEND_API_KEY;

    if (!RESEND_API_KEY) {
      console.error('RESEND_API_KEY no configurada');
      return {
        statusCode: 500,
        body: JSON.stringify({ error: 'Error de configuración del servidor' })
      };
    }

    // Email 1: Notificación a SOCHIMT
    const emailAdmin = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'SOCHIMT <contacto@sochimt.cl>',
        to: ['contacto@sochimt.cl'],
        reply_to: correo,
        subject: `Nueva inscripción - ${conversatorio}`,
        html: `
          <h2>Nueva inscripción al Conversatorio</h2>
          <p><strong>Conversatorio:</strong> ${conversatorio}</p>
          <hr>
          <p><strong>Nombre:</strong> ${nombre}</p>
          <p><strong>Correo:</strong> ${correo}</p>
          <p><strong>Institución:</strong> ${institucion}</p>
          <p><strong>Mensaje:</strong> ${mensaje || 'Sin mensaje adicional'}</p>
          <hr>
          <p><em>Puedes responder directamente a este correo para contactar al inscrito.</em></p>
        `
      })
    });

    if (!emailAdmin.ok) {
      const errorData = await emailAdmin.json();
      console.error('Error enviando email a admin:', errorData);
      throw new Error('Error enviando notificación');
    }

    // Email 2: Confirmación al usuario con link del Meet
    const emailUser = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'SOCHIMT <contacto@sochimt.cl>',
        to: [correo],
        subject: '¡Inscripción confirmada! - 5° Conversatorio SOCHIMT',
        html: `
          <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <div style="background: linear-gradient(135deg, #7c3aed, #a855f7); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
              <h1 style="color: white; margin: 0;">¡Inscripción Confirmada!</h1>
            </div>

            <div style="padding: 30px; background: #f9fafb; border-radius: 0 0 10px 10px;">
              <p style="font-size: 16px;">Estimado/a <strong>${nombre}</strong>,</p>

              <p style="font-size: 16px;">Tu inscripción ha sido registrada exitosamente. Te esperamos en el <strong>5° Conversatorio SOCHIMT</strong>.</p>

              <div style="background: white; padding: 20px; border-radius: 10px; margin: 20px 0; border-left: 4px solid #7c3aed;">
                <h3 style="color: #7c3aed; margin-top: 0;">Detalles del evento</h3>
                <p><strong>Tema:</strong> Reacciones Adversas a la Transfusión en el Sistema de Salud Público Chileno</p>
                <p><strong>Expositora:</strong> TM Javiera Villanueva Cortéz</p>
                <p><strong>Moderador:</strong> Juan Pablo Teyssier</p>
                <p><strong>Fecha:</strong> Miércoles 03 de diciembre de 2025</p>
                <p><strong>Hora:</strong> 20:30 hrs (Chile)</p>
              </div>

              <div style="text-align: center; margin: 30px 0;">
                <a href="https://meet.google.com/pcs-vebs-kbh"
                   style="background: linear-gradient(135deg, #2563eb, #06b6d4); color: white; padding: 15px 30px; text-decoration: none; border-radius: 30px; font-weight: bold; display: inline-block;">
                  Unirse al Google Meet
                </a>
              </div>

              <p style="font-size: 14px; color: #666;">
                <strong>Link de acceso:</strong><br>
                <a href="https://meet.google.com/pcs-vebs-kbh">https://meet.google.com/pcs-vebs-kbh</a>
              </p>

              <hr style="border: none; border-top: 1px solid #e5e7eb; margin: 20px 0;">

              <p style="font-size: 14px; color: #666;">
                ¡Te esperamos!<br>
                <strong>Equipo SOCHIMT</strong><br>
                Sociedad Chilena de Medicina Transfusional
              </p>
            </div>
          </div>
        `
      })
    });

    if (!emailUser.ok) {
      const errorData = await emailUser.json();
      console.error('Error enviando email a usuario:', errorData);
      // No fallamos si el email al admin ya se envió
    }

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Inscripción enviada correctamente'
      })
    };

  } catch (error) {
    console.error('Error en función:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Error al procesar la inscripción' })
    };
  }
};
