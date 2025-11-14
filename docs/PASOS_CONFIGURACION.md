# 🚀 Pasos para Configurar el Sistema de Autenticación

## ✅ Archivos Creados

1. ✅ `login-socios.html` - Página de login
2. ✅ `auth.js` - Lógica de autenticación
3. ⏳ `registro-socios.html` - Formulario de registro (siguiente)
4. ⏳ `dashboard-socios.html` - Panel de socios (siguiente)

---

## 📋 Pasos Inmediatos ANTES de Probar

### **PASO 1: Ejecutar SQL en Supabase** (5 minutos)

1. **Ir a Supabase Dashboard**
   - URL: https://supabase.com/dashboard/project/dkohwhosputnxismgkon

2. **Abrir SQL Editor**
   - Click en "SQL Editor" en el menú lateral

3. **Ejecutar el Script**
   - Abrir el archivo `setup_sistema_completo.sql`
   - Copiar TODO el contenido
   - Pegarlo en el SQL Editor
   - Click en "Run" o presionar `Ctrl+Enter`

4. **Verificar que se crearon las tablas**
   ```sql
   SELECT tablename FROM pg_tables 
   WHERE schemaname = 'public' 
   AND tablename LIKE '%socio%'
   ORDER BY tablename;
   ```
   
   Deberías ver:
   - `socios`
   - `conversaciones_gotita`
   - `logs_acceso`
   - etc.

---

### **PASO 2: Habilitar Supabase Auth** (5 minutos)

1. **Ir a Authentication**
   - Dashboard → Authentication → Settings

2. **Configurar Email Provider**
   - Enable Email provider: ✅ ON
   - Enable Email Confirmations: ✅ ON (opcional)
   - Disable signups: ⬜ OFF (permitir registros)

3. **Configurar URLs**
   - Site URL: `http://localhost:3000` (o tu dominio)
   - Redirect URLs: Agregar:
     ```
     http://localhost:3000/dashboard-socios.html
     https://tu-dominio.com/dashboard-socios.html
     ```

4. **Configurar Email Templates** (Opcional)
   - Puedes personalizar los emails de confirmación
   - Templates → Confirm signup
   - Templates → Reset password

---

### **PASO 3: Crear Usuario de Prueba** (2 minutos)

Tienes 2 opciones:

**Opción A: Crear manualmente en Supabase**
1. Dashboard → Authentication → Users
2. Click en "Add user"
3. Email: `test@sochimt.cl`
4. Password: `Test123456!`
5. Email Confirm: ✅ (marcar como confirmado)
6. Click "Create user"

**Opción B: Usar la página de registro (cuando esté lista)**
1. Ir a `registro-socios.html`
2. Llenar el formulario
3. Click en "Registrar"

---

### **PASO 4: Probar el Login** (2 minutos)

1. Abrir `login-socios.html` en el navegador

2. Ingresar credenciales:
   - Email: `test@sochimt.cl`
   - Password: `Test123456!`

3. Click en "Iniciar Sesión"

4. **Si todo está bien:**
   - ✅ Redirigirá a `dashboard-socios.html`
   - ✅ Verás mensaje en consola: "✅ Login exitoso"
   - ✅ Se creará entrada en `logs_acceso`

5. **Si hay error:**
   - ❌ Revisar consola del navegador (F12)
   - ❌ Verificar que SQL se ejecutó
   - ❌ Verificar que Auth está habilitado

---

## 🔍 Troubleshooting

### Error: "Invalid login credentials"
**Causa:** Usuario no existe o contraseña incorrecta
**Solución:** Crear usuario en Supabase Dashboard

### Error: "relation 'socios' does not exist"
**Causa:** No se ejecutó el SQL
**Solución:** Ejecutar `setup_sistema_completo.sql`

### Error: "CORS policy"
**Causa:** URL no autorizada
**Solución:** Agregar URL en Supabase → Authentication → URL Configuration

### Error: "Cannot read property 'auth' of undefined"
**Causa:** Supabase client no se cargó
**Solución:** Verificar que `auth.js` se carga DESPUÉS del CDN de Supabase

---

## 📊 Verificar que Todo Funciona

### **1. Verificar Tablas Creadas**
```sql
SELECT 
  table_name,
  (SELECT COUNT(*) FROM information_schema.columns 
   WHERE table_name = t.table_name) as column_count
FROM information_schema.tables t
WHERE table_schema = 'public'
  AND table_name IN ('socios', 'base_conocimientos', 'conversaciones_gotita', 
                     'articulos', 'eventos', 'recursos')
ORDER BY table_name;
```

### **2. Verificar Auth está Habilitado**
```sql
SELECT * FROM auth.users LIMIT 1;
```

### **3. Verificar RLS está Activo**
```sql
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename = 'socios';
```
(rowsecurity debe ser `true`)

### **4. Probar Login en Consola**
Abrir consola del navegador y ejecutar:
```javascript
// Verificar que Supabase está cargado
console.log('Supabase:', typeof supabaseClient);

// Intentar login
await loginSocio('test@sochimt.cl', 'Test123456!', false);
```

---

## 🎯 Próximos Pasos DESPUÉS de Configurar

1. ✅ Crear usuario de prueba
2. ✅ Probar login
3. ⏳ Crear `registro-socios.html`
4. ⏳ Crear `dashboard-socios.html`
5. ⏳ Agregar botón "Área de Socios" en index.html
6. ⏳ Implementar IA Gotita 💧

---

## 📞 ¿Necesitas Ayuda?

Si algo no funciona:
1. Revisar consola del navegador (F12)
2. Revisar logs en Supabase Dashboard → Logs
3. Verificar que todas las URLs están correctas
4. Asegurarse de que el navegador permite cookies

---

## ✅ Checklist de Configuración

- [ ] SQL ejecutado exitosamente
- [ ] Tablas creadas en Supabase
- [ ] Auth habilitado
- [ ] Email provider configurado
- [ ] URLs de redirect configuradas
- [ ] Usuario de prueba creado
- [ ] Login probado y funcionando
- [ ] Redirección a dashboard funciona
- [ ] Logs de acceso se registran

**Una vez completados todos los pasos, estarás listo para continuar con el desarrollo! 🚀**
