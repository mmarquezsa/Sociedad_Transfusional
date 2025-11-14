-- ============================================
-- QUERIES RÁPIDAS PARA COPIAR Y PEGAR
-- Supabase SQL Editor
-- ============================================

-- ============================================
-- 🚀 QUERY #1: INSERTAR 3 MIEMBROS DE PRUEBA
-- ============================================
-- Copia todo este bloque y pégalo en SQL Editor

INSERT INTO miembros (nombre, especialidad, descripcion, fecha_ingreso, ciudad, color_avatar) VALUES
('Juan Alberto Pérez González', 'Tecnólogo Médico - Medicina Transfusional', 
 'Especialista en inmunohematología con 8 años de experiencia en bancos de sangre y medicina transfusional. Certificado en gestión de calidad ISO 15189.', 
 CURRENT_DATE - INTERVAL '1 day', 'Santiago', 'sochimt'),

('María Fernanda Silva Rojas', 'Estudiante de Tecnología Médica', 
 'Estudiante de 4º año de Tecnología Médica con mención en Banco de Sangre. Realizando práctica profesional en Hospital Regional.', 
 CURRENT_DATE, 'Valparaíso', 'medical'),

('Dr. Carlos Eduardo Rodríguez Muñoz', 'Médico Hematólogo - Inmunohematología', 
 'Médico hematólogo especializado en medicina transfusional e inmunohematología. Coordinador de banco de sangre con 12 años de experiencia.', 
 CURRENT_DATE - INTERVAL '2 days', 'Concepción', 'purple');

-- ============================================
-- ✅ QUERY #2: VERIFICAR QUE SE INSERTARON
-- ============================================

SELECT 
  id,
  nombre,
  especialidad,
  ciudad,
  fecha_ingreso,
  DATE_PART('day', CURRENT_DATE - fecha_ingreso) as dias_desde_ingreso
FROM miembros
ORDER BY fecha_ingreso DESC
LIMIT 10;

-- ============================================
-- 📊 QUERY #3: ESTADÍSTICAS DE MIEMBROS
-- ============================================

SELECT 
  COUNT(*) as total_miembros,
  COUNT(*) FILTER (WHERE fecha_ingreso >= CURRENT_DATE - INTERVAL '7 days') as nuevos_esta_semana,
  COUNT(*) FILTER (WHERE fecha_ingreso >= CURRENT_DATE - INTERVAL '30 days') as nuevos_este_mes,
  COUNT(DISTINCT ciudad) as ciudades_representadas
FROM miembros;

-- ============================================
-- 🔍 QUERY #4: VER MIEMBROS POR CIUDAD
-- ============================================

SELECT 
  ciudad,
  COUNT(*) as total_miembros,
  STRING_AGG(nombre, ', ' ORDER BY nombre) as nombres
FROM miembros
GROUP BY ciudad
ORDER BY total_miembros DESC;

-- ============================================
-- 🎓 QUERY #5: VER MIEMBROS POR ESPECIALIDAD
-- ============================================

SELECT 
  especialidad,
  COUNT(*) as total
FROM miembros
GROUP BY especialidad
ORDER BY total DESC;

-- ============================================
-- 📅 QUERY #6: MIEMBROS MÁS RECIENTES (TOP 5)
-- ============================================

SELECT 
  nombre,
  especialidad,
  ciudad,
  fecha_ingreso,
  CASE 
    WHEN fecha_ingreso = CURRENT_DATE THEN 'Hoy'
    WHEN fecha_ingreso = CURRENT_DATE - 1 THEN 'Ayer'
    ELSE fecha_ingreso::TEXT
  END as cuando_ingreso
FROM miembros
ORDER BY fecha_ingreso DESC
LIMIT 5;

-- ============================================
-- 🔧 QUERY #7: ACTUALIZAR AVATAR DE UN MIEMBRO
-- ============================================

UPDATE miembros 
SET 
  url_foto = 'https://ui-avatars.com/api/?name=' || REPLACE(nombre, ' ', '+') || '&background=2563eb&color=fff&size=200',
  updated_at = NOW()
WHERE nombre = 'Juan Alberto Pérez González';

-- ============================================
-- 🗑️ QUERY #8: ELIMINAR MIEMBROS DE PRUEBA
-- ============================================

-- CUIDADO: Solo ejecutar si quieres eliminar los datos de prueba
/*
DELETE FROM miembros 
WHERE nombre IN (
  'Juan Alberto Pérez González',
  'María Fernanda Silva Rojas',
  'Dr. Carlos Eduardo Rodríguez Muñoz'
);
*/

-- ============================================
-- 🎨 QUERY #9: INSERTAR MIEMBRO CON FOTO URL
-- ============================================

INSERT INTO miembros (nombre, especialidad, descripcion, fecha_ingreso, ciudad, url_foto) VALUES
('Ana Patricia Torres Ramírez', 'Tecnóloga Médica - Hemoterapia', 
 'Especialista en hemoterapia y aféresis terapéutica. Encargada de unidad de medicina transfusional.',
 CURRENT_DATE, 'La Serena', 
 'https://ui-avatars.com/api/?name=Ana+Torres&background=dc2626&color=fff&size=200');

