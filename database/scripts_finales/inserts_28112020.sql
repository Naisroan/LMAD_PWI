-- TRUNCATE TABLE categorias;

INSERT INTO categorias (nombre) VALUES('Acción');
INSERT INTO categorias (nombre) VALUES('Aventura');
INSERT INTO categorias (nombre) VALUES('Carreras');
INSERT INTO categorias (nombre) VALUES('Deporte');
INSERT INTO categorias (nombre) VALUES('Disparos');
INSERT INTO categorias (nombre) VALUES('Estrategia');
INSERT INTO categorias (nombre) VALUES('Rol');
INSERT INTO categorias (nombre) VALUES('Simulación');


INSERT INTO usuario(id_rol, correo, nick, pass, ruta_imagen) VALUES (2, 'anonimo@fake.com', 'Anónimo', '', '');

SELECT * FROM usuario;
SELECT * FROM categorias;
SELECT * FROM noticia;
SELECT * FROM rol;
SELECT * FROM comentario;
SELECT * FROM noticia_multimedia;
SELECT * FROM valoracion;

UPDATE valoracion SET tipo_valoracion = 2;

SELECT 		*,
			() AS VotosPositivos,
			() AS VotosNegativos
FROM 		valoracion 
ORDER BY 	valoracion_comentario DESC;

INSERT INTO noticia (titulo, desc_corta, noticia, id_categoria, id_usuario) 
VALUES 
(
	'Halo Infinite es GOTY', 
    'Gingerbread cheesecake chocolate cake.',
	'Gingerbread cheesecake chocolate cake cookie gingerbread sweet chocolate jelly-o lemon drops. Muffin gummi bears pudding fruitcake. Candy canes marshmallow donut cake. Liquorice cookie ice cream cookie. Wafer lemon drops chupa chups. Donut biscuit marzipan jelly beans topping marshmallow. Soufflé gummi bears marzipan jelly tart chocolate. Marzipan cookie lollipop topping oat cake sugar plum icing bear claw jujubes. Jelly beans gummies liquorice. Caramels topping cheesecake cotton candy jujubes. Liquorice carrot cake bear claw bonbon. Sweet cookie chocolate cake tiramisu croissant halvah tart. Ice cream powder sweet roll.',
	1,
	1
);

UPDATE usuario SET id_rol = 5 WHERE id_usuario = 1;
UPDATE usuario SET pass = '123' WHERE id_usuario = 1;

ALTER TABLE mytable AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE noticia;
TRUNCATE TABLE usuario;
SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE noticia_multimedia;
SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM noticia WHERE 1 = 1;

TRUNCATE TABLE valoracion;
TRUNCATE TABLE comentario;