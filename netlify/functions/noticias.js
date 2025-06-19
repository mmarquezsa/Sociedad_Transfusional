const { createClient } = require('@supabase/supabase-js');

exports.handler = async (event, context) => {
  console.log('🚀 Función noticias ejecutándose');
  console.log('Método:', event.httpMethod);
  
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With',
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Content-Type': 'application/json',
    'Cache-Control': 'public, max-age=300'
  };

  // Manejar preflight requests
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

  try {
    // Verificar variables de entorno
    const supabaseUrl = process.env.SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_ANON_KEY;
    
    console.log('🔍 Verificando configuración...');
    console.log('- SUPABASE_URL presente:', !!supabaseUrl);
    console.log('- SUPABASE_KEY presente:', !!supabaseKey);
    
    if (!supabaseUrl || !supabaseKey) {
      console.error('❌ Variables de entorno faltantes');
      
      // Fallback a datos de prueba si no hay variables configuradas
      const noticiasTest = [
        {
          id: 1,
          titulo: "Configura las variables de entorno",
          categoria: "Noticia",
          fecha: "2025-01-19",
          resumen: "Necesitas configurar SUPABASE_URL y SUPABASE_ANON_KEY en Netlify.",
          url_externa: "https://app.netlify.com",
          url_media: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=250&fit=crop"
        }
      ];
      
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify(noticiasTest)
      };
    }

    // Crear cliente de Supabase
    console.log('🔌 Creando cliente de Supabase...');
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Consultar noticias reales de Supabase
    console.log('📊 Consultando noticias de Supabase...');
    const { data, error } = await supabase
      .from('noticias')
      .select(`
        id,
        titulo,
        categoria,
        fecha,
        resumen,
        contenido,
        url_externa,
        url_media,
        created_at
      `)
      .order('fecha', { ascending: false })
      .limit(6);

    if (error) {
      console.error('❌ Error de Supabase:', error);
      
      // Fallback a datos de prueba si hay error de BD
      const noticiasTest = [
        {
          id: 1,
          titulo: "Error conectando a Supabase",
          categoria: "Noticia",
          fecha: "2025-01-19",
          resumen: `Error: ${error.message}. Revisa la configuración de Supabase.`,
          url_externa: "https://supabase.com",
          url_media: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=250&fit=crop"
        }
      ];
      
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify(noticiasTest)
      };
    }

    console.log(`✅ ${data?.length || 0} noticias encontradas en Supabase`);

    // Si no hay noticias en Supabase, devolver datos de ejemplo
    if (!data || data.length === 0) {
      console.log('📝 No hay noticias en Supabase, devolviendo datos de ejemplo');
      const noticiasTest = [
        {
          id: 1,
          titulo: "¡Conectado a Supabase!",
          categoria: "Noticia",
          fecha: "2025-01-19",
          resumen: "La conexión funciona. Agrega noticias desde el panel de gestión.",
          url_externa: "/gestion_noticias.html",
          url_media: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=250&fit=crop"
        }
      ];
      
      return {
        statusCode: 200,
        headers,
        body: JSON.stringify(noticiasTest)
      };
    }

    // Limpiar y validar datos reales de Supabase
    const noticiasLimpias = data.map(noticia => ({
      id: noticia.id,
      titulo: noticia.titulo || 'Sin título',
      categoria: noticia.categoria || 'Noticia',
      fecha: noticia.fecha,
      resumen: noticia.resumen || 'Sin descripción disponible',
      url_externa: noticia.url_externa || '#',
      url_media: noticia.url_media || null,
      created_at: noticia.created_at
    }));

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(noticiasLimpias)
    };

  } catch (error) {
    console.error('💥 Error general:', error);
    
    // Fallback final a datos de prueba
    const noticiasTest = [
      {
        id: 1,
        titulo: "Error del servidor",
        categoria: "Noticia",
        fecha: "2025-01-19",
        resumen: `Error: ${error.message}`,
        url_externa: "#",
        url_media: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=250&fit=crop"
      }
    ];
    
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(noticiasTest)
    };
  }
};
