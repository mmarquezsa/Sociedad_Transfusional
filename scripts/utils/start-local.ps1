# ============================================
# Script de Inicio Rápido - Servidor Local
# SOCHIMT - Desarrollo Local
# ============================================

Write-Host ""
Write-Host "🚀 Iniciando Servidor Local SOCHIMT..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si Python está instalado
$pythonInstalled = Get-Command python -ErrorAction SilentlyContinue

if ($pythonInstalled) {
    Write-Host "✅ Python encontrado" -ForegroundColor Green
    Write-Host "📡 Iniciando servidor HTTP en puerto 8000..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🌐 Abre tu navegador en: http://localhost:8000" -ForegroundColor Cyan
    Write-Host "🧪 Página de pruebas: http://localhost:8000/test-supabase.html" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "⚠️  Presiona Ctrl+C para detener el servidor" -ForegroundColor Yellow
    Write-Host ""
    
    # Iniciar servidor
    python -m http.server 8000
    
} else {
    Write-Host "❌ Python no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternativas:" -ForegroundColor Yellow
    Write-Host "  1. Instala Python desde: https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "  2. Usa Live Server en VS Code (extensión)" -ForegroundColor White
    Write-Host "  3. Instala Node.js y ejecuta: npm install -g http-server" -ForegroundColor White
    Write-Host ""
    
    # Intentar abrir con el navegador predeterminado (como archivo)
    Write-Host "⚠️  Intentando abrir con el navegador (puede no funcionar completamente)..." -ForegroundColor Yellow
    Start-Process "index.html"
}

Write-Host ""
