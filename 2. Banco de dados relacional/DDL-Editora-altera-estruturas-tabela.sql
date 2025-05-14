use Editora;

-- Tabela Cargos
ALTER TABLE Cargos 
ADD COLUMN salario DECIMAL(6,2) NOT NULL;

-- Tabela Funcionarios
ALTER TABLE Funcionarios
ADD COLUMN data_admissao DATE;

ALTER TABLE Funcionarios
ADD COLUMN tipo_sanguineo VARCHAR(2);

ALTER TABLE Funcionarios
DROP COLUMN tipo_sanguineo;

-- Tabela Vendas
ALTER TABLE Vendas
CHANGE COLUMN valor_desconto valor_desconto DECIMAL(5,2) NOT NULL;

-- Tabela Livros
RENAME TABLE Livros TO Acervo;

-- Tabela Genero
RENAME TABLE Genero TO Generos;

-- Tabela Endereços
ALTER TABLE Enderecos
ADD COLUMN cep VARCHAR(10) NOT NULL;

ALTER TABLE Enderecos
ADD COLUMN pais VARCHAR(10) NOT NULL;

ALTER TABLE Enderecos
DROP COLUMN cep;

ALTER TABLE Enderecos
DROP COLUMN pais;
