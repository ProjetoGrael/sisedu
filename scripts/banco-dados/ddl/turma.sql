/**

   Criado por: Frederico Martins Eça
   Data: 30/04/2022
   Descriçao: Script das tabelas relacionadas ao contexto do Turma
  ____________________________________________________________________________________________
  | Demanda | Descrição                                                   |      Autor       |
  --------------------------------------------------------------------------------------------
  | SE-10   | Criar script das tabelas relacionado contexto do Disciplina | Frederico Martins|
  | SE-143  | Criar script das tabelas relacionado contexto de Turma      | Frederico Martins|
  | SE-143  | Criado inscrições, plano de aula e presenças                | Frederico Martins|
  | SE-10   | Criar script das tabelas relacionado contexto do Disciplina | Frederico Martins|
  | SE-143  | Criar script das tabelas relacionado contexto de Turma      | Frederico Martins|
  | SE-141  | Criar script das tabelas relacionado contexto do Instrutor  | David Dener      |
  | SE-150  | Associar Instrutor a Disciplina (Back-End)                  | David Dener      |
  | SE-143  | Criação Curso associando ao instrutor-disciplina            | Frederico Martins|
  | SE-11   | Cadastro de Períodos Letivos                                | David Dener      |
  | SE-160  | Cadastro de Dias sem aulas                                  | David Dener      |
  | SE-196  | Alterando o relacionamento da inscricao da turma para curso | Rafael Rodrigues |
  --------------------------------------------------------------------------------------------

**/

/************************************************** Programa ***************************/

CREATE TABLE programa(
    id SMALLINT CONSTRAINT pk_programa PRIMARY KEY,
    nome VARCHAR(20) NOT NULL
);

CREATE SEQUENCE seq_programa
    AS SMALLINT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 50
    START 1
    OWNED BY programa.id;

ALTER TABLE programa ALTER COLUMN id SET DEFAULT NEXTVAL('seq_programa');

/************************************************** Nivel ***************************/

CREATE TABLE nivel(
    id SMALLINT CONSTRAINT pk_nivel PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL,
    evolucao INT NOT NULL
);

CREATE SEQUENCE seq_nivel
    AS SMALLINT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 10
    START 1
    OWNED BY nivel.id;

ALTER TABLE nivel ALTER COLUMN id SET DEFAULT NEXTVAL('seq_nivel');

/************************************************** Disciplina ***************************/

CREATE TABLE disciplina(
    id INT CONSTRAINT pk_disciplina PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    carga_horaria DOUBLE PRECISION NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    id_nivel SMALLINT,
    id_programa SMALLINT NOT NULL,

    CONSTRAINT fk_nivel_disciplina FOREIGN KEY (id_nivel) REFERENCES nivel(id),
    CONSTRAINT fk_programa_disciplina FOREIGN KEY (id_programa) REFERENCES programa(id)
);

CREATE SEQUENCE seq_disciplina
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY disciplina.id;

ALTER TABLE disciplina ALTER COLUMN id SET DEFAULT NEXTVAL('seq_disciplina');

/************************************************** Plano de Aula ***************************/

CREATE TABLE plano_de_aula(
  id INT CONSTRAINT pk_plano_de_aula PRIMARY KEY,
  anotacoes VARCHAR(200) NOT NULL,
  observacoes VARCHAR(200),
  ordenacao INT NOT NULL,
  id_disciplina INT NOT NULL,
  
  CONSTRAINT fk_disciplina_plano_de_aula FOREIGN KEY (id_disciplina) REFERENCES disciplina(id)
);

CREATE SEQUENCE seq_plano_de_aula
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY plano_de_aula.id;

ALTER TABLE plano_de_aula ALTER COLUMN id SET DEFAULT NEXTVAL('seq_plano_de_aula');


/*************************** Status período letivo ***************************/

