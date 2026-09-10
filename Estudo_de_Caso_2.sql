----- Contexto -----

Este estudo de caso descreve um pequeno sistema imaginário da Confederação Brasileira de Futebol.
Com informação de Federações estaduais, times filiados às federações e seus respectivos jogadores.
  
----- Questão 1:	Criação das tabelas respeitando as restrições impostas pela Confederação -----

-- Criação da Tabela Federacao
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
  	CONSTRAINT checar_salarioJog CHECK(salario >= 5000,00) -- Checar salário para atender restrição de salário mínimo de R$ 5.000,00
);

----- Questão 2:	Inserção de 4 federações estaduais (BA, SP, RJ, MG), 2 times em cada federação e 11 jogadores em cada time inserido. -----

-- Inserção das 4 federações estaduais
INSERT INTO federacao(cod_fed, descricao, uf, telefone) VALUES
    (1, 'Federação Bahiana', 'BA', '7133000000')
    (2, 'Federação Paulista', 'SP', '1133000000')
    (3, 'Federação Carioca', 'RJ', '2133000000')
    (4, 'Federação Mineira', 'RJ', '3133000000')

  -- Inserção dos times por unidade federativa (estado)
INSERT INTO clube(cod_clube, cod_fed, nome, telefone, data_fundacao) VALUES
    -- Relacionado à Federação Bahiana (1)
    (1, 1, 'Bahia', '7133000001', '1931-01-01 00:00:00')
    (2, 1, 'Vitória', '7133000002', '1899-05-13 00:00:00')
    -- Relacionado à Federação Paulista (2)
    (1, 2, 'São Paulo', '1133000001', '1930-01-25 00:00:00')
    (2, 2, 'Mirassol', '1133000002', '1925-11-09 00:00:00')
    -- Relacionado à Federação Carioca (3)
    (1, 3, 'Flamengo', '2133000001', '1895-11-15 00:00:00')
    (2, 3, 'Fluminense', '2133000002', '1902-07-21 00:00:00')
    -- Relacionado à Federação Mineira (4)
    (1, 4, 'Cruzeiro', '3133000001', '1921-01-02 00:00:00')
    (2, 4, 'Atlético Mineiro', '2133000002', '1908-03-25 00:00:00')

INSERT INTO jogador(cod_jog, cod_clube, cod_fed, nome, dat_nasc, sexo, cidade_nasc, salario) VALUES
