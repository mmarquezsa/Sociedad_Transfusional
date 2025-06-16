// Importa la librería de Supabase
import { createClient } from '@supabase/supabase-js'

// La URL de tu proyecto de Supabase
const supabaseUrl = 'https://dkohwhosputnxismgkon.supabase.co';

// La SERVICE_ROLE_KEY de Supabase. ¡ES SECRETA!
// Debes guardarla en las variables de entorno de Netlify como SUPABASE_SERVICE_KEY
const supabaseKey = process.env.SUPABASE_SERVICE_KEY;

// Crea el cliente de Supabase
const supabase = createClient(supabaseUrl, supabaseKey);

exports.handler = async function (event, context) {
  try {
    // Obtiene las 3 noticias más recientes de la tabla "noticias", ordenadas por fecha
    const { data, error } = await supabase
      .from('noticias')
      .select('*') // Selecciona todas las columnas
      .order('fecha', { ascending: false }) // Ordena por la columna 'fecha'
      .limit(3); // Limita a 3 resultados

    // Si ocurre un error en la consulta
    if (error) {
      throw error;
    }

    // Si no hay noticias
    if (!data || data.length === 0) {
      return {
        statusCode: 200,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify([])
      };
    }
    
    // Devuelve las noticias encontradas
    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    };

  } catch (error) {
    console.error("Error al obtener noticias desde Supabase:", error);
    return {
      statusCode: 500,
      body: "Error interno del servidor al contactar la base de datos."
    };
  }
};