CREATE TABLE status_periodo_letivo(
    id SMALLINT CONSTRAINT pk_status_periodo_letivo PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE SEQUENCE seq_status_periodo_letivo
    AS SMALLINT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 10
    START 1
    OWNED BY status_periodo_letivo.id;

ALTER TABLE status_periodo_letivo ALTER COLUMN id SET DEFAULT NEXTVAL('seq_status_periodo_letivo');

/*************************** Período letivo ***************************/

CREATE TABLE periodo_letivo (
     id INT CONSTRAINT pk_periodo_letivo PRIMARY KEY,
     nome VARCHAR(40) NOT NULL,
     inicio DATE,
     fim DATE,
     capacidade INT,
     status_periodo_letivo SMALLINT NOT NULL,

     CONSTRAINT fk_status_periodo_letivo FOREIGN KEY (status_periodo_letivo) REFERENCES status_periodo_letivo(id)
);

CREATE SEQUENCE seq_periodo_letivo
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY periodo_letivo.id;

ALTER TABLE periodo_letivo ALTER COLUMN id SET DEFAULT NEXTVAL('seq_periodo_letivo');


/*************************Dias sem aula*******************************/

CREATE TABLE dias_sem_aula (
     id INT CONSTRAINT pk_dias_sem_aula PRIMARY KEY,
     dia DATE,
     descricao VARCHAR(40) NOT NULL,
     periodo_letivo SMALLINT NOT NULL,

     CONSTRAINT fk_periodo_letivo FOREIGN KEY (periodo_letivo) REFERENCES periodo_letivo(id)
);

CREATE SEQUENCE seq_dias_sem_aula
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY dias_sem_aula.id;

ALTER TABLE dias_sem_aula ALTER COLUMN id SET DEFAULT NEXTVAL('seq_dias_sem_aula');

/************************************************** Turma ***************************/

CREATE TABLE turma(
   id INT CONSTRAINT pk_turma PRIMARY KEY,
   nome_fantasia VARCHAR(200) NOT NULL,
   comentario VARCHAR(200),
   id_periodo_letivo INT NOT NULL,

   CONSTRAINT fk_periodo_letivo_turma FOREIGN KEY (id_periodo_letivo) REFERENCES periodo_letivo(id)
);

CREATE SEQUENCE seq_turma
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY turma.id;

ALTER TABLE turma ALTER COLUMN id SET DEFAULT NEXTVAL('seq_turma');

/************************************************** Instrutor ***************************/

CREATE TABLE instrutor(
    id INT CONSTRAINT pk_instrutor PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    celular VARCHAR(11) NOT NULL
);
CREATE SEQUENCE seq_instrutor
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY instrutor.id;

    ALTER TABLE instrutor ALTER COLUMN id SET DEFAULT NEXTVAL('seq_instrutor');


/************************************************** instrutor-disciplina ***************************/

CREATE TABLE instrutor_disciplina(
    id INT CONSTRAINT pk_instrutor_disciplina PRIMARY KEY,
    id_instrutor INT NOT NULL,
    id_disciplina INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,

    CONSTRAINT fk_id_instrutor FOREIGN KEY (id_instrutor) REFERENCES instrutor(id),
    CONSTRAINT fk_id_disciplina FOREIGN KEY (id_disciplina) REFERENCES disciplina(id)
);

CREATE SEQUENCE seq_instrutor_disciplina
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY instrutor_disciplina.id;

ALTER TABLE instrutor_disciplina ALTER COLUMN id SET DEFAULT NEXTVAL('seq_instrutor_disciplina');

/************************************************** Cursos ***************************/

CREATE TABLE curso(
  id INT CONSTRAINT pk_curso PRIMARY KEY,
  horario_inicio TIME NOT NULL,
  horario_termino TIME NOT NULL,
  segunda_feira BOOLEAN DEFAULT FALSE,
  terca_feira BOOLEAN DEFAULT FALSE,
  quarta_feira BOOLEAN DEFAULT FALSE,
  quinta_feira BOOLEAN DEFAULT FALSE,
  sexta_feira BOOLEAN DEFAULT FALSE,
  disciplina_principal BOOLEAN DEFAULT FALSE,
  ativo BOOLEAN DEFAULT TRUE,
  id_instrutor_disciplina INT NOT NULL,
  id_turma INT NOT NULL,

  CONSTRAINT fk_instrutor_disciplina_curso FOREIGN KEY (id_instrutor_disciplina) REFERENCES instrutor_disciplina(id),
  CONSTRAINT fk_turma_curso FOREIGN KEY (id_turma) REFERENCES turma(id)
);

CREATE SEQUENCE seq_curso
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY curso.id;

ALTER TABLE curso ALTER COLUMN id SET DEFAULT NEXTVAL('seq_curso');

/************************************************** Inscrições ***************************/

CREATE TABLE inscricao(
  id INT CONSTRAINT pk_inscricao PRIMARY KEY,
  data_inicio TIMESTAMP NOT NULL,
  data_fim TIMESTAMP,
  situacao VARCHAR(40) NOT NULL,
  comentario_aluno VARCHAR(200),
  ativo BOOLEAN DEFAULT TRUE,
  data_renovacao DATE,
  status_estudante VARCHAR(40) NOT NULL,
  data_modificacao_situacao DATE,
  id_estudante INT NOT NULL,
  id_curso INT NOT NULL,

  CONSTRAINT fk_estudante_inscricao FOREIGN KEY (id_estudante) REFERENCES estudante(id),
  CONSTRAINT fk_curso_inscricao FOREIGN KEY (id_curso) REFERENCES curso(id)
);

CREATE SEQUENCE seq_inscricao
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY inscricao.id;

ALTER TABLE inscricao ALTER COLUMN id SET DEFAULT NEXTVAL('seq_inscricao');

/************************************************** Conselho de Classe ***************************/

CREATE TABLE conselho_de_classe(
    id INT CONSTRAINT pk_conselho_de_classe PRIMARY KEY,
    conselho_inicial CHAR,
    conselho_parcial CHAR,
    conselho_final CHAR,
    situacao VARCHAR(40) DEFAULT 'Estudando',
    opiniao_conselho TEXT,
    proxima_disciplina_principal_curso INT,
    id_inscricao INT NOT NULL,

    CONSTRAINT fk_inscricao_conselho_de_classe FOREIGN KEY (id_inscricao) REFERENCES inscricao(id)
);

CREATE SEQUENCE seq_conselho_de_classe
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY conselho_de_classe.id;

ALTER TABLE conselho_de_classe ALTER COLUMN id SET DEFAULT NEXTVAL('seq_conselho_de_classe');


/************************************************** Historico Curso Instrutor_Disciplina ***************************/

CREATE TABLE historico_curso_instrutor_disciplina(
  id INT CONSTRAINT pk_historico_curso_instrutor_disciplina PRIMARY KEY,
  data_inicio TIMESTAMP NOT NULL,
  data_fim TIMESTAMP,
  id_instrutor_disciplina INT NOT NULL,
  id_curso INT NOT NULL,

  CONSTRAINT fk_instrutor_disciplina_historico FOREIGN KEY (id_instrutor_disciplina) REFERENCES instrutor_disciplina(id),
  CONSTRAINT fk_curso_historico FOREIGN KEY (id_curso) REFERENCES curso(id)
);

CREATE SEQUENCE seq_historico_curso_instrutor_disciplina
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY curso.id;

ALTER TABLE historico_curso_instrutor_disciplina ALTER COLUMN id SET DEFAULT NEXTVAL('seq_historico_curso_instrutor_disciplina');


/*************************** Pauta ***************************/

CREATE TABLE pauta (
     id INT CONSTRAINT pk_pauta PRIMARY KEY,
     notas_aula VARCHAR(500),
     observacao VARCHAR(500),
     dia_aula DATE,
     id_curso INT,
     id_plano_de_aula INT NOT NULL,

    CONSTRAINT fk_curso_pauta FOREIGN KEY (id_curso) REFERENCES curso(id),
    CONSTRAINT fk_plano_de_aula_pauta FOREIGN KEY (id_plano_de_aula) REFERENCES plano_de_aula(id)
);

CREATE SEQUENCE seq_pauta
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY pauta.id;

ALTER TABLE pauta ALTER COLUMN id SET DEFAULT NEXTVAL('seq_pauta');

/************************************************** Presenças ***************************/

CREATE TABLE presenca(
  id INT CONSTRAINT pk_presenca PRIMARY KEY,
  situacao VARCHAR(40) NOT NULL DEFAULT 'Não Lançado',
  participacao VARCHAR(40),
  id_estudante INT NOT NULL,
  id_pauta INT NOT NULL,

  CONSTRAINT fk_estudante_presenca FOREIGN KEY (id_estudante) REFERENCES estudante(id),
  CONSTRAINT fk_pauta_presenca FOREIGN KEY (id_pauta) REFERENCES pauta(id)
);

CREATE SEQUENCE seq_presenca
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY presenca.id;

ALTER TABLE presenca ALTER COLUMN id SET DEFAULT NEXTVAL('seq_presenca');
