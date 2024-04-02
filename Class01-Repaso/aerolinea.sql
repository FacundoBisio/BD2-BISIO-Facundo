drop database if exists db2024;
create database db2024;
use db2024;
CREATE TABLE TipoDoc (
    id_tipDoc INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255)
);



CREATE TABLE Destino (
    id_destino INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255)
);



CREATE TABLE Pasajero (
    id_pasajero INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefono INT,
    id_tipoDoc INT,
    CONSTRAINT pasajero_fk FOREIGN KEY (id_tipoDoc) REFERENCES TipoDoc(id_tipDoc)
);



CREATE TABLE Vuelo (
    id_vuelo INT PRIMARY KEY,
    num_vuelo INT NOT NULL,
    num_avion INT NOT NULL,
    origen VARCHAR(255) NOT NULL,
    horafecha DATETIME NOT NULL,
    descripcion VARCHAR(255),
    id_destino INT,
    CONSTRAINT vuelo_fk FOREIGN KEY (id_destino) REFERENCES Destino(id_destino)
);



CREATE TABLE EstadoR (
    id_estadoR INT PRIMARY KEY,
    estado INT NOT NULL,
    descripcion VARCHAR(255)
);



CREATE TABLE EstadoAS (
    id_estadoAS INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255)
);



CREATE TABLE Historial_estadoAS (
    id_historial_estadoAS INT PRIMARY KEY,
    estadoAS INT,
    descripcion VARCHAR(255),
    CONSTRAINT historial_estadoAS_fk FOREIGN KEY (estadoAS) REFERENCES EstadoAS(id_estadoAS)
);

CREATE TABLE Asiento (
    id_asiento INT PRIMARY KEY,
    numero INT NOT NULL,
    id_historial_estadoAS INT,
    CONSTRAINT asiento_historial_fk FOREIGN KEY (id_historial_estadoAS) REFERENCES Historial_estadoAS(id_historial_estadoAS)

);

CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY,
    codigo INT NOT NULL,
    horafecha DATETIME NOT NULL,
    id_estadoR INT,
    id_vuelo INT,
    id_pasajero INT,
    id_asiento INT,
    descripcion VARCHAR(255),
    CONSTRAINT reserva_estadoR_fk FOREIGN KEY (id_estadoR) REFERENCES EstadoR(id_estadoR),
    CONSTRAINT reserva_vuelo_fk FOREIGN KEY (id_vuelo) REFERENCES Vuelo(id_vuelo),
    CONSTRAINT reserva_pasajero_fk FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id_pasajero),
    CONSTRAINT reserva_asiento_fk FOREIGN KEY (id_asiento) REFERENCES Asiento(id_asiento)
);







CREATE TABLE Pasajero_Reserva (
    id_pasajero_reserva INT PRIMARY KEY,
    id_reserva INT,
    id_pasajero INT,
    descripcion VARCHAR(255),
    CONSTRAINT pasajero_reserva_reserva_fk FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
    CONSTRAINT pasajero_reserva_pasajero_fk FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id_pasajero)
);
