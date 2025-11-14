-- Script SQL para crear la tabla 'miembros' en Supabase
-- Ejecutar este script en el SQL Editor de Supabase

-- Crear tabla de miembros
CREATE TABLE IF NOT EXISTS miembros (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  especialidad VARCHAR(255) NOT NULL,
  descripcion TEXT NOT NULL,
  fecha_ingreso DATE NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  url_foto TEXT,
  color_avatar VARCHAR(50) DEFAULT 'sochimt',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_miembros_fecha_ingreso ON miembros(fecha_ingreso DESC);
CREATE INDEX idx_miembros_especialidad ON miembros(especialidad);
CREATE INDEX idx_miembros_ciudad ON miembros(ciudad);

-- Habilitar Row Level Security (RLS)
ALTER TABLE miembros ENABLE ROW LEVEL SECURITY;

-- Política para permitir lectura pública
CREATE POLICY "Permitir lectura pública de miembros"
  ON miembros FOR SELECT
  USING (true);

-- Política para permitir inserción autenticada (opcional - ajustar según necesidades)
CREATE POLICY "Permitir inserción autenticada de miembros"
  ON miembros FOR INSERT
  WITH CHECK (true);

-- Política para permitir actualización autenticada
CREATE POLICY "Permitir actualización autenticada de miembros"
  ON miembros FOR UPDATE
  USING (true);

-- Política para permitir eliminación autenticada
CREATE POLICY "Permitir eliminación autenticada de miembros"
  ON miembros FOR DELETE
  USING (true);

-- Trigger para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc'::text, NOW());
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_miembros_updated_at BEFORE UPDATE ON miembros
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insertar datos de ejemplo (los que ya tienes en el HTML)
INSERT INTO miembros (nombre, especialidad, descripcion, fecha_ingreso, ciudad, color_avatar) VALUES
('Dr. Juan Pérez', 'Tecnólogo Médico', 'Especialista en inmunohematología con 8 años de experiencia en bancos de sangre.', '2025-01-15', 'Santiago', 'sochimt'),
('Dra. María González', 'Hematóloga', 'Médica hematóloga enfocada en terapia transfusional y hemostasia.', '2025-01-10', 'Valparaíso', 'medical'),
('TM. Carlos Rojas', 'Tecnólogo Médico', 'Especialista en medicina transfusional con certificación en gestión de calidad.', '2024-12-20', 'Concepción', 'purple');

-- Verificar que los datos se insertaron correctamente
SELECT * FROM miembros ORDER BY fecha_ingreso DESC;
