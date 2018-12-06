use spotper;
--use master;
GO

INSERT INTO gravadora VALUES 
(1, 'AB Records', 'www.abrecords.com', 'rua ab', 30, '73612736'),
(2, 'Line Records', 'www.linerecords.com.br', 'RUA GENERAL GUSTAVO CORDEIRO DE FARIAS', 84, '20910-220'),
(3, 'LGK Music', 'lgkmusic.com.br', 'teste LGK', 340, '15421212'),
(4, 'MK Music', 'www.mkmusic.com.br', 'Rua gotemburgo', 211, '20941-080'),
(5, 'SONY', 'https://www.sonymusic.com.br', 'Rua da sony', 45, '4564544'),
(6, 'WARNER', 'http://www.wmg.com/', 'Rua da warner', 54545, '1564584'),
(7, 'Som Livre', 'https://www.somlivre.com/', '', 30, '73612736'),
(8, 'Digital music', 'www.digitalmusic.com', 'rua digital music',544 , '215645641'),
(9, 'Laboratório Fantasma', 'site fantasma', 'Rua 447',5447 , '24548645'),
(10, 'Indie Records', 'indie site', 'Rua indie', 44, '113456'),
(11, 'Gospel Records', 'gospel records site', 'rua gospel', 666, '6666-666'),
(12, 'Band Music', 'Band site', 'Rua band', 2414, '5142144');


GO
INSERT INTO telefone VALUES
(1, '85996182019'),
(2, '85996182019'),
(3, '85996182019'),
(4, '85996182019'),
(5, '85996182019');

GO
INSERT INTO periodo_musical VALUES
(1, 'entre os séculos V e XV', 'idade media'),
(2, 'entre o século XIV e o século XVI', 'renascenca'),
(3, 'entre o final do século XVI e meados do século XVIII', 'barroco'),
(4, 'VI - IV a. C.', 'classico'),
(5, 'Final do século XVIII e grande parte do século XIX', 'romantico'),
(6, '1453 indo até 1789', 'moderno');

GO
INSERT INTO interprete VALUES
(20, 'Xuxa', 'SOLO'),
(1, 'Kades Singers', 'Coral'),
(2, 'Lexa', 'SOLO'),
(3, 'Anitta', 'SOLO'),
(4, 'Linkin Park', 'Banda'),
(5, 'Melim', 'Trio'),
(6, 'Henrique & Juliano', 'Dupla');

GO
INSERT INTO album VALUES (1, 1, 'Hybrid theory', 29.00, '30/11/2018' ,'download', '01/06/2000');
INSERT INTO album VALUES (2, 2, 'Super Nova', 35.00, '30/12/2012' ,'download', '01/02/2001');
INSERT INTO album VALUES (3, 3, 'Lua Azul', 20.00, '10/10/2008' ,'download', '01/06/2005');
INSERT INTO album VALUES (4, 4, 'Revolução', 80.00, '09/12/2015' ,'download', '01/04/2010');
INSERT INTO album VALUES (5, 5, 'Sonar', 99.00, '01/02/2003' ,'download', '02/03/2002');
INSERT INTO album VALUES (6, 6, 'Whaleship', 59.00, '27/05/2004' ,'download', '27/05/1992');
INSERT INTO album VALUES (7, 6, 'barroco_concerto', 59.00, '27/05/2004' ,'download', '27/05/1992');
INSERT INTO album VALUES (8, 6, '1 de cada', 59.00, '27/05/2004' ,'download', '27/05/1992');
INSERT INTO album VALUES (9, 6, 'n tem barroco nem playlist', 59.00, '27/05/2004' ,'download', '27/05/1992');

GO
INSERT INTO composicao VALUES
(1, 'sinfonia'),
(2, 'ópera'),
(3, 'sonata'),
(4, 'concerto'),
(5, 'single');

GO
INSERT INTO compositor VALUES
(1, 'Linkin Park', 'Agoura Hills', 'EUA', '1996','' , 6),
(2, 'Arcangelo Corelli', 'Fusignano', 'Roma', '17/02/1653','08/01/1713' , 2),
(3, 'Marc-Antoine Charpentier', 'Paris', 'França', '02/04/1643','24/02/1704' , 3),
(4, 'Frank Martin', 'Genebra', 'Suiça', '15/07/1890','21/09/1974' , 4),
(5, 'Thomas Adès', 'Londres', 'Inglaterra', '01/03/1972','' , 5),
(6, 'barrocoso', 'Genebra', 'Suiça', '15/07/1890','21/09/1974' , 3),
(7, 'não barrocoso', 'Genebra', 'Suiça', '15/07/1890','21/09/1974' , 4);
GO

