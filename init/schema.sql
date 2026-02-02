-- ==========================================================
-- 1. SEGURIDAD Y ACCESO (Quién entra al sistema)
-- ==========================================================
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, 
    rol_acceso ENUM('Administrador', 'Coordinador', 'Voluntario') NOT NULL,
    estado INT DEFAULT 1 -- 1: Activo, 0: Inactivo
);

-- ==========================================================
-- 2. CATÁLOGOS GLOBALES (Listas básicas)
-- ==========================================================
CREATE TABLE lugar (
    id_lugar INT PRIMARY KEY AUTO_INCREMENT,
    nombre_lugar VARCHAR(150),
    direccion VARCHAR(200),
    distrito VARCHAR(100),
    referencia VARCHAR(255)
);

CREATE TABLE recurso (
    id_recurso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_recurso VARCHAR(100), -- Ej: Agua, Pala, Kit Educativo
    descripcion VARCHAR(200),
    unidad_medida VARCHAR(20)    -- Ej: Unidades, Litros, Packs
);

CREATE TABLE rol_voluntario (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50),      -- Ej: Líder, Logística, Fotógrafo
    descripcion VARCHAR(200)
);

-- ==========================================================
-- 3. ACTORES (Personas y Entidades)
-- ==========================================================
CREATE TABLE voluntario (
    id_voluntario INT PRIMARY KEY AUTO_INCREMENT,
    codigo_universitario VARCHAR(20) UNIQUE, 
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    carrera VARCHAR(100),
    id_usuario INT, -- Opcional: Si el voluntario tiene acceso al sistema
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE beneficiario (
    id_beneficiario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_entidad VARCHAR(150) NOT NULL, -- Comunidad o Institución
    tipo VARCHAR(50), 
    nombre_contacto VARCHAR(100),
    telefono_contacto VARCHAR(20)
);

CREATE TABLE donante (
    id_donante INT PRIMARY KEY AUTO_INCREMENT,
    nombre_donante VARCHAR(150) NOT NULL, -- Nombre de Grupo, Empresa o Persona
    tipo_donante ENUM('Persona', 'Empresa', 'Grupo Estudiantil', 'ONG') NOT NULL,
    ruc_o_dni VARCHAR(20),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- ==========================================================
-- 4. ESTRUCTURA CENTRAL (Actividad -> Programación)
-- ==========================================================

-- A. ACTIVIDAD (El concepto general)
CREATE TABLE actividad (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_actividad VARCHAR(150) NOT NULL, -- Ej: "Campaña Navideña"
    descripcion_general TEXT,
    objetivo TEXT
);

-- B. PROGRAMACIÓN (La ejecución real - EL CORAZÓN DEL SISTEMA)
-- Aquí conectamos Lugar y Beneficiario como pidieron
CREATE TABLE programacion_actividad (
    id_programacion INT PRIMARY KEY AUTO_INCREMENT,
    id_actividad INT NOT NULL,
    id_lugar INT NOT NULL,
    id_beneficiario INT NOT NULL,
    id_responsable INT NOT NULL, -- Voluntario líder de ESTA fecha específica
    
    fecha_ejecucion DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    estado ENUM('Pendiente', 'En Curso', 'Finalizada', 'Cancelada'),
    
    FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar),
    FOREIGN KEY (id_beneficiario) REFERENCES beneficiario(id_beneficiario),
    FOREIGN KEY (id_responsable) REFERENCES voluntario(id_voluntario)
);

-- ==========================================================
-- 5. GESTIÓN DE RECURSOS (Lo que necesito vs. Lo que tengo)
-- ==========================================================

-- A. REQUERIMIENTO (Lo que la programación NECESITA para funcionar)
-- *CLASE AGREGADA PARA PERFECCIÓN*
CREATE TABLE requerimiento_recurso (
    id_requerimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_programacion INT NOT NULL,
    id_recurso INT NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (id_programacion) REFERENCES programacion_actividad(id_programacion),
    FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso)
);

-- B. DONACIÓN (Lo que RECIBIMOS para cubrir esa necesidad)
CREATE TABLE donacion (
    id_donacion INT PRIMARY KEY AUTO_INCREMENT,
    id_programacion INT NOT NULL, -- La donación va directo a la programación
    id_donante INT NOT NULL,      -- Quién lo dio
    fecha_donacion DATE,
    observacion TEXT,
    
    FOREIGN KEY (id_programacion) REFERENCES programacion_actividad(id_programacion),
    FOREIGN KEY (id_donante) REFERENCES donante(id_donante)
);

-- C. DETALLE DONACIÓN (Qué items vinieron en esa donación)
CREATE TABLE detalle_donacion (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_donacion INT NOT NULL,
    id_recurso INT NOT NULL,
    cantidad_donada DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (id_donacion) REFERENCES donacion(id_donacion),
    FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso)
);

-- ==========================================================
-- 6. GESTIÓN DE VOLUNTARIADO (Asistencia)
-- ==========================================================
CREATE TABLE participacion (
    id_participacion INT PRIMARY KEY AUTO_INCREMENT,
    id_programacion INT NOT NULL,
    id_voluntario INT NOT NULL,
    id_rol INT NOT NULL,
    asistencia BOOLEAN DEFAULT FALSE, -- Check de si fue o no
    horas_reconocidas DECIMAL(5,2),   -- Para créditos universitarios
    
    FOREIGN KEY (id_programacion) REFERENCES programacion_actividad(id_programacion),
    FOREIGN KEY (id_voluntario) REFERENCES voluntario(id_voluntario),
    FOREIGN KEY (id_rol) REFERENCES rol_voluntario(id_rol)
);