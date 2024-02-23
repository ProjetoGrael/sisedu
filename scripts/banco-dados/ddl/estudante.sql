/**

   Criado por: Rafael Rodrigues de Oliveira
   Data: 04/01/2022
   Descriçao: Script das tabelas relacionadas ao contexto do Estudante
  ____________________________________________________________________________________________
  | Demanda | Descrição                                                   |      Autor       |
  --------------------------------------------------------------------------------------------
  | SE-73   | Criar script das tabelas relacionado contexto do estudante  | Rafael Rodrigues |
  | SE-65   | Inserir um novo Estudante                                   | Rafael Rodrigues |
  | SE-86   | Cadastrar responsavel                                       | David Dener      |
  | SE-105  | Ajuste no Cadastro de Estudante                             | Rafael Rodrigues |
  | SE-124  | Inclusão da tabela Filiação                                 | Rafael Rodrigues |
  | SE-134  | Ajuste da validação do Responsável                          | Rafael Rodrigues |
  | SE-152  | Inclusão de Situação familiar                               | Frederico Martins|
  | SE-137  | Informações de Saúde                              		  | David Dener      |
  | SE-138  | Como conheceu o Projeto?                              	  | David Dener      |
  --------------------------------------------------------------------------------------------

**/


/*************************** Tipo Responsavel ***************************/

