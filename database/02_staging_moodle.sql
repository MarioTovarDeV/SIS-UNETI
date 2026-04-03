---Pista de aterrizaje donde descansa los datos externos---
---Propósito: La pista de aterrizaje para los datos que vienen del Excel.---

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.importacion_moodle_raw (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    estudiante_cedula VARCHAR(20),
    nota_moodle_100 DECIMAL(5,2),
    data_completa_json JSONB,
    fecha_carga TIMESTAMPTZ DEFAULT NOW(),
    procesado BOOLEAN DEFAULT FALSE
);