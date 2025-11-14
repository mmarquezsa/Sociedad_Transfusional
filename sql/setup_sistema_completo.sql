-- ============================================
-- SETUP COMPLETO DEL SISTEMA SOCHIMT
-- Sistema de Socios + IA Gotita + Contenido Premium
-- ============================================

-- ============================================
-- 1. TABLA DE SOCIOS (con Supabase Auth)
-- ============================================
CREATE TABLE IF NOT EXISTS socios (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email VARCHAR(255) UNIQUE NOT NULL,
  nombre_completo VARCHAR(255) NOT NULL,
  rut VARCHAR(20) UNIQUE,
  especialidad VARCHAR(100),
  ciudad VARCHAR(100),
  telefono VARCHAR(20),
  foto_perfil_url TEXT,
  
  -- Estado de membresía
  estado VARCHAR(50) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'activo', 'suspendido', 'inactivo')),
  tipo_membresia VARCHAR(50) DEFAULT 'regular' CHECK (tipo_membresia IN ('regular', 'estudiante', 'honorario', 'vitalicio')),
  fecha_ingreso DATE DEFAULT CURRENT_DATE,
  fecha_vencimiento DATE,
  
  -- Preferencias
  recibir_newsletter BOOLEAN DEFAULT true,
  categorias_interes TEXT[],
  
  -- Metadata
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  ultimo_acceso TIMESTAMP WITH TIME ZONE
);

-- Índices para socios
CREATE INDEX idx_socios_email ON socios(email);
CREATE INDEX idx_socios_estado ON socios(estado);
CREATE INDEX idx_socios_rut ON socios(rut);

-- Trigger para actualizar updated_at
CREATE OR REPLACE FUNCTION update_updated_at_socios()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_socios
BEFORE UPDATE ON socios
FOR EACH ROW EXECUTE FUNCTION update_updated_at_socios();

