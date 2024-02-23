/*************************** Estado ***************************/

CREATE TABLE estado(
    id INT CONSTRAINT pk_estado PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    sigla VARCHAR(2) NOT NULL
);

CREATE SEQUENCE seq_estado
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY estado.id;

ALTER TABLE estado ALTER COLUMN id SET DEFAULT NEXTVAL('seq_estado');

/*************************** Cidade ***************************/

CREATE TABLE cidade(
    id INT CONSTRAINT pk_cidade PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_estado INT NOT NULL,

    CONSTRAINT fk_estado_cidade FOREIGN KEY (id_estado) REFERENCES estado(id)
);

CREATE SEQUENCE seq_cidade
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY cidade.id;

ALTER TABLE cidade ALTER COLUMN id SET DEFAULT NEXTVAL('seq_cidade');

/*************************** Bairro ***************************/

CREATE TABLE bairro(
    id INT CONSTRAINT pk_bairro PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_cidade INT NOT NULL,

    CONSTRAINT fk_cidade_bairro FOREIGN KEY (id_cidade) REFERENCES cidade(id)
);

CREATE SEQUENCE seq_bairro
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY bairro.id;

ALTER TABLE bairro ALTER COLUMN id SET DEFAULT NEXTVAL('seq_bairro');

/*************************** Sub-Bairro ***************************/

CREATE TABLE sub_bairro(
    id INT CONSTRAINT pk_sub_bairro PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_bairro INT NOT NULL,

    CONSTRAINT fk_bairro_sub_bairro FOREIGN KEY (id_bairro) REFERENCES bairro(id)
    
);

CREATE SEQUENCE seq_sub_bairro
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY sub_bairro.id;

ALTER TABLE sub_bairro ALTER COLUMN id SET DEFAULT NEXTVAL('seq_sub_bairro');