-- ============================================
-- 📈 QUERY #10: DASHBOARD COMPLETO
-- ============================================

SELECT 
  'Total Miembros' as metrica,
  COUNT(*)::TEXT as valor
FROM miembros

UNION ALL

SELECT 
  'Nuevos Esta Semana',
  COUNT(*)::TEXT
FROM miembros
WHERE fecha_ingreso >= CURRENT_DATE - INTERVAL '7 days'

UNION ALL

SELECT 
  'Nuevos Este Mes',
  COUNT(*)::TEXT
FROM miembros
WHERE fecha_ingreso >= CURRENT_DATE - INTERVAL '30 days'

UNION ALL

SELECT 
  'Ciudades',
  COUNT(DISTINCT ciudad)::TEXT
FROM miembros

UNION ALL

SELECT 
  'Miembro Más Reciente',
  nombre
FROM miembros
ORDER BY fecha_ingreso DESC
LIMIT 1;

-- ============================================
-- 🔐 QUERY #11: VER TABLA SOCIOS (Si existe)
-- ============================================

SELECT 
  nombre_completo,
  email,
  especialidad,
  ciudad,
  estado,
  tipo_membresia,
  fecha_ingreso
FROM socios
ORDER BY created_at DESC
LIMIT 10;

-- ============================================
-- 🎯 QUERY #12: INSERTAR VARIOS MIEMBROS DE UNA VEZ
-- ============================================

INSERT INTO miembros (nombre, especialidad, descripcion, fecha_ingreso, ciudad, color_avatar) VALUES
('Pedro Alejandro Fuentes López', 'Tecnólogo Médico - Banco de Sangre', 
 'Especialista en selección de donantes y procesamiento de hemocomponentes.', 
 CURRENT_DATE - INTERVAL '3 days', 'Antofagasta', 'sochimt'),
 
('Sofía Constanza Valenzuela Díaz', 'Bioquímica Clínica', 
 'Bioquímica especializada en análisis inmunohematológicos y pruebas de compatibilidad.', 
 CURRENT_DATE - INTERVAL '5 days', 'Rancagua', 'medical'),
 
('Dr. Roberto Andrés Gutiérrez Soto', 'Médico Internista', 
 'Médico internista con formación en medicina transfusional y hemovigilancia.', 
 CURRENT_DATE - INTERVAL '1 week', 'Puerto Montt', 'purple'),
 
('Isabel Carolina Muñoz Pinto', 'Enfermera Especialista', 
 'Enfermera con mención en cuidados críticos y administración de hemoderivados.', 
 CURRENT_DATE - INTERVAL '4 days', 'Iquique', 'sochimt'),
 
('TM. Javier Esteban Ramírez Cruz', 'Tecnólogo Médico - Inmunohematología', 
 'Especialista en tipificación sanguínea compleja y búsqueda de donantes raros.', 
 CURRENT_DATE - INTERVAL '6 days', 'Talca', 'medical');

-- ============================================
-- 🌟 QUERY #13: BÚSQUEDA POR NOMBRE
-- ============================================

SELECT * FROM miembros 
WHERE nombre ILIKE '%juan%' 
   OR nombre ILIKE '%pérez%'
ORDER BY fecha_ingreso DESC;

-- ============================================
-- 🏆 QUERY #14: MIEMBROS CON DESCRIPCIONES MÁS LARGAS
-- ============================================

SELECT 
  nombre,
  especialidad,
  LENGTH(descripcion) as longitud_descripcion,
  LEFT(descripcion, 100) || '...' as preview
FROM miembros
ORDER BY longitud_descripcion DESC
LIMIT 5;

-- ============================================
-- 📊 QUERY #15: ANÁLISIS POR REGIÓN
-- ============================================

SELECT 
  ciudad,
  COUNT(*) as total_miembros,
  ARRAY_AGG(especialidad) as especialidades,
  MIN(fecha_ingreso) as primer_miembro,
  MAX(fecha_ingreso) as ultimo_miembro
FROM miembros
GROUP BY ciudad
HAVING COUNT(*) > 0
ORDER BY total_miembros DESC;

-- ============================================
-- NOTAS DE USO
-- ============================================

/*
INSTRUCCIONES:
1. Abre Supabase Dashboard
2. Ve a SQL Editor
3. Copia cualquiera de estas queries
4. Pégala en el editor
5. Click en "Run" (▶️) o Ctrl+Enter
6. ¡Listo!

QUERIES MÁS ÚTILES PARA EMPEZAR:
- Query #1: Insertar miembros de prueba
- Query #2: Verificar que se insertaron
- Query #3: Ver estadísticas
- Query #6: Ver los más recientes

QUERIES PARA LIMPIAR:
- Query #8: Eliminar datos de prueba (cuidado!)

PERSONALIZACIÓN:
- Cambia los nombres, ciudades y especialidades según necesites
- Ajusta las fechas de ingreso modificando el INTERVAL
- Modifica los colores: 'sochimt', 'medical', 'purple'
*/
