CREATE TABLE Cinemas (
  	cod_cinema INT PRIMARY KEY NOT NULL,
  	nome VARCHAR(30) NOT NULL,
  	telefone CHAR(10) NOT NULL,
  	endereco CHAR(10) NOT NULL,
  	cidade CHAR(10) NOT NULL,
 	estado CHAR(10) NOT NULL
);
  
CREATE TABLE Salas (
 	cod_cinema INT NOT NULL,
    numero_sala INT NOT NULL,
    capacidade INT NOT NULL,
  	PRIMARY KEY (cod_cinema, numero_sala),
  	CONSTRAINT fk_cinema
  		FOREIGN KEY (cod_cinema) REFERENCES Cinemas(cod_cinema),
  	CONSTRAINT capacidade_sala
  		CHECK (capacidade >= 0 AND capacidade <= 350)
);
  
CREATE TABLE Sessao (
	cod_cinema INT NOT NULL,
	cod_filme INT NOT NULL,
  	numero_sala INT NOT NULL,
  	cod_horario INT NOT NULL,
  	preco DECIMAL(5,2) NOT NULL,
  	qtd_ingressos INT NOT NULL,
  	qtd_vendidos INT NOT NULL,
  	PRIMARY KEY(cod_cinema, cod_filme, numero_sala, cod_horario),
  	CONSTRAINT fk_cinema
  		FOREIGN KEY (cod_cinema) REFERENCES Cinemas(cod_cinema),
  	CONSTRAINT fk_filme
  		FOREIGN KEY (cod_filme) REFERENCES Filmes(cod_filme),
  	CONSTRAINT fk_sala
  		FOREIGN KEY (numero_sala) REFERENCES Salas(cod_cinema, numero_sala),
  	CONSTRAINT fk_horario
  		FOREIGN KEY (cod_horario) REFERENCES Horarios(cod_horario),
  	CONSTRAINT qt_max_ingressos
  		CHECK (qtd_ingressos >= 25)
);

CREATE TABLE Horarios (
	cod_horario INT PRIMARY KEY NOT NULL,
  	inicio NUMERIC(4,0) NOT NULL,
  	fim NUMERIC(4,0) NOT NULL,
  	CONSTRAINT horario_filme
  		CHECK (inicio >= 0700 AND fim <= 2359)
);

CREATE TABLE Filmes (
	cod_filme INT PRIMARY KEY NOT NULL,
  	cod_estudio INT NOT NULL,
  	CONSTRAINT fk_estudio
  		FOREIGN KEY (cod_estudio) REFERENCES Estudio(cod_estudio)
);

CREATE TABLE Estudio (
	cod_estudio INT PRIMARY KEY NOT NULL,
  	nome VARCHAR(30) NOT NULL,
  	pais VARCHAR(30) NOT NULL
);

CREATE TABLE Elenco (
  	cod_filme INT NOT NULL,
  	cod_ator INT NOT NULL,
  	PRIMARY KEY(cod_filme, cod_ator),
  	CONSTRAINT fk_filme
  		FOREIGN KEY (cod_filme) REFERENCES Filmes(cod_filme),
  	CONSTRAINT fk_ator
  		FOREIGN KEY (cod_ator) REFERENCES Atores(cod_ator)
);

CREATE TABLE Atores (
	cod_ator INT PRIMARY KEY NOT NULL,
  	nome_ator VARCHAR(30) NOT NULL,
  	pais_ator VARCHAR(20) NOT NULL
);
