-- CRIAÇÃO DAS TABELAS
use master;
go
DROP DATABASE spotper;

CREATE DATABASE spotper
ON
        PRIMARY(
        NAME = 'spotper',
        FILENAME = 'C:\FBD1\spotper.mdf',
        SIZE = 5120KB,
        FILEGROWTH = 1024KB
        ),

        FILEGROUP spotper_fg01(
        NAME = 'spotper_001',
        FILENAME = 'C:\FBD1\spotper_001.ndf',
        SIZE = 1024KB,
        FILEGROWTH = 30%  
        ),
        (
        NAME = 'spotper_002',
        FILENAME = 'C:\FBD1\spotper_002.ndf',
        SIZE = 1024KB,
        MAXSIZE = 3072KB,
        FILEGROWTH = 15%
        ),

        FILEGROUP spotper_fg02(
        NAME = 'loja_003',
        FILENAME = 'C:\FBD1\spotper_003.ndf',
        SIZE = 1024KB,
        MAXSIZE = 5120KB,
        FILEGROWTH = 1024KB
        )

        LOG ON
        (
        NAME = 'spotper_log',
        FILENAME = 'C:\FBD1\spotper_log.ldf',
        SIZE = 1024KB,
        FILEGROWTH = 10%
        )

USE spotper;



CREATE TABLE tipo_composicao (
                cod_tipo_comp INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                
) ON spotper_fg01;
CREATE TABLE interprete (
                cod_inter INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                tipo VARCHAR NOT NULL,
                
)ON spotper_fg01;


CREATE TABLE playlist (
                cod_playlist VARCHAR NOT NULL,
                dt_criacao DATE NOT NULL,
                nome VARCHAR NOT NULL,
                tmp_exec_play TIME NOT NULL,
                
)ON spotper_fg02;


CREATE TABLE periodo_musical (
                cod_per INTEGER NOT NULL,
                intervalo VARCHAR NOT NULL,
                descricao VARCHAR NOT NULL,
                
)ON spotper_fg01;


CREATE TABLE compositor (
                cod_comp INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                local_nasc VARCHAR NOT NULL,
                dt_nasc DATE NOT NULL,
                dt_morte DATE,
                cod_per INTEGER NOT NULL,
                
)ON spotper_fg01;

CREATE TABLE gravadora (
                cod_grav INTEGER NOT NULL,
                nome_grav VARCHAR NOT NULL,
                site VARCHAR NOT NULL,
                endereco VARCHAR NOT NULL,
                
)ON spotper_fg01;

CREATE TABLE album (
                cod_album INTEGER NOT NULL,
                cod_grav INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                preco FLOAT NOT NULL,
                dt_compra DATE NOT NULL,
                tipo_compra VARCHAR NOT NULL,
                dt_grav DATE NOT NULL,
                
)ON spotper_fg01;

CREATE TABLE faixa (
                numero INTEGER NOT NULL,
                cod_album_faixa INTEGER NOT NULL,
                descricao VARCHAR NOT NULL,
                tmp_exec VARCHAR NOT NULL,
                tipo_grav VARCHAR NOT NULL,
                cod_tipo_comp INTEGER NOT NULL,
               
)ON spotper_fg02;

CREATE TABLE faixa_playlist (
                cod_playlist VARCHAR NOT NULL,
                numero INTEGER NOT NULL,
                cod_album INTEGER NOT NULL,
                dt_ultima_vez DATE NOT NULL,
                qtd INTEGER NOT NULL,
                tpm_exec_faixa TIME NOT NULL,
               
)ON spotper_fg02;

CREATE TABLE aux_comp (
                cod_comp_aux INTEGER NOT NULL,
                numero_aux_comp INTEGER NOT NULL,
                cod_album_aux_comp INTEGER NOT NULL,
               
)ON spotper_fg01;

CREATE TABLE aux_inter (
                cod_inter_aux INTEGER NOT NULL,
                numero_aux_inter INTEGER NOT NULL,
                cod_album_aux INTEGER NOT NULL,
               
)ON spotper_fg01;


CREATE TABLE telefone (
                telefone VARCHAR NOT NULL,
                cod_grav_tel INTEGER NOT NULL,
               
)ON spotper_fg01;



--chaves primarias
ALTER TABLE tipo_composicao ADD CONSTRAINT tipo_composicao_pk PRIMARY KEY (cod_tipo_comp);
ALTER TABLE interprete ADD CONSTRAINT interprete_pk PRIMARY KEY (cod_inter);
ALTER TABLE playlist ADD CONSTRAINT playlist_pk PRIMARY KEY (cod_playlist);
ALTER TABLE periodo_musical ADD CONSTRAINT periodo_musical_pk PRIMARY KEY (cod_per);
ALTER TABLE compositor ADD CONSTRAINT compositor_pk PRIMARY KEY (cod_comp);
ALTER TABLE gravadora ADD CONSTRAINT gravadora_pk PRIMARY KEY (cod_grav);
ALTER TABLE album ADD CONSTRAINT album_pk PRIMARY KEY (cod_album);
ALTER TABLE faixa ADD CONSTRAINT faixa_pk PRIMARY KEY (numero, cod_album_faixa);
ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_playlist_pk PRIMARY KEY (cod_playlist, numero, cod_album);
ALTER TABLE aux_comp ADD CONSTRAINT aux_comp_pk PRIMARY KEY (cod_comp_aux, numero_aux_comp, cod_album_aux_comp);
ALTER TABLE aux_inter ADD CONSTRAINT aux_inter_pk PRIMARY KEY (cod_inter_aux, numero_aux_inter, cod_album_aux);
ALTER TABLE telefone ADD CONSTRAINT telefone_pk PRIMARY KEY (telefone, cod_grav_tel);

-- Chaves estrangeiras --
ALTER TABLE faixa ADD CONSTRAINT tipo_composicao_faixa_fk
FOREIGN KEY (cod_tipo_comp)
REFERENCES tipo_composicao (cod_tipo_comp)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE aux_inter ADD CONSTRAINT interprete_aux_inter_fk
FOREIGN KEY (cod_inter_aux)
REFERENCES interprete (cod_inter)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE faixa_playlist ADD CONSTRAINT playlist_componentes_fk
FOREIGN KEY (cod_playlist)
REFERENCES playlist (cod_playlist)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE compositor ADD CONSTRAINT periodo_musical_compositor_fk
FOREIGN KEY (cod_per)
REFERENCES periodo_musical (cod_per)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE aux_comp ADD CONSTRAINT compositor_aux_comp_fk
FOREIGN KEY (cod_comp_aux)
REFERENCES compositor (cod_comp)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE telefone ADD CONSTRAINT gravadora_telefone_fk
FOREIGN KEY (cod_grav_tel)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE album ADD CONSTRAINT gravadora_album_fk
FOREIGN KEY (cod_grav)
REFERENCES gravadora (cod_grav)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE faixa ADD CONSTRAINT album_faixa_fk
FOREIGN KEY (cod_album_faixa)
REFERENCES album (cod_album)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE aux_inter ADD CONSTRAINT faixa_aux_inter_fk
FOREIGN KEY (numero_aux_inter, cod_album_aux)
REFERENCES faixa (numero, cod_album_faixa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE aux_comp ADD CONSTRAINT faixa_aux_comp_fk
FOREIGN KEY (numero_aux_comp, cod_album_aux_comp)
REFERENCES faixa (numero, cod_album_faixa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE faixa_playlist ADD CONSTRAINT faixa_componentes_fk
FOREIGN KEY (numero, cod_album)
REFERENCES faixa (numero, cod_album_faixa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

