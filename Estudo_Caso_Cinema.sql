--I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I--

-- Criação das tabelas do Estudo de Caso I Cinemas

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

--I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I--

-- Criação de dados nas tabelas do Estudo de Caso I Cinemas

INSERT INTO Cinemas (cod_cinema, nome, telefone, endereco, cidade, estado) VALUES
	(1, 'The Cosmic View', '7133069856', 'Rua da Lua', 'Itabuna', 'Bahia'),
	(2, 'Cine Retro', '1133024567', 'Av Saudade', 'São Paulo', 'São Paulo'),
	(3, 'SciFi Cine', '9299876543', 'Pr Estrela', 'Manaus', 'Amazonas'),
	(4, 'EcoCine', '4133445566', 'Al Oliveir', 'Curitiba', 'Paraná');

INSERT INTO Salas (cod_cinema, numero_sala, capacidade) VALUES
	-- Salas do Cinema 1 (The Cosmic View)
	(1, 1, 150),
	(1, 2, 150),
	(1, 3, 220),
	(1, 4, 80),

	-- Salas do Cinema 2 (Cine Retro)
	(2, 1, 100),
	(2, 2, 100),
	(2, 3, 120),
	(2, 4, 60),

	-- Salas do Cinema 3 (SciFi Cine)
	(3, 1, 300),
	(3, 2, 250),
	(3, 3, 250),
	(3, 4, 180),

	-- Salas do Cinema 4 (EcoCine)
	(4, 1, 80),
	(4, 2, 80),
	(4, 3, 120),
	(4, 4, 50);

INSERT INTO Horarios (cod_horario, inicio, fim) VALUES
	(1, 0730, 1730),
	(2, 0700, 1930),
	(3, 0900, 2300);

INSERT INTO Estudio (cod_estudio, nome, pais) VALUES
	(1, 'Quirky Productions', 'Brasil'),
	(2, 'Universal Pictures', 'China');

INSERT INTO Atores (cod_ator, nome_ator, pais_ator) VALUES
	(1, 'Leonardo Das Nove', 'Portugual'),
	(2, 'Cillian Murphy', 'Irlanda'),
	(3, 'Florence Pugh', 'Reino Unido'),
	(4, 'Tom e Jerry', 'Holanda'),
	(5, 'Margot Robbie', 'Australia'),
	(6, 'Pedro Mostarda', 'Alemanha'),
	(7, 'Bruno Pipoca', 'Espanha'),
	(8, 'Larissa Lasanha', 'Escócia'),
	(9, 'Vivi Castor', 'Brasil'),
	(10, 'Wagner Moura', 'Brasil');

INSERT INTO Filmes (cod_filme, cod_estudio, nome, censura, diretor, sinopse) VALUES
	(1, 1, 'O Homem do Café Extraforte', 18, 'Leonardo Da Madrugada', 'Homem encontra café extraforte, e o último acaba com tudo')
	(2, 2, 'Inimigos do Despertador', 14, 'Soneca Rodrigues', 'Grupo luta contra o toque das 06:00, mas a bateria nao acaba.'),
	(3, 1, 'A Vinganca do CLT', 12, 'Chefe Sem Noçao', 'Funcionario recebe e-mail sexta as 17:59 e sua mente sabota o PC.'),
	(4, 1, 'Maratona Interminavel', 10, 'Series Da Noite', 'Ele disse que era so mais um episodio, agora ja amanheceu.'),
	(5, 1, 'O Wi-Fi que Sumiu', 16, 'Modem Caido', 'Sinal cai no meio da call mais importante e o desespero reina.'),
	(6, 2, 'O Ultimato da Dieta', 0, 'Nutri Braba', 'Segunda-feira comeca o plano, mas a coxinha da esquina chama mais forte.'),
	(7, 1, 'Fatura do Apocalipse', 18, 'Cartao Estourado', 'O jovem abre o aplicativo do banco e descobre que gastou o que nao tinha.'),
	(8, 2, 'Audio de 5 Minutos', 14, 'Amigo Falador', 'Um homem recebe um podcast no WhatsApp e tenta ouvir na velocidade 2x.'),
	(9, 2, 'Agua no Xampu', 10, 'Mao de Vaca', 'O frasco estava no fim, ele botou agua e criou um monstro infinito.'),
	(10, 2, 'O Encontro das Meias', 0, 'Maquina de Lavar', 'Uma meia esquerda viaja pelo portal da maquina para achar seu par.'),
	(11, 1, 'Estacionando de Primeira', 12, 'Barbeiro Alerta', 'Motorista tenta vaga apertada sob o olhar julgador de dez pedestres.'),
	(12, 1, 'Panela de Pressao Assassina', 16, 'Cozinheiro Medroso', 'O pino comeca a chiar e o jovem corre para a sala com medo de explodir.'),
	(13, 1, 'Vizinho do Furador', 14, 'Furadeira Das Oito', 'Um homem tenta dormir no domingo, mas o vizinho comprou uma ferramenta nova.'),
	(14, 2, 'Gato do Meio da Noite', 10, 'Bichano Atrevido', 'Humano dorme e o felino decide derrubar um copo de vidro na cozinha.'),
	(15, 2, 'Esqueci a Senha', 12, 'Mente Branca', 'Ele tenta redefinir a senha e o sistema diz que a nova nao pode ser igual a antiga.');

INSERT INTO Sessao (cod_cinema, cod_filme, numero_sala, cod_horario, preco, qtd_ingressos, qtd_vendidos) VALUES
	-- Cinema 1 (The Cosmic View)
	(1, 1, 1, 1, 25.00, 100, 45), (1, 2, 1, 2, 25.00, 100, 80), (1, 3, 1, 3, 28.00, 100, 20),
	(1, 4, 2, 1, 25.00, 120, 60), (1, 5, 2, 2, 25.00, 120, 95), (1, 6, 2, 3, 28.00, 120, 40),
	(1, 7, 3, 1, 25.00, 150, 70), (1, 8, 3, 2, 25.00, 150, 110), (1, 9, 3, 3, 28.00, 150, 130),
	(1, 10, 4, 1, 25.00, 80, 25), (1, 11, 4, 2, 25.00, 80, 50), (1, 12, 4, 3, 28.00, 80, 78),

	-- Cinema 2 (Cine Retro)
	(2, 13, 1, 1, 22.00, 100, 30), (2, 14, 1, 2, 22.00, 100, 55), (2, 15, 1, 3, 26.00, 100, 90),
	(2, 1, 2, 1, 22.00, 100, 12),  (2, 3, 2, 2, 22.00, 100, 48),  (2, 5, 2, 3, 26.00, 100, 85),
	(2, 2, 3, 1, 22.00, 120, 60),  (2, 4, 3, 2, 22.00, 120, 72),  (2, 6, 3, 3, 26.00, 120, 100),
	(2, 7, 4, 1, 22.00, 60, 15),   (2, 8, 4, 2, 22.00, 60, 40),   (2, 9, 4, 3, 26.00, 60, 58),

	-- Cinema 3 (SciFi Cine)
	(3, 10, 1, 1, 30.00, 200, 120), (3, 11, 1, 2, 30.00, 200, 180), (3, 12, 1, 3, 35.00, 200, 195),
	(3, 13, 2, 1, 30.00, 150, 45),  (3, 14, 2, 2, 30.00, 150, 90),  (3, 15, 2, 3, 35.00, 150, 140),
	(3, 1, 3, 1, 30.00, 150, 85),   (3, 2, 3, 2, 30.00, 150, 110),  (3, 4, 3, 3, 35.00, 150, 125),
	(3, 3, 4, 1, 30.00, 100, 40),   (3, 5, 4, 2, 30.00, 100, 75),   (3, 7, 4, 3, 35.00, 100, 90),

	-- Cinema 4 (EcoCine)
	(4, 6, 1, 1, 20.00, 80, 22),  (4, 8, 1, 2, 20.00, 80, 50),  (4, 9, 1, 3, 24.00, 80, 75),
	(4, 11, 2, 1, 20.00, 80, 35), (4, 12, 2, 2, 20.00, 80, 60), (4, 14, 2, 3, 24.00, 80, 79),
	(4, 15, 3, 1, 20.00, 120, 45), (4, 2, 3, 2, 20.00, 120, 80), (4, 3, 3, 3, 24.00, 120, 110),
	(4, 5, 4, 1, 20.00, 50, 15),  (4, 1, 4, 2, 20.00, 50, 30),  (4, 13, 4, 3, 24.00, 50, 48);

--I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I=====I--

-- Questão 1
SELECT DISTINCT
	f.nome AS "Nome do Filme",
	f.censura AS "Censura"

	FROM Sessao AS s
	JOIN Filmes AS f ON s.cod_filme = f.cod_filme
	WHERE s.cod_cinema = 1
	ORDER BY f.nome ASC;

-- Questão 2
SELECT DISTINCT
	c.cod_cinema AS "Código",
	c.nome AS "Nome do Cinema",
	f.nome AS "Nome do Filme",
	f.censura AS "Censura"

	FROM Sessao AS s
	JOIN Filmes AS f ON s.cod_filme = f.cod_filme
	JOIN Cinemas AS c ON s.cod_cinema = c.cod_cinema
	WHERE s.cod_cinema = 2 OR s.cod_cinema = 4
	ORDER BY c.nome DESC;






