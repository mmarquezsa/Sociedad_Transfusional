// Templates de email para SOCHIMT - Sociedad Chilena de Medicina Transfusional
// Todos los emails usan este diseño consistente

const LOGO_URL = 'https://sochimt.cl/images/logos/Transparent_logo.png';
const SOCHIMT_COLOR = '#9f1239'; // rose-800

// Header común para todos los emails
const emailHeader = `
  <div style="background: linear-gradient(135deg, #2563eb 0%, #06b6d4 100%); padding: 30px; text-align: center; border-radius: 16px 16px 0 0;">
    <div style="width: 90px; height: 90px; background: white; border-radius: 50%; margin: 0 auto 15px; display: inline-block; padding: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.2);">
      <img src="${LOGO_URL}" alt="SOCHIMT" style="width: 100%; height: 100%; object-fit: contain;">
    </div>
    <h1 style="color: white; margin: 0; font-size: 24px; font-weight: bold;">SOCHIMT</h1>
    <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">Sociedad Chilena de Medicina Transfusional</p>
  </div>
`;

// Footer común para todos los emails
const emailFooter = `
  <div style="background: #f8fafc; padding: 25px; border-top: 1px solid #e2e8f0;">
    <p style="text-align: center; color: #64748b; font-size: 14px; margin: 0 0 15px 0; font-weight: 600;">Información de Contacto</p>

    <div style="text-align: center; margin-bottom: 15px;">
      <p style="color: #475569; font-size: 13px; margin: 5px 0;">
        <span style="color: ${SOCHIMT_COLOR};">✉</span> Email: <a href="mailto:contacto@sochimt.cl" style="color: #2563eb; text-decoration: none;">contacto@sochimt.cl</a>
      </p>
      <p style="color: #475569; font-size: 13px; margin: 5px 0;">
        <span style="color: ${SOCHIMT_COLOR};">📞</span> Teléfono: +56 9 7499 8376
      </p>
      <p style="color: #475569; font-size: 13px; margin: 5px 0;">
        <span style="color: ${SOCHIMT_COLOR};">📍</span> Ubicación: Santiago, Chile
      </p>
    </div>

    <p style="text-align: center; color: #64748b; font-size: 13px; margin: 15px 0;">Síguenos en Redes Sociales</p>
    <table align="center" border="0" cellpadding="0" cellspacing="0" style="margin: 0 auto;">
      <tr>
        <td style="padding: 0 12px;">
          <a href="https://www.facebook.com/profile.php?id=61575757064945" style="text-decoration: none;">
            <img src="https://cdn-icons-png.flaticon.com/512/5968/5968764.png" alt="Facebook" style="width: 32px; height: 32px; display: block;">
          </a>
        </td>
        <td style="padding: 0 12px;">
          <a href="https://www.youtube.com/@SOCHIMT" style="text-decoration: none;">
            <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" alt="YouTube" style="width: 32px; height: 32px; display: block;">
          </a>
        </td>
        <td style="padding: 0 12px;">
          <a href="https://www.instagram.com/sochimt_cl/" style="text-decoration: none;">
            <img src="https://cdn-icons-png.flaticon.com/512/174/174855.png" alt="Instagram" style="width: 32px; height: 32px; display: block;">
          </a>
        </td>
      </tr>
    </table>
  </div>

  <div style="background: #1e293b; padding: 20px; text-align: center; border-radius: 0 0 16px 16px;">
    <p style="color: #94a3b8; font-size: 12px; margin: 0;">© 2025 Sociedad Chilena de Medicina Transfusional</p>
    <p style="color: #64748b; font-size: 11px; margin: 5px 0 0 0;">Todos los derechos reservados</p>
    <p style="color: #475569; font-size: 10px; margin: 10px 0 0 0; font-style: italic;">Este es un mensaje automático, por favor no responder a este correo.</p>
  </div>
`;

// Wrapper base para todos los emails
const wrapEmail = (content) => `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin: 0; padding: 20px; background-color: #f1f5f9; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;">
  <div style="max-width: 600px; margin: 0 auto; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    ${emailHeader}
    ${content}
    ${emailFooter}
  </div>
</body>
</html>
`;

// ============================================
// TEMPLATES PARA INSCRIPCIÓN AL CONVERSATORIO
// ============================================

