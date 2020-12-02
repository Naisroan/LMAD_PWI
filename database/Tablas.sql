USE noti_app; 


DROP TABLE IF EXISTS noticia_multimedia;
DROP TABLE IF EXISTS valoracion;
DROP TABLE IF EXISTS comentario;
DROP TABLE IF EXISTS noticia;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;
DROP TABLE IF EXISTS categorias;


CREATE TABLE IF NOT EXISTS rol #MOSTRAR ROL POR ID USUARIO TRAER ID ROL Y NOMBRE  **
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

CREATE TABLE IF NOT EXISTS categorias #SHOW TODAS **
(
	id_categoria 	INT			AUTO_INCREMENT			PRIMARY KEY,	
    nombre			VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS noticia #CREATE DELETE UPDATE SHOW BASICO **
(
	id_noticia		INT 			AUTO_INCREMENT 		PRIMARY KEY,
    titulo			VARCHAR(30)		NOT NULL,
    desc_corta		VARCHAR(300)	NOT NULL, 
    noticia			VARCHAR(1000)	NOT NULL,
    aprobada		BIT				NOT NULL,
    comentario_aprobacion VARCHAR(300) NULL,
    id_categoria	INT				NULL,	
    id_usuario		INT				NULL,
    
	FOREIGN KEY (id_categoria)	REFERENCES categorias(id_categoria),	
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario)
);

-- ALTER TABLE noticia MODIFY desc_corta VARCHAR(300) NOT NULL
-- ALTER TABLE noticia MODIFY titulo VARCHAR(100) NOT NULL
-- ALTER TABLE noticia ADD aprobada BIT NOT NULL
-- ALTER TABLE noticia ADD comentario_aprobacion VARCHAR(300) NULL

#OTRA CONSULTA DE COMENTARIOS DE UN COMENTARIO BUSCARLO CON COMENTARIO PADRE CHECK **
CREATE TABLE IF NOT EXISTS comentario #CREATE DELETE MOSTRAR TODOS LOS COMENTARIOS DE UNA NOTICIA BUSCARLOS CON ID NOTICIA CHECK **
(
	id_comentario			INT				AUTO_INCREMENT		PRIMARY KEY,
    fecha_hora				DATETIME		NULL,
    descripcion				VARCHAR(300)	NOT NULL,
    id_usuario				INT				NULL,
    id_noticia 				INT 			NULL,
    id_comentario_padre 	INT 			NULL,
    
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario), 
    FOREIGN KEY (id_noticia)	REFERENCES noticia(id_noticia)
);

CREATE TABLE IF NOT EXISTS valoracion #CREATE DELETE UPDATE SHOW DESPUES **
(
	id_valoracion 			INT 		AUTO_INCREMENT 		PRIMARY KEY,
    id_noticia 				INT 		NULL,	
    id_comentario 			INT 		NULL,
    id_usuario				INT 		NOT NULL,
    favorito_noticia		boolean		NULL,
    valoracion_noticia		INT 		NULL, #estrellitas noticia 
    valoracion_comentario	boolean  	NULL, 
	fecha_hora				DATETIME		NULL,
    
    FOREIGN KEY (id_usuario)	REFERENCES usuario(id_usuario), 
    FOREIGN KEY (id_noticia)	REFERENCES noticia(id_noticia),
    FOREIGN KEY (id_comentario)	REFERENCES comentario(id_comentario) 
);
-- ALTER TABLE valoracion ADD tipo_valoracion INT NOT NULL
-- ALTER TABLE valoracion DROP FOREIGN KEY valoracion_ibfk_3;

CREATE TABLE IF NOT EXISTS noticia_multimedia #CREATE DELETE UPDATE SHOW ID NOTICIA  **
(
	id_noticia_multimedia	INT 			AUTO_INCREMENT		PRIMARY KEY, 
    id_noticia				INT 			NOT NULL, 
	ruta					VARCHAR(250) 	NULL,
    tipo_contenido			VARCHAR(30)		NULL, #1 imagen 2 video
    
    FOREIGN KEY (id_noticia)	REFERENCES noticia(id_noticia)
);

-- ALTER TABLE noticia_multimedia MODIFY tipo_contenido VARCHAR(30)		NULL;