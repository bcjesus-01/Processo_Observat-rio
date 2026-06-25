CREATE TABLE author( id SERIAL PRIMARY KEY, name TEXT NOT NULL );
CREATE TABLE post( id SERIAL PRIMARY KEY, title TEXT NOT NULL, content TEXT NOT NULL, author_id INT NOT NULL references author(id) );
CREATE TABLE tag( id SERIAL PRIMARY KEY, name TEXT NOT NULL );
CREATE TABLE posts_tags( post_id INT NOT NULL references post(id), tag_id INT NOT NULL references tag(id) );

INSERT INTO author (id, name) VALUES 
(1, 'Pete Graham'), (2, 'Rachid Belaid'), (3, 'Robert Berry');

INSERT INTO tag (id, name) VALUES 
(1, 'scifi'), (2, 'politics'), (3, 'science');

INSERT INTO post (id, title, content, author_id) VALUES 
(1, 'Exploração do Espaço', 'O espaço é um lugar perigoso e vasto.', 1),
(2, 'O Universo', 'Ele é muito grande e em constante expansão.', 1),
(3, 'Esperança Rebelde', 'Os rebeldes contra-atacam a frota imperial.', 2);

-- Ele entende que 'espaço' no tsvector bate com a busca 'espaço' no tsquery
SELECT to_tsvector('portuguese', 'O espaço é um lugar perigoso') @@ to_tsquery('portuguese', 'espaço');

SELECT title, content 
FROM post 
WHERE to_tsvector('portuguese', title || ' ' || content) @@ to_tsquery('portuguese', 'vasto');

SELECT 
    post.title AS titulo_artigo, 
    author.name AS nome_autor
FROM post
JOIN author ON author.id = post.author_id
WHERE to_tsvector('portuguese', post.content) @@ to_tsquery('portuguese', 'espaço | rebelde');

SELECT 
    post.title, 
    post.content,
    ts_rank(
        setweight(to_tsvector('portuguese', COALESCE(post.title, '')), 'A') || 
        setweight(to_tsvector('portuguese', COALESCE(post.content, '')), 'B'), 
        to_tsquery('portuguese', 'espaço')
    ) AS relevancia
FROM post
WHERE (
    setweight(to_tsvector('portuguese', COALESCE(post.title, '')), 'A') || 
    setweight(to_tsvector('portuguese', COALESCE(post.content, '')), 'B')
) @@ to_tsquery('portuguese', 'espaço')
ORDER BY relevancia DESC;

ALTER TABLE post ADD COLUMN document tsvector;

UPDATE post 
SET document = setweight(to_tsvector('portuguese', COALESCE(title, '')), 'A') || 
               setweight(to_tsvector('portuguese', COALESCE(content, '')), 'B');

CREATE INDEX document_idx ON post USING GIN (document);

SELECT 
    title, 
    content,
    ts_rank(document, to_tsquery('portuguese', 'espaço')) AS relevancia
FROM post
WHERE document @@ to_tsquery('portuguese', 'espaço')
ORDER BY relevancia DESC;