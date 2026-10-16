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
  	CONSTRAINT fk_salas_cinema
  		FOREIGN KEY (cod_cinema) REFERENCES Cinemas(cod_cinema),
  	CONSTRAINT capacidade_sala
  		CHECK (capacidade BETWEEN 1 AND 350)
);

CREATE TABLE Horarios (
	cod_horario INT PRIMARY KEY NOT NULL,
  	inicio NUMERIC(4,0) NOT NULL,
  	fim NUMERIC(4,0) NOT NULL,
  	CONSTRAINT horario_filme
  		CHECK (
			inicio BETWEEN 0700 AND 2359
			AND fim BETWEEN 0700 AND 2359
			AND MOD(inicio, 100) BETWEEN 0 AND 59
			AND MOD(fim, 100) BETWEEN 0 AND 59
			AND inicio < fim
		)
);

CREATE TABLE Estudio (
	cod_estudio INT PRIMARY KEY NOT NULL,
  	nome VARCHAR(30) NOT NULL,
  	pais VARCHAR(30) NOT NULL
);

CREATE TABLE Filmes (
	cod_filme INT PRIMARY KEY NOT NULL,
  	cod_estudio INT NOT NULL,
	nome VARCHAR(40) NOT NULL,
    censura INT NOT NULL,
	diretor VARCHAR(30) NOT NULL,
	sinopse TEXT,
  	CONSTRAINT fk_filme_estudio
  		FOREIGN KEY (cod_estudio) REFERENCES Estudio(cod_estudio)
);

CREATE TABLE Atores (
	cod_ator INT PRIMARY KEY NOT NULL,
  	nome_ator VARCHAR(30) NOT NULL,
  	pais_ator VARCHAR(20) NOT NULL
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
  	CONSTRAINT fk_cinema_sessao
  		FOREIGN KEY (cod_cinema) REFERENCES Cinemas(cod_cinema),
  	CONSTRAINT fk_filme_sessao
  		FOREIGN KEY (cod_filme) REFERENCES Filmes(cod_filme),
  	CONSTRAINT fk_sessao_sala
    	FOREIGN KEY (cod_cinema, numero_sala) REFERENCES Salas(cod_cinema, numero_sala),
  	CONSTRAINT fk_horario_sessao
  		FOREIGN KEY (cod_horario) REFERENCES Horarios(cod_horario),
  	CONSTRAINT qt_min_ingressos
  		CHECK (qtd_ingressos >= 25),
	CONSTRAINT qt_max_vendidos
		CHECK (
			qtd_vendidos >= 0	
			AND qtd_vendidos <= qtd_ingressos
		),
	CONSTRAINT preco_valido
		CHECK (preco >= 0)
);

CREATE TABLE Elenco (
  	cod_filme INT NOT NULL,
  	cod_ator INT NOT NULL,
  	PRIMARY KEY(cod_filme, cod_ator),
  	CONSTRAINT fk_elenco_filme
  		FOREIGN KEY (cod_filme) REFERENCES Filmes(cod_filme),
  	CONSTRAINT fk_ator_elenco
  		FOREIGN KEY (cod_ator) REFERENCES Atores(cod_ator)
);


