// Netlify Serverless Function - Proxy para YouTube API
// La API Key se guarda como variable de entorno en Netlify (no en el código)

const CHANNEL_ID = 'UC_AilJ-c1yFMOzEogyG-W4w';

exports.handler = async (event, context) => {
  // Headers CORS
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Content-Type': 'application/json'
  };

  // Manejar preflight OPTIONS
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  // Solo permitir GET
  if (event.httpMethod !== 'GET') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Método no permitido' })
    };
  }

  // Obtener API Key desde variable de entorno de Netlify
  const API_KEY = process.env.YOUTUBE_API_KEY;

  if (!API_KEY) {
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ error: 'API Key no configurada en el servidor' })
    };
  }

  const params = event.queryStringParameters || {};
  const action = params.action;

  try {
    let youtubeUrl;

    switch (action) {
      case 'channel':
        // Obtener información del canal (playlist de uploads)
        youtubeUrl = `https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=${CHANNEL_ID}&key=${API_KEY}`;
        break;

      case 'playlist':
        // Obtener videos de una playlist
        const playlistId = params.playlistId;
        if (!playlistId) {
          return {
            statusCode: 400,
            headers,
            body: JSON.stringify({ error: 'playlistId requerido' })
          };
        }
        youtubeUrl = `https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&playlistId=${playlistId}&maxResults=50&key=${API_KEY}`;
        break;

      case 'videos':
        // Obtener detalles de videos específicos
        const videoIds = params.ids;
        if (!videoIds) {
          return {
            statusCode: 400,
            headers,
            body: JSON.stringify({ error: 'ids requerido' })
          };
        }
        youtubeUrl = `https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=${videoIds}&key=${API_KEY}`;
        break;

      default:
        return {
          statusCode: 400,
          headers,
          body: JSON.stringify({ error: 'Acción no válida. Use: channel, playlist, o videos' })
        };
    }

    // Hacer la llamada a YouTube API
    const response = await fetch(youtubeUrl);
    const data = await response.json();

    // Si YouTube devuelve error, propagarlo
    if (data.error) {
      return {
        statusCode: data.error.code || 400,
        headers,
        body: JSON.stringify({ error: data.error.message })
      };
    }

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(data)
    };

  } catch (error) {
    console.error('Error en youtube-proxy:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ error: 'Error al conectar con YouTube API' })
    };
  }
};
