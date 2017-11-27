CREATE DATABASE 404
GO

USE 404
GO

CREATE TABLE Disciplina
(
	carga_horaria TINYINT
	,teoria		  DECIMAL(3)
	,pratica	  DECIMAL(3)
	,ementa				 VARCHAR(5000)
	,competencias		 VARCHAR(2000)
	,habilidades		 VARCHAR(1000)
	,conteudo			 VARCHAR(300)
	,bibliografia_basica VARCHAR(1000)
	,bibliografia_complementar VARCHAR(1000)
	,nome VARCHAR (240) NOT NULL
	,CONSTRAINT PKDisciplina PRIMARY KEY (nome)
);

CREATE TABLE Curso
(
	Sigla VARCHAR(5) NOT NULL
	,Nome VARCHAR(50) NOT NULL
	,CONSTRAINT pkCurso PRIMARY KEY (Sigla)
	,CONSTRAINT uqNome UNIQUE (Nome)
);

CREATE TABLE GradeCurricular
(
	Sigla_curso VARCHAR(5)
	,Ano SMALLINT NOT NULL
	,Semestre CHAR(1) NOT NULL
    ,CONSTRAINT pkGradeCurricular  PRIMARY KEY(Ano,Semestre,sigla_curso)
	,CONSTRAINT fkGradeCurricularCurso   FOREIGN KEY(Sigla_curso) REFERENCES Curso(Sigla)
);

