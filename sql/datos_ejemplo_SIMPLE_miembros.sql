-- ============================================
-- DATOS DE EJEMPLO SIMPLES - TABLA MIEMBROS
-- Para probar la visualización de nuevos miembros
-- ============================================

-- Estos datos se pueden usar INMEDIATAMENTE
-- Solo copia y pega en el SQL Editor de Supabase

-- ============================================
-- INSERTAR NUEVOS MIEMBROS DE EJEMPLO
-- ============================================

-- Miembro 1: Profesional recién ingresado
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'Juan Alberto Pérez González',
  'Tecnólogo Médico - Medicina Transfusional',
  'Especialista en inmunohematología con 8 años de experiencia en bancos de sangre y medicina transfusional. Certificado en gestión de calidad ISO 15189.',
  CURRENT_DATE - INTERVAL '2 days', -- Ingresó hace 2 días
  'Santiago',
  'sochimt'
);

-- Miembro 2: Estudiante recién aprobado
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'María Fernanda Silva Rojas',
  'Estudiante de Tecnología Médica',
  'Estudiante de 4º año de Tecnología Médica con mención en Banco de Sangre. Realizando práctica profesional en Hospital Regional.',
  CURRENT_DATE - INTERVAL '1 day', -- Ingresó ayer
  'Valparaíso',
  'medical'
);

-- Miembro 3: Profesional con experiencia
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'Dr. Carlos Eduardo Rodríguez Muñoz',
  'Médico Hematólogo - Inmunohematología',
  'Médico hematólogo especializado en medicina transfusional e inmunohematología. Coordinador de banco de sangre con 12 años de experiencia.',
  CURRENT_DATE, -- Ingresó hoy
  'Concepción',
  'purple'
);

-- Miembro 4: Profesional de región
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'Ana Patricia Torres Ramírez',
  'Tecnóloga Médica - Hemoterapia',
  'Especialista en hemoterapia y aféresis terapéutica. Encargada de unidad de medicina transfusional en hospital de alta complejidad.',
  CURRENT_DATE - INTERVAL '3 days',
  'La Serena',
  'sochimt'
);

-- Miembro 5: Investigador
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'Dr. Felipe Ignacio Morales Castro',
  'Bioquímico Clínico - Investigación',
  'PhD en inmunología. Investigador en tipificación HLA y compatibilidad transfusional. Autor de 15 publicaciones indexadas en medicina transfusional.',
  CURRENT_DATE - INTERVAL '5 days',
  'Viña del Mar',
  'medical'
);

-- Miembro 6: Enfermera especializada
INSERT INTO miembros (
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
) VALUES (
  'Claudia Beatriz Sánchez Vera',
  'Enfermera - Medicina Transfusional',
  'Enfermera especialista en medicina transfusional y cuidados críticos. Certificada en hemovigilancia y reacciones transfusionales.',
  CURRENT_DATE - INTERVAL '1 week',
  'Temuco',
  'purple'
);

-- ============================================
-- VERIFICAR LOS NUEVOS MIEMBROS INSERTADOS
-- ============================================

-- Ver todos los miembros ordenados por fecha de ingreso (más recientes primero)
SELECT 
  id,
  nombre,
  especialidad,
  ciudad,
  fecha_ingreso,
  DATE_PART('day', CURRENT_DATE - fecha_ingreso) as dias_desde_ingreso
FROM miembros
ORDER BY fecha_ingreso DESC;

-- ============================================
-- CONSULTAS ÚTILES PARA LA WEB
-- ============================================

-- Obtener los 5 miembros más recientes
SELECT 
  id,
  nombre,
  especialidad,
  descripcion,
  fecha_ingreso,
  ciudad,
  color_avatar
FROM miembros
ORDER BY fecha_ingreso DESC
LIMIT 5;

-- Contar miembros por ciudad
SELECT 
  ciudad,
  COUNT(*) as total_miembros
