use Editora;
-- Tabela Estoque
UPDATE Estoque 
SET quantidade = 100
WHERE exemplar_id = 10;

UPDATE Estoque
SET quantidade = 100
WHERE exemplar_id = 11;

UPDATE Estoque
SET quantidade = 100
WHERE exemplar_id = 12;

-- Pedidos
UPDATE Pedidos
SET valor_pedido = 400.00
WHERE pedido_id = 1;

-- Pedidos por Estoque
UPDATE Pedidos_por_Estoque
SET qtd_vendida = 10
WHERE pedido_id = 1 and exemplar_id = 1;

-- Estoque
UPDATE Estoque
SET quantidade = 140
WHERE exemplar_id = 1;

UPDATE Estoque
SET quantidade = 10
WHERE exemplar_id = 2;

-- Vendas
UPDATE Vendas
SET valor_bruto = 400.00
WHERE pedido_id = 1;

UPDATE Vendas
SET valor_desconto = 20
WHERE pedido_id = 1;

UPDATE Vendas
SET valor_total = 380.00
WHERE pedido_id = 1;

-- Funcionario
DELETE FROM Funcionarios
WHERE funcionario_cpf = '45678901238';

-- Descontos
UPDATE Descontos
SET descontos = 35
WHERE desconto_id = 6;

-- Cargos
UPDATE Cargos
SET salario = 2500.00
WHERE cargo_id = 3;

UPDATE Cargos
SET salario = 1400.00
WHERE cargo_id = 9;

UPDATE Cargos
SET salario = 1500.00
WHERE cargo_id = 14;

-- Autores
UPDATE Autores
SET biografia = 'Herdeiro'
WHERE autor_id = 1;

UPDATE Autores
SET biografia = 'Escreveu livros com muita safadeza e dragões'
WHERE autor_id = 7;

UPDATE Autores
SET biografia = 'Maluco da conspiração'
WHERE autor_id = 9;

UPDATE Autores
SET biografia = 'Fez um livro muito famoso de um doido'
WHERE autor_id = 3;




