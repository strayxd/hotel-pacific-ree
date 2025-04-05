DROP TABLE IF EXISTS reserva_habitacion CASCADE;
DROP TABLE IF EXISTS reserva CASCADE;
DROP TABLE IF EXISTS pago CASCADE;
DROP TABLE IF EXISTS habitacion CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS administrador CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    correo VARCHAR(20),
    password VARCHAR(255),
    rol VARCHAR(10)
);

CREATE TABLE administrador (
    id INTEGER PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES usuario (id)
);

CREATE TABLE cliente (
    id INTEGER PRIMARY KEY,
    direccion VARCHAR(50),
    telefono VARCHAR(12),
    FOREIGN KEY (id) REFERENCES usuario (id)
);

CREATE TABLE empleado (
    id INTEGER PRIMARY KEY,
    puesto VARCHAR(10),
    FOREIGN KEY (id) REFERENCES usuario (id)
);

CREATE TABLE habitacion (
    num_habitacion INTEGER PRIMARY KEY,
    tipo_habitacion VARCHAR(10),
    precio INTEGER,
    estado VARCHAR(10),
    admin_usuario_id INTEGER,
    FOREIGN KEY (admin_usuario_id) REFERENCES administrador (id)
);

CREATE TABLE pago (
    id_pago INTEGER PRIMARY KEY,
    monto INTEGER,
    fecha_pago DATE,
    tipo_pago VARCHAR(10),
    id_reserva INTEGER NOT NULL
);

CREATE UNIQUE INDEX pago__idx ON pago (id_reserva);

CREATE TABLE reserva (
    id_reserva INTEGER PRIMARY KEY,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado_reserva VARCHAR(10),
    pago_id_pago INTEGER NOT NULL,
    FOREIGN KEY (pago_id_pago) REFERENCES pago (id_pago)
);

CREATE UNIQUE INDEX reserva__idx ON reserva (pago_id_pago);

CREATE TABLE reserva_habitacion (
    id_reserva INTEGER NOT NULL,
    num_habitacion INTEGER NOT NULL,
    PRIMARY KEY (id_reserva, num_habitacion),
    FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva),
    FOREIGN KEY (num_habitacion) REFERENCES habitacion (num_habitacion)
);

ALTER TABLE pago
ADD CONSTRAINT pago_reserva_fk FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva);