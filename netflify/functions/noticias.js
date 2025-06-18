const { createClient } = require('@supabase/supabase-js');

exports.handler = async (event, context) => {
  console.log('🚀 Función noticias ejecutándose...');
  console.log('HTTP Method:', event.httpMethod);
  console.log('Headers:', event.headers);

  // Headers para CORS
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Content-Type': 'application/json',
  };

  // Manejo de preflight requests
  if (event.httpMethod === 'OPTIONS') {
    console.log('📋 Respondiendo a preflight request');
    return {
      statusCode: 200,
      headers,
      body: '',
    };
  }

  // Solo permitir GET requests
  if (event.httpMethod !== 'GET') {
    console.log('❌ Método no permitido:', event.httpMethod);
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
    
    console.log('🔍 Verificando variables de entorno...');
    console.log('SUPABASE_URL presente:', !!supabaseUrl);
    console.log('SUPABASE_KEY presente:', !!supabaseKey);
    console.log('SUPABASE_URL value:', supabaseUrl);
    
    if (!supabaseUrl || !supabaseKey) {
      console.error('❌ Variables de entorno faltantes');
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({ 
          error: 'Configuración del servidor incompleta',
          details: `Faltan variables: ${!supabaseUrl ? 'SUPABASE_URL ' : ''}${!supabaseKey ? 'SUPABASE_KEY' : ''}`,
          env_check: {
            supabaseUrl: !!supabaseUrl,
            supabaseKey: !!supabaseKey
          }
        }),
      };
    }

    // Crear cliente de Supabase
    console.log('🔌 Creando cliente de Supabase...');
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Consultar noticias
    console.log('📊 Consultando noticias...');
    const { data, error } = await supabase
      .from('noticias')
      .select('*')
      .order('fecha', { ascending: false })
      .limit(10); // Aumenté el límite para tener más noticias

    if (error) {
      console.error('❌ Error de Supabase:', error);
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({
          error: 'Error de base de datos',
          details: error.message,
          supabase_error: error
        }),
      };
    }

    console.log('✅ Noticias obtenidas:', data?.length || 0);
    console.log('📄 Datos:', data);

    // Retornar datos exitosamente
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(data || []),
    };

  } catch (error) {
    console.error('💥 Error general en función noticias:', error);
    
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
