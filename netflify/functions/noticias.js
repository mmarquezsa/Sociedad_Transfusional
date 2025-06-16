// Importa el SDK de administrador de Firebase para usarlo en el servidor
const admin = require('firebase-admin');

// Carga las credenciales de forma segura desde las variables de entorno de Netlify
// Asegúrate de haber configurado FIREBASE_SERVICE_ACCOUNT_KEY en tu panel de Netlify
try {
    const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT_KEY);

    // Inicializa la app de Firebase solo si no ha sido inicializada antes
    if (!admin.apps.length) {
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
      });
    }
} catch (e) {
    console.error('Error al inicializar Firebase Admin SDK. Asegúrate de que la variable de entorno FIREBASE_SERVICE_ACCOUNT_KEY esté configurada correctamente en Netlify.');
}


const db = admin.firestore();

exports.handler = async function (event, context) {
  try {
    // Obtiene las 3 noticias más recientes de la colección "noticias", ordenadas por fecha
    const snapshot = await db.collection('noticias').orderBy('fechaRaw', 'desc').limit(3).get();
    
    if (snapshot.empty) {
      return { 
        statusCode: 200, 
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify([]) 
      };
    }

    // Mapea los documentos a un formato de objeto simple
    const noticias = snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
    }));

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
