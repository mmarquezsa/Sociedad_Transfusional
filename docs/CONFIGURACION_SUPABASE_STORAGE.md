# 📦 Configuración de Supabase Storage para Documentos de Socios

## 🎯 Objetivo

Configurar Supabase Storage para almacenar los documentos PDF que los socios adjuntan durante su registro.

---

## 🔧 Pasos de Configuración

### **1. Acceder a Supabase Dashboard**

1. Ve a: https://supabase.com/dashboard
2. Inicia sesión con tu cuenta
3. Selecciona tu proyecto: `dkohwhosputnxismgkon`

---

### **2. Crear el Bucket de Storage**

1. En el menú lateral, haz clic en **"Storage"**
2. Click en **"New bucket"**
3. Configura el bucket:

```
Nombre del bucket: documentos-socios
Público: NO (mantener privado para seguridad)
File size limit: 5MB
Allowed MIME types: application/pdf
```

4. Click en **"Create bucket"**

---

### **3. Configurar Políticas de Acceso (RLS)**

Necesitas crear políticas para que los usuarios puedan subir archivos pero no ver los de otros.

#### **Política 1: Permitir Upload (INSERT)**

```sql
-- Nombre: Permitir upload de documentos durante registro
-- Operación: INSERT
-- Target roles: authenticated, anon

CREATE POLICY "Permitir upload documentos"
ON storage.objects
FOR INSERT
TO authenticated, anon
WITH CHECK (
  bucket_id = 'documentos-socios' AND
  auth.role() IN ('authenticated', 'anon')
);
```

#### **Política 2: Permitir Lectura Solo de Administradores**

```sql
-- Nombre: Solo admin puede leer documentos
-- Operación: SELECT
-- Target roles: authenticated

CREATE POLICY "Admin puede leer documentos"
ON storage.objects
FOR SELECT
TO authenticated
USING (
  bucket_id = 'documentos-socios' AND
  auth.jwt() ->> 'role' = 'admin'
);
```

#### **Política 3: Permitir Update/Delete Solo Administradores**

```sql
-- Nombre: Solo admin puede modificar/eliminar
-- Operación: UPDATE, DELETE
-- Target roles: authenticated

CREATE POLICY "Admin puede gestionar documentos"
ON storage.objects
FOR ALL
TO authenticated
USING (
  bucket_id = 'documentos-socios' AND
  auth.jwt() ->> 'role' = 'admin'
);
```

---

### **4. Estructura de Carpetas**

Los documentos se organizarán automáticamente así:

```
documentos-socios/
├── {RUT}_{TIMESTAMP}/
│   ├── curriculum_vitae.pdf
│   ├── certificado_antecedentes.pdf
│   ├── certificado_registro_sis.pdf
│   ├── firma_patrocinadores.pdf (opcional)
│   └── otro_documento.pdf (opcional)
```

**Ejemplo:**
```
documentos-socios/
├── 123456789_1704672000000/
│   ├── curriculum_vitae.pdf
│   ├── certificado_antecedentes.pdf
│   └── certificado_registro_sis.pdf
```

---

### **5. Agregar Columnas a la Tabla `socios`**

Ejecuta este SQL en Supabase para agregar las columnas necesarias:

```sql
-- Agregar columnas para URLs de documentos
ALTER TABLE socios ADD COLUMN IF NOT EXISTS url_cv TEXT;
ALTER TABLE socios ADD COLUMN IF NOT EXISTS url_antecedentes TEXT;
ALTER TABLE socios ADD COLUMN IF NOT EXISTS url_registro_sis TEXT;
ALTER TABLE socios ADD COLUMN IF NOT EXISTS url_firma_patrocinadores TEXT;
ALTER TABLE socios ADD COLUMN IF NOT EXISTS url_otro_documento TEXT;
ALTER TABLE socios ADD COLUMN IF NOT EXISTS carpeta_documentos TEXT;

-- Agregar comentarios
COMMENT ON COLUMN socios.url_cv IS 'URL del Currículum Vitae en Supabase Storage';
COMMENT ON COLUMN socios.url_antecedentes IS 'URL del Certificado de Antecedentes';
COMMENT ON COLUMN socios.url_registro_sis IS 'URL del Certificado de Registro SIS';
COMMENT ON COLUMN socios.url_firma_patrocinadores IS 'URL de Firma de Patrocinadores (categorías B y C)';
COMMENT ON COLUMN socios.url_otro_documento IS 'URL de documento adicional';
COMMENT ON COLUMN socios.carpeta_documentos IS 'Nombre de carpeta en Storage (RUT_timestamp)';
```

---

## 🧪 Cómo Probar

### **Desde Local (Desarrollo):**

1. **Inicia tu servidor local:**
   ```powershell
   cd D:\2025\Sociedad_Transfusional
   .\start-local.ps1
   ```

2. **Abre el formulario:**
   ```
   http://localhost:8000/registro-socios.html
   ```

3. **Completa el formulario:**
   - Llena todos los campos
   - Adjunta los 3 PDFs obligatorios (CV, Antecedentes, Registro SIS)
   - Click en "Enviar Solicitud"

