USE master;
GO

IF EXISTS(select * from sys.databases where name='spotper')
DROP DATABASE spotper;

CREATE DATABASE spotper
ON
        PRIMARY(
        NAME = 'spotper',
        FILENAME = 'C:\FBD\spotper.mdf',
        SIZE = 5120KB,
        FILEGROWTH = 1024KB
        ),

        FILEGROUP spotper_fg01(
        NAME = 'spotper_001',
        FILENAME = 'C:\FBD\spotper_001.ndf',
        SIZE = 1024KB,
        FILEGROWTH = 30%  
        ),
        (
        NAME = 'spotper_002',
        FILENAME = 'C:\FBD\spotper_002.ndf',
        SIZE = 1024KB,
        MAXSIZE = 3072KB,
        FILEGROWTH = 15%
        ),

        FILEGROUP spotper_fg02(
        NAME = 'loja_003',
        FILENAME = 'C:\FBD\spotper_003.ndf',
        SIZE = 1024KB,
        MAXSIZE = 5120KB,
        FILEGROWTH = 1024KB
        )

        LOG ON
        (
        NAME = 'spotper_log',
        FILENAME = 'C:\FBD\spotper_log.ldf',
        SIZE = 1024KB,
        FILEGROWTH = 10%
        )
GO
USE spotper;


CREATE TABLE album (
                cod_album INTEGER NOT NULL,
                cod_grav INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                preco FLOAT NOT NULL,
                dt_compra DATE NOT NULL,
                tipo_compra VARCHAR NOT NULL, -- fisica ou download
                dt_grav DATE NOT NULL,
                
)ON spotper_fg01;

ALTER TABLE album
ADD CONSTRAINT data_limite_check
CHECK (dt_compra > '01.01.2000');

ALTER TABLE album
ADD CONSTRAINT tipo_compra_check 
CHECK (tipo_compra = 'cd' or tipo_compra = 'vinil' or tipo_compra = 'download');

CREATE TABLE faixa (
                numero INTEGER NOT NULL,
                cod_album INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                tmp_exec VARCHAR NOT NULL,
                tipo_grav VARCHAR NOT NULL, -- ADD ou DDD
                cod_comp INTEGER NOT NULL,
               
)ON spotper_fg02;

ALTER TABLE faixa
ADD CONSTRAINT tipo_grav_check
CHECK (tipo_grav = 'ADD' OR tipo_grav = 'DDD');

CREATE TABLE composicao (
                cod_comp INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
) ON spotper_fg01;

CREATE TABLE interprete (
                cod_inter INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                tipo VARCHAR NOT NULL, -- Tipo de intérprete pode ser orquestra, trio, quarteto, ensemble, soprano, tenor, etc...
                
)ON spotper_fg01;

--interprete NxN faixa
CREATE TABLE faixa_inter (
                cod_inter INTEGER NOT NULL,
                numero INTEGER NOT NULL,
                cod_album INTEGER NOT NULL,
               
)ON spotper_fg01;

CREATE TABLE compositor (
                cod_comp INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                cidade VARCHAR NOT NULL,
                pais VARCHAR NOT NULL,
                dt_nasc DATE NOT NULL,
                dt_morte DATE,
                cod_per INTEGER NOT NULL,
                
)ON spotper_fg01;

--compositor NxN faixa
CREATE TABLE faixa_compositor (
                cod_comp INTEGER NOT NULL,
                numero INTEGER NOT NULL,
                cod_album INTEGER NOT NULL,
               
)ON spotper_fg01;

CREATE TABLE periodo_musical (
                cod_per INTEGER NOT NULL,
                intervalo VARCHAR NOT NULL,
                descricao VARCHAR NOT NULL, -- idade média, renascença, barroco, clássico, romântico e moderno
)ON spotper_fg01;

ALTER TABLE periodo_musical 
ADD CONSTRAINT descricao_check
CHECK (descricao = 'idade media' or descricao = 'renascenca' or descricao = 'barroco' or 
        descricao = 'classico' or descricao = 'romantico' or descricao = 'moderno');

