# 🏛️ Logos de Universidades y Convenios

Esta carpeta contiene los logos de las universidades e instituciones con las que SOCHIMT tiene convenios educativos.

## 📁 Estructura de Archivos

Guarda los logos con nombres descriptivos en minúsculas y guiones:

```
convenios/
├── universidad-central-logo.png
├── universidad-chile-logo.png
├── universidad-catolica-logo.png
├── universidad-concepcion-logo.png
└── README.md (este archivo)
```

## 📋 Especificaciones Técnicas

### Formatos Aceptados
- **PNG** (preferido - con fondo transparente)
- **SVG** (ideal para escalabilidad)
- **JPG** (solo si no hay transparencia disponible)

### Dimensiones Recomendadas
- **Ancho:** 400-800px
- **Alto:** 200-400px
- **Relación de aspecto:** Mantener la proporción original del logo
- **Peso:** Menos de 200KB por imagen

### Calidad
- Resolución mínima: 72 DPI para web
- Resolución recomendada: 150 DPI
- Fondo transparente (PNG) preferido

## 🎯 Cómo Agregar un Nuevo Logo

### Paso 1: Preparar el Logo

1. Obtén el logo oficial de la universidad
2. Asegúrate de que tenga **fondo transparente** (PNG)
3. Redimensiona si es necesario a las dimensiones recomendadas
4. Optimiza la imagen con herramientas como [TinyPNG](https://tinypng.com/)

### Paso 2: Guardar el Archivo

1. Guarda el logo en esta carpeta con un nombre descriptivo:
   ```
   D:\2025\Sociedad_Transfusional\images\convenios\universidad-nombre-logo.png
   ```

2. Ejemplos de nombres correctos:
   - `universidad-central-logo.png`
   - `universidad-chile-logo.png`
   - `hospital-clinico-uc-logo.png`

### Paso 3: Actualizar el HTML

Abre `index.html` y busca la sección de convenios (línea ~1532).

**ANTES (placeholder):**
```html
<div class="bg-white rounded-2xl p-8 mb-6 flex items-center justify-center" style="height: 150px;">
  <div class="text-center">
    <div class="text-4xl font-bold text-slate-800 mb-2">Universidad Central</div>
    <p class="text-sm text-slate-600">de Chile</p>
  </div>
</div>
```

**DESPUÉS (con logo real):**
```html
<div class="bg-white rounded-2xl p-8 mb-6 flex items-center justify-center" style="height: 150px;">
  <img
    src="images/convenios/universidad-central-logo.png"
    alt="Logo Universidad Central"
    class="max-h-32 w-auto mx-auto object-contain"
    loading="lazy"
  >
</div>
```

## 🏛️ Logos de Ejemplo Necesarios

### Universidad Central de Chile
- **Archivo:** `universidad-central-logo.png`
- **Ubicación en HTML:** Línea ~1532
- **Estado:** ⏳ Pendiente

### Otras Universidades (Futuras)

Cuando agregues más convenios, puedes seguir el mismo patrón:

```html
<!-- Nueva Universidad -->
<div class="bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 rounded-3xl shadow-2xl overflow-hidden mt-8">
  <div class="grid md:grid-cols-2 gap-0">
    <div class="p-10 md:p-12 flex flex-col justify-center">
      <span class="inline-block px-4 py-2 bg-green-500/20 text-green-300 rounded-full text-sm font-semibold mb-6">
        ⭐ Convenio Destacado
      </span>

      <div class="bg-white rounded-2xl p-8 mb-6 flex items-center justify-center" style="height: 150px;">
        <img
          src="images/convenios/universidad-nombre-logo.png"
          alt="Logo Universidad"
          class="max-h-32 w-auto mx-auto object-contain"
          loading="lazy"
        >
      </div>

      <h3 class="text-3xl font-bold text-white mb-4">
        Nombre de la Universidad
      </h3>
      <!-- Resto del contenido... -->
    </div>
    <!-- Columna derecha con info de contacto -->
  </div>
</div>
```

## 🎨 Optimización de Imágenes

### Herramientas Recomendadas

1. **TinyPNG** (https://tinypng.com/)
   - Comprime PNG sin perder calidad
   - Reduce el peso hasta 70%

2. **SVGOMG** (https://jakearchibald.github.io/svgomg/)
   - Optimiza archivos SVG
   - Elimina metadatos innecesarios

3. **Squoosh** (https://squoosh.app/)
   - Herramienta de Google para optimización de imágenes
   - Soporta múltiples formatos

### Comando para Optimizar (Opcional)

Si tienes ImageMagick instalado:

```bash
# Redimensionar
magick convert logo-original.png -resize 600x300 logo-optimizado.png

# Comprimir
magick convert logo-original.png -quality 85 logo-comprimido.png
```

## 📞 Información de Contacto en la Sección

La sección incluye espacio para:

- ✉️ Email de contacto
- 📞 Teléfono
- 📚 Programas disponibles (Q4 2025 y 2026)
- 🎓 Descuentos aplicables (30% y 40%)

Para actualizar la información de contacto, edita las líneas 1600-1610 en `index.html`.

## ✅ Checklist de Implementación

- [ ] Obtener logo oficial de la Universidad Central
- [ ] Optimizar imagen (PNG transparente, <200KB)
- [ ] Guardar en `images/convenios/universidad-central-logo.png`
- [ ] Actualizar HTML en línea ~1532
- [ ] Verificar que el logo se vea bien en desktop y mobile
- [ ] Actualizar información de contacto (email, teléfono)
- [ ] Probar la página en el navegador

## 📝 Notas Importantes

1. **Derechos de Autor:** Asegúrate de tener permiso para usar los logos oficiales
2. **Calidad:** Usa siempre logos de alta resolución oficial
3. **Consistencia:** Mantén el mismo estilo (fondo transparente) para todos los logos
4. **Rendimiento:** Optimiza las imágenes para carga rápida
5. **Accesibilidad:** Incluye siempre el atributo `alt` descriptivo

## 🔗 Enlaces Útiles

- [Guía de optimización de imágenes web](https://web.dev/fast/#optimize-your-images)
- [Cómo exportar logos en Illustrator](https://helpx.adobe.com/illustrator/using/exporting-artwork.html)
- [PNG vs SVG: ¿Cuál usar?](https://blog.hubspot.com/website/svg-vs-png)

---

**Última actualización:** 2025-11-10
**Responsable:** Equipo Web SOCHIMT
