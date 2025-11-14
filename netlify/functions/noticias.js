const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

exports.handler = async (event) => {
  // CORS
  const headers = { 'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json' };

  // Sólo GET
  if (event.httpMethod !== 'GET') {
    return { statusCode: 405, headers, body: JSON.stringify({ error: 'Method not allowed' }) };
  }

  const { data, error } = await supabase.from('noticias').select('*');
  if (error) {
    return { statusCode: 500, headers, body: JSON.stringify({ error: error.message }) };
  }
  return { statusCode: 200, headers, body: JSON.stringify(data) };
};