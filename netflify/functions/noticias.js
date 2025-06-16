// Importa la librería de Supabase. Netlify la encontrará automáticamente.
import { createClient } from '@supabase/supabase-js'

// La URL de tu proyecto de Supabase
const supabaseUrl = 'https://dkohwhosputnxismgkon.supabase.co';

// La clave secreta de Supabase (la que guardaste en Netlify)
const supabaseKey = process.env.SUPABASE_SERVICE_KEY;

// Crea el cliente de Supabase para usar en el servidor
const supabase = createClient(supabaseUrl, supabaseKey);

exports.handler = async function (event, context) {
  try {
    // Pide a Supabase todas las noticias de la tabla 'noticias'
    // y las ordena por fecha de más nueva a más antigua.
    const { data, error } = await supabase
      .from('noticias')
      .select('*') // Selecciona todas las columnas
      .order('fecha', { ascending: false }); // Ordena por la columna 'fecha'

    // Si Supabase devuelve un error, lo registramos y fallamos.
    if (error) {
      throw error;
    }

    // Si todo va bien, devolvemos los datos en formato JSON.
    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data || []), // Devuelve los datos o un array vacío
    };

  } catch (error) {
    console.error("Error al obtener noticias desde Supabase:", error);
    return {
      statusCode: 500,
      body: "Error interno del servidor al contactar la base de datos."
    };
  }
};