// Email de confirmación al usuario que se inscribe
const inscripcionUsuario = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #10b981; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">✓</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">¡Inscripción Confirmada!</h2>
      </div>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Estimado/a <strong>${data.nombre}</strong>,
      </p>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Tu inscripción ha sido registrada exitosamente. Te esperamos en el <strong>5° Conversatorio SOCHIMT</strong>.
      </p>

      <div style="background: #f8fafc; border-left: 4px solid #7c3aed; padding: 20px; margin: 25px 0; border-radius: 0 12px 12px 0;">
        <h3 style="color: #7c3aed; margin: 0 0 15px 0; font-size: 16px;">📋 Detalles del Evento</h3>
        <p style="color: #475569; margin: 8px 0; font-size: 14px;"><strong>Tema:</strong> Reacciones Adversas a la Transfusión en el Sistema de Salud Público Chileno</p>
        <p style="color: #475569; margin: 8px 0; font-size: 14px;"><strong>Expositora:</strong> TM Javiera Villanueva Cortéz</p>
        <p style="color: #475569; margin: 8px 0; font-size: 14px;"><strong>Moderador:</strong> Juan Pablo Teyssier</p>
        <p style="color: #475569; margin: 8px 0; font-size: 14px;"><strong>Fecha:</strong> Miércoles 03 de diciembre de 2025</p>
        <p style="color: #475569; margin: 8px 0; font-size: 14px;"><strong>Hora:</strong> 20:30 hrs (Chile)</p>
      </div>

      <div style="text-align: center; margin: 30px 0;">
        <a href="${data.linkMeet}" style="display: inline-block; background: linear-gradient(135deg, #2563eb, #06b6d4); color: white; padding: 15px 35px; text-decoration: none; border-radius: 30px; font-weight: bold; font-size: 16px;">
          🔗 Unirse al Google Meet
        </a>
      </div>

      <p style="color: #64748b; font-size: 13px; text-align: center;">
        <strong>Link de acceso:</strong><br>
        <a href="${data.linkMeet}" style="color: #2563eb;">${data.linkMeet}</a>
      </p>

      <div style="background: #fef3c7; border-radius: 12px; padding: 15px; margin-top: 25px;">
        <p style="color: #92400e; margin: 0; font-size: 13px;">
          <strong>⏰ Recordatorio:</strong> Te recomendamos conectarte 5 minutos antes del inicio.
        </p>
      </div>
    </div>
  `;
  return wrapEmail(content);
};

// Email de notificación a SOCHIMT (admin)
const inscripcionAdmin = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #2563eb; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">📝</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">Nueva Inscripción</h2>
        <p style="color: #64748b; margin: 10px 0 0 0;">${data.conversatorio}</p>
      </div>

      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin: 20px 0;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; font-size: 16px;">👤 Datos del Inscrito</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px; width: 120px;">Nombre:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px; font-weight: 600;">${data.nombre}</td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Correo:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;"><a href="mailto:${data.correo}" style="color: #2563eb;">${data.correo}</a></td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Institución:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.institucion}</td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Mensaje:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.mensaje || 'Sin mensaje adicional'}</td>
          </tr>
        </table>
      </div>

      <p style="color: #64748b; font-size: 13px; text-align: center; margin-top: 20px;">
        Puedes responder directamente a este correo para contactar al inscrito.
      </p>
    </div>
  `;
  return wrapEmail(content);
};

// ============================================
// TEMPLATES PARA FORMULARIO DE CONTACTO
// ============================================

// Email de confirmación al usuario que envía mensaje
const contactoUsuario = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #10b981; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">✓</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">¡Mensaje Recibido!</h2>
      </div>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Estimado/a <strong>${data.nombre}</strong>,
      </p>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Hemos recibido tu mensaje correctamente. Nuestro equipo revisará tu consulta y nos comunicaremos contigo <strong>a la brevedad</strong>.
      </p>

      <div style="background: #fef3c7; border-radius: 12px; padding: 15px; margin: 25px 0;">
        <p style="color: #92400e; margin: 0; font-size: 14px;">
          <strong>⏱ Tiempo de respuesta:</strong> Respondemos en un plazo máximo de 48 horas hábiles.
        </p>
      </div>

      <p style="color: #64748b; font-size: 14px; text-align: center; font-style: italic;">
        Gracias por contactar a la Sociedad Chilena de Medicina Transfusional.
      </p>
    </div>
  `;
  return wrapEmail(content);
};

// Email de notificación a SOCHIMT (admin) - Contacto
const contactoAdmin = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #f59e0b; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">📩</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">Nuevo Mensaje de Contacto</h2>
      </div>

      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin: 20px 0;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; font-size: 16px;">👤 Datos del Remitente</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px; width: 120px;">Nombre:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px; font-weight: 600;">${data.nombre}</td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Email:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;"><a href="mailto:${data.email}" style="color: #2563eb;">${data.email}</a></td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Teléfono:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.telefono || 'No proporcionado'}</td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Motivo:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.motivo}</td>
          </tr>
          <tr>
            <td style="padding: 8px 0; color: #64748b; font-size: 14px;">Región:</td>
            <td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.region || 'No especificada'}</td>
          </tr>
        </table>
      </div>

      <div style="background: #f1f5f9; border-radius: 12px; padding: 20px; margin: 20px 0;">
        <h3 style="color: #1e293b; margin: 0 0 10px 0; font-size: 16px;">💬 Mensaje</h3>
        <p style="color: #475569; font-size: 14px; line-height: 1.6; margin: 0; white-space: pre-wrap;">${data.mensaje}</p>
      </div>

      <p style="color: #64748b; font-size: 13px; text-align: center; margin-top: 20px;">
        Puedes responder directamente a este correo para contactar al remitente.
      </p>
    </div>
  `;
  return wrapEmail(content);
};

