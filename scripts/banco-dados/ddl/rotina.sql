/**

   Criado por: Rafael Rodrigues de Oliveira
   Data: 15/03/2022
   Descricao: Script das tabelas relacionadas ao controle das rotinas automaticas
  ____________________________________________________________________________________________
  | Demanda | Descricao                                                    |      Autor       |
  --------------------------------------------------------------------------------------------
  | SE-94   | Criar tabelas para controle do fluxo da Situacao no Projeto  | Rafael Rodrigues |
  --------------------------------------------------------------------------------------------

**/

/*************************** Tipo Rotina ***************************/

CREATE TABLE tipo_rotina(
    id INT CONSTRAINT pk_tipo_rotina PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE SEQUENCE seq_tipo_rotina
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY tipo_rotina.id;

ALTER TABLE tipo_rotina ALTER COLUMN id SET DEFAULT NEXTVAL('seq_tipo_rotina');


/*************************** Rotina ********************************/

CREATE TABLE rotina (
     id INT CONSTRAINT pk_rotina PRIMARY KEY,
     nome VARCHAR(50) NOT NULL,
     uuid VARCHAR(255) UNIQUE NOT NULL,
     ativo BOOLEAN DEFAULT TRUE, 
     id_tipo_rotina INT NOT NULL,
     
     CONSTRAINT fk_tipo_rotina_rotina FOREIGN KEY (id_tipo_rotina) REFERENCES tipo_rotina(id)
);

CREATE SEQUENCE seq_rotina
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY rotina.id;

ALTER TABLE rotina ALTER COLUMN id SET DEFAULT NEXTVAL('seq_rotina');


/*************************** Periodo *******************************/

CREATE TABLE periodo(
     id INT CONSTRAINT pk_periodo PRIMARY KEY,
     segundo VARCHAR(50) DEFAULT '0',
     minuto VARCHAR(50) DEFAULT '0',
     hora VARCHAR(50) NOT NULL,
     dia_mes VARCHAR(50) NOT NULL,
     mes VARCHAR(50) NOT NULL,
     dia_semana VARCHAR(50) DEFAULT '*',
     ano VARCHAR(50),
     ativo BOOLEAN DEFAULT TRUE,
     id_rotina INT NOT NULL,

     CONSTRAINT fk_rotina_periodo FOREIGN KEY (id_rotina) REFERENCES rotina(id)
);

CREATE SEQUENCE seq_periodo
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY periodo.id;

ALTER TABLE periodo ALTER COLUMN id SET DEFAULT NEXTVAL('seq_periodo');


/******************** Tarefa Situacao no Projeto ******************/

CREATE TABLE tarefa_situacao_projeto(
     id INT CONSTRAINT pk_tarefa_situacao_projeto PRIMARY KEY,
     status_atual VARCHAR(40) NOT NULL,
     proximo_status VARCHAR(40) NOT NULL,
     id_periodo INT NOT NULL UNIQUE,

     CONSTRAINT fk_periodo_tarefa_situacao_projeto FOREIGN KEY (id_periodo) REFERENCES periodo(id)
);

CREATE SEQUENCE seq_tarefa_situacao_projeto
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY tarefa_situacao_projeto.id;

ALTER TABLE tarefa_situacao_projeto ALTER COLUMN id SET DEFAULT NEXTVAL('seq_tarefa_situacao_projeto');