CREATE TABLE gravadora (
                cod_grav INTEGER NOT NULL,
                nome_grav VARCHAR NOT NULL,
                site VARCHAR NOT NULL,
                rua VARCHAR NOT NULL,
                numero INTEGER NOT NULL,
                cep VARCHAR NOT NULL,
)ON spotper_fg01;

CREATE TABLE telefone (
                telefone VARCHAR NOT NULL,
                cod_grav_tel INTEGER NOT NULL,
               
)ON spotper_fg01;

CREATE TABLE faixa_playlist (
                cod_playlist VARCHAR NOT NULL,
                numero INTEGER NOT NULL,
                cod_album INTEGER NOT NULL,
                dt_ultima_vez DATE NOT NULL,
                qtd INTEGER NOT NULL,
                tpm_exec_faixa TIME NOT NULL,
               	
)ON spotper_fg02;

CREATE TABLE playlist (
                cod_playlist VARCHAR NOT NULL,
                dt_criacao DATE NOT NULL,
                nome VARCHAR NOT NULL,
                tmp_exec_play TIME NOT NULL,
                
)ON spotper_fg02;


--chaves primarias
ALTER TABLE composicao ADD CONSTRAINT composicao_pk PRIMARY KEY (cod_comp);
ALTER TABLE interprete ADD CONSTRAINT interprete_pk PRIMARY KEY (cod_inter);
ALTER TABLE playlist ADD CONSTRAINT playlist_pk PRIMARY KEY (cod_playlist);
ALTER TABLE periodo_musical ADD CONSTRAINT periodo_musical_pk PRIMARY KEY (cod_per);
ALTER TABLE compositor ADD CONSTRAINT compositor_pk PRIMARY KEY (cod_comp);
ALTER TABLE gravadora ADD CONSTRAINT gravadora_pk PRIMARY KEY (cod_grav);
ALTER TABLE album ADD CONSTRAINT album_pk PRIMARY KEY (cod_album);
ALTER TABLE faixa ADD CONSTRAINT faixa_pk PRIMARY KEY NONCLUSTERED (numero, cod_album); --não clusterizado
ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_playlist_pk PRIMARY KEY (cod_playlist, numero, cod_album);
ALTER TABLE faixa_compositor ADD CONSTRAINT faixa_compositor_pk PRIMARY KEY (cod_comp, numero, cod_album);
ALTER TABLE faixa_inter ADD CONSTRAINT faixa_inter_pk PRIMARY KEY (cod_inter, numero, cod_album);
ALTER TABLE telefone ADD CONSTRAINT telefone_pk PRIMARY KEY (telefone, cod_grav_tel);


--questão 4
CREATE CLUSTERED INDEX faixa_album_index 
ON faixa(cod_album) 
WITH (fillfactor=100, pad_index=on);


CREATE INDEX faixa_composicao_pk 
ON faixa(cod_comp) 
WITH (fillfactor=100, pad_index=on);

