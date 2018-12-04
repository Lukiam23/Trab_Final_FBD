use spotper;
--use master;
DELETE FROM gravadora
GO
INSERT INTO gravadora VALUES 
(1, 'AB Records', 'www.abrecords.com', 'rua ab', 'Cidade X', 'País Y'),
(2, 'Line Records', 'www.linerecords.com.br', 'RUA GENERAL GUSTAVO CORDEIRO DE FARIAS', 'Cidade X', 'País Y'),
(3, 'LGK Music', 'lgkmusic.com.br', 'teste LGK', 'Cidade X', 'País Y'),
(4, 'MK Music', 'www.mkmusic.com.br', 'Rua gotemburgo', 'Cidade X', 'País Y'),
(5, 'SONY', 'www.sonymusic.com.br', 'Rua da sony', 'Cidade X', 'País Y'),
(6, 'WARNER', 'www.wmg.com/', 'Rua da warner', 'Cidade X', 'País Y'),
(7, 'Som Livre', 'www.somlivre.com/', ' ', 'Cidade X', 'País Y'),
(8, 'Digital music', 'www.digitalmusic.com', 'rua digital music', 'Cidade X', 'País Y'),
(9, 'Laboratório Fantasma', 'site fantasma', 'Rua 447', 'Cidade X', 'País Y'),
(10, 'Indie Records', 'indie site', 'Rua indie', 'Cidade X', 'País Y'),
(11, 'Gospel Records', 'gospel records site', 'rua gospel', 'Cidade X', 'País Y'),
(12, 'Band Music', 'Band site', 'Rua band', 'Cidade X', 'País Y');

DELETE FROM telefones
GO
INSERT INTO telefones VALUES
(1, '85996182019'),
(2, '85996182019'),
(3, '85996182019'),
(4, '85996182019'),
(5, '85996182019');

DELETE FROM periodo_musical
GO
INSERT INTO periodo_musical VALUES
(1, 'entre os séculos V e XV', 'idade media'),
(2, 'entre o século XIV e o século XVI', 'renascenca'),
(3, 'entre o final do século XVI e meados do século XVIII', 'barroco'),
(4, 'VI - IV a. C.', 'classico'),
(5, 'Final do século XVIII e grande parte do século XIX', 'romantico'),
(6, '1453 indo até 1789', 'moderno');

DELETE FROM interprete
GO
INSERT INTO interprete VALUES
(20, 'Xuxa', 'SOLO'),
(1, 'Kades Singers', 'Coral'),
(2, 'Lexa', 'SOLO'),
(3, 'Anitta', 'SOLO'),
(4, 'Linkin Park', 'Banda'),
(5, 'Melim', 'Trio'),
(6, 'Henrique & Juliano', 'Dupla');

DELETE FROM album
GO
INSERT INTO album VALUES
(1, 1, 'Hybrid theory', 29.00, '30/11/2018' ,'download', '01/06/2000'),
(2, 2, 'Super Nova', 35.00, '30/12/2012' ,'download', '01/02/2001'),
(3, 3, 'Lua Azul', 20.00, '10/10/2008' ,'download', '01/06/2005'),
(4, 4, 'Revolução', 80.00, '09/12/2015' ,'download', '01/04/2010'),
(5, 5, 'Sonar', 99.00, '01/02/2003' ,'download', '02/03/2002'),
(6, 6, 'Whaleship', 59.00, '27/05/2004' ,'download', '27/05/1992');

DELETE FROM tipo_composicao
GO
INSERT INTO tipo_composicao VALUES
(1, 'sinfonia'),
(2, 'ópera'),
(3, 'sonata'),
(4, 'concerto'),
(5, 'single');

DELETE FROM compositor
GO
INSERT INTO compositor VALUES
(1, 'Linkin Park', 'Agoura Hills', 'Estados Unidos', '1996','' , 1),
(2, 'Arcangelo Corelli', 'Fusignano', 'Roma', '17/02/1653','08/01/1713' , 2),
(3, 'Marc-Antoine Charpentier', 'Paris', 'França', '02/04/1643','24/02/1704' , 3),
(4, 'Frank Martin', 'Genebra', 'Suiça', '15/07/1890','21/09/1974' , 4),
(5, 'Thomas Adès', 'Londres', 'Inglaterra', '01/03/1972','' , 5);

DELETE FROM faixa
GO
INSERT INTO faixa VALUES
(1, 1, 1,'DDD','Largado às Traças', '00:02:03'),
(2, 2, 2,'ADD','Apelido Carinhoso', '00:03:04'),
(3, 3, 3,'DDD','Quem Ensinou Fui Eu', '00:04:05'),
(4, 4, 4,'ADD','Buá Buá Buá', '00:05:06'),
(5, 5, 5,'DDD','Mais Amor e Menos Drama', '00:07:08'),

(1, 2, 2,'ADD','Zé da recaída', '00:01:02'),
(2, 3, 3,'DDD','In my feelings', '01:00:00'),
(3, 4, 4,'ADD','Super-homem chora', '02:03:04'),
(4, 5, 5,'DDD','New rules', '01:05:06'),
(5, 1, 1,'ADD','Reggae in roça', '10:07:08'),

(1, 3, 5,'DDD','Deixe-me ir', '04:02:03'),
(2, 4, 4,'DDD','Não fala não pra mim', '00:09:04'),
(3, 5, 3,'ADD','Filho do mato', '00:01:05'),
(4, 1, 2,'ADD','Havana', '00:02:06'),
(5, 2, 1,'DDD','Perfect', '00:03:02');

DELETE FROM faixa_compositor
GO
insert into faixa_compositor VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

DELETE FROM faixa_interprete
GO
INSERT INTO faixa_interprete VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

DELETE FROM playlist
GO
INSERT INTO playlist VALUES
(1,'Playlist da Sofrência', '03/12/2018','00:00:00'),
(2,'Playlist do Sono', '01/01/2005','00:00:00'),
(3,'Playlist do Fim de Semestre', '02/04/2008','00:00:00'),
(4,'Playlist da Superação', '03/07/2014','00:00:00'),
(5,'Playlist do Gado', '03/05/2018','00:00:00');

DELETE FROM faixa_playlist
GO
INSERT INTO faixa_playlist VALUES
(1,1,1,10,'03/12/2018'),
(2,2,2,12,'02/12/2018'),
(3,3,4,8,'01/12/2018'),
(4,4,4,3,'10/11/2018'),
(5,5,5,6,'09/11/2018'),
(1,5,2,22,'08/11/2018'),
(2,4,1,90,'02/07/2018'),
(3,3,5,102,'05/05/2018'),
(4,2,4,77,'27/02/2018'),
(5,1,3,66,'29/04/2018');
