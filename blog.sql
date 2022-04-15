\c jlopez
DROP DATABASE blog; 
CREATE DATABASE blog; 
\c blog


CREATE TABLE usuario(
    id SERIAL PRIMARY KEY,
    email VARCHAR(59) NOT NULL UNIQUE
);

\copy usuario FROM 'usuarios.csv' csv header;

CREATE TABLE post(
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id),
    titulo VARCHAR(100) NOT NULL UNIQUE,
    fecha DATE NOT NULL
);
\copy post FROM 'posts.csv' csv header;


CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL REFERENCES post(id),
    usuario_id INT NOT NULL REFERENCES usuario(id),
    texto VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL
);
\copy comentario FROM 'comentarios.csv' csv header;
SELECT usuario.email, post.id, post.titulo
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE usuario.id = 5;

SELECT usuario.email, comentario.id, comentario.texto
FROM usuario
JOIN comentario
ON usuario.id = comentario.usuario_id
WHERE usuario.email != 'usuario06@hotmail.com';

SELECT *
FROM usuario
LEFT JOIN post
ON usuario.id = post.usuario_id 
WHERE post.usuario_id IS NULL; 

SELECT *
FROM post
LEFT JOIN comentario
ON post.id = comentario.post_id;

SELECT *
FROM comentario
LEFT JOIN post
ON post.id = comentario.post_id; 

-- SELECT usuario.*, post.fecha
-- FROM usuario
-- JOIN post
-- ON usuario.id = post.usuario_id
-- WHERE EXTRACT(month FROM post.fecha) = '6';

SELECT usuario.*, post.fecha
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';
