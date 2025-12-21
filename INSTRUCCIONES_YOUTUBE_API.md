# Instrucciones para Configurar YouTube API - SOCHIMT

## ¿Para qué sirve esto?
Permite que la página web de SOCHIMT detecte **automáticamente** cuando se sube un nuevo video al canal de YouTube y lo muestre en la sección de Conversatorios sin necesidad de editar el código manualmente.

---

## Lo que necesitamos del Administrador del Canal

### 1. ID del Canal de YouTube

**URL para obtenerlo:** https://commentpicker.com/youtube-channel-id.php

**Pasos:**
1. Ir a la URL de arriba
2. En el campo de texto, pegar: `https://www.youtube.com/@SOCHIMT`
3. Hacer clic en "Get YouTube Channel ID"
4. Copiar el **Channel ID** que aparece (empieza con "UC" y tiene 24 caracteres)

**Ejemplo de cómo se ve un Channel ID:** `UCddiUEpeqJcYeBxX1IVBKvQ`

---

### 2. API Key de YouTube (Google Cloud Console)

**URL:** https://console.cloud.google.com/

**Pasos detallados:**

#### A) Crear proyecto (si no existe)
1. Ir a https://console.cloud.google.com/
2. Iniciar sesión con la cuenta de Google asociada al canal
3. En la parte superior, hacer clic en el selector de proyectos
4. Clic en "Nuevo Proyecto"
5. Nombre: "SOCHIMT Web" (o cualquier nombre descriptivo)
6. Clic en "Crear"

#### B) Habilitar YouTube Data API
1. En el menú lateral izquierdo, ir a: **APIs y servicios** → **Biblioteca**
2. En el buscador, escribir: **YouTube Data API v3**
3. Hacer clic en el resultado
4. Clic en el botón **"Habilitar"**

#### C) Crear la API Key
1. En el menú lateral, ir a: **APIs y servicios** → **Credenciales**
2. Clic en **"+ Crear credenciales"** (botón azul arriba)
3. Seleccionar **"Clave de API"**
4. Se generará una clave. **Copiarla inmediatamente**
5. (Opcional pero recomendado) Clic en "Restringir clave" para mayor seguridad:
   - En "Restricciones de API", seleccionar "Restringir clave"
   - Marcar solo "YouTube Data API v3"
   - Guardar

**Ejemplo de cómo se ve una API Key:** `AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

---

## Información a Enviar

Una vez obtenidos los datos, enviar:

```
Channel ID: UCxxxxxxxxxxxxxxxxxxxxxx
API Key: AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## Notas Importantes

- **Costo:** La API de YouTube es **GRATUITA** con un límite de 10,000 consultas por día (más que suficiente)
- **Seguridad:** La API Key solo permite LEER información pública del canal, no puede modificar nada
- **Privacidad:** Solo se accede a videos públicos que ya están visibles en YouTube

---

## ¿Problemas?

Si hay algún problema con estos pasos, contactar al desarrollador web con capturas de pantalla del error.
