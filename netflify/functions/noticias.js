// --- TU NUEVA BASE DE DATOS DE NOTICIAS ---
const noticiasDB = [
  {
    titulo: 'Ceremonia Lanzamiento Sochimt',
    fecha: '14 de junio de 2025',
    resumen: 'La recepción del evento marcó el inicio de esta significativa jornada. Fue una instancia cordial y enriquecedora, donde los asistentes demostraron entusiasmo, compromiso y una excelente disposición.',
    categoria: 'Evento',
    // IMPORTANTE: Sube tus imágenes a un servicio como https://imgur.com/ y pega el enlace directo aquí.
    imagen: 'https://i.imgur.com/tuqjI4H.png', 
    url: '#' // Coloca aquí el enlace a la noticia completa si tienes una página dedicada.
  },
  {
    titulo: 'Apertura de la Sociedad Chilena de Medicina Transfusional',
    fecha: '06 de junio de 2025',
    resumen: 'El pasado viernes 6 de junio se realizó la ceremonia de apertura oficial, marcando el inicio de sus actividades académicas, de investigación y difusión en el país.',
    categoria: 'Evento',
    imagen: 'https://i.imgur.com/L3gO1un.png',
    url: 'https://www.linkedin.com/posts/guillermo-alfonso-jerez-jerez-860842281_el-pasado-viernes-06-de-junio-en-el-campus-activity-7337676979099328512-kJKU'
  },
  {
    titulo: 'Próximo Webinar: Avances en Inmunohematología',
    fecha: '30 de julio de 2025',
    resumen: 'Prepárate para nuestro próximo webinar donde exploraremos los últimos avances y técnicas en el campo de la inmunohematología. ¡Inscripciones abiertas pronto!',
    categoria: 'Webinar',
    imagen: 'https://images.unsplash.com/photo-1576091160550-2173dba999ab?q=80&w=2070&auto=format&fit=crop', // Imagen de ejemplo
    url: '#'
  }
];

// Esta es la parte que Netlify ejecuta para entregar tus noticias.
exports.handler = async function (event, context) {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    // Convierte tu lista de noticias a formato de texto JSON para enviarla.
    body: JSON.stringify(noticiasDB),
  };
};
