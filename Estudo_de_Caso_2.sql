-- CREATE DATABASE cbf_uneb;

-- USE cbf_uneb;

----- Contexto -----

-- Este estudo de caso descreve um pequeno sistema imaginário da Confederação Brasileira de Futebol.
-- Com informação de Federações estaduais, times filiados às federações e seus respectivos jogadores.
  
----- Questão 1:	Criação das tabelas respeitando as restrições impostas pela Confederação -----

-- Criação da Tabela Federacao
-- DROP TABLE FEDERACAO;
CREATE TABLE FEDERACAO (
	cod_fed INT NOT NULL,
	descricao VARCHAR(30) NOT NULL,
    uf CHAR(2) NOT NULL,
	telefone VARCHAR(10),
	CONSTRAINT chaveP_federacao PRIMARY KEY(cod_fed), -- Chave primária
	CONSTRAINT fed_uf UNIQUE(uf) -- Para restringir federação a um estado
);

-- Criação da Tabela Clube
CREATE TABLE CLUBE (
    cod_clube INT NOT NULL,
	  cod_fed INT NOT NULL,
	  nome VARCHAR(30) NOT NULL,
	  telefone VARCHAR(10),
	  data_fundacao DATETIME,
  	CONSTRAINT chaveP_clube PRIMARY KEY(cod_clube, cod_fed), -- Chave primária composta
  	CONSTRAINT chaveE_clube_fed FOREIGN KEY(cod_fed) -- Chave estrangeira
		    REFERENCES federacao(cod_fed)
);

-- Criação da Tabela Jogador
CREATE TABLE JOGADOR (
	  cod_jog INT NOT NULL,
	  cod_clube INT NOT NULL,
  	cod_fed INT NOT NULL,
  	nome VARCHAR(30) NOT NULL,
  	dat_nasc DATETIME NOT NULL,
  	sexo CHAR(1),
  	cidade_nasc VARCHAR(20) NOT NULL,
  	salario NUMERIC(8, 2),
  	CONSTRAINT chaveP_jogador PRIMARY KEY(cod_jog), -- Chave primária
  	CONSTRAINT chaveE_jog_clube FOREIGN KEY(cod_clube, cod_fed) -- Chave estrangeira composta
	    	REFERENCES clube(cod_clube, cod_fed),
  	CONSTRAINT checar_salarioJog CHECK(salario >= 5000.00) -- Checar salário para atender restrição de salário mínimo de R$ 5.000,00
);

----- Questão 2:	Inserção de 4 federações estaduais (BA, SP, RJ, MG), 2 times em cada federação e 11 jogadores em cada time inserido. -----

-- Inserção das 4 federações estaduais
INSERT INTO federacao(cod_fed, descricao, uf, telefone) VALUES
    (1, 'Federação Baiana', 'BA', '7133000000'),
    (2, 'Federação Paulista', 'SP', '1133000000'),
    (3, 'Federação Carioca', 'RJ', '2133000000'),
    (4, 'Federação Mineira', 'MG', '3133000000');

-- Inserção dos times por unidade federativa (estado)
INSERT INTO clube(cod_clube, cod_fed, nome, telefone, data_fundacao) VALUES
    -- Clubes relacionados à Federação Baiana (1)
    (1, 1, 'Bahia', '7133000001', '1931-01-01 08:30:00'),
    (2, 1, 'Vitória', '7133000002', '1899-05-13 14:15:00'),
    -- Clubes relacionados à Federação Paulista (2)
    (1, 2, 'São Paulo', '1133000001', '1930-01-25 10:00:00'),
    (2, 2, 'Mirassol', '1133000002', '1925-11-09 16:45:00'),
    -- Clubes relacionados à Federação Carioca (3)
    (1, 3, 'Flamengo', '2133000001', '1895-11-15 09:20:00'),
    (2, 3, 'Fluminense', '2133000002', '1902-07-21 15:10:00'),
    -- Clubes relacionados à Federação Mineira (4)
    (1, 4, 'Cruzeiro', '3133000001', '1921-01-02 11:00:00'),
    (2, 4, 'Atlético Mineiro', '2133000002', '1908-03-25 17:30:00');

