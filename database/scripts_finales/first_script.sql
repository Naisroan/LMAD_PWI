-- CREATE DATABASE noti_app;

USE noti_app;

DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;

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

DROP PROCEDURE IF EXISTS sp_usuario_create;
DROP PROCEDURE IF EXISTS sp_usuario_read;
DROP PROCEDURE IF EXISTS sp_usuario_readall;
DROP PROCEDURE IF EXISTS sp_usuario_update;
DROP PROCEDURE IF EXISTS sp_usuario_delete;
DROP PROCEDURE IF EXISTS sp_usuario_readByNick;
DROP PROCEDURE IF EXISTS sp_usuario_readByCorreo;

DELIMITER //

CREATE PROCEDURE sp_usuario_create -- call sp_usuario_create (NULL, 'iansolis98@outlook.com', 'isolis', '471951Pa98*', NULL);
(
	IN p_id_rol 		INT,
    IN p_correo			VARCHAR(30),
    IN p_nick			VARCHAR(25),
    IN p_pass			VARCHAR(25),
    IN p_ruta_imagen	VARCHAR(250)
)
BEGIN

	INSERT INTO		usuario(id_rol, correo, nick, pass, ruta_imagen)
    VALUES			(p_id_rol, p_correo, p_nick, p_pass, p_ruta_imagen);
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_update -- call sp_usuario_update (1, NULL, 'iansolis98@outlook.com', 'isolis', '15361536*_A', NULL);
(
	IN p_id_usuario 	INT,
	IN p_id_rol 		INT,
    IN p_correo			VARCHAR(30),
    IN p_nick			VARCHAR(25),
    IN p_pass			VARCHAR(25),
    IN p_ruta_imagen	VARCHAR(250)
)
BEGIN

	UPDATE 			usuario
    SET				id_rol 		= p_id_rol,
					correo 		= p_correo,
                    nick 		= p_nick,
                    pass 		= p_pass,
                    ruta_imagen = p_ruta_imagen
                    
    WHERE			id_usuario = p_id_usuario;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_delete -- call sp_usuario_delete (1);
(
	IN p_id_usuario 		INT
)
BEGIN

	DELETE FROM		usuario u
    WHERE			u.id_usuario = p_id_usuario;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_read -- call sp_usuario_read (1);
(
	IN p_id_usuario 		INT
)
BEGIN

	SELECT 	 	u.id_usuario,
				u.id_rol,
                u.correo,
                u.nick,
                u.pass,
                u.ruta_imagen
    FROM		usuario u
    
    WHERE		u.id_usuario = p_id_usuario
    
    LIMIT		1;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_readByNick -- call sp_usuario_readByNick ('isolis');
(
	IN p_nick 		VARCHAR(25)
)
BEGIN

	SELECT 	 	u.id_usuario,
				u.id_rol,
                u.correo,
                u.nick,
                u.pass,
                u.ruta_imagen
    FROM		usuario u
    
    WHERE		u.nick = p_nick
    
    LIMIT		1;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_readByCorreo -- call sp_usuario_readByCorreo ('iansolis98@outlook.com');
(
	IN p_correo 		VARCHAR(30)
)
BEGIN

	SELECT 	 	u.id_usuario,
				u.id_rol,
                u.correo,
                u.nick,
                u.pass,
                u.ruta_imagen
    FROM		usuario u
    
    WHERE		u.correo = p_correo
    
    LIMIT		1;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_readall -- call sp_usuario_readall
(
)
BEGIN

	SELECT	 	u.id_usuario,
				u.id_rol,
                u.correo,
                u.nick,
                u.pass,
                u.ruta_imagen
    FROM		usuario u;
	
END //

DELIMITER ;