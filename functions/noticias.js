// --- TU NUEVA BASE DE DATOS DE NOTICIAS ---
// Para actualizar tu web, solo edita este arreglo.
const noticiasDB = [
  {
    titulo: 'Prueba',
    fecha: '14 de junio de 2025',
    resumen: 'cfbnfg',
    categoria: 'Webinar',
    imagen: 'https://i.imgur.com/uT0mE5e.png', // Sube imágenes a imgur.com para un enlace permanente
    url: '#'
  },
  {
    titulo: 'Ceremonia Lanzamiento Sochimt',
    fecha: '14 de junio de 2025',
    resumen: 'La recepción del evento marcó el inicio de esta significativa jornada. Fue una instancia cordial y enriquecedora...',
    categoria: 'Evento',
    imagen: 'https://i.imgur.com/tuqjI4H.png',
    url: '#'
  },
  {
    titulo: 'Sociedad Chilena de Medicina Transfusional',
    fecha: '05 de junio de 2025',
    resumen: 'El pasado viernes 6 de junio de 2025 se realizó la ceremonia de apertura de la Sociedad Chilena de Medicina Transfusional...',
    categoria: 'Evento',
    imagen: 'https://i.imgur.com/L3gO1un.png',
    url: 'https://www.linkedin.com/posts/guillermo-alfonso-jerez-jerez-860842281_el-pasado-viernes-06-de-junio-en-el-campus-activity-7337676979099328512-kJKU'
  }
];

// --- LÓGICA DE LA FUNCIÓN (No necesitas tocar esto) ---
exports.handler = async function (event, context) {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(noticiasDB),
  };
};
