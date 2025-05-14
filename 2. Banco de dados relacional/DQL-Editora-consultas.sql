use editora;

-- Departamentos e Responsáveis:
SELECT nome, responsavel FROM Departamentos;

-- Total de Clientes:
SELECT COUNT(*) AS total_clientes FROM Clientes;
 
-- Cargos e Descrições 
SELECT nome_cargo, descricao_cargo FROM Cargos;

-- Pedidos e seus respectivos status
SELECT Pedidos.pedido_id, StatusPedido.status FROM Pedidos JOIN StatusPedido ON Pedidos.statusPedido_id = StatusPedido.statusPedido_id;

-- Total de Vendas realizadas":

SELECT SUM(valor_total) AS total_vendas FROM Vendas;

-- Total de Pedidos por Cliente":
SELECT Clientes.nome, COUNT(Pedidos.pedido_id) AS total_pedidos FROM Clientes JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id GROUP BY Clientes.nome;

-- Tipos de Pagamentos":
SELECT tipoPgto FROM TipoPagamento;

-- Funcionários e seus departamentos:
SELECT Funcionarios.nome, Funcionarios.sobrenome, Departamentos.nome AS departamento FROM Funcionarios JOIN Departamentos ON Funcionarios.departamento_id = Departamentos.departamento_id;

-- Média dos pedidos:
SELECT AVG(valor_pedido) AS valor_medio_pedido FROM Pedidos;

-- Descontos Disponivéis
SELECT descontos FROM Descontos;

-- Vendas por funcionário:
SELECT Funcionarios.nome, Funcionarios.sobrenome, COUNT(Vendas.pedido_id) AS total_vendas FROM Funcionarios JOIN Vendas ON Funcionarios.funcionario_pf = Vendas.Funcionarios_cpf GROUP BY Funcionarios.nome, Funcionarios.sobrenome;

-- Total de Venda por mês:
SELECT MONTH(data_venda) AS mes, COUNT(*) AS total_vendas FROM Vendas GROUP BY MONTH(data_venda);

-- Número de funcionários por cargo
SELECT c.descricao_cargo AS cargo, COUNT(f.funcionario_cpf) AS total_funcionarios FROM cargos c JOIN Funcionarios f ON c.cargo_id = f.cargo_id GROUP BY c.descricao_cargo;

-- Média salarial por cargo":
SELECT c.descricao_cargo AS cargo, truncate(AVG(c.salario),2) AS media_salarial FROM Cargos c JOIN Funcionarios f ON c.cargo_id = f.cargo_id GROUP BY c.descricao_cargo;

-- Funcionários admitidos por ano":
SELECT year(data_admissao) AS Ano, COUNT(*) AS total_admitidos FROM Funcionarios GROUP BY YEAR(data_admissao);

-- Receita média por venda":
SELECT AVG(valor_total) AS receita_media FROM Vendas;

-- Total de clientes por estado:
SELECT e.uf, COUNT(c.cliente_id) AS total_clientes FROM Clientes c JOIN Enderecos e ON c.endereco_id = e.endereco_id GROUP BY e.uf;