INSERT INTO faixa VALUES (1, 1, 'Papercut', '00:03:04', 'DDD', 1);
INSERT INTO faixa VALUES (1, 4, 'Largado às Traças', '00:02:03', 'DDD', 1);
INSERT INTO faixa VALUES (2, 2, 'Apelido Carinhoso', '00:03:04', 'ADD', 2);
INSERT INTO faixa VALUES (3, 3, 'Quem Ensinou Fui Eu', '00:04:05', 'DDD',3);
INSERT INTO faixa VALUES (4, 4, 'Buá Buá Buá', '00:05:06', 'ADD', 4);
INSERT INTO faixa VALUES (5, 5, 'Mais Amor e Menos Drama', '00:07:08', 'DDD', 5);
INSERT INTO faixa VALUES (1, 2, 'Zé da recaída', '00:01:02', 'ADD', 2);
INSERT INTO faixa VALUES (2, 3, 'In my feelings', '01:00:00', 'DDD' ,3);
INSERT INTO faixa VALUES (3, 4, 'Super-homem chora', '02:03:04', 'ADD', 4);
INSERT INTO faixa VALUES (4, 5, 'New rules', '01:05:06', 'DDD', 5);
INSERT INTO faixa VALUES (5, 1, 'Reggae in roça', '10:07:08', 'ADD', 1);
INSERT INTO faixa VALUES (1, 3, 'Deixe-me ir', '04:02:03', 'DDD', 5);
INSERT INTO faixa VALUES (2, 4, 'Não fala não pra mim', '00:09:04', 'DDD', 4);
INSERT INTO faixa VALUES (3, 5, 'Filho do mato', '00:01:05', 'ADD', 3);
INSERT INTO faixa VALUES (4, 1, 'Havana', '00:02:06', 'ADD', 2);
INSERT INTO faixa VALUES (5, 2, 'Perfect', '00:03:02', 'DDD', 1);
INSERT INTO faixa VALUES (1, 7, 'aparece', '00:03:02', 'DDD', 4);
INSERT INTO faixa VALUES (2, 7, 'aparece', '00:03:02', 'DDD', 4);

INSERT INTO faixa VALUES (1, 8, 'n aparece', '00:03:02', 'DDD', 1);
INSERT INTO faixa VALUES (2, 8, 'aparece', '00:03:02', 'DDD', 4);
INSERT INTO faixa VALUES (1, 9, 'n aparece', '00:03:02', 'DDD', 1);
INSERT INTO faixa VALUES (2, 9, 'n aparece', '00:03:02', 'DDD', 1);

GO
insert into faixa_compositor VALUES (1,1,1);
insert into faixa_compositor VALUES (2,2,2);
insert into faixa_compositor VALUES (3,3,3);
insert into faixa_compositor VALUES (4,4,4);
insert into faixa_compositor VALUES (5,5,5);
insert into faixa_compositor VALUES (6,1,7);
insert into faixa_compositor VALUES (6,2,7);
insert into faixa_compositor VALUES (7,1,8);
insert into faixa_compositor VALUES (6,2,8);
insert into faixa_compositor VALUES (7,1,9);
insert into faixa_compositor VALUES (7,2,9);

GO
INSERT INTO faixa_inter VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);


GO

INSERT INTO playlist VALUES
(1,'Playlist da Sofrência', '03/12/2018','00:00:00'),
(2,'Playlist do Sono', '01/01/2005','00:00:00'),
(3,'Playlist do Fim de Semestre', '02/04/2008','00:00:00'),
(4,'Playlist da Superação', '03/07/2014','00:00:00'),
(5,'Playlist do Gado', '03/05/2018','00:00:00'),
(6,'Playlist barroco_concerto', '03/05/2018','00:00:00'),
(7,'Playlist 1 barroco_concerto e outro não', '03/05/2018','00:00:00'),
(8,'Playlist não barroco_concerto', '03/05/2018','00:00:00');
insert into playlist (cod_playlist, nome, tmp_exec_play ) values (9, 'p1','00:00:00')

GO
INSERT INTO faixa_playlist VALUES (1,1,1,'03/12/2018');
INSERT INTO faixa_playlist VALUES (2,2,2,'02/12/2018');
INSERT INTO faixa_playlist VALUES (3,3,4,'01/12/2018');
INSERT INTO faixa_playlist VALUES (4,4,4,'10/11/2018');
INSERT INTO faixa_playlist VALUES (5,5,5,'09/11/2018');
INSERT INTO faixa_playlist VALUES (1,5,2,'08/11/2018');
INSERT INTO faixa_playlist VALUES (2,4,1,'02/07/2018');
INSERT INTO faixa_playlist VALUES (3,3,5,'05/05/2018');
INSERT INTO faixa_playlist VALUES (4,2,4,'27/02/2018');
INSERT INTO faixa_playlist VALUES (5,1,3,'29/04/2018');

INSERT INTO faixa_playlist VALUES (6,1,7,'29/04/2018');
INSERT INTO faixa_playlist VALUES (6,2,7,'29/04/2018');

INSERT INTO faixa_playlist VALUES (7,1,8,'29/04/2018');
INSERT INTO faixa_playlist VALUES (7,2,8,'29/04/2018');

INSERT INTO faixa_playlist VALUES (8,1,9,'29/04/2018');
INSERT INTO faixa_playlist VALUES (8,2,9,'29/04/2018');