FROM miembros
GROUP BY ciudad
ORDER BY total_miembros DESC;

-- Contar miembros por especialidad
SELECT 
  CASE 
    WHEN especialidad LIKE '%Tecnólog%' THEN 'Tecnólogos Médicos'
    WHEN especialidad LIKE '%Médico%' OR especialidad LIKE '%Dr.%' THEN 'Médicos'
    WHEN especialidad LIKE '%Enferm%' THEN 'Enfermeros'
    WHEN especialidad LIKE '%Estudiante%' THEN 'Estudiantes'
    ELSE 'Otros Profesionales'
  END as categoria,
  COUNT(*) as total
FROM miembros
GROUP BY categoria
ORDER BY total DESC;

-- ============================================
-- DATOS PARA EL DASHBOARD DE ESTADÍSTICAS
-- ============================================

-- Total de miembros
SELECT COUNT(*) as total_miembros FROM miembros;

-- Miembros nuevos este mes
SELECT COUNT(*) as miembros_mes_actual 
FROM miembros 
WHERE DATE_TRUNC('month', fecha_ingreso) = DATE_TRUNC('month', CURRENT_DATE);

-- Miembros nuevos esta semana
SELECT COUNT(*) as miembros_semana_actual 
FROM miembros 
WHERE fecha_ingreso >= CURRENT_DATE - INTERVAL '7 days';

-- Miembros nuevos hoy
SELECT COUNT(*) as miembros_hoy 
FROM miembros 
WHERE fecha_ingreso = CURRENT_DATE;

-- ============================================
-- ACTUALIZAR UN MIEMBRO (Ejemplo)
-- ============================================

-- Actualizar foto de perfil
UPDATE miembros 
SET 
  url_foto = 'https://ui-avatars.com/api/?name=Juan+Perez&background=2563eb&color=fff&size=200',
  updated_at = NOW()
WHERE nombre = 'Juan Alberto Pérez González';

-- Actualizar descripción
UPDATE miembros 
SET 
  descripcion = descripcion || ' Ponente en el último Congreso Nacional de Medicina Transfusional.',
  updated_at = NOW()
WHERE nombre = 'María Fernanda Silva Rojas';

-- ============================================
-- ELIMINAR DATOS DE PRUEBA (Si es necesario)
-- ============================================

-- CUIDADO: Esto elimina todos los ejemplos insertados
-- Descomentar solo si quieres limpiar la base de datos

/*
DELETE FROM miembros 
WHERE nombre IN (
  'Juan Alberto Pérez González',
  'María Fernanda Silva Rojas',
  'Dr. Carlos Eduardo Rodríguez Muñoz',
  'Ana Patricia Torres Ramírez',
  'Dr. Felipe Ignacio Morales Castro',
  'Claudia Beatriz Sánchez Vera'
);
*/

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================

/*
PARA PROBAR EN SUPABASE:

1. Abre Supabase Dashboard
2. Ve a SQL Editor
3. Copia y pega el bloque INSERT que necesites
4. Click en "Run" o presiona Ctrl+Enter
5. Ve a Table Editor > miembros para verificar

PARA VISUALIZAR EN LA WEB:

1. Los datos se mostrarán automáticamente en la sección #miembros del index.html
2. La web hace un fetch a Supabase para obtener los miembros
3. Los miembros más recientes aparecen primero

COLORES DISPONIBLES PARA AVATARES:
- 'sochimt' (azul - color principal de la sociedad)
- 'medical' (rojo - color médico)
- 'purple' (morado - variación)
- También puedes usar url_foto con un link directo a una imagen

FECHAS DE INGRESO:
- CURRENT_DATE: Hoy
- CURRENT_DATE - INTERVAL '1 day': Ayer
- CURRENT_DATE - INTERVAL '1 week': Hace una semana
- CURRENT_DATE - INTERVAL '1 month': Hace un mes
*/