// ============================================
// TEMPLATES PARA REGISTRO DE SOCIOS
// ============================================

const registroSocioUsuario = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #10b981; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">🎉</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">¡Solicitud Recibida!</h2>
      </div>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Estimado/a <strong>${data.nombre}</strong>,
      </p>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Hemos recibido tu solicitud de membresía a la <strong>Sociedad Chilena de Medicina Transfusional</strong>.
      </p>

      <div style="background: #f0fdf4; border-left: 4px solid #10b981; padding: 20px; margin: 25px 0; border-radius: 0 12px 12px 0;">
        <h3 style="color: #166534; margin: 0 0 10px 0; font-size: 16px;">📋 Próximos pasos</h3>
        <ol style="color: #475569; font-size: 14px; line-height: 1.8; margin: 0; padding-left: 20px;">
          <li>Nuestro equipo revisará tu solicitud</li>
          <li>Recibirás un correo con los datos de pago</li>
          <li>Una vez confirmado el pago, activaremos tu membresía</li>
        </ol>
      </div>

      <div style="background: #fef3c7; border-radius: 12px; padding: 15px; margin: 25px 0;">
        <p style="color: #92400e; margin: 0; font-size: 14px;">
          <strong>⏱ Tiempo de respuesta:</strong> Te contactaremos en un plazo máximo de 48 horas hábiles.
        </p>
      </div>
    </div>
  `;
  return wrapEmail(content);
};

const registroSocioAdmin = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #8b5cf6; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">👤</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">Nueva Solicitud de Socio</h2>
      </div>

      <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin: 20px 0;">
        <h3 style="color: #1e293b; margin: 0 0 15px 0; font-size: 16px;">📋 Datos del Solicitante</h3>
        <table style="width: 100%; border-collapse: collapse;">
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px; width: 140px;">Nombre:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px; font-weight: 600;">${data.nombre}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">RUT:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.rut}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Email:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;"><a href="mailto:${data.email}" style="color: #2563eb;">${data.email}</a></td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Teléfono:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.telefono || 'No proporcionado'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Profesión:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.profesion}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Especialidad:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.especialidad || 'No especificada'}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Institución:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.institucion}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Región:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px;">${data.region}</td></tr>
          <tr><td style="padding: 8px 0; color: #64748b; font-size: 14px;">Tipo membresía:</td><td style="padding: 8px 0; color: #1e293b; font-size: 14px; font-weight: 600;">${data.tipoMembresia}</td></tr>
        </table>
      </div>

      ${data.mensaje ? `
      <div style="background: #f1f5f9; border-radius: 12px; padding: 20px; margin: 20px 0;">
        <h3 style="color: #1e293b; margin: 0 0 10px 0; font-size: 16px;">💬 Mensaje adicional</h3>
        <p style="color: #475569; font-size: 14px; line-height: 1.6; margin: 0;">${data.mensaje}</p>
      </div>
      ` : ''}
    </div>
  `;
  return wrapEmail(content);
};

// ============================================
// TEMPLATE PARA RECUPERACIÓN DE CONTRASEÑA
// ============================================

const recuperacionPassword = (data) => {
  const content = `
    <div style="padding: 30px;">
      <div style="text-align: center; margin-bottom: 25px;">
        <div style="width: 60px; height: 60px; background: #f59e0b; border-radius: 50%; margin: 0 auto 15px; display: flex; align-items: center; justify-content: center;">
          <span style="color: white; font-size: 30px;">🔑</span>
        </div>
        <h2 style="color: #1e293b; margin: 0; font-size: 24px;">Recuperación de Contraseña</h2>
      </div>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Estimado/a <strong>${data.nombre}</strong>,
      </p>

      <p style="color: #475569; font-size: 16px; line-height: 1.6;">
        Recibimos una solicitud para restablecer tu contraseña. Tu código de verificación es:
      </p>

      <div style="text-align: center; margin: 30px 0;">
        <div style="display: inline-block; background: linear-gradient(135deg, #1e293b, #334155); padding: 20px 40px; border-radius: 12px;">
          <span style="color: white; font-size: 32px; font-weight: bold; letter-spacing: 8px;">${data.codigo}</span>
        </div>
      </div>

      <p style="color: #64748b; font-size: 14px; text-align: center;">
        Este código expira en <strong>15 minutos</strong>.
      </p>

      <div style="background: #fef2f2; border-radius: 12px; padding: 15px; margin: 25px 0;">
        <p style="color: #991b1b; margin: 0; font-size: 13px;">
          <strong>⚠️ Importante:</strong> Si no solicitaste este cambio, ignora este correo. Tu contraseña permanecerá sin cambios.
        </p>
      </div>
    </div>
  `;
  return wrapEmail(content);
};

module.exports = {
  inscripcionUsuario,
  inscripcionAdmin,
  contactoUsuario,
  contactoAdmin,
  registroSocioUsuario,
  registroSocioAdmin,
  recuperacionPassword
};
