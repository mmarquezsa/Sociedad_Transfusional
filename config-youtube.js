// ============================================
// CONFIGURACIÓN DE YOUTUBE API PARA SOCHIMT
// ============================================
// 
// INSTRUCCIONES PARA ACTIVAR LA CARGA AUTOMÁTICA DE VIDEOS:
//
// PASO 1: Obtener el ID del Canal de YouTube
// -------------------------------------------
// 1. Ve a https://www.youtube.com/@SOCHIMT
// 2. Haz clic derecho en la página y selecciona "Ver código fuente"
// 3. Busca (Ctrl+F) "channelId" o "externalId"
// 4. Copia el ID que empieza con "UC" (ejemplo: UCxxxxxxxxxxxxxxxxxx)
// 
// O usa esta herramienta: https://commentpicker.com/youtube-channel-id.php
// Ingresa: https://www.youtube.com/@SOCHIMT
//
// PASO 2: Crear una API Key de Google
// ------------------------------------
// 1. Ve a https://console.cloud.google.com/
// 2. Inicia sesión con tu cuenta de Google
// 3. Crea un nuevo proyecto (o usa uno existente)
// 4. En el menú lateral, ve a "APIs y servicios" > "Biblioteca"
// 5. Busca "YouTube Data API v3" y haz clic en "Habilitar"
// 6. Ve a "APIs y servicios" > "Credenciales"
// 7. Haz clic en "Crear credenciales" > "Clave de API"
// 8. Copia la clave generada
// 
// IMPORTANTE: La API de YouTube tiene un límite gratuito de 10,000 unidades/día
// Cada carga de videos consume aproximadamente 100 unidades
// Esto es más que suficiente para uso normal
//
// PASO 3: Configurar los valores abajo
// ------------------------------------

const YOUTUBE_CONFIG = {
  // ID del canal de SOCHIMT
  // Obtenido de: https://www.youtube.com/@SOCHIMT
  CHANNEL_ID: 'UC_AilJ-c1yFMOzEogyG-W4w',
  
  // API Key de YouTube Data API v3
  // Obtener desde Google Cloud Console
  API_KEY: '',
  
  // Configuración adicional
  MAX_VIDEOS: 50,           // Máximo de videos a cargar
  CHECK_INTERVAL: 300000,   // Verificar nuevos videos cada 5 minutos (en ms)
  AUTO_REFRESH: true,       // Actualizar automáticamente
  
  // Si está habilitado, muestra mensajes en consola
  DEBUG: true
};

// ============================================
// NO MODIFICAR DEBAJO DE ESTA LÍNEA
// ============================================

// Verificar si la configuración está completa
function isYouTubeConfigured() {
  return YOUTUBE_CONFIG.API_KEY && 
         YOUTUBE_CONFIG.API_KEY.length > 0 && 
         YOUTUBE_CONFIG.CHANNEL_ID && 
         YOUTUBE_CONFIG.CHANNEL_ID !== 'UCxxxxxxxxxxxxxxxxxxx';
}

// Exportar configuración
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { YOUTUBE_CONFIG, isYouTubeConfigured };
}
