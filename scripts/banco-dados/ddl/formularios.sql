/*************************** Entrevista Profissionalizante ***************************/

CREATE TABLE entrevista_profissionalizante(
   id INT CONSTRAINT pk_entrevista_profissionalizante PRIMARY KEY,
   id_disciplina INT,
   instituicao VARCHAR(50),
   repetente BOOLEAN DEFAULT FALSE,
   qtd_repetente INT,
   necessidade_especial BOOLEAN DEFAULT FALSE,
   desc_necessidade_especial VARCHAR(100),
   com_quem_reside VARCHAR(50),
   condicao_moradia VARCHAR(100),
   infra_moradia VARCHAR(20),
   transporte VARCHAR(50),
   qtd_transporte INT,
   frequentou_grael BOOLEAN DEFAULT FALSE,
   experiencia_nautica BOOLEAN DEFAULT FALSE,
   outro_projeto BOOLEAN DEFAULT FALSE,
   motivacao_grael VARCHAR(100),
   atividade_remunerada BOOLEAN DEFAULT FALSE,
   trabalhou BOOLEAN DEFAULT FALSE,
   quem_trabalha_casa VARCHAR(20),
   pacote_office BOOLEAN DEFAULT FALSE,
   acesso_internet BOOLEAN DEFAULT FALSE,
   utiliza_rede_social BOOLEAN DEFAULT FALSE,
   desc_rede_social VARCHAR(100),
   convivio_familiar VARCHAR(200),
   atividade_lazer VARCHAR(200),
   fazer_com_familia VARCHAR(200),
   observacao_servico_social VARCHAR(200),
   id_estudante INT,

   CONSTRAINT fk_disciplina FOREIGN KEY (id_disciplina) REFERENCES disciplina(id),
   CONSTRAINT fk_estudante_entrevista_profissionalizante FOREIGN KEY (id_estudante) REFERENCES estudante(id)
);

CREATE SEQUENCE seq_entrevista_profissionalizante
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY entrevista_profissionalizante.id;

ALTER TABLE entrevista_profissionalizante ALTER COLUMN id SET DEFAULT NEXTVAL('seq_entrevista_profissionalizante');


/*************************** Ficha Atendimento ***************************/

CREATE TABLE ficha_atendimento(
    id INT CONSTRAINT pk_ficha_atendimento PRIMARY KEY, 
	permanencia_endereco INT,
	estado_civil VARCHAR(50),
	possui_deficiencia BOOLEAN DEFAULT FALSE,
	desc_necessidade_especial VARCHAR(100),
	possui_documentacao BOOLEAN DEFAULT TRUE,
    desc_documentacao VARCHAR(50),
	nome_familiar VARCHAR(50),
	ocupacao_familiar VARCHAR(50),
	escolaridade_familiar VARCHAR(50),
	idade_familiar INT,
	renda_familiar FLOAT,
	quantidade_familiares INT, -- campo calculado --
	renda_media_familiar FLOAT, -- campo calculado --
	renda_total_familiar FLOAT, -- campo calculado --
	trabalha BOOLEAN DEFAULT FALSE,
	quanto_ganha FLOAT,
	situacao_trabalho VARCHAR(50),
	recebe_beneficio BOOLEAN DEFAULT FALSE,
	desc_beneficio VARCHAR(50),
	nome_programa VARCHAR(50),
	valor_programa FLOAT,
	quantidade_programa INT, -- campo calculado --
	valor_total_programa FLOAT, -- campo calculado --
	nome_despesa VARCHAR(50),
	valor_despesa FLOAT,
	total_despesa FLOAT, -- campo calculado --
	tempo_cidade INT,
	situacao_residencia VARCHAR(50),
	tipo_residencia VARCHAR(50),
	numero_comodos INT,
	cidade_anterior VARCHAR(50),
	id_informacao_saude INT,
	tratamento_psiquiatrico BOOLEAN DEFAULT FALSE,
	desc_tratamento_psiquiatrico VARCHAR(50),
	acompanhamento_psicologico BOOLEAN DEFAULT FALSE,
	desc_acompanhamento_psicologico VARCHAR(50),
	deficiente_familiar BOOLEAN DEFAULT FALSE,
	desc_deficiente_familiar VARCHAR(50),
	plano_de_saude BOOLEAN DEFAULT FALSE,
	desc_plano_de_saude VARCHAR(50),
	medida_de_protecao BOOLEAN DEFAULT FALSE,
	desc_medida_protecao VARCHAR(100),
	medida_socio_educativa BOOLEAN DEFAULT FALSE,
	desc_quando_cumpriu_medida_socio_educativa VARCHAR(50),
	desc_sobre_medida_socio_educativa VARCHAR(100),
	desc_referencias VARCHAR(200),
	notas_servico_social VARCHAR(500),
    tec_resposavel VARCHAR(50),
    id_estudante INT,

    CONSTRAINT fk_informacao_saude FOREIGN KEY (id_informacao_saude) REFERENCES informacao_saude(id),
    CONSTRAINT fk_estudante_ficha_cadastro FOREIGN KEY (id_estudante) REFERENCES estudante(id)  
);

CREATE SEQUENCE seq_ficha_atendimento
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY ficha_atendimento.id;

ALTER TABLE ficha_atendimento ALTER COLUMN id SET DEFAULT NEXTVAL('seq_ficha_atendimento');


/*************************** Inserção mercado de trabalho ***************************/

CREATE TABLE insercao_mercado_trabalho(
	id INT CONSTRAINT pk_insercao_mercado_trabalho PRIMARY KEY,
	id_contato_estudante INT, 
	mes_ano_inicio DATE,
	mes_ano_fim DATE,
	nome_empresa VARCHAR(50),
	endereco_empresa VARCHAR(50),
	bairro_empresa VARCHAR(50),
	cidade_empresa VARCHAR(50),
	uf_empresa VARCHAR(2),
	empresa_meio_nautico BOOLEAN DEFAULT FALSE,
	nome_representante_empresa VARCHAR(50),
	cargo_representante_empresa VARCHAR(50),
	telefone_empresa VARCHAR(50),
	email_empresa VARCHAR(50),
	area_atuacao_estudante VARCHAR(50),
	cargo_estudante VARCHAR(50),
	tipo_contratacao VARCHAR(50),
	salario_estudante FLOAT,
    id_estudante INT,

    CONSTRAINT fk_contato_estudante FOREIGN KEY (id_contato_estudante) REFERENCES contato_estudante(id),
    CONSTRAINT fk_estudante_ficha_cadastro FOREIGN KEY (id_estudante) REFERENCES estudante(id)  
);

CREATE SEQUENCE seq_insercao_mercado_trabalho
    AS INT
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 2147483647
    START 1
    OWNED BY insercao_mercado_trabalho.id;

ALTER TABLE insercao_mercado_trabalho ALTER COLUMN id SET DEFAULT NEXTVAL('seq_insercao_mercado_trabalho');