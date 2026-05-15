-- 1. Posicionamiento y limpieza total
SET search_path TO seguridad, public;

-- Borramos todo para que solo queden los 7 de Miguel
TRUNCATE TABLE seguridad.roles CASCADE;
TRUNCATE TABLE seguridad.usuarios CASCADE;

-- 2. SIEMBRA OFICIAL DE ROLES (Los 7 de la minuta)
INSERT INTO seguridad.roles (codigo, nombre, nivel_jerarquico) VALUES
('ADMINISTRADOR', 'Administrador del Sistema', 5),
('ESTUDIANTE', 'Estudiante', 1),
('DOCENTE', 'Docente', 2),
('COORDINADOR_ACADEMICO', 'Coordinador Académico', 4),
('COORDINADOR_CONTROL_ESTUDIOS', 'Coordinador de Control de Estudios', 4),
('COORDINADOR_EGRESOS', 'Coordinador de Grado/Egresos', 4),
('ANALISTA', 'Analista de Control de Estudios', 3);

-- 3. SIEMBRA OFICIAL DE USUARIOS (Con el fix de SALT)
DO $$
DECLARE
    v_pass TEXT := '$2b$10$nK0u9/mCNpSshjF2B.EbeurT2BEn2GvjV0uYf3oN7G7CqXG2V9uOa';
    v_salt TEXT := 'uneti_salt_2026';
BEGIN
    INSERT INTO usuarios (id, cedula, correo_principal, password_hash, salt, nombres, apellidos, estado_usuario) VALUES
    (gen_random_uuid(), 'V11111111', 'admin@uneti.edu.ve', v_pass, v_salt, 'Administrador', 'Sistema', 'ACTIVO'),
    (gen_random_uuid(), 'V22222222', 'estudiante@uneti.edu.ve', v_pass, v_salt, 'Estudiante', 'Regular', 'ACTIVO'),
    (gen_random_uuid(), 'V33333333', 'docente@uneti.edu.ve', v_pass, v_salt, 'Docente', 'Académico', 'ACTIVO'),
    (gen_random_uuid(), 'V44444444', 'coordinador.academico@uneti.edu.ve', v_pass, v_salt, 'Coordinador', 'Carrera', 'ACTIVO'),
    (gen_random_uuid(), 'V55555555', 'coordinador.control.estudios@uneti.edu.ve', v_pass, v_salt, 'Coordinador', 'Control Estudios', 'ACTIVO'),
    (gen_random_uuid(), 'V66666666', 'coordinador.egresos@uneti.edu.ve', v_pass, v_salt, 'Coordinador', 'Egresos', 'ACTIVO'),
    (gen_random_uuid(), 'V77777777', 'analista@uneti.edu.ve', v_pass, v_salt, 'Analista', 'Control Estudios', 'ACTIVO');

    -- 4. Vinculación Automática (Relación Many-to-Many)
    INSERT INTO usuario_roles (usuario_id, rol_id)
    SELECT u.id, r.id FROM usuarios u, roles r 
    WHERE (u.correo_principal LIKE 'admin%' AND r.codigo = 'ADMINISTRADOR')
       OR (u.correo_principal LIKE 'estudiante%' AND r.codigo = 'ESTUDIANTE')
       OR (u.correo_principal LIKE 'docente%' AND r.codigo = 'DOCENTE')
       OR (u.correo_principal LIKE 'coordinador.academico%' AND r.codigo = 'COORDINADOR_ACADEMICO')
       OR (u.correo_principal LIKE 'coordinador.control%' AND r.codigo = 'COORDINADOR_CONTROL_ESTUDIOS')
       OR (u.correo_principal LIKE 'coordinador.egresos%' AND r.codigo = 'COORDINADOR_EGRESOS')
       OR (u.correo_principal LIKE 'analista%' AND r.codigo = 'ANALISTA');
END $$;