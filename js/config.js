// ============================================
// CONFIG.JS - Configuración de Entornos SOCHIMT
// ============================================

/**
 * IMPORTANTE: Este archivo maneja las configuraciones de diferentes entornos
 * - DESARROLLO: Para pruebas locales
 * - PRODUCCIÓN: Para el sitio en GitHub Pages
 */

// Detectar entorno automáticamente
const ENV = {
  // Detectar si estamos en local o producción
  isLocal: window.location.hostname === 'localhost' || 
           window.location.hostname === '127.0.0.1' || 
           window.location.hostname.includes('192.168') ||
           window.location.protocol === 'file:',
  
  isDevelopment: window.location.hostname.includes('github.io') === false &&
                 window.location.hostname !== 'www.sochimt.cl' &&
                 window.location.hostname !== 'sochimt.cl',
  
  isProduction: window.location.hostname === 'www.sochimt.cl' ||
                window.location.hostname === 'sochimt.cl' ||
                window.location.hostname.includes('github.io')
};

// Configuraciones de Supabase
const SUPABASE_CONFIG = {
  // PRODUCCIÓN - Usa el mismo Supabase que producción
  production: {
    url: 'https://dkohwhosputnxismgkon.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRrb2h3aG9zcHV0bnhpc21na29uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwMzkxMTQsImV4cCI6MjA2NTYxNTExNH0.2ZOwkilUv49SADBzjrq-4AHUUKnMLZs-beftr3FLdAE',
    debugMode: false
  },
  
  // DESARROLLO LOCAL - Misma base de datos pero con debug activado
  development: {
    url: 'https://dkohwhosputnxismgkon.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRrb2h3aG9zcHV0bnhpc21na29uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwMzkxMTQsImV4cCI6MjA2NTYxNTExNH0.2ZOwkilUv49SADBzjrq-4AHUUKnMLZs-beftr3FLdAE',
    debugMode: true
  }
};

// Seleccionar configuración según entorno
const currentConfig = ENV.isProduction 
  ? SUPABASE_CONFIG.production 
  : SUPABASE_CONFIG.development;

// Exportar configuración actual
export const CONFIG = {
  supabase: {
    url: currentConfig.url,
    anonKey: currentConfig.anonKey
  },
  environment: ENV.isProduction ? 'production' : 'development',
  isLocal: ENV.isLocal,
  debugMode: currentConfig.debugMode
};

// Logging de configuración
console.log('🔧 Configuración cargada:');
console.log('   📍 Entorno:', CONFIG.environment);
console.log('   🏠 Local:', CONFIG.isLocal);
console.log('   🐛 Debug:', CONFIG.debugMode);
console.log('   🔗 Supabase URL:', CONFIG.supabase.url);

// Mostrar banner visual si estamos en desarrollo
if (CONFIG.debugMode && CONFIG.isLocal) {
  console.log('%c🚀 MODO DESARROLLO ACTIVADO', 
    'background: #2563eb; color: white; padding: 8px 16px; font-size: 14px; font-weight: bold; border-radius: 4px;');
  console.log('%c⚠️  Estás usando la base de datos de PRODUCCIÓN en modo LOCAL', 
    'background: #dc2626; color: white; padding: 4px 8px; font-size: 12px; border-radius: 4px;');
  console.log('%c💡 Ten cuidado con los cambios que realices', 
    'background: #f59e0b; color: white; padding: 4px 8px; font-size: 12px; border-radius: 4px;');
  
  // Agregar badge visual en la página
  window.addEventListener('DOMContentLoaded', () => {
    const badge = document.createElement('div');
    badge.innerHTML = `
      <div style="
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: linear-gradient(135deg, #2563eb 0%, #dc2626 100%);
        color: white;
        padding: 12px 20px;
        border-radius: 12px;
        font-family: 'Inter', sans-serif;
        font-weight: bold;
        font-size: 14px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        z-index: 9999;
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
      " onclick="this.parentElement.remove()">
        <span style="font-size: 18px;">🧪</span>
        <span>MODO DESARROLLO</span>
      </div>
    `;
    document.body.appendChild(badge);
  });
}

// Hacer CONFIG disponible globalmente
window.CONFIG = CONFIG;
