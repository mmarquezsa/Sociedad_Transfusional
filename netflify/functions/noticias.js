const { createClient } = require('@supabase/supabase-js');

// Logging para debugging
console.log('Función noticias iniciada');

exports.handler = async (event, context) => {
  // Headers para CORS
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Content-Type': 'application/json',
  };

  // Manejo de preflight requests
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers,
      body: '',
    };
  }

  // Solo permitir GET requests
  if (event.httpMethod !== 'GET') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Método no permitido' }),
    };
  }

  try {
    // Verificar variables de entorno
    const supabaseUrl = process.env.SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_ANON_KEY;
    
    if (!supabaseUrl || !supabaseKey) {
      console.error('Variables de entorno faltantes');
      console.error('SUPABASE_URL:', !!supabaseUrl);
      console.error('SUPABASE_KEY:', !!supabaseKey);
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({ 
          error: 'Configuración del servidor incompleta',
          details: `Faltan variables: ${!supabaseUrl ? 'SUPABASE_URL ' : ''}${!supabaseKey ? 'SUPABASE_KEY' : ''}`
        }),
      };
    }

    // Crear cliente de Supabase
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Consultar noticias
    const { data, error } = await supabase
      .from('noticias')
      .select('*')
      .order('fecha', { ascending: false })
      .limit(6);

    if (error) {
      console.error('Error de Supabase:', error);
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({
          error: 'Error de base de datos',
          details: error.message
        }),
      };
    }

    // Retornar datos exitosamente
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(data || []),
    };

  } catch (error) {
    console.error('Error general en función noticias:', error);
    
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Error interno del servidor',
        details: error.message,
        stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
      }),
    };
  }
};
