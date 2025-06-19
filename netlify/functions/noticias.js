{
  "name": "sochimt-website",
  "version": "1.0.0",
  "description": "Website de la Sociedad Chilena de Medicina Transfusional",
  "scripts": {
    "build": "echo '🔄 Preparando archivos...' && mkdir -p public && cp index.html gestion_noticias.html public/ && cp *.png public/ 2>/dev/null || true && echo '✅ Build completado'",
    "dev": "echo '🚀 Servidor de desarrollo no configurado'",
    "test": "echo '🧪 Tests no configurados'"
  },
  "dependencies": {
    "@supabase/supabase-js": "^2.39.0"
  },
  "devDependencies": {},
  "engines": {
    "node": "18.x",
    "npm": ">=8.0.0"
  },
  "keywords": [
    "medicina-transfusional",
    "sochimt",
    "sociedad-cientifica",
    "netlify",
    "supabase"
  ],
  "author": "Marcelo Márquez-Sandoval",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/mmarquezsa/Sociedad_Transfusional.git"
  }
}
