create table Disciplina (
    id int IDENTITY(1,1) not null,
    nome varchar(240) not null,
    carga_horaria tinyint not null,
    teoria decimal(3) not null,
    pratica decimal (3) not null,
    ementa text,
    competencias text,
    habilidades text,
    conteudo text,
    biografia_basica text,
    biografia_complementar text,

    constraint id_disciplina primary key (id),
	 constraint uq_nome unique(nome)
);
go
create table Curso (
    id int IDENTITY(1,1) not null ,
    sigla varchar (5),
    nome varchar (50) not null ,

    constraint pk_curso primary key (id),
    constraint uq_curso unique (nome, sigla)
);
go

create table Professor (
   id int IDENTITY(1,1) not null,
    ra int not null,
    apelido varchar(30) not null,
    nome varchar (120) not null ,
    email varchar(80) not null,
    celular varchar(11),

    constraint pk_professor primary key (id),
    constraint uq_professor unique (apelido,ra)
);
go

create table Aluno (
  	id int IDENTITY(1,1) not null,
	 ra int not null,
	 nome varchar (120) not null ,
	 email varchar (80) not null,
	 celular varchar(11),
	 sigla_curso char(2),

	constraint pk_aluno primary key (id),
	constraint uq_aluno unique (ra),
);
go

create table GradeCurricular (
    id int IDENTITY(1,1) not null,
    ano smallint,
    semestre char(1) not null,
    id_curso int not null,

    constraint pk_gradecurricular primary key (id),
    constraint fk_idCurso foreign key (id_curso) references Curso(id),
    constraint uq_gradecurricular unique (ano, semestre),
);
go

create table Periodo (
	  id int IDENTITY(1,1) not null,
    numero tinyint,
	  id_gradecurricular int not null,

    constraint pk_periodo primary key (id),
    constraint uq_periodo unique(numero),
    constraint fk_periodo foreign key (id_gradecurricular) references GradeCurricular(id),
);
go

create table PeriodoDisciplina (
	id int IDENTITY(1,1) not null,
	id_periodo int not null,
  id_disciplina int not null,

	constraint pk_periododisciplina primary key (id),
	constraint fk_periododisciplina foreign key (id_periodo) references Periodo(id),
  constraint fk_id_disciplina foreign key (id_disciplina) references Disciplina(id),
);
go

create table DisciplinaOfertada (
	id  int IDENTITY(1,1) not null,
	ano smallint,
	semestre char(1),
	id_disciplina int  not null,


	constraint pk_iddisciplinaofertada primary key(id),
	constraint uq_iddisciplinaofertada unique (ano, semestre),
	constraint fk_iddisciplinaofertada foreign key (id_disciplina) references Disciplina(id)
);
go

create table Turma (
	id int IDENTITY(1,1) not null,
	turno varchar(15) not null,
	id_professor int not null,
	id_disciplinaofertada int not null,

	constraint pk_turma primary key(id),
	constraint fk_id_professor foreign key (id_professor) references Professor(id),
	constraint fk_id_disciplinaOfertada foreign key (id_disciplinaofertada) references DisciplinaOfertada(id),
);
go

create table CursoTurma (
	id int IDENTITY(1,1) not null,
	id_turma int not null,
	id_curso int not null,

	constraint pk_cursoturma primary key (id),
	constraint fk_id_curso foreign key (id_curso) references Curso(id),
	constraint fk_id_turma foreign key (id_turma) references Turma(id),
);
go

create table Matricula( /* Pronto */
	id int IDENTITY(1,1) not null,
	id_turma int not null,
	id_aluno  int not null,

	constraint Pk_Matricula primary key (id),
	constraint Fk_matricula_id_turma foreign key (id_turma) references Turma(id),
	constraint Fk_matricula_id_aluno foreign key (id_aluno) references Aluno(id),
);
go

create table Questao (
  id int IDENTITY(1,1) not null,
	numero int not null,
	data_limite_entrega date,
	descricao text,
	data date,
  id_turma int not null,

  constraint pk_questao primary key (id),
  constraint fk_questao_id_turma foreign key (id_turma) references Turma(id),
	constraint uq_questao unique (numero)
);
go

create table ArquivosQuestao (
  id int IDENTITY(1,1) not null,
	arquivo varchar(500) not null,
  id_questao int not null,

  constraint pk_arquivosquestao primary key (id),
	constraint uq_arquivosquestao unique (arquivo),
	constraint fk_arquivosquestao foreign key (id_questao) references Questao(id),

);
go

create table Resposta (
  id int IDENTITY(1,1) not null,
  ra_aluno int not null,
	data_avaliacao date,
	nota decimal(4,2),
	avaliacao text,
	descricao text,
	data_de_envio date,
	id_questao int not null,

	constraint uq_resposta unique (ra_aluno),
	constraint pk_repsosta primary key (id),
  constraint fk_resposta foreign key (id_questao) references Questao(id),
);
go

create table arquivosresposta (
    id int IDENTITY(1,1) not null,
	arquivo varchar(500),
    id_resposta int not null,

	constraint uq_arquivosresposta unique (arquivo),
	constraint fk_arquivosreposta foreign key (id_resposta) references Resposta(id),
	constraint pk_arquivosresposta primary key (id)
);
go	

create table usuario(
	id int IDENTITY(1,1) not null,
	ra int not null,
	perfil char(1),
	nome varchar(150) not null,
	celular char(11),
	ativo bit not null default 1,

	constraint pk_usuario primary key (id),
	constraint uq_usuario unique (ra)
);
go
