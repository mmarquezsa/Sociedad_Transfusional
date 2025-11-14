# Sistema de Gestión de Miembros SOCHIMT

## 📋 Resumen
Sistema completo para gestionar miembros de SOCHIMT similar al sistema de noticias.

## 🗄️ Paso 1: Crear la Tabla en Supabase

1. **Ir a Supabase Dashboard**
   - URL: https://supabase.com/dashboard
   - Proyecto: dkohwhosputnxismgkon

2. **Abrir SQL Editor** 
   - Click en "SQL Editor" en el menú lateral

3. **Ejecutar el script**
   - Abrir el archivo `setup_miembros_table.sql`
   - Copiar todo el contenido
   - Pegarlo en el SQL Editor
   - Click en "Run" o presionar `Ctrl+Enter`

4. **Verificar creación**
   - Ir a "Table Editor"
   - Debería aparecer la tabla "miembros"
   - Debería tener 3 registros de ejemplo

## 📝 Paso 2: Crear la Página de Gestión

Opción A: **Duplicar y Modificar** (Recomendado)
1. Duplicar `gestion_noticias.html` → `gestion-miembros.html`
2. Buscar y reemplazar (Ctrl+H en tu editor):
   
   ```
   Reemplazos principales:
   - "Gestión de Noticias" → "Gestión de Miembros"
   - "newsForm" → "memberForm"
   - "newsList" → "membersList"
   - "'noticias'" → "'miembros'"
   - "loadNews" → "loadMembers"
   - "handleNewsSubmit" → "handleMemberSubmit"
   - "editNews" → "editMember"
   - "deleteNews" → "deleteMember"
   ```

3. Actualizar los campos del formulario:
   ```html
   <!-- Cambiar de: -->
   <input id="news-title" ...>
   <select id="news-category" ...>
   <input id="news-date" ...>
   <textarea id="news-summary" ...>
   
   <!-- A: -->
   <input id="member-name" ...>
   <select id="member-specialty" ...>
   <input id="member-date" ...>
   <textarea id="member-description" ...>
   <input id="member-city" ...>
   <select id="member-color" ...>
   ```

4. Actualizar las opciones del select de especialidad:
   ```html
   <select id="member-specialty" required ...>
     <option value="">Seleccionar especialidad</option>
     <option value="Tecnólogo Médico">Tecnólogo Médico</option>
     <option value="Hematólogo">Hematólogo</option>
     <option value="Médico Transfusionista">Médico Transfusionista</option>
     <option value="Enfermero/a">Enfermero/a</option>
     <option value="Bioquímico">Bioquímico</option>
     <option value="Otro">Otro</option>
   </select>
   ```

5. Actualizar estadísticas del dashboard:
   ```html
   <div>Total Miembros</div>
   <div>Nuevos (mes)</div>
   <div>Especialidades</div>
   <div>Ciudades</div>
   ```

6. Actualizar la función de carga de datos:
   ```javascript
   async function loadMembers() {
     const { data, error } = await supabaseClient
       .from('miembros')
       .select('*')
       .order('fecha_ingreso', { ascending: false });
     
     // Renderizar tarjetas de miembros
     // Similar a como se hace con las noticias
   }
   ```

7. Actualizar la función de submit:
   ```javascript
   async function handleMemberSubmit(e) {
     e.preventDefault();
     
     const memberData = {
       nombre: dom.memberForm['member-name'].value,
       especialidad: dom.memberForm['member-specialty'].value,
       fecha_ingreso: dom.memberForm['member-date'].value,
       descripcion: dom.memberForm['member-description'].value,
       ciudad: dom.memberForm['member-city'].value,
       color_avatar: dom.memberForm['member-color'].value,
       url_foto: urlMedia
     };
     
     // Insert o Update según corresponda
   }
   ```

Opción B: **Usar Python Script**
```bash
cd "d:\2025\Sociedad_Transfusional"
python convert_to_members.py
```
Luego revisar y ajustar manualmente los campos del formulario.

## 🔗 Paso 3: Modificar index.html

El archivo `index.html` ya ha sido modificado para:
- Cargar miembros dinámicamente desde Supabase
- Mostrar los 3 miembros más recientes
- Actualizar automáticamente cuando se agregan nuevos miembros

## 🎨 Paso 4: Configurar Colores de Avatar

Los colores disponibles son:
- `sochimt`: Azul (default)
- `medical`: Rojo
- `purple`: Púrpura
- `green`: Verde
- `orange`: Naranja

Estos colores determinan el degradado del avatar circular.

## 📸 Paso 5: Subir Fotos (Opcional)

Si quieres agregar fotos de miembros:
1. Ir a Supabase Storage
2. Seleccionar el bucket "media"
3. Crear carpeta "miembros" (si no existe)
4. Subir fotos con nombres descriptivos
5. Copiar la URL pública
6. Usar esa URL en el campo `url_foto`

## 🚀 Uso del Sistema

### Agregar Nuevo Miembro
1. Abrir `gestion-miembros.html`
2. Login (admin/marcelo o editora/silvia)
3. Click en "Gestionar Miembros"
4. Llenar formulario
5. Click en "Agregar Miembro"

### Editar Miembro
1. En la lista de miembros, click en el botón editar (lápiz amarillo)
2. Modificar los campos
3. Click en "Actualizar Miembro"

### Eliminar Miembro
1. Click en el botón eliminar (basura roja)
2. Confirmar eliminación

## 📊 Dashboard

El dashboard muestra:
- **Total Miembros**: Cantidad total en la base de datos
- **Nuevos (mes)**: Miembros ingresados este mes
- **Especialidades**: Cantidad de especialidades únicas
- **Ciudades**: Cantidad de ciudades únicas

## 🔐 Seguridad

- Login requerido para acceder al panel
- Row Level Security (RLS) habilitado en Supabase
- Políticas configuradas para:
  - Lectura pública
  - Escritura autenticada

## 📱 Responsive

El sistema es completamente responsive:
- Desktop: Grid de 3 columnas
- Tablet: Grid de 2 columnas
- Mobile: 1 columna

## ⚡ Características

✅ CRUD completo (Crear, Leer, Actualizar, Eliminar)
✅ Subida de imágenes opcional
✅ Colores personalizables para avatares
✅ Búsqueda y filtrado
✅ Estadísticas en tiempo real
✅ Notificaciones de éxito/error
✅ Animaciones suaves
✅ Diseño moderno con Tailwind CSS

## 🐛 Troubleshooting

### Error: "relation 'miembros' does not exist"
- Solución: Ejecutar el script SQL en Supabase

### No se muestran los miembros en index.html
- Verificar que hay datos en la tabla
- Abrir DevTools (F12) y revisar Console
- Verificar que la conexión a Supabase está activa

### No se suben las imágenes
- Verificar que el bucket "media" existe
- Verificar que la carpeta "public/" existe en el bucket
- Verificar permisos del bucket (debe ser público)

## 📞 Soporte

Para problemas o dudas:
1. Revisar la consola del navegador (F12)
2. Verificar la configuración de Supabase
3. Comparar con `gestion_noticias.html` que funciona correctamente