-- Inserção dos jogadores por clube
-- ===== FEDERAÇÃO BAIANA (1) ===== --
-- Jogadores relacionados ao clube do Bahia (1)
INSERT INTO jogador(cod_jog, cod_clube, cod_fed, nome, dat_nasc, sexo, cidade_nasc, salario) VALUES
(1, 1, 1, 'Roberto Guimarães', '2000-10-09 04:30:00', 'M', 'Salvador', 6700.00),
(2, 1, 1, 'Alex Silva', '1997-08-07 14:15:00', 'M', 'Camaçari', 9800.00),
(3, 1, 1, 'Bruno Bezzerra', '1999-12-31 22:10:00', 'M', 'Itaberaba', 5300.00),
(4, 1, 1, 'Marco Silvestre', '1988-12-29 08:50:00', 'M', 'São Paulo', 6600.00),
(5, 1, 1, 'Sérgio Bahia', '2004-12-12 11:25:00', 'M', 'Brumado', 9300.00),
(6, 1, 1, 'Carlos Prata', '1996-05-07 19:40:00', 'M', 'Salvador', 5600.00),
(7, 1, 1, 'Raimundo Lock', '1989-10-13 03:15:00', 'M', 'Salvador', 7800.00),
(8, 1, 1, 'Breno Souza', '2002-01-12 16:05:00', 'M', 'Ilhéus', 6900.00),
(9, 1, 1, 'João Pedro', '2000-03-18 12:55:00', 'M', 'Itacaré', 7300.00),
(10, 1, 1, 'Leo Costard', '2001-03-18 07:20:00', 'M', 'Irecê', 7100.00),
(11, 1, 1, 'Victor Mar', '2003-04-16 23:45:00', 'M', 'Camaçari', 6400.00),

-- Jogadores relacionados ao clube do Vitória (2)
(12, 2, 1, 'Lucas Castro', '1998-03-12 10:11:00', 'M', 'Salvador', 5800.00),
(13, 2, 1, 'Gabriel Santos', '1995-11-04 15:22:00', 'M', 'Feira de Santana', 7200.00),
(14, 2, 1, 'Matheus Oliveira', '2001-07-22 01:33:00', 'M', 'Salvador', 6100.00),
(15, 2, 1, 'Rodrigo Alves', '1999-01-15 18:44:00', 'M', 'Juiz de Fora', 8400.00),
(16, 2, 1, 'Felipe Costa', '2003-09-08 09:55:00', 'M', 'Lauro de Freitas', 5500.00),
(17, 2, 1, 'André Luiz', '1996-04-30 20:10:00', 'M', 'Salvador', 9100.00),
(18, 2, 1, 'Diego Ferreira', '2000-08-19 13:05:00', 'M', 'Jequié', 6300.00),
(19, 2, 1, 'Caio Ribeiro', '2002-12-05 04:20:00', 'M', 'Alagoinhas', 7700.00),
(20, 2, 1, 'Thiago Ramos', '1997-06-14 21:50:00', 'M', 'Barreiras', 5200.00),
(21, 2, 1, 'Vinícius Lima', '2004-02-28 11:30:00', 'M', 'Salvador', 8800.00),
(22, 2, 1, 'Rafael Rocha', '1999-10-11 06:15:00', 'M', 'Teixeira de Freitas', 6000.00),

-- ===== FEDERAÇÃO PAULISTA (2) ===== --
-- Jogadores relacionados ao clube do São Paulo (1)
(23, 1, 2, 'Marcelo Augusto', '1995-05-10 12:00:00', 'M', 'São Paulo', 12500.00),
(24, 1, 2, 'Luciano Martins', '1997-02-18 17:25:00', 'M', 'Campinas', 9500.00),
(25, 1, 2, 'Pablo Henrique', '2000-11-03 08:14:00', 'M', 'Santos', 8300.00),
(26, 1, 2, 'Igor Vinícius', '1998-07-25 22:40:00', 'M', 'Ribeirão Preto', 11000.00),
(27, 1, 2, 'Lucas Moura', '1994-01-12 14:50:00', 'M', 'São José dos Campos', 15000.00),
(28, 1, 2, 'Wellington Rato', '1996-09-30 03:10:00', 'M', 'Sorocaba', 7800.00),
(29, 1, 2, 'Giuliano Galoppo', '1999-04-15 19:35:00', 'M', 'São Paulo', 10200.00),
(30, 1, 2, 'Robert Arboleda', '1993-10-22 05:45:00', 'M', 'Osasco', 13000.00),
(31, 1, 2, 'Alan Franco', '1997-08-09 16:05:00', 'M', 'Guarulhos', 8700.00),
(32, 1, 2, 'Jandrei Ribeiro', '1995-03-01 11:15:00', 'M', 'Santo André', 6500.00),
(33, 1, 2, 'Diego Costa', '2001-06-17 23:20:00', 'M', 'São Bernardo', 7400.00),

