exports.handler = async (event, context) => {
  console.log('🚀 Función noticias ejecutándose');
  console.log('Método:', event.httpMethod);
  
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Content-Type': 'application/json'
  };

  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  if (event.httpMethod !== 'GET') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Método no permitido' })
    };
  }

  try {
    // Datos de prueba mientras solucionamos la conexión
    const noticiasTest = [
      {
        id: 1,
        titulo: "Congreso Nacional de Medicina Transfusional 2025",
        categoria: "Evento",
        fecha: "2025-03-15",
        resumen: "Únete al evento más importante del año en medicina transfusional.",
        url_externa: "https://www.sochimt.cl",
        url_media: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=250&fit=crop"
      },
      {
        id: 2,
        titulo: "Nueva Guía de Seguridad Transfusional",
        categoria: "Publicación",
        fecha: "2025-02-20",
        resumen: "Actualización de protocolos de seguridad en medicina transfusional.",
        url_externa: "https://www.sochimt.cl",
        url_media: "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=250&fit=crop"
      },
      {
        id: 3,
        titulo: "Webinar: Avances en Inmunohematología",
        categoria: "Webinar",
        fecha: "2025-01-30",
        resumen: "Seminario online sobre los últimos avances en inmunohematología.",
        url_externa: "https://www.sochimt.cl",
        url_media: "https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=400&h=250&fit=crop"
      }
    ];

    console.log(`✅ Devolviendo ${noticiasTest.length} noticias de prueba`);

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(noticiasTest)
    };

  } catch (error) {
    console.error('❌ Error:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Error interno del servidor',
        message: error.message,
        timestamp: new Date().toISOString()
      })
    };
  }
};
