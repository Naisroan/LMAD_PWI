Use noti_app;


DROP PROCEDURE IF EXISTS sp_usuario_create;
DROP PROCEDURE IF EXISTS sp_usuario_read;
DROP PROCEDURE IF EXISTS sp_usuario_readall;
DROP PROCEDURE IF EXISTS sp_usuario_update;
DROP PROCEDURE IF EXISTS sp_usuario_delete;
DROP PROCEDURE IF EXISTS sp_usuario_readByNick;
DROP PROCEDURE IF EXISTS sp_usuario_readByCorreo;

DROP PROCEDURE IF EXISTS sp_noticia_create;
DROP PROCEDURE IF EXISTS sp_noticia_delete;
DROP PROCEDURE IF EXISTS sp_noticia_update;
DROP PROCEDURE IF EXISTS sp_noticia_read;
DROP PROCEDURE IF EXISTS sp_noticia_readAll;
DROP PROCEDURE IF EXISTS sp_noticia_readLast;
DROP PROCEDURE IF EXISTS sp_noticia_aprobar;

DROP PROCEDURE IF EXISTS sp_categorias_read;
DROP PROCEDURE IF EXISTS sp_categorias_readAll;
DROP PROCEDURE IF EXISTS sp_categorias_readByNombre;

DROP PROCEDURE IF EXISTS sp_comentario_create;
DROP PROCEDURE IF EXISTS sp_comentario_delete;
DROP PROCEDURE IF EXISTS sp_comentario_readBynoticia;
DROP PROCEDURE IF EXISTS sp_comentario_readBycomentariopadre;

DROP PROCEDURE IF EXISTS sp_rol_readByUsuario;

DROP PROCEDURE IF EXISTS sp_valoracion_create;
DROP PROCEDURE IF EXISTS sp_valoracion_delete;
DROP PROCEDURE IF EXISTS sp_valoracion_update;

DROP PROCEDURE IF EXISTS sp_noticia_multimedia_create;
DROP PROCEDURE IF EXISTS sp_noticia_multimedia_delete;
DROP PROCEDURE IF EXISTS sp_noticia_multimedia_update;
DROP PROCEDURE IF EXISTS sp_noticia_multimedia_readBynoticia;


#STORED PROCEDURE USERS START

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

CREATE PROCEDURE sp_usuario_read -- call sp_usuario_read (2);
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

#STORED PROCEDURE NOTICIAS 

DELIMITER //
CREATE PROCEDURE sp_noticia_create
(
	IN p_titulo			VARCHAR(30),
    IN p_desc_corta		VARCHAR(300),
    IN p_noticia		VARCHAR(1000),
    IN p_id_categoria	INT,
    IN p_id_usuario		INT
)
BEGIN 
	INSERT INTO noticia(titulo, desc_corta, noticia, 
						id_categoria, id_usuario, aprobada)
	VALUES 		(p_titulo, p_desc_corta, p_noticia, 
						p_id_categoria, p_id_usuario, false);
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_noticia_delete
(
	IN p_id_noticia		INT
)
BEGIN

	DELETE FROM		valoracion v
    WHERE			v.id_noticia = p_id_noticia;

	DELETE FROM		noticia_multimedia nm
    WHERE			nm.id_noticia = p_id_noticia;

	DELETE FROM		comentario c
    WHERE			c.id_noticia = p_id_noticia;

	DELETE FROM		noticia n
    WHERE			n.id_noticia = p_id_noticia;