-- Jogadores relacionados ao clube do Mirassol (2)
(34, 2, 2, 'Alex Muralha', '1992-11-10 07:50:00', 'M', 'Mirassol', 6800.00),
(35, 2, 2, 'Luiz Otávio', '1996-05-21 15:40:00', 'M', 'S. J. do Rio Preto', 7100.00),
(36, 2, 2, 'Gabriel Barros', '2002-03-14 02:10:00', 'M', 'Barretos', 5400.00),
(37, 2, 2, 'Danielzinho', '1997-12-01 18:30:00', 'M', 'Araraquara', 7900.00),
(38, 2, 2, 'Chico Kim', '1995-08-18 10:25:00', 'M', 'Bauru', 6300.00),
(39, 2, 2, 'Negueba', '2000-01-29 21:00:00', 'M', 'Piracicaba', 8100.00),
(40, 2, 2, 'Fernandinho', '1998-04-05 13:15:00', 'M', 'Franca', 5900.00),
(41, 2, 2, 'Dellatorre', '1994-07-12 06:00:00', 'M', 'Marília', 9200.00),
(42, 2, 2, 'Henri', '2001-10-20 20:45:00', 'M', 'Limeira', 5600.00),
(43, 2, 2, 'Yuri Lima', '1999-02-11 14:10:00', 'M', 'Pres. Prudente', 6700.00),
(44, 2, 2, 'Wanderson', '1996-09-03 09:35:00', 'M', 'Catanduva', 7300.00),

-- ===== FEDERAÇÃO CARIOCA (3) ===== --
-- Jogadores relacionados ao clube do Flamengo (1)
(45, 1, 3, 'Pedro Guilherme', '1997-06-20 16:20:00', 'M', 'Rio de Janeiro', 18000.00),
(46, 1, 3, 'Gabriel Barbosa', '1996-08-30 08:15:00', 'M', 'Niterói', 17500.00),
(47, 1, 3, 'Arrascaeta', '1994-06-01 22:50:00', 'M', 'Rio de Janeiro', 16000.00),
(48, 1, 3, 'Bruno Henrique', '1992-12-30 11:30:00', 'M', 'Duque de Caxias', 14000.00),
(49, 1, 3, 'Gerson Santos', '1997-05-20 04:40:00', 'M', 'Nova Iguaçu', 15500.00),
(50, 1, 3, 'Everton Ribeiro', '1991-04-10 19:10:00', 'M', 'Petrópolis', 12000.00),
(51, 1, 3, 'Ayrton Lucas', '1998-01-19 13:25:00', 'M', 'Volta Redonda', 9800.00),
(52, 1, 3, 'Fabrício Bruno', '1996-02-12 07:05:00', 'M', 'Campos', 8900.00),
(53, 1, 3, 'Leo Ortiz', '1997-07-03 21:55:00', 'M', 'Rio de Janeiro', 10500.00),
(54, 1, 3, 'Agustín Rossi', '1995-08-21 15:00:00', 'M', 'Macaé', 9000.00),
(55, 1, 3, 'Erick Pulgar', '1994-01-15 10:45:00', 'M', 'Cabo Frio', 11200.00),