4. **Verifica en Supabase:**
   - Ve a Storage → documentos-socios
   - Deberías ver una nueva carpeta con formato: `{RUT}_{TIMESTAMP}`
   - Dentro deben estar los PDFs subidos

5. **Verifica en la tabla socios:**
   - Ve a Table Editor → socios
   - Busca el registro recién creado
   - Las columnas `url_cv`, `url_antecedentes`, `url_registro_sis` deben tener URLs

---

### **Desde Producción (GitHub Pages):**

El mismo proceso funciona automáticamente porque:
- ✅ Usa la misma configuración de Supabase
- ✅ Detecta el entorno automáticamente
- ✅ Los archivos se guardan en el mismo bucket

---

## 🔒 Seguridad

### **Configuración Actual:**

✅ **Bucket Privado:** Los documentos NO son accesibles públicamente  
✅ **Solo Admins:** Solo usuarios con rol `admin` pueden ver/descargar documentos  
✅ **Upload Controlado:** Solo durante el proceso de registro  
✅ **Validación:** Solo archivos PDF, máximo 5MB  

### **URLs Generadas:**

Las URLs tienen este formato:
```
https://dkohwhosputnxismgkon.supabase.co/storage/v1/object/public/documentos-socios/123456789_1704672000000/curriculum_vitae.pdf
```

**Nota:** Aunque la URL contenga "public", el acceso está controlado por las políticas RLS.

---

## 📊 Verificar Estado del Storage

### **En Supabase Dashboard:**

1. **Storage → documentos-socios**
   - Verás todas las carpetas de documentos
   - Puedes descargar/ver archivos individuales

2. **Table Editor → socios**
   - Columna `url_cv`: URL del CV
   - Columna `url_antecedentes`: URL de antecedentes
   - Columna `url_registro_sis`: URL registro SIS
   - Columna `carpeta_documentos`: Nombre de la carpeta

### **Desde la Consola del Navegador:**

```javascript
// Ver archivos subidos
const { data, error } = await supabaseClient.storage
  .from('documentos-socios')
  .list();

console.log('Carpetas:', data);
```

---

## 🚨 Solución de Problemas

### **Error: "Storage bucket not found"**

**Solución:** Crea el bucket siguiendo el paso 2

---

### **Error: "new row violates row-level security policy"**

**Solución:** Configura las políticas RLS siguiendo el paso 3

---

### **Error: "File size exceeds limit"**

**Solución:** El archivo excede 5MB. Pide al usuario que comprima el PDF.

---

### **Error: "Invalid file type"**

**Solución:** Solo se permiten archivos PDF. Verifica que el archivo tenga extensión .pdf

---

### **Los archivos no aparecen en Storage**

**Diagnóstico:**
1. Abre la consola del navegador (F12)
2. Busca errores en la pestaña "Console"
3. Verifica que veas los mensajes:
   ```
   📤 Subiendo archivos a Supabase Storage...
   ✅ CV subido
   ✅ Antecedentes subidos
   ✅ Registro SIS subido
   ```

**Si no ves esos mensajes:**
- Verifica que `config.js` esté cargado
- Verifica que `auth.js` esté cargado
- Verifica la conexión a Supabase

---

## 📝 Notas Adicionales

### **Límites de Storage:**

- **Plan Free:** 1 GB de storage
- **Tamaño por archivo:** 5 MB máximo (configurable en el bucket)
- **Tipos permitidos:** Solo PDF

### **Nomenclatura:**

- Los archivos siempre tienen nombres fijos: `curriculum_vitae.pdf`, `certificado_antecedentes.pdf`, etc.
- La carpeta se identifica por: `{RUT}_{TIMESTAMP}`
- Esto evita conflictos de nombres

### **Backup:**

Los documentos en Supabase Storage están respaldados automáticamente. Sin embargo, considera:
- Hacer backups periódicos de documentos críticos
- Implementar un sistema de respaldo en otro servicio (opcional)

---

## ✅ Checklist de Configuración

Antes de poner en producción, verifica:

- [ ] Bucket `documentos-socios` creado
- [ ] Políticas RLS configuradas
- [ ] Columnas agregadas a tabla `socios`
- [ ] Prueba local exitosa
- [ ] Archivos visibles en Storage
- [ ] URLs guardadas en base de datos
- [ ] Solo admins pueden ver documentos
- [ ] Validación de tamaño (5MB) funciona
- [ ] Validación de tipo (PDF) funciona

---

## 🎉 ¡Listo!

Tu sistema de carga de documentos está completamente configurado y funciona tanto en:

✅ **Desarrollo Local:** http://localhost:8000  
✅ **Producción:** GitHub Pages  

Los documentos se almacenan de forma segura en Supabase Storage y las URLs se guardan en la base de datos para acceso posterior por parte de administradores.

---

## 📞 Soporte

Si encuentras problemas:

1. Revisa la consola del navegador (F12)
2. Verifica las políticas RLS en Supabase
3. Confirma que el bucket existe
4. Revisa los logs de Supabase en: Dashboard → Logs