CREATE TABLE tipo_responsavel(
    id SMALLINT CONSTRAINT pk_tipo_responsavel PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE SEQUENCE seq_tipo_responsavel
    AS SMALLINT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 10
    START 1
    OWNED BY tipo_responsavel.id;

ALTER TABLE tipo_responsavel ALTER COLUMN id SET DEFAULT NEXTVAL('seq_tipo_responsavel');

/*************************** Responsavel ***************************/

CREATE TABLE responsavel (
     id INT CONSTRAINT pk_responsavel PRIMARY KEY,
     nome VARCHAR(100) NOT NULL ,
     sobrenome VARCHAR(255) NOT NULL,
     cpf VARCHAR(11) NOT NULL,
     rg VARCHAR(50),     
     telefone VARCHAR(11),
     celular VARCHAR(12),
     email VARCHAR(30),
     ativo BOOLEAN DEFAULT TRUE,
     id_tipo_responsavel SMALLINT NOT NULL,

     CONSTRAINT fk_tipo_responsavel FOREIGN KEY (id_tipo_responsavel) REFERENCES tipo_responsavel(id)
);

CREATE SEQUENCE seq_responsavel
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY responsavel.id;

ALTER TABLE responsavel ALTER COLUMN id SET DEFAULT NEXTVAL('seq_responsavel');


/*************************** Estudante ***************************/

CREATE TABLE estudante (
     id INT CONSTRAINT pk_estudante PRIMARY KEY,
     uuid VARCHAR(255) UNIQUE NOT NULL,
     matricula VARCHAR(255) UNIQUE NOT NULL,
     nome VARCHAR(100) NOT NULL,
     sobrenome VARCHAR(300) NOT NULL,
     nome_social VARCHAR(300),
     sexo CHAR(1) NOT NULL,
     data_nascimento DATE NOT NULL,
     cor_etnia VARCHAR(50),
     naturalidade VARCHAR(100),
     local_nascimento VARCHAR(100),
     numero_rg VARCHAR(50) UNIQUE,
     orgao_expedidor_rg VARCHAR(150),
     data_emissao_rg DATE,
     cpf VARCHAR(25) UNIQUE,
     nacionalidade VARCHAR(100),
     ativo BOOLEAN DEFAULT TRUE,
     id_responsavel INT,

     CONSTRAINT fk_responsavel_estudante FOREIGN KEY (id_responsavel) REFERENCES responsavel(id)
);

CREATE SEQUENCE seq_estudante
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY estudante.id;

ALTER TABLE estudante ALTER COLUMN id SET DEFAULT NEXTVAL('seq_estudante');

/*************************** Contato Estudante ***************************/

CREATE TABLE contato_estudante(
   id INT CONSTRAINT pk_contato_estudante PRIMARY KEY,
   contato VARCHAR(50),
   pertence VARCHAR(255),
   tipo VARCHAR(50),
   id_estudante INT,
   
   CONSTRAINT fk_estudante_contato_estudante FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_contato_estudante
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY contato_estudante.id;

ALTER TABLE contato_estudante ALTER COLUMN id SET DEFAULT NEXTVAL('seq_contato_estudante');


/*************************** Endereco ***************************/

CREATE TABLE endereco(
    id INT CONSTRAINT pk_endereco PRIMARY KEY,
    logradouro VARCHAR(50) NOT NULL,
    numero INT,
    complemento VARCHAR(30),
    bairro VARCHAR(30) NOT NULL,
    sub_bairro VARCHAR(30),
    cidade VARCHAR(30) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    id_estudante INT UNIQUE NOT NULL,

    CONSTRAINT fk_estudante_endereco FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_endereco
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY endereco.id;

ALTER TABLE endereco ALTER COLUMN id SET DEFAULT NEXTVAL('seq_endereco');

/*************************** Escola ***************************/

CREATE TABLE escola(
    id INT CONSTRAINT pk_escola PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

CREATE SEQUENCE seq_escola
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY escola.id;

ALTER TABLE escola ALTER COLUMN id SET DEFAULT NEXTVAL('seq_escola');

/*************************** Situacao Escolar ***************************/

CREATE TABLE situacao_escolar(
    id INT CONSTRAINT pk_situacao_escolar PRIMARY KEY,
    escolaridade VARCHAR(100) NOT NULL,
    turno VARCHAR(20),
    situacao VARCHAR(20) NOT NULL,
    bolsista BOOLEAN,
    periodo INT,
    estado_escolaridade VARCHAR(100) NOT NULL,
    nivel INT,
    id_estudante int NOT NULL,
    id_escola int NOT NULL,

    CONSTRAINT fk_estudante_situacao_escolar FOREIGN KEY (id_estudante) REFERENCES estudante(id),
    CONSTRAINT fk_escola_situacao_escolar FOREIGN KEY (id_escola) REFERENCES escola(id)
);

CREATE SEQUENCE seq_situacao_escolar
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY situacao_escolar.id;

ALTER TABLE situacao_escolar ALTER COLUMN id SET DEFAULT NEXTVAL('seq_situacao_escolar');

/*************************** Check List Documentacao ***************************/

CREATE TABLE check_list_documentacao(
    id INT CONSTRAINT pk_check_list_documentacao PRIMARY KEY,
    rg_estudante BOOLEAN DEFAULT FALSE,
    rg_responsavel BOOLEAN DEFAULT FALSE,
    cpf_estudante BOOLEAN DEFAULT FALSE,
    cpf_responsavel BOOLEAN DEFAULT FALSE,
    comprovante_residencia BOOLEAN DEFAULT FALSE,
    declaracao_escolar BOOLEAN DEFAULT FALSE,
    certidao_nascimento BOOLEAN DEFAULT FALSE,
    termo_audio_video BOOLEAN DEFAULT FALSE,
    atestado_medico BOOLEAN DEFAULT FALSE,
    historico_escolar BOOLEAN DEFAULT FALSE,
    id_estudante INT NOT NULL,

    CONSTRAINT fk_estudante_check_list_documentacao FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_check_list_documentacao
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY check_list_documentacao.id;

ALTER TABLE check_list_documentacao ALTER COLUMN id SET DEFAULT NEXTVAL('seq_check_list_documentacao');

/*************************** Entrevista ***************************/
CREATE TABLE entrevista(
    id INT CONSTRAINT pk_entrevista PRIMARY KEY,
    numero_residentes INT,
    renda_familiar NUMERIC(12, 2),
    nis VARCHAR(11),
    trabalhando BOOLEAN DEFAULT FALSE,
    laudo_medico VARCHAR(300),
    como_foi_indicado_projeto VARCHAR(100),
    descricao_indicacao VARCHAR(300),
    id_estudante INT NOT NULL,

    CONSTRAINT fk_estudante_entrevista FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_entrevista
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY entrevista.id;

ALTER TABLE entrevista ALTER COLUMN id SET DEFAULT NEXTVAL('seq_entrevista');

/*************************** SITUACAO PROJETO ***************************/

CREATE TABLE situacao_projeto(
    id INT CONSTRAINT pk_situacao_projeto PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    ano_ingresso INT NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    id_estudante INT NOT NULL,

    CONSTRAINT fk_estudante_situacao_projeto FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_situacao_projeto
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY situacao_projeto.id;

ALTER TABLE situacao_projeto ALTER COLUMN id SET DEFAULT NEXTVAL('seq_situacao_projeto');


/*************************** Filiação ***************************/

CREATE TABLE filiacao (
     id INT CONSTRAINT pk_filiacao PRIMARY KEY,
     nome_pai VARCHAR(40) NOT NULL ,
     sobrenome_pai VARCHAR(40) NOT NULL,
     cpf_pai VARCHAR(11),   
     email_pai VARCHAR(30),
     telefone_pai VARCHAR(11),
     nome_mae VARCHAR(40) NOT NULL ,
     sobrenome_mae VARCHAR(40) NOT NULL,
     cpf_mae VARCHAR(11),   
     email_mae VARCHAR(30),
     telefone_mae VARCHAR(11),
     id_estudante INT NOT NULL UNIQUE,

     CONSTRAINT fk_estudante_filiacao FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_filiacao
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY filiacao.id;

ALTER TABLE filiacao ALTER COLUMN id SET DEFAULT NEXTVAL('seq_filiacao');

/*************************** Situação Familiar  ***************************/

CREATE TABLE situacao_familiar (
   id INT CONSTRAINT pk_situacao_familiar PRIMARY KEY,
   numero_residentes INT NOT NULL,
   renda_familiar NUMERIC(1000, 2) NOT NULL,
   nis_pis_nit BIGINT,
   estudante_trabalhando BOOLEAN,
   nome_empresa VARCHAR(100),
   id_estudante INT NOT NULL UNIQUE,

   CONSTRAINT fk_estudante_situacao_familiar FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_situacao_familiar
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY situacao_familiar.id;

ALTER TABLE situacao_familiar ALTER COLUMN id SET DEFAULT NEXTVAL('seq_situacao_familiar');


/*************************** INFORMAÇÕES DE SAÚDE ***************************/

CREATE TABLE informacao_saude(
    id INT CONSTRAINT pk_informacao_saude PRIMARY KEY,
    medicacao BOOLEAN DEFAULT FALSE,
    informacao_medicacao VARCHAR,
    laudo_medico BOOLEAN DEFAULT FALSE,
    informacao_laudo_medico VARCHAR,
    outra_observacao BOOLEAN DEFAULT FALSE,
    observacao VARCHAR,
    id_estudante INT NOT NULL UNIQUE,

    CONSTRAINT fk_estudante_informacao_saude FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_informacao_saude
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY informacao_saude.id;

ALTER TABLE informacao_saude ALTER COLUMN id SET DEFAULT NEXTVAL('seq_informacao_saude');



/*************************** Tipo Indicação ***************************/

CREATE TABLE tipo_indicacao(
    id SMALLINT CONSTRAINT pk_tipo_indicacao PRIMARY KEY,
    descricao VARCHAR NOT NULL
);

CREATE SEQUENCE seq_tipo_indicacao
    AS SMALLINT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 10
    START 1
    OWNED BY tipo_indicacao.id;

ALTER TABLE tipo_indicacao ALTER COLUMN id SET DEFAULT NEXTVAL('seq_tipo_indicacao');


/*************************** COMO CONHECEU O PROJETO? ***************************/

CREATE TABLE indicacao_projeto(
    id INT CONSTRAINT pk_indicacao_projeto PRIMARY KEY,
    descricao_outro VARCHAR,
    id_tipo_indicacao INT NOT NULL UNIQUE,
    id_estudante INT NOT NULL UNIQUE,

    CONSTRAINT fk_tipo_indicacao FOREIGN KEY (id_tipo_indicacao) REFERENCES tipo_indicacao(id),
    CONSTRAINT fk_estudante_indicacao_projeto FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_indicacao_projeto
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY indicacao_projeto.id;

ALTER TABLE indicacao_projeto ALTER COLUMN id SET DEFAULT NEXTVAL('seq_indicacao_projeto');