CREATE TABLE Periodo
(
    Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero TINYINT NOT  NULL
	,CONSTRAINT pkPeriodo        PRIMARY KEY (numero,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoGrade   FOREIGN KEY (Ano_grade, Semestre_grade,sigla_curso) REFERENCES GradeCurricular(Ano, Semestre,sigla_curso)
);

CREATE TABLE PeriodoDisciplina 
(
	Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero_periodo TINYINT
	,Nome_disciplina VARCHAR(240)
	,CONSTRAINT pkPeriodoDisciplina  PRIMARY KEY (numero_periodo,Nome_disciplina,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoDisciplinaPeriodo      FOREIGN KEY (numero_periodo,sigla_curso,ano_grade,semestre_grade)  REFERENCES Periodo(numero,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoDisciplinaDisciplina   FOREIGN KEY (Nome_disciplina ) REFERENCES Disciplina(Nome)
);

CREATE  TABLE DisciplinaOfertada
(
	nome_disciplina VARCHAR(240)
	,ano SMALLINT NOT NULL
	,semestre CHAR(1) NOT NULL
	,CONSTRAINT pkDisciplinaOfertada PRIMARY KEY (ano,semestre,nome_disciplina)
	, CONSTRAINT fkDisciplinaOfertadaDisciplina FOREIGN KEY (nome_disciplina) REFERENCES Disciplina (nome)
);

CREATE TABLE  Professor
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome VARCHAR (120) NOT NULL
	,Email VARCHAR (80) NOT NULL
	,celular CHAR(11) NULL
	,apelido VARCHAR NOT NULL
	,CONSTRAINT PKProfessor PRIMARY KEY (ra)
	,CONSTRAINT UQapelido UNIQUE (apelido)
);

CREATE TABLE Turma
(
	ra_professor INT
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id CHAR(1) NOT NULL
	,turno VARCHAR (15) NOT NULL
	,CONSTRAINT PKTurma PRIMARY KEY (id,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkTurmaProfessor FOREIGN KEY(ra_professor) REFERENCES professor(ra)
	,CONSTRAINT fkTurmaDisciplinaOfertada FOREIGN KEY(ano_ofertado,semestre_ofertado,nome_disciplina) REFERENCES DisciplinaOfertada (ano, semestre,nome_disciplina)
);

CREATE TABLE CursoTurma
(
	sigla_curso VARCHAR(5)
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,CONSTRAINt pkCursoTurma PRIMARY KEY (id_turma, sigla_curso,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkCursoTurmaCurso FOREIGN KEY(sigla_curso) REFERENCES Curso(sigla)
	,CONSTRAINT fkCursoTurmaTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado) REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
);

CREATE TABLE Aluno
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome	 VARCHAR(120) NOT NULL
	,Email  VARCHAR(80) NOT NULL
	,celular     CHAR(11) NULL
	,sigla_Curso VARCHAR(5)
	,CONSTRAINT pkAluno PRIMARY KEY (ra)
	,CONSTRAINT fkAlunoCurso FOREIGN KEY(sigla_curso) REFERENCES curso(sigla)
);

CREATE TABLE Matricula
(
	ra_aluno INT
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_Turma CHAR(1)
	,CONSTRAINT pkMatricula PRIMARY KEY (ra_aluno, id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkMatriculaTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado) REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkMatriculaAluno FOREIGN KEY(ra_aluno) REFERENCES Aluno(ra)
);

CREATE TABLE Questao
(
	nome_Disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma          CHAR(1)
	,numero INT	NOT NULL
	,data_limite_entrega DATE NOT NULL
	,descricao VARCHAR(500) NULL
	,data1 DATE  NOT NULL
	,CONSTRAINT pkQuestao PRIMARY KEY (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkQuestaoTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)  REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
);

CREATE TABLE ArquivosQuestao
	(
	nome_disciplina VARCHAR (240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,arquivo VARCHAR(500) NOT NULL
	,CONSTRAINT pkArquivosQuestao PRIMARY KEY (arquivo,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkArquivoQuestaoQuestao FOREIGN KEY (numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)  REFERENCES Questao (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
);

CREATE TABLE Resposta
(
	nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,numero_questao INT
	,ra_aluno INT
	,data_avaliacao DATE NOT NULL
	,nota DECIMAL (4,2) NOT NULL
	,avaliacao VARCHAR(100) NOT NULL
	,descricao VARCHAR(100) NULL
	,data_de_envio DATE NOT NULL
	,CONSTRAINT pkResposta PRIMARY KEY (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkRespostaQuestao      FOREIGN KEY (numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)    REFERENCES Questao (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkRespostaAluno FOREIGN KEY(ra_aluno) REFERENCES Aluno(ra)
);
CREATE TABLE ArquivosResposta
(
	nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,numero_questao INT
	,ra_aluno INT
	,arquivo VARCHAR(500) NOT NULL
	,CONSTRAINT pkArquivosResposta PRIMARY KEY (arquivo,ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkArquivoRespostaResposta  FOREIGN KEY (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)   REFERENCES Resposta (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
);
-- INSERTS NAS TABDELAS

INSERT INTO Disciplina(nome,carga_horaria,teoria,pratica,ementa,competencias,habilidades,conteudo, bibliografia_basica, bibliografia_complementar)
VALUES ('Engenharia de Software',80,20,60,'Introdução a algoritmos. Conceitos de programação estruturada. Tipos, variáveis,
expressões. Estruturas de controle de fluxo. Vetores e matrizes. Funções','Entender os Requisitos Mínimos','Habilidade no efeitp cascata','Conteúdo diário'
,'MANZANO, J. A.; OLIVEIRA, J.F.; Algoritmos – Lógica para Desenvolvimento de Programação de Computadores. 22ª. Edição. São Paulo: Érica, 2009.'
,'VILARIM, GILVAN, Algoritmos – Programação para Iniciantes. Ciência Moderna, Rio de Janeiro, 2004')
		,('TecWeb',70,30,40,'aContainers, Servlets e Java Server Pages (JSP).
		   Frameworks de aplicação MVC. Acesso a banco de dados com JDBC. Frameworks de persistência objeto-relacional.'
		   ,'Este profissional irá valer-se de conceitos e técnicas de informática, bem como das teorias de sistemas com foco em contribuir na solução de problemas de  tratamento  de  informações  nas  organizações'
		   ,' conceitos e técnicas de informática, bem como das teorias de sistemas com vistas a contribuir na solução de problemas de tratamento de informações nas organizações, através do planejamento, desenvolvimento, implementação e manutenção de modelos '
		   ,'Prático','GONÇALVES, E. Desenvolvendo Aplicações Web com JSP,
SERVELTS, JAVASERVER FACES, HIBERNATE, EJB 3 PERSISTANCE E AJAX; Rio de Janeiro: Ciência Moderna, 2007.'
,'2BIBLI == HALL, M., Core Servlets and JSP. 2a. edição. Prentice Hall, 2003.')
		,('DevOps',70,30,40,'Comportamento grupal, trabalho em equipe, motivação nas organizações, liderança, poder e influência.
Mudanças tecnológicas na contemporaneidade e seus efeitos nas relações interpessoais.'
		,'Comprove sua capacidade para cumprir as metas de desempenho,
	      treinar pessoas e colocar em uso seu conhecimento sobre o produto.'
		  ,'Coloque seu conhecimento sobre o produto à prova sendo aprovado nos exames e avaliações.'
		  ,'conseguirá optimizar a equipa de desenvolvimento da sua empresa e rapidamente ver o retorno do investiment'
		  ,'ROBBINS, S. P. , Comportamento Organizacional, 11ed. São Paulo: Pearson Prentice Hall, 2005.'
,'O´BRIEN, James. Sistemas de informação e as decisões gerenciais na era da Internet. São Paulo: Saraiva, 2003.')
		,('Linguagem da Programação II',60,30,40,'Estudo de uma linguagem de programação voltada para a
internet; Conceitos básicos de programação cliente/servidor;
Noções gerais de programação orientada a objetos; Noções gerais
de Sistemas Gerenciadores de Bancos de Dados; Implementações
em laboratório.','– PROGRAMAÇÃO PARA WEB1.1. Noções básicas de programação para web;1.2. programação client side versus server side;1.3. noções básicas de HTML;
1.4. Introdução a programação em PHP:1.4.1. Extensão de arquivos;1.4.2. Comandos de saída;1.4.3. Variáveis;1.4.4. Tipos de dados;1.4.5. Constantes;'
		,'2.1. Classe Objeto Construtores e destrutores Herança; Polimorfismo; Abstração. Encapsulamento; Membros de classe;'
		,'Prática'
		,'1. DALL’OGLIO, Pablo. PHP – PROGRAMANDO COM
ORIENTAÇÃO A OBJETOS. NOVATEC. 2ª Ed.
2. SILVA, Maurício Samy. CRIANDO SITES COM HTML.
NOVATEC. '
		,'SINTES, Anthony. APRENDA PROGRAMAÇÃO ORIENTADA
A OBJETOS EM 21 DIAS. Editora MAKRON.')
		,('SQL',70,30,40,'Conceitos Básicos. Componentes de Sistemas Gerenciadores de Bancos de Dados. Modelagem Conceitual de Dados. Modelo Relacional. Restrições de Integridade,
Dependência Funcional. Noções de Álgebra e Cálculo Relacional. Formas Normais. Linguagem SQL Básica. Visões e Índices.'
		,'Alguns dos principais comandos SQL para manipulação de dados são: INSERT (inserção), SELECT (consulta), UPDATE (atualização), DELETE (exclusão). SQL possibilita ainda a criação de relações entre tabelas e o controle do acesso aos dados'
		,'A linguagem SQL surgiu em 1974 e foi desenvolvida nos laboratórios da IBM como interface para o Sistema Gerenciador de Banco de Dados Relacional (SGBDR) denominado SYSTEM R. Esse sistema foi criado com base em um artigo de 1970 escrito por Edgar F. Codd.'
		,'Prático','HEUSER, C.A.; Projeto de Banco de Dados. 6a edição. Série Livros Didáticos – Instituto de Informática da UFRGS, número 4. Editora Bookman, 2009.'
		,'KORTH, H. F.; SUDARSHAN, S; SILBERCHATZ, A. Sistema de Banco de Dados. 5a edição. Editora Campus, 2006');
select * from disciplina

INSERT INTO Curso(Sigla,Nome)
VALUES ('SI','Sistema de Informação')
	  ,('ADS' ,'Análise e Desenvolvimento de Sistemas')
	  ,('BD' ,'Banco de Dados')
	  ,('SGI' ,'Segurança da Informação');
select * from curso

INSERT INTO GradeCurricular(Sigla_curso,Semestre,Ano)
VALUES ('SI',2,2015)
	  ,('ADS',1,2018)
	  ,('BD',3,2011)
	  ,('SGI',2,2009);
select * from GradeCurricular

INSERT INTO Periodo(Sigla_curso,Ano_grade,Semestre_grade,numero)
VALUES('SI',2015,2,8)
	 ,('ADS',2018,1,7)
	 ,('BD',2011,3,3)
	 ,('SGI',2009,2,5);
select * from Periodo

INSERT INTO PeriodoDisciplina(Sigla_curso,Ano_grade,Semestre_grade,numero_periodo,Nome_disciplina)
VALUES
	  ('SI'  ,2015,'2',8,'TecWeb')
	  ,('SI'  ,2015,'2',8,'DevOps')
	  ,('SI'  ,2015,'2',8,'Linguagem da Programação II')
	  ,('SI'  ,2015,'2',8,'SQL')
	  ,('ADS'  ,2018,'1',7,'Engenharia de Software')
	  ,('ADS'  ,2018,'1',7,'TecWeb')
	  ,('ADS'  ,2018,'1',7,'DevOps')
	  ,('ADS'  ,2018,'1',7,'Linguagem da Programação II')
	  ,('ADS'  ,2018,'1',7,'SQL')
	  ,('BD'  ,2011,'3',3,'Engenharia de Software')
	  ,('BD'  ,2011,'3',3,'TecWeb')
	  ,('BD'  ,2011,'3',3,'DevOps')
	  ,('BD'  ,2011,'3',3,'Linguagem da Programação II')
	  ,('BD'  ,2011,'3',3,'SQL')
	  ,('SGI'  ,2009,'2',5,'Engenharia de Software')
	  ,('SGI'  ,2009,'2',5,'TecWeb')
	  ,('SGI'  ,2009,'2',5,'DevOps')
	  ,('SGI'  ,2009,'2',5,'Linguagem da Programação II')
	  ,('SGI'  ,2009,'2',5,'SQL');
select * from PeriodoDisciplina

INSERT INTO DisciplinaOfertada(nome_disciplina,ano,semestre)
VALUES ('Engenharia De Software',2011,1)
		,('TecWeb',2012,2)
		,('DevOps',2013,3)
		,('Linguagem da Programação II',2014,4)
		,('SQL',2015,5);
select * from DisciplinaOfertada

INSERT INTO Professor(nome,Email,celular,apelido) 
VALUES('Sand Onofre','sand.onofre@gmail.com',11965545567,'S') 
	,('Vanderson Gomes Bossi','Vanderson.Bossi@impacta.edu.br',11924567789,'V') 
	,('Osvaldo Kotaro Takai','osvaldo.takai@impacta.edu.br	',11978112245,'T')
	,('Fernando Sequeira Sousa','Fernando.Sousa@impacta.edu.br',11966542311,'F')
	,('Leonardo Massayuki Takuno','Leonardo.Takuno@impacta.edu.br',11934974962,'L')
	,('Edson Tiharu Tsukimoto','Edson.Tsukimoto@impacta.edu.br',11931112993,'E')
	,('Ivair Lima','Ivair.Lima@impacta.edu.br',11924433576,'I');
select * from Professor

INSERT INTO Turma(ra_professor,nome_disciplina,ano_ofertado,semestre_ofertado,id,turno)
VALUES (3,'Engenharia de Software',2011,1,1,'DIURNO')
	  ,(2,'TecWeb',2012,2,2,'DIURNO')
	  ,(4,'DevOps',2013,3,3,'DIURNO')
	  ,(5,'Linguagem da Programação II',2014,4,4,'DIURNO')
	  ,(1,'SQL',2015,5,5,'DIURNO');
select * from Turma

INSERT INTO CursoTurma(sigla_curso,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
VALUES ('SI','Engenharia de Software',2011,'1',1)
	  ,('SI','TecWeb',2012,'2',2)
	  ,('SI','DevOps',2013,'3',3)
	  ,('SI','Linguagem da Programação II',2014,'4',4)
	  ,('SI','SQL',2015,'5',5)
	  ,('ADS','Engenharia de Software',2011,'1',1)
	  ,('ADS','TecWeb',2012,'2',2)
	  ,('ADS','DevOps',2013,'3',3)
	  ,('ADS','Linguagem da Programação II',2014,'4',4)
	  ,('ADS','SQL',2015,'5',5)
	  ,('BD','Engenharia de Software',2011,'1',1)
	  ,('BD','TecWeb',2012,'2',2)
	  ,('BD','DevOps',2013,'3',3)
	  ,('BD','Linguagem da Programação II',2014,'4',4)
	  ,('BD','SQL',2015,'5',5)
	  ,('SGI','Engenharia de Software',2011,'1',1)
	  ,('SGI','TecWeb',2012,'2',2)
	  ,('SGI','DevOps',2013,'3',3)
	  ,('SGI','Linguagem da Programação II',2014,'4',4)
	  ,('SGI','SQL',2015,'5',5);
select * from CursoTurma

INSERT INTO Aluno(nome,email,celular,sigla_Curso)
VALUES ('Diego constantino','dsconsta@gmail.com',11956890356,'ADS')
	  ,('Henrique Estevão','henriqueestevao@outlook.com ',11912328756,'ADS')
	  ,('Leonardo Negreiros','leonardo.negreiros@gmail.com ',11937659735,'SI')
	  ,('Matheus Scotini Rozario ','Matheusscotini@outlook.com  ',11922446587,'ADS')
select * from Aluno

INSERT INTO Matricula(ra_aluno,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
VALUES (1,'Engenharia de Software',2011,1,1)
	,(2,'Engenharia de Software',2011,1,1)
	,(3,'Engenharia de Software',2011,1,1)
	,(4,'Engenharia de Software',2011,1,1)
	,(1,'TecWeb',2012,2,2)
	,(2,'TecWeb',2012,2,2)
	,(3,'TecWeb',2012,2,2)
	,(4,'TecWeb',2012,2,2)
	,(1,'Devops',2013,3,3)
	,(2,'Devops',2013,3,3)
	,(3,'Devops',2013,3,3)
	,(4,'Devops',2013,3,3)
	,(1,'Linguagem da Programação II',2014,4,4)
	,(2,'Linguagem da Programação II',2014,4,4)
	,(3,'Linguagem da Programação II',2014,4,4)
	,(4,'Linguagem da Programação II',2014,4,4)
	,(1,'SQL',2015,5,5)
	,(2,'SQL',2015,5,5)
	,(3,'SQL',2015,5,5)
	,(4,'SQL',2015,5,5);
select * from Matricula

INSERT INTO Questao(nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero,data_limite_entrega,descricao,data1)
VALUES ('Engenharia de Software',2011,1,1,2,'2016-11-28','Projeto de Banco de Dados - Professor: Sand','2016-12-11')
	   ,('TecWeb',2012,2,2,3,'2015-10-25','Projeto Programação - Professor: Leonardo Takuno','2015-12-10')
	   ,('DevOps',2013,3,3,4,'2014-9-12','Trabalhando Com Area Restrita - Professor: Vanderon','2014-12-10')
	   ,('Linguagem da Programação II',2014,4,4,5,'2017-10-22','Projeto Activia - Professor: Vanderson','2017-11-2')
	   ,('SQL',2015,5,5,6,'2016-10-22','Projeto Activia - Professor: Vanderson','2016-11-2');
select * from Questao

INSERT INTO ArquivosQuestao(arquivo,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
VALUES ('Arquivo encontra-se no Maverick ou na SmartClass',2,1,'Engenharia de Software',2011,1)
      ,('Arquivo encontra-se no Maverick ou na SmartClass',3,2,'TecWeb',2012,2)
	  ,('Arquivo encontra-se no Maverick ou na SmartClass',4,3,'DevOps',2013,3)
	  ,('Arquivo encontra-se no Maverick ou na SmartClass',5,4,'Linguagem da Programação II',2014,4)
	  ,('Arquivo encontra-se no Maverick ou na SmartClass',6,5,'SQL',2015,5);
select * from ArquivosQuestao

INSERT INTO Resposta(ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado,data_avaliacao,nota,avaliacao,descricao,data_de_envio)
VALUES (1,2,1,'Engenharia de Software',2011,1,'2017-11-29',9.5,'Bom Aluno','Prova prática de BD utilizando o SSMS','2017-12-02')
	,(2,3,2,'TecWeb',2012,2,'2007-11-29',9.5,'Bom Aluno','Prova prática de SI utilizando o C#','2017-12-02')
	,(3,4,3,'DevOps',2013,3,'2017-11-29',8.5,'Rasoável Aluno','Prova prática de ADS utilizando o Linux com C++','2017-12-02')
	,(4,5,4,'Linguagem da Programação II',2014,4,'2017-11-29',7.5,'Bom Aluno','Prova prática de Hardware utilizando Ferramentas','2017-12-02')
	,(5,6,5,'SQl',2015,5,'2017-11-29',7.5,'Bom Aluno','Prova prática de Hardware utilizando Ferramentas','2017-12-02');
select * from Resposta

INSERT INTO ArquivosResposta(arquivo,ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
VALUES ('Arquivo Avaliado',1,2,1,'Engenharia de Software',2011,1)
	,('Arquivo Avaliado',2,3,2,'TecWeb',2012,2)
	,('Arquivo Avaliado',3,4,3,'DevOps',2013,3)
	,('Arquivo Avaliado',4,5,4,'Linguagem da Programação II',2014,4)
	,('Arquivo Avaliado',5,6,5,'SQL',2015,5);
select * from ArquivosResposta


	-- SELECTS --


SELECT 	D.nome AS 'Disciplina'
	,D.carga_horaria AS 'Carga Horaria'
	,PD.Sigla_curso AS 'Sigla'
	,PD.Ano_grade AS 'Ano'
	,pd.Semestre_grade AS 'Semestre'
FROM Disciplina AS D JOIN PeriodoDisciplina AS PD ON D.nome = PD.Nome_disciplina

SELECT A.ra AS 'RA'
	,A.nome AS 'Aluno'
	,A.email AS 'E-mail'
	,A.celular AS 'Celular'
	,A.sigla_curso AS 'Sigla'
	,M.nome_disciplina AS 'Matéria'
	,M.ano_ofertado AS 'Ano'
	,M.semestre_ofertado AS 'Semestre'
	,T.id AS 'Identifcação de turma'
	,T.turno AS 'Turno'
	,T.ra_professor AS 'RA do Professor'
FROM Curso AS C Join Aluno AS A ON C.sigla = A.sigla_curso
				Join Matricula AS M ON A.ra = M.ra_aluno
				JOIN Turma AS T AS ON T.id= M.id_turma
WHERE M.nome_disciplina = 'Devops'

SELECT Q.nome_disciplina AS 'Nome da disciplina'
	,Q.ano_ofertado AS 'Ano'
	,Q.semestre_ofertado  AS'Semestre'
	,Q.id_turma     AS    'Turma'
	,Q.numero 	AS    'Número da questão'
	,Q.data_limite_entrega AS 'Data Limite de entrega'
	,T.ra_professor AS 'RA Professor'
	,T.turno AS 'Turno'
FROM Turma AS T JOIN Questao AS Q ON T.id = Q.id_turma

SELECT P.ra AS 'RA do professor'
	,P.apelido AS 'apelido'
	,P.nome AS 'nome'
	,P.email AS 'email'
	,P.celular AS 'Celular'
	,T.nome_disciplina AS 'Nome da disciplina'
	,T.ano_ofertado AS 'Ano'
	,T.semestre_ofertado AS 'semestre'
	,T.turno AS 'Turno'
FROM Professor AS P JOIN Turma AS T ON P.ra = T.ra_professor


SELECT C.sigla AS 'sigla do curso'
	,C.nome AS 'Nome'
	,Per.Ano_grade AS 'Ano'
	,Per.Semestre_grade AS 'Semestre'
FROM Curso AS C JOIN Periodo AS Per ON C.sigla = Per.Sigla_curso
WHERE C.Nome = 'Análise e Desenvolvimento de Sistemas'

SELECT D.nome AS 'Nome da disciplina'
	,D.carga_horaria AS 'Carga horária'
	,D.teoria AS 'Teoria'
	,D.pratica AS 'Prática'
	,D.ementa AS 'Ementa'
	,D.competencias AS 'Competências'
	,D.habilidades AS 'Habilidades'
	,D.conteudo AS 'Conteúdos'
	,D.bibliografia_basica AS 'Bibligrafia Básica'
	,D.bibliografia_complementar AS 'Bibliografia Complementar'
	,M.ra_aluno AS 'RA do aluno'
	,M.ano_ofertado AS 'Ano'
	,M.semestre_ofertado AS 'Semestre'
	,M.id_turma AS 'identificação da turma'
FROM Disciplina AS D JOIN Matricula AS M ON D.nome = M.nome_disciplina