-- Jogadores relacionados ao clube do Fluminense (2)
(56, 2, 3, 'Germán Cano', '1990-01-02 02:30:00', 'M', 'Rio de Janeiro', 16500.00),
(57, 2, 3, 'Jhon Arias', '1997-09-21 18:00:00', 'M', 'Niterói', 14200.00),
(58, 2, 3, 'Ganso Lima', '1991-10-12 09:20:00', 'M', 'Nova Friburgo', 11800.00),
(59, 2, 3, 'André Trindade', '2001-07-16 14:15:00', 'M', 'Teresópolis', 13500.00),
(60, 2, 3, 'Samuel Xavier', '1992-06-06 23:10:00', 'M', 'Angra dos Reis', 7600.00),
(61, 2, 3, 'Nino Mota', '1997-04-10 07:40:00', 'M', 'Volta Redonda', 10800.00),
(62, 2, 3, 'Fábio Deivson', '1982-09-30 12:05:00', 'M', 'Rio de Janeiro', 8500.00),
(63, 2, 3, 'Martinelli Silva', '2001-10-05 16:50:00', 'M', 'Resende', 7200.00),
(64, 2, 3, 'Keno Machado', '1991-09-10 03:25:00', 'M', 'Itaboraí', 8900.00),
(65, 2, 3, 'John Kennedy', '2002-05-18 20:15:00', 'M', 'Rio de Janeiro', 9500.00),
(66, 2, 3, 'Diogo Barbosa', '1994-08-17 11:50:00', 'M', 'Magé', 6800.00),

-- ===== FEDERAÇÃO MINEIRA (4) ===== --
-- Jogadores relacionados ao clube do Cruzeiro (1)
(67, 1, 4, 'Matheus Pereira', '1996-05-05 15:30:00', 'M', 'Belo Horizonte', 14000.00),
(68, 1, 4, 'Lucas Silva', '1993-02-16 08:45:00', 'M', 'Uberlândia', 9800.00),
(69, 1, 4, 'Rafael Cabral', '1990-05-20 21:10:00', 'M', 'Juiz de Fora', 8200.00),
(70, 1, 4, 'William Furtado', '1995-04-03 12:20:00', 'M', 'Betim', 7600.00),
(71, 1, 4, 'Zé Ivaldo', '1997-02-21 04:00:00', 'M', 'Contagem', 8100.00),
(72, 1, 4, 'Marlon Xavier', '1997-05-20 19:15:00', 'M', 'Montes Claros', 7900.00),
(73, 1, 4, 'Lucas Romero', '1994-04-18 09:50:00', 'M', 'Uberaba', 9100.00),
(74, 1, 4, 'Arthur Gomes', '1998-07-03 14:35:00', 'M', 'Gov. Valadares', 8500.00),
(75, 1, 4, 'Juan Dinenno', '1994-08-29 01:25:00', 'M', 'Belo Horizonte', 11000.00),
(76, 1, 4, 'Rafael Papagaio', '1999-04-12 17:05:00', 'M', 'Ipatinga', 6200.00),
(77, 1, 4, 'Mateus Vital', '1998-02-12 22:40:00', 'M', 'Sete Lagoas', 7400.00),

-- Jogadores relacionados ao clube do Atlético Mineiro (2)
(78, 2, 4, 'Hulk Paraíba', '1986-07-25 10:10:00', 'M', 'Belo Horizonte', 19000.00),
(79, 2, 4, 'Paulinho Sampaio', '2000-07-15 16:30:00', 'M', 'Contagem', 16000.00),
(80, 2, 4, 'Gustavo Scarpa', '1994-01-05 05:20:00', 'M', 'Uberlândia', 14500.00),
(81, 2, 4, 'Guilherme Arana', '1997-04-14 13:40:00', 'M', 'Juiz de Fora', 13000.00),
(82, 2, 4, 'Matías Zaracho', '1998-03-10 20:05:00', 'M', 'Belo Horizonte', 11500.00),
(83, 2, 4, 'Otávio Henrique', '1994-05-04 07:55:00', 'M', 'Betim', 8800.00),
(84, 2, 4, 'Everson Marques', '1990-07-22 14:12:00', 'M', 'Montes Claros', 9500.00),
(85, 2, 4, 'Igor Rabello', '1995-04-28 23:33:00', 'M', 'Uberaba', 7800.00),
(86, 2, 4, 'Renzo Saravia', '1993-06-16 09:14:00', 'M', 'Ipatinga', 7200.00),
(87, 2, 4, 'Alan Kardec', '1989-01-12 18:22:00', 'M', 'Gov. Valadares', 8100.00),
(88, 2, 4, 'Eduardo Vargas', '1989-11-20 11:45:00', 'M', 'Belo Horizonte', 10200.00);

SELECT * FROM federacao;
SELECT * FROM clube;
SELECT * FROM jogador;
