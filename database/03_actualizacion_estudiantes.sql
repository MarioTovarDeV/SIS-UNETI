---Campos sociodemográficos para la IA o agente---
---Propósito: Sincronizar la tabla de estudiantes con los "Diferenciadores de Mario" (campos sociodemográficos).---

SET search_path TO academia, public;

-- Agregamos las columnas para analítica sociográfica
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS matricula VARCHAR(20);
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS ciudad VARCHAR(50);
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS estado VARCHAR(50);
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS indice_academico DECIMAL(4,2) DEFAULT 0.00;
ALTER TABLE estudiantes ADD COLUMN IF NOT EXISTS nivel_socioeconomico VARCHAR(5);