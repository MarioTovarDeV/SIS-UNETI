-- 1. Aseguramos el esquema y herramientas
SET search_path TO seguridad, public;

-- 2. Limpieza preventiva
DELETE FROM usuario_roles WHERE usuario_id IN (SELECT id FROM usuarios WHERE cedula = 'V25029008');
DELETE FROM usuarios WHERE cedula = 'V25029008';

-- 3. INSERT de Roles (Mantenemos los nombres de columna 'codigo' y 'nombre')
INSERT INTO roles (codigo, nombre, nivel_jerarquico) 
VALUES 
('ESTUDIANTE', 'Estudiante', 1),
('ADMINISTRADOR', 'Administrador', 5)
ON CONFLICT (codigo) DO NOTHING;

-- 4. INSERT de Usuario (QUITAMOS rol_id de aquí)
-- Usamos 'WITH' para guardar el ID generado y usarlo en el siguiente paso
WITH nuevo_admin AS (
    INSERT INTO usuarios (id, cedula, correo_principal, password_hash, salt, nombres, apellidos, estado_usuario)
    VALUES (
        gen_random_uuid(), 
        'V25029008', 
        'mario.tovar@uneti.edu.ve', 
        crypt('admin123', gen_salt('bf')), 
        'salt_ejemplo',
        'Mario', 
        'Tovar', 
        'ACTIVO'
    )
    RETURNING id
)
-- 5. ASIGNACIÓN DEL ROL (En la tabla de relación)
INSERT INTO usuario_roles (usuario_id, rol_id)
SELECT id, (SELECT id FROM roles WHERE codigo = 'ADMINISTRADOR')
FROM nuevo_admin;