-- ============================================
-- 2. BASE DE CONOCIMIENTOS PARA GOTITA
-- ============================================
CREATE TABLE IF NOT EXISTS base_conocimientos (
  id BIGSERIAL PRIMARY KEY,
  titulo VARCHAR(500) NOT NULL,
  categoria VARCHAR(100) NOT NULL,
  subcategoria VARCHAR(100),
  contenido TEXT NOT NULL,
  fuente VARCHAR(500),
  url_referencia TEXT,
  fecha_actualizacion DATE DEFAULT CURRENT_DATE,
  palabras_clave TEXT[],
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_conocimientos_categoria ON base_conocimientos(categoria);
CREATE INDEX idx_conocimientos_activo ON base_conocimientos(activo);
CREATE INDEX idx_conocimientos_palabras ON base_conocimientos USING GIN(palabras_clave);

-- Datos iniciales de conocimientos
INSERT INTO base_conocimientos (titulo, categoria, subcategoria, contenido, fuente, palabras_clave) VALUES
('Criterios básicos de selección de donantes', 'seleccion_donantes', 'criterios_generales', 
'Para ser donante de sangre en Chile, la persona debe cumplir con los siguientes criterios básicos:
- Edad entre 18 y 65 años
- Peso mínimo de 50 kg
- Presión arterial sistólica entre 90-180 mmHg y diastólica entre 50-100 mmHg
- Hemoglobina mínima: Mujeres 12.5 g/dL, Hombres 13.5 g/dL
- Sin síntomas de enfermedad aguda
- Intervalo mínimo entre donaciones: 2 meses para hombres, 3 meses para mujeres',
'Minsal Chile - Norma Técnica de Hemoterapia',
ARRAY['donantes', 'criterios', 'edad', 'peso', 'presión', 'hemoglobina']),

('Contraindicaciones permanentes', 'seleccion_donantes', 'contraindicaciones',
'Están permanentemente contraindicados para donar sangre:
- Personas con VIH/SIDA
- Hepatitis B o C crónica
- Enfermedad de Chagas
- Historia de uso de drogas intravenosas
- Algunos cánceres (excepto carcinoma basocelular de piel)
- Enfermedad cardiovascular severa
- Trastornos de la coagulación hereditarios',
'AABB Standards',
ARRAY['contraindicaciones', 'permanentes', 'vih', 'hepatitis', 'chagas', 'drogas']),

('Contraindicaciones temporales', 'seleccion_donantes', 'contraindicaciones',
'Están temporalmente contraindicados:
- Resfriado o gripe (7 días después de recuperación)
- Extracción dental (7 días)
- Tatuajes o piercing (6 meses en Chile)
- Embarazo (hasta 6 meses post-parto)
- Lactancia (hasta 3 meses después de finalizar)
- Viaje a zona de malaria (1 año)
- Vacuna contra COVID-19 (según tipo: 0-28 días)
- Medicamentos (según tipo)',
'Minsal Chile',
ARRAY['contraindicaciones', 'temporales', 'embarazo', 'tatuaje', 'vacunas', 'medicamentos']);

-- ============================================
-- 3. CONVERSACIONES DE GOTITA
-- ============================================
CREATE TABLE IF NOT EXISTS conversaciones_gotita (
  id BIGSERIAL PRIMARY KEY,
  socio_id UUID REFERENCES socios(id) ON DELETE CASCADE,
  session_id UUID DEFAULT gen_random_uuid(),
  mensaje_usuario TEXT NOT NULL,
  respuesta_gotita TEXT NOT NULL,
  fuentes_citadas TEXT[],
  tokens_usados INT,
  modelo_usado VARCHAR(50) DEFAULT 'gpt-4',
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_conversaciones_socio ON conversaciones_gotita(socio_id);
CREATE INDEX idx_conversaciones_session ON conversaciones_gotita(session_id);
CREATE INDEX idx_conversaciones_timestamp ON conversaciones_gotita(timestamp DESC);

-- ============================================
-- 4. ARTÍCULOS/BLOG
-- ============================================
CREATE TABLE IF NOT EXISTS articulos (
  id BIGSERIAL PRIMARY KEY,
  titulo VARCHAR(500) NOT NULL,
  slug VARCHAR(500) UNIQUE NOT NULL,
  resumen TEXT,
  contenido TEXT NOT NULL,
  autor_id UUID REFERENCES socios(id),
  categoria VARCHAR(100) NOT NULL,
  tags TEXT[],
  imagen_destacada_url TEXT,
  url_pdf TEXT,
  tiempo_lectura INT, -- minutos
  vistas INT DEFAULT 0,
  destacado BOOLEAN DEFAULT false,
  solo_socios BOOLEAN DEFAULT true,
  fecha_publicacion TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_articulos_categoria ON articulos(categoria);
CREATE INDEX idx_articulos_autor ON articulos(autor_id);
CREATE INDEX idx_articulos_slug ON articulos(slug);
CREATE INDEX idx_articulos_tags ON articulos USING GIN(tags);
CREATE INDEX idx_articulos_publicacion ON articulos(fecha_publicacion DESC);

-- ============================================
-- 5. EVENTOS
-- ============================================
CREATE TABLE IF NOT EXISTS eventos (
  id BIGSERIAL PRIMARY KEY,
  titulo VARCHAR(300) NOT NULL,
  descripcion TEXT,
  tipo VARCHAR(50) CHECK (tipo IN ('webinar', 'congreso', 'curso', 'reunion', 'taller')),
  fecha_inicio TIMESTAMP WITH TIME ZONE NOT NULL,
  fecha_fin TIMESTAMP WITH TIME ZONE,
  ubicacion VARCHAR(300),
  modalidad VARCHAR(50) CHECK (modalidad IN ('presencial', 'virtual', 'hibrido')),
  url_evento TEXT, -- Link a Zoom/Meet
  precio DECIMAL(10, 2) DEFAULT 0,
  cupos_total INT,
  cupos_disponibles INT,
  imagen_url TEXT,
  destacado BOOLEAN DEFAULT false,
  solo_socios BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_eventos_fecha ON eventos(fecha_inicio);
CREATE INDEX idx_eventos_tipo ON eventos(tipo);
CREATE INDEX idx_eventos_destacado ON eventos(destacado);

-- ============================================
-- 6. INSCRIPCIONES A EVENTOS
-- ============================================
CREATE TABLE IF NOT EXISTS inscripciones (
  id BIGSERIAL PRIMARY KEY,
  evento_id BIGINT REFERENCES eventos(id) ON DELETE CASCADE,
  socio_id UUID REFERENCES socios(id) ON DELETE CASCADE,
  estado VARCHAR(50) DEFAULT 'confirmado' CHECK (estado IN ('pendiente', 'confirmado', 'cancelado', 'asistio')),
  fecha_inscripcion TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  notas TEXT,
  UNIQUE(evento_id, socio_id)
);

CREATE INDEX idx_inscripciones_evento ON inscripciones(evento_id);
CREATE INDEX idx_inscripciones_socio ON inscripciones(socio_id);

-- ============================================
-- 7. RECURSOS DESCARGABLES
-- ============================================
CREATE TABLE IF NOT EXISTS recursos (
  id BIGSERIAL PRIMARY KEY,
  titulo VARCHAR(300) NOT NULL,
  descripcion TEXT,
  tipo VARCHAR(50) CHECK (tipo IN ('guia', 'protocolo', 'formulario', 'presentacion', 'documento')),
  categoria VARCHAR(100),
  archivo_url TEXT NOT NULL,
  tamano_mb DECIMAL(10, 2),
  descargas_count INT DEFAULT 0,
  solo_socios BOOLEAN DEFAULT true,
  destacado BOOLEAN DEFAULT false,
  fecha_publicacion DATE DEFAULT CURRENT_DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_recursos_categoria ON recursos(categoria);
CREATE INDEX idx_recursos_tipo ON recursos(tipo);

-- ============================================
-- 8. TRACKING DE DESCARGAS
-- ============================================
CREATE TABLE IF NOT EXISTS descargas_recursos (
  id BIGSERIAL PRIMARY KEY,
  recurso_id BIGINT REFERENCES recursos(id) ON DELETE CASCADE,
  socio_id UUID REFERENCES socios(id),
  ip_address VARCHAR(50),
  fecha_descarga TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_descargas_recurso ON descargas_recursos(recurso_id);
CREATE INDEX idx_descargas_socio ON descargas_recursos(socio_id);

-- ============================================
-- 9. CERTIFICACIONES
-- ============================================
CREATE TABLE IF NOT EXISTS certificaciones (
  id BIGSERIAL PRIMARY KEY,
  socio_id UUID REFERENCES socios(id) ON DELETE CASCADE,
  evento_id BIGINT REFERENCES eventos(id),
  titulo VARCHAR(300) NOT NULL,
  descripcion TEXT,
  horas_certificadas INT,
  fecha_emision DATE NOT NULL,
  codigo_verificacion VARCHAR(100) UNIQUE NOT NULL,
  url_certificado_pdf TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_certificaciones_socio ON certificaciones(socio_id);
CREATE INDEX idx_certificaciones_codigo ON certificaciones(codigo_verificacion);

-- ============================================
-- 10. NEWSLETTER SUBSCRIBERS
-- ============================================
CREATE TABLE IF NOT EXISTS suscriptores_newsletter (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  nombre VARCHAR(255),
  es_socio BOOLEAN DEFAULT false,
  socio_id UUID REFERENCES socios(id),
  categorias_interes TEXT[],
  activo BOOLEAN DEFAULT true,
  fecha_suscripcion TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  fecha_confirmacion TIMESTAMP WITH TIME ZONE,
  token_confirmacion VARCHAR(100),
  fuente VARCHAR(100) -- 'web', 'evento', 'referido'
);

CREATE INDEX idx_newsletter_email ON suscriptores_newsletter(email);
CREATE INDEX idx_newsletter_activo ON suscriptores_newsletter(activo);

-- ============================================
-- 11. LOGS DE ACCESO
-- ============================================
CREATE TABLE IF NOT EXISTS logs_acceso (
  id BIGSERIAL PRIMARY KEY,
  socio_id UUID REFERENCES socios(id),
  accion VARCHAR(100) NOT NULL,
  recurso_accedido VARCHAR(500),
  ip_address VARCHAR(50),
  user_agent TEXT,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_logs_socio ON logs_acceso(socio_id);
CREATE INDEX idx_logs_timestamp ON logs_acceso(timestamp DESC);

-- ============================================
-- 12. ROW LEVEL SECURITY (RLS)
-- ============================================

-- Habilitar RLS en todas las tablas
ALTER TABLE socios ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversaciones_gotita ENABLE ROW LEVEL SECURITY;
ALTER TABLE articulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE eventos ENABLE ROW LEVEL SECURITY;
ALTER TABLE inscripciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE recursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE certificaciones ENABLE ROW LEVEL SECURITY;

-- Políticas para socios (pueden ver y editar su propia información)
CREATE POLICY "Socios pueden ver su propia información"
  ON socios FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Socios pueden actualizar su propia información"
  ON socios FOR UPDATE
  USING (auth.uid() = id);

-- Políticas para conversaciones (solo el socio puede ver sus conversaciones)
CREATE POLICY "Socios pueden ver sus conversaciones"
  ON conversaciones_gotita FOR SELECT
  USING (auth.uid() = socio_id);

CREATE POLICY "Socios pueden crear conversaciones"
  ON conversaciones_gotita FOR INSERT
  WITH CHECK (auth.uid() = socio_id);

-- Políticas para artículos
CREATE POLICY "Lectura pública de artículos destacados"
  ON articulos FOR SELECT
  USING (NOT solo_socios OR auth.uid() IS NOT NULL);

-- Políticas para eventos
CREATE POLICY "Lectura pública de eventos"
  ON eventos FOR SELECT
  USING (NOT solo_socios OR auth.uid() IS NOT NULL);

-- Políticas para inscripciones
CREATE POLICY "Socios pueden ver sus inscripciones"
  ON inscripciones FOR SELECT
  USING (auth.uid() = socio_id);

CREATE POLICY "Socios pueden inscribirse"
  ON inscripciones FOR INSERT
  WITH CHECK (auth.uid() = socio_id);

-- Políticas para recursos
CREATE POLICY "Lectura pública de recursos"
  ON recursos FOR SELECT
  USING (NOT solo_socios OR auth.uid() IS NOT NULL);

-- Políticas para certificaciones
CREATE POLICY "Socios pueden ver sus certificaciones"
  ON certificaciones FOR SELECT
  USING (auth.uid() = socio_id);

-- ============================================
-- 13. FUNCIONES ÚTILES
-- ============================================

-- Función para incrementar contador de descargas
CREATE OR REPLACE FUNCTION increment_recurso_downloads(recurso_id_param BIGINT)
RETURNS VOID AS $$
BEGIN
  UPDATE recursos 
  SET descargas_count = descargas_count + 1 
  WHERE id = recurso_id_param;
END;
$$ LANGUAGE plpgsql;

-- Función para incrementar vistas de artículos
CREATE OR REPLACE FUNCTION increment_articulo_views(articulo_id_param BIGINT)
RETURNS VOID AS $$
BEGIN
  UPDATE articulos 
  SET vistas = vistas + 1 
  WHERE id = articulo_id_param;
END;
$$ LANGUAGE plpgsql;

-- Función para verificar si socio está activo
CREATE OR REPLACE FUNCTION is_socio_activo(socio_id_param UUID)
RETURNS BOOLEAN AS $$
DECLARE
  estado_actual VARCHAR(50);
  fecha_venc DATE;
BEGIN
  SELECT estado, fecha_vencimiento INTO estado_actual, fecha_venc
  FROM socios WHERE id = socio_id_param;
  
  RETURN estado_actual = 'activo' AND (fecha_venc IS NULL OR fecha_venc >= CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 14. VISTA DE ANALYTICS
-- ============================================
CREATE OR REPLACE VIEW analytics_dashboard AS
SELECT 
  (SELECT COUNT(*) FROM socios WHERE estado = 'activo') as socios_activos,
  (SELECT COUNT(*) FROM socios) as total_socios,
  (SELECT COUNT(*) FROM conversaciones_gotita WHERE timestamp > NOW() - INTERVAL '30 days') as consultas_gotita_mes,
  (SELECT COUNT(DISTINCT session_id) FROM conversaciones_gotita WHERE timestamp > NOW() - INTERVAL '30 days') as sesiones_gotita_mes,
  (SELECT COUNT(*) FROM articulos WHERE solo_socios = true) as articulos_premium,
  (SELECT SUM(vistas) FROM articulos WHERE fecha_publicacion > NOW() - INTERVAL '30 days') as vistas_articulos_mes,
  (SELECT COUNT(*) FROM eventos WHERE fecha_inicio > NOW()) as eventos_proximos,
  (SELECT COUNT(*) FROM inscripciones WHERE fecha_inscripcion > NOW() - INTERVAL '30 days') as inscripciones_mes,
  (SELECT COUNT(*) FROM descargas_recursos WHERE fecha_descarga > NOW() - INTERVAL '30 days') as descargas_mes,
  (SELECT COUNT(*) FROM suscriptores_newsletter WHERE activo = true) as suscriptores_activos;

-- ============================================
-- 15. DATOS DE EJEMPLO PARA TESTING
-- ============================================

-- Nota: Los socios se crearán a través de Supabase Auth
-- Aquí solo insertamos datos de ejemplo para otras tablas

-- Eventos de ejemplo
INSERT INTO eventos (titulo, descripcion, tipo, fecha_inicio, fecha_fin, modalidad, cupos_total, cupos_disponibles, solo_socios) VALUES
('Webinar: Actualización en Selección de Donantes', 'Revisión de las últimas guías internacionales para selección de donantes de sangre', 'webinar', NOW() + INTERVAL '15 days', NOW() + INTERVAL '15 days' + INTERVAL '2 hours', 'virtual', 100, 100, false),
('Curso: Medicina Transfusional Avanzada', 'Curso intensivo de 3 días sobre medicina transfusional', 'curso', NOW() + INTERVAL '30 days', NOW() + INTERVAL '33 days', 'presencial', 30, 28, true),
('Congreso Anual SOCHIMT 2025', 'Congreso anual de la Sociedad Chilena de Medicina Transfusional', 'congreso', NOW() + INTERVAL '90 days', NOW() + INTERVAL '93 days', 'hibrido', 200, 150, false);

-- Recursos de ejemplo
INSERT INTO recursos (titulo, descripcion, tipo, categoria, archivo_url, solo_socios) VALUES
('Protocolo de Transfusión de Emergencia', 'Protocolo actualizado para transfusiones de emergencia', 'protocolo', 'Protocolos Clínicos', 'https://example.com/protocolo.pdf', true),
('Guía de Selección de Donantes 2025', 'Guía completa actualizada según normativa Minsal', 'guia', 'Selección de Donantes', 'https://example.com/guia.pdf', false),
('Formulario de Evaluación Pre-Donación', 'Formulario estandarizado para evaluación de donantes', 'formulario', 'Formularios', 'https://example.com/formulario.pdf', true);

-- ============================================
-- FIN DEL SCRIPT
-- ============================================

-- Para verificar que todo se creó correctamente:
SELECT 
  tablename, 
  schemaname 
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename IN ('socios', 'base_conocimientos', 'conversaciones_gotita', 'articulos', 'eventos', 'inscripciones', 'recursos', 'certificaciones')
ORDER BY tablename;
