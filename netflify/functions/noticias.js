// Importa el SDK de administrador de Firebase para usarlo en el servidor
const admin = require('firebase-admin');

// Carga las credenciales de forma segura desde las variables de entorno de Netlify.
// Este es el paso final que configurarás en el panel de Netlify.
const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT_KEY);

// Inicializa la app de Firebase solo si no ha sido inicializada antes,
// para evitar errores en el entorno de Netlify.
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
}

const db = admin.firestore();

// La función principal que se ejecuta cuando se llama a la API.
exports.handler = async function (event, context) {
  try {
    // 1. Conéctate a la colección "noticias".
    // 2. Ordénalas por fecha descendente para obtener las más nuevas primero.
    // 3. Limita los resultados a 3 para la página principal.
    const snapshot = await db.collection('noticias').orderBy('fechaRaw', 'desc').limit(3).get();
    
    // Si no hay noticias, devuelve un arreglo vacío.
    if (snapshot.empty) {
      return { 
        statusCode: 200, 
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify([]) 
      };
    }

    // Convierte los documentos de Firebase a un formato de objeto simple.
    const noticias = snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
    }));

    // Devuelve las noticias en formato JSON.
    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(noticias),
    };

  } catch (error) {
    console.error("Error al obtener noticias desde Firestore:", error);
    return { 
      statusCode: 500, 
      body: "Error interno del servidor al contactar la base de datos." 
    };
  }
};
