-- =====================================================================
-- APORTE CÉLULA 01: EXTENSIÓN SOCIODEMOGRÁFICA V4.5 
-- =====================================================================

ALTER TABLE estudiantes.estudiantes 
ADD COLUMN IF NOT EXISTS estrato_social VARCHAR(2),
ADD COLUMN IF NOT EXISTS acceso_internet BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS dispositivo_propio BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS situacion_laboral VARCHAR(50),
-- NUEVO REQUERIMIENTO: DISCAPACIDAD
ADD COLUMN IF NOT EXISTS tiene_discapacidad BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS discapacidad_tipo VARCHAR(100); 

-- 2. Actualizamos la Metadata para Swagger e IA
COMMENT ON COLUMN estudiantes.estudiantes.tiene_discapacidad IS 'Flag de inclusión: indica si el estudiante posee alguna discapacidad.';
COMMENT ON COLUMN estudiantes.estudiantes.discapacidad_tipo IS 'Descripción de la discapacidad según registro médico legal.';

-- 3. Verificación de seguridad
SELECT 'ADN Soberano Inyectado Exitosamente' as status;