-- Chaves estrangeiras --
ALTER TABLE faixa ADD CONSTRAINT composicao_faixa_fk
FOREIGN KEY (cod_comp)
REFERENCES composicao (cod_comp)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa_inter ADD CONSTRAINT interprete_faixa_inter_fk
FOREIGN KEY (cod_inter)
REFERENCES interprete (cod_inter)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa_playlist ADD CONSTRAINT playlist_componentes_fk
FOREIGN KEY (cod_playlist)
REFERENCES playlist (cod_playlist)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE compositor ADD CONSTRAINT periodo_musical_compositor_fk
FOREIGN KEY (cod_per)
REFERENCES periodo_musical (cod_per)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa_compositor ADD CONSTRAINT compositor_faixa_compositor_fk
FOREIGN KEY (cod_comp)
REFERENCES compositor (cod_comp)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE telefone ADD CONSTRAINT gravadora_telefone_fk
FOREIGN KEY (cod_grav_tel)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE album ADD CONSTRAINT gravadora_album_fk
FOREIGN KEY (cod_grav)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE faixa ADD CONSTRAINT album_faixa_fk
FOREIGN KEY (cod_album)
REFERENCES album (cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE faixa_inter ADD CONSTRAINT faixa_faixa_inter_fk
FOREIGN KEY (numero, cod_album)
REFERENCES faixa (numero, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE faixa_compositor ADD CONSTRAINT faixa_faixa_compositor_fk
FOREIGN KEY (numero, cod_album)
REFERENCES faixa (numero, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_componentes_fk
FOREIGN KEY (numero, cod_album)
REFERENCES faixa (numero, cod_album)
ON DELETE CASCADE
ON UPDATE CASCADE;

--------------------||TRIGGERS||------------------------


GO
CREATE TRIGGER PRECO_ALBUM
ON album
AFTER INSERT
AS
IF ( (SELECT preco FROM inserted) > (3 * (SELECT AVG(preco) 
	  FROM album a inner join faixa f 
	  ON f.cod_album = a.cod_album 
	  WHERE tipo_grav = 'DDD')) )
BEGIN
	RAISERROR('', 4, 2)
	ROLLBACK TRANSACTION
END;


GO
CREATE TRIGGER QTD_MAX_FAIXA_ALBUM
ON faixa
AFTER INSERT
AS
IF( ((select count(*)
        from faixa, inserted
        where faixa.cod_album = inserted.cod_album)+1) > (64)) 

BEGIN
        RAISERROR('Limite máximo de faixas no album atingido!!!', 10, 6)
        ROLLBACK TRANSACTION
END;

--3a
GO
CREATE TRIGGER BARROCO_DDD
ON faixa_compositor
AFTER INSERT, UPDATE
AS
IF ( EXISTS(SELECT f.numero 'Numero da Faixa', f.cod_album 'Código album'
			FROM inserted ac, faixa f, compositor c, periodo_musical p
			WHERE f.numero = ac.numero and f.cod_album = ac.cod_album and 
			ac.cod_comp = c.cod_comp and c.cod_per = p.cod_per and p.descricao like 'barroco'
			and f.tipo_grav != 'DDD' ) )
BEGIN
	RAISERROR('Faixa com período Barroco só pode ser adquirida se o tipo de gravação for DDD', 10, 6)
	ROLLBACK TRANSACTION
END;



--INSERIRNDO DADOS


-----------------||VIEW MATERIALIZADA||-----------------
GO

CREATE VIEW VW_PLAYLIST(cod_playlist, nome, qtd_album)
WITH SCHEMABINDING
AS
SELECT p.cod_playlist, p.nome, count_big(*) qtd_album
FROM dbo.playlist p, dbo.faixa_playlist fp, dbo.faixa f
WHERE p.cod_playlist = fp.cod_playlist and
fp.numero = f.numero and fp.cod_album = f.cod_album
GROUP BY p.nome, p.cod_playlist

GO

CREATE UNIQUE CLUSTERED INDEX I_VW_PLAYLIST
ON VW_PLAYLIST(cod_playlist, nome);

--------------||FUNCTIONS       ||---------------
--parâmetro de entrada o nome (ou parte do)
--nome do compositor e o parâmetro de saída todos os álbuns com obras
--compostas pelo compositor
GO
CREATE FUNCTION albuns_compostos(@nome_input VARCHAR(60))
RETURNS @rtnTable TABLE(
                                cod_album INTEGER NOT NULL,
                cod_grav INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                preco FLOAT NOT NULL,
                dt_compra DATE NOT NULL,
                tipo_compra VARCHAR NOT NULL, -- fisica ou download
                dt_grav DATE NOT NULL)
AS
BEGIN
INSERT INTO @rtnTable
        SELECT a.cod_album, a.cod_grav, a.descricao, a.preco, a.dt_compra, a.tipo_compra, a.dt_grav
        FROM album a, faixa_compositor ac, compositor c
        WHERE a.cod_album = ac.cod_album and ac.cod_comp = c.cod_comp and c.nome LIKE '%'+@nome_input+'%'

RETURN
END