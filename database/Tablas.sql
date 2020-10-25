USE noti_app; 

DROP TABLE IF EXISTS comentarios_noticias;
DROP TABLE IF EXISTS comentarios_comentarios;
DROP TABLE IF EXISTS comentarios;
DROP TABLE IF EXISTS subcomentarios;
DROP TABLE IF EXISTS noticia;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS noticia;


CREATE TABLE IF NOT EXISTS rol
(
	id_rol		INT 				PRIMARY KEY,
    nombre		VARCHAR(15) 		NOT NULL
);

INSERT INTO rol (id_rol, nombre) VALUES(1, 'Administrador');
INSERT INTO rol (id_rol, nombre) VALUES(2, 'Anónimo');
INSERT INTO rol (id_rol, nombre) VALUES(3, 'Normal');
INSERT INTO rol (id_rol, nombre) VALUES(4, 'Moderador');
INSERT INTO rol (id_rol, nombre) VALUES(5, 'Creador');
INSERT INTO rol (id_rol, nombre) VALUES(6, 'Editor');

CREATE TABLE IF NOT EXISTS usuario
(
	id_usuario		INT 			AUTO_INCREMENT 		PRIMARY KEY,
    id_rol			INT				NULL,
    correo			VARCHAR(30)		NOT NULL,
    nick			VARCHAR(25)		NOT NULL,
    pass			VARCHAR(25)		NOT NULL,
	ruta_imagen		VARCHAR(250)	NULL,
    
    FOREIGN KEY 	(id_rol) REFERENCES rol(id_rol)
); 

CREATE TABLE IF NOT EXISTS categorias
(
	id_categoria 	INT			AUTO_INCREMENT			PRIMARY KEY,	
    nombre			VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS noticia
(
	id_noticia		INT 			AUTO_INCREMENT 		PRIMARY KEY,
    titulo			VARCHAR(30)		NOT NULL,
    desc_corta		VARCHAR(30)		NOT NULL, 
    noticia			VARCHAR(1000)	NOT NULL,
    ruta_imagen		VARCHAR(250)	NULL,	
	ruta_video		VARCHAR(300)	NULL,
    valoracion 		INT				NULL,
    id_categoria	INT				NULL,	
    id_usuario		INT				NULL,
    
	FOREIGN KEY (id_categoria)	REFERENCES categorias(id_categoria),	
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario)
);


CREATE TABLE IF NOT EXISTS comentarios
(
	id_comentario	INT				AUTO_INCREMENT		PRIMARY KEY,
    fecha_hora		DATETIME		NULL,
	valoracion		INT				NULL,
    descripcion		VARCHAR(300)	NOT NULL,
    id_usuario		INT				NULL,
    
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS comentarios_noticias
(
	id_com_noti		INT 	AUTO_INCREMENT 		PRIMARY KEY,
    id_noticia		INT		NULL,
	id_comentario	INT		NULL,
    
	FOREIGN KEY (id_noticia)	REFERENCES noticia(id_noticia),
	FOREIGN KEY (id_comentario)	REFERENCES comentarios(id_comentario)
);

CREATE TABLE IF NOT EXISTS subcomentarios
(
	id_subcomentario	INT				AUTO_INCREMENT		PRIMARY KEY,
    fecha_hora			DATETIME		NULL,
    descripcion			VARCHAR(300) 	NOT NULL,
    id_usuario			INT 			NULL,
    
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS comentarios_comentarios
(
	id_com_com			INT 	AUTO_INCREMENT		PRIMARY KEY,
    id_comentario		INT 	NULL,
    id_subcomentario	INT		NULL,
    
    FOREIGN KEY (id_comentario)	REFERENCES comentarios(id_comentario),
    FOREIGN KEY (id_subcomentario) REFERENCES subcomentarios(id_subcomentario)
);