END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_update
(
	IN p_id_noticia		INT, 
    IN p_titulo			VARCHAR(30),
    IN p_desc_corta		VARCHAR(300),
	IN p_noticia		VARCHAR(1000),	
    IN p_id_categoria	INT	,
    IN p_id_usuario		INT
)
BEGIN 
	UPDATE 		noticia
	SET			titulo = p_titulo,
                desc_corta = p_desc_corta,		
                noticia = p_noticia,	
                id_categoria = p_id_categoria,	
                id_usuario = p_id_usuario
                
	WHERE 		id_noticia = p_id_noticia;
    
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_aprobar
(
	IN p_id_noticia				INT,
	IN p_aprobada				BIT,
    IN p_comentario_aprobacion	VARCHAR(300)
)
BEGIN 

	UPDATE 		noticia
	SET			aprobada = p_aprobada,
				comentario_aprobacion = p_comentario_aprobacion
                
	WHERE 		id_noticia = p_id_noticia;
    
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_read -- CALL sp_noticia_read(2);
(
	IN p_id_noticia		INT 
)
BEGIN 
	SELECT 		n.id_noticia, 
				n.titulo,
				n.desc_corta,	
				n.noticia,	
				n.id_categoria,
				n.id_usuario,
                n.aprobada,
                n.comentario_aprobacion,
                IFNULL((SELECT m.ruta FROM noticia_multimedia m WHERE m.id_noticia = n.id_noticia LIMIT 1), '') AS thumbnail
	FROM 		noticia n
	WHERE 		n.id_noticia = p_id_noticia
    LIMIT		1;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_readAll #call sp_noticia_readAll (0)
(
	IN p_aprobada  INT
)
BEGIN

	SELECT 		n.id_noticia, 
				n.titulo,
				n.desc_corta,	
				n.noticia,	
				n.id_categoria,
				n.id_usuario,
                n.aprobada,
                n.comentario_aprobacion,
                IFNULL((SELECT m.ruta FROM noticia_multimedia m WHERE m.id_noticia = n.id_noticia LIMIT 1), '') AS thumbnail
	FROM 		noticia n
    WHERE		(n.aprobada = IF(p_aprobada = 1, true, false) OR p_aprobada = 2)
    ORDER BY    n.id_noticia DESC;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_readLast
(
)
BEGIN 

	SELECT 		n.id_noticia, 
				n.titulo,
				n.desc_corta,	
				n.noticia,	
				n.id_categoria,
				n.id_usuario,
                n.aprobada,
                n.comentario_aprobacion,
                IFNULL((SELECT m.ruta FROM noticia_multimedia m WHERE m.id_noticia = n.id_noticia LIMIT 1), '') AS thumbnail
	FROM 		noticia n
    ORDER BY 	n.id_noticia DESC LIMIT 1;

END //
DELIMITER ;


#STORED PROCEDURE CATEGORIAS
DELIMITER //
CREATE PROCEDURE sp_categorias_read
(
	IN p_id_categoria	INT
)
BEGIN 
	SELECT 		c.id_categoria,
				c.nombre
	FROM 		categorias c
    WHERE 		c.id_categoria = p_id_categoria;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_categorias_readByNombre
(
	IN p_nombre	VARCHAR(30)
)
BEGIN 
	SELECT			c.id_categoria,
					c.nombre
	FROM 			categorias c
    WHERE 			c.nombre = p_nombre
    LIMIT			1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categorias_readAll -- CALL sp_categorias_readAll
(
)
BEGIN 
	SELECT 		c.id_categoria,
				c.nombre
	FROM 		categorias c;
END //

DELIMITER ;

#STORED PROCEDURE COMENTARIOS
DELIMITER //

CREATE PROCEDURE sp_comentario_create
(
    IN p_descripcion	VARCHAR(300),
    IN p_id_usuario		INT,
    IN p_id_noticia 	INT,
    IN fecha_hora		DATETIME
)
BEGIN 
	INSERT INTO comentario(fecha_hora, descripcion, id_usuario, id_noticia)
		VALUES 	(p_fecha_hora, p_descripcion, p_id_usuario, p_id_noticia);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_delete
(
	IN p_id_comentario		INT
)
BEGIN
	DELETE FROM		comentario c
    WHERE			c.id_comentario = p_id_comentario;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_readBynoticia
(
	IN p_id_noticia		INT
)
BEGIN
	SELECT 	 	c.id_comentario,
				c.fecha_hora,
                c.descripcion,
                c.id_usuario,
                c.id_noticia,
                c.id_comentario_padre
    FROM		comentario c
    
    WHERE		c.id_noticia = p_id_noticia;
    
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_comentario_readBycomentariopadre
(
	IN p_id_comentario_padre 	INT 
)
BEGIN 
	SELECT 	 	c.id_comentario,
				c.fecha_hora,
                c.descripcion,
                c.id_usuario,
                c.id_noticia,
                c.id_comentario_padre
    FROM		comentario c
    
    WHERE		c.id_comentario_padre = p_id_comentario_padre;
END //
DELIMITER ;


#STORED PROCEDURE ROL 
DELIMITER //
CREATE PROCEDURE sp_rol_readByUsuario -- call sp_rol_readByUsuario (2);
(
	IN p_id_usuario INT
    
)
BEGIN 

	SELECT 		r.id_rol,
				r.nombre
    FROM 		rol r 
    INNER JOIN 	usuario u ON r.id_rol = u.id_rol
    WHERE 		u.id_usuario = p_id_usuario
    LIMIT		1;
    
END //

DELIMITER ; 


#STORED PROCEDURE Valoracion

DELIMITER //

CREATE PROCEDURE sp_valoracion_create
(
    IN p_id_noticia 			INT, 	
    IN p_id_comentario 			INT,	
    IN p_id_usuario				INT, 	
    IN p_favorito_noticia		boolean,	
    IN p_valoracion_noticia		INT, 	
    IN p_valoracion_comentario	boolean, 
    IN p_fecha_hora				DATETIME
)
BEGIN 
	INSERT INTO valoracion(id_noticia, id_comentario, id_usuario, favorito_noticia,
							valoracion_noticia, valoracion_comentario, fecha_hora)
		VALUES 	(p_id_noticia, p_id_comentario, p_id_usuario, p_favorito_noticia,
					p_valoracion_noticia, p_valoracion_comentario, p_fecha_hora);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_valoracion_delete
(
	IN p_id_valoracion 		INT 
)
BEGIN
	DELETE FROM		valoracion v
    WHERE			v.id_valoracion = p_id_valoracion;
END //
DELIMITER ;

DELIMITER // 

CREATE PROCEDURE sp_valoracion_update
(
	IN p_id_valoracion 			INT, 
	IN p_id_noticia 			INT, 	
    IN p_id_comentario 			INT,	
    IN p_id_usuario				INT, 	
    IN p_favorito_noticia		boolean,	
    IN p_valoracion_noticia		INT, 	
    IN p_valoracion_comentario	boolean, 
    IN p_fecha_hora				DATETIME
)
BEGIN 
	UPDATE 		valoracion
	SET			id_noticia = p_id_noticia,
                id_comentario = p_id_comentario,
                id_usuario = p_id_usuario, 
                favorito_noticia = p_favorito_noticia, 
                valoracion_noticia = p_valoracion_noticia, 
                valoracion_comentario = p_valoracion_comentario,
                fecha_hora = p_fecha_hora
                
	WHERE 		id_valoracion = p_id_valoracion;
END //
DELIMITER ;

#STORED PROCEDURE noticia_multimedia

DELIMITER //
CREATE PROCEDURE sp_noticia_multimedia_create
(
	IN p_id_noticia				INT, 			
    IN p_ruta					VARCHAR(250), 	
    IN p_tipo_contenido			VARCHAR(30)		
)
BEGIN 
	INSERT INTO noticia_multimedia(id_noticia, ruta, tipo_contenido)
			VALUES (p_id_noticia, p_ruta, p_tipo_contenido);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_multimedia_delete
(
	IN p_id_noticia_multimedia 		INT
)
BEGIN
		DELETE FROM		noticia_multimedia n
		WHERE			n.id_noticia_multimedia = p_id_noticia_multimedia;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_multimedia_update
(
	IN p_id_noticia_multimedia 	INT,
    IN p_id_noticia				INT, 			
    IN p_ruta					VARCHAR(250), 	
    IN p_tipo_contenido			VARCHAR(30)
)
BEGIN 
	UPDATE 		noticia_multimedia
	SET			id_noticia = p_id_noticia,
                ruta = p_ruta,		
                tipo_contenido = p_tipo_contenido
                
	WHERE 		id_noticia_multimedia = p_id_noticia_multimedia;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_noticia_multimedia_readBynoticia -- CALL sp_noticia_multimedia_readBynoticia(1);
(
	IN p_id_noticia 	INT
)
BEGIN 
	SELECT 	 	n.id_noticia_multimedia,
				n.id_noticia,
                n.ruta,
                n.tipo_contenido
    FROM		noticia_multimedia n
    
    WHERE		n.id_noticia = p_id_noticia;
END //
DELIMITER ;
