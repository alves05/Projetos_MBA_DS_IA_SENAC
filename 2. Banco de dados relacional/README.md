## Modelagem do BD da Editora Laços - DDL

**Criando o Banco de Dados**

```sql
CREATE SCHEMA IF NOT EXISTS `Editora` ;
USE `Editora` ;
```

### Estrutura do Banco de Dados

O esquema consiste nas seguintes tabelas principais:

1. **Departamentos**
   - Tabela para armazenar informações sobre os departamentos da editora.

```sql
   CREATE TABLE IF NOT EXISTS `Editora`.`Departamentos` (
  `departamento_id` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `responsavel` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(200) NULL,
  PRIMARY KEY (`departamento_id`),
  UNIQUE INDEX `departamento_id_UNIQUE` (`departamento_id` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;
```

2. **Cargos**
   - Tabela para armazenar informações sobre os cargos dos funcionários.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Cargos` (
  `cargo_id` INT NOT NULL,
  `nome_cargo` VARCHAR(100) NOT NULL,
  `descricao_cargo` VARCHAR(200) NULL,
  PRIMARY KEY (`cargo_id`),
  UNIQUE INDEX `cargo_id_UNIQUE` (`cargo_id` ASC) VISIBLE,
  UNIQUE INDEX `nome_cargo_UNIQUE` (`nome_cargo` ASC) VISIBLE)
ENGINE = InnoDB;
``` 

3. **Endereços**
   - Tabela para armazenar informações de endereços, utilizada por funcionários e clientes.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Enderecos` (
  `endereco_id` INT NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(4) NOT NULL,
  `comp` VARCHAR(50) NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`endereco_id`),
  UNIQUE INDEX `endereco_id_UNIQUE` (`endereco_id` ASC) VISIBLE)
ENGINE = InnoDB;
```

4. **Funcionários**
   - Tabela para armazenar informações dos funcionários da editora, incluindo detalhes de contato e vínculos com departamentos e cargos.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Funcionarios` (
  `funcionario_cpf` CHAR(11) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(200) NULL,
  `departamento_id` INT NOT NULL,
  `cargo_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`funcionario_cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`funcionario_cpf` ASC) VISIBLE,
  UNIQUE INDEX `sobrenome_UNIQUE` (`sobrenome` ASC) VISIBLE,
  INDEX `fk_Funcionarios_Departamentos_idx` (`departamento_id` ASC) VISIBLE,
  INDEX `fk_Funcionarios_Cargos1_idx` (`cargo_id` ASC) VISIBLE,
  INDEX `fk_Funcionarios_Enderecos1_idx` (`endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionarios_Departamentos`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `Editora`.`Departamentos` (`departamento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionarios_Cargos1`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `Editora`.`Cargos` (`cargo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionarios_Enderecos1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `Editora`.`Enderecos` (`endereco_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

5. **Clientes**
   - Tabela para armazenar informações dos clientes da editora, incluindo detalhes de contato e endereço.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Clientes` (
  `cliente_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `Clientescol_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_Clientes_Enderecos1_idx` (`endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_Enderecos1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `Editora`.`Enderecos` (`endereco_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
6. **StatusPedido**
   - Tabela para armazenar os status disponíveis do processo de pedido dos clientes e vendas.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`StatusPedido` (
  `statusPedido_id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`statusPedido_id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC) VISIBLE)
ENGINE = InnoDB;
```
7. **TipoPagamento**
   - Tabela para armazenar informações das opções de pagamentos disponíveis para pedidos e vendas.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`TipoPagamento` (
  `tipoPgto_id` INT NOT NULL AUTO_INCREMENT,
  `tipoPgto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipoPgto_id`),
  UNIQUE INDEX `tipoPgto_UNIQUE` (`tipoPgto` ASC) VISIBLE,
  UNIQUE INDEX `tipoPgto_id_UNIQUE` (`tipoPgto_id` ASC) VISIBLE)
ENGINE = InnoDB;
```

8. **Pedidos**
   - Tabela para armazenar informações sobre os pedidos feitos pelos clientes, incluindo detalhes como data, valor e vínculos com clientes, funcionários e status do pedido.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Pedidos` (
  `pedido_id` INT NOT NULL,
  `data_pedido` DATE NOT NULL,
  `valor_pedido` DECIMAL(10,2) NOT NULL,
  `funcionarios_cpf` CHAR(11) NULL,
  `cliente_id` INT NOT NULL,
  `statusPedido_id` INT NOT NULL,
  `tipoPgto_id` INT NOT NULL,
  PRIMARY KEY (`pedido_id`),
  UNIQUE INDEX `pedido_id_UNIQUE` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_Pedidos_Funcionarios1_idx` (`funcionarios_cpf` ASC) VISIBLE,
  INDEX `fk_Pedidos_Clientes1_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_Pedidos_StatusPedido1_idx` (`statusPedido_id` ASC) VISIBLE,
  INDEX `fk_Pedidos_TipoPagamento1_idx` (`tipoPgto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Funcionarios1`
    FOREIGN KEY (`funcionarios_cpf`)
    REFERENCES `Editora`.`Funcionarios` (`funcionario_cpf`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Editora`.`Clientes` (`cliente_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedidos_StatusPedido1`
    FOREIGN KEY (`statusPedido_id`)
    REFERENCES `Editora`.`StatusPedido` (`statusPedido_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_TipoPagamento1`
    FOREIGN KEY (`tipoPgto_id`)
    REFERENCES `Editora`.`TipoPagamento` (`tipoPgto_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;
```
9. **TipoCliente**
   - Tabela para armazenar informações de documentos cadastrais dos clientes e classificalos como pj ou pf.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`TipoCliente` (
  `num_doc` VARCHAR(18) NOT NULL,
  `tipo` VARCHAR(2) NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE INDEX `documento_UNIQUE` (`num_doc` ASC) VISIBLE,
  UNIQUE INDEX `cliente_id_UNIQUE` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_PF_Clientes1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Editora`.`Clientes` (`cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
```
10. **Descontos**
   - Tabela para armazenar informações dos descontos concedidos no ato da efetivação da venda.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Descontos` (
  `desconto_id` INT NOT NULL AUTO_INCREMENT,
  `descontos` FLOAT NOT NULL,
  PRIMARY KEY (`desconto_id`))
ENGINE = InnoDB;

```
11. **Vendas**
   - Tabela para armazenar informações sobre as vendas realizadas, incluindo detalhes como data, valor bruto, desconto aplicado, forma de pagamento e vínculos com pedidos, funcionários e descontos.

```sql
   CREATE TABLE IF NOT EXISTS `Editora`.`Vendas` (
  `data_venda` DATE NOT NULL,
  `valor_bruto` DECIMAL(10,2) NOT NULL,
  `valor_desconto` DECIMAL(10,2) NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `Funcionarios_cpf` CHAR(11) NOT NULL,
  `pedido_id` INT NOT NULL,
  `desconto_id` INT NOT NULL,
  `tipoPgto_id` INT NOT NULL,
  UNIQUE INDEX `data_venda_UNIQUE` (`data_venda` ASC) VISIBLE,
  INDEX `fk_Vendas_Funcionarios1_idx` (`Funcionarios_cpf` ASC) VISIBLE,
  PRIMARY KEY (`pedido_id`),
  INDEX `fk_Vendas_Descontos1_idx` (`desconto_id` ASC) VISIBLE,
  INDEX `fk_Vendas_TipoPagamento1_idx` (`tipoPgto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Funcionarios1`
    FOREIGN KEY (`Funcionarios_cpf`)
    REFERENCES `Editora`.`Funcionarios` (`funcionario_cpf`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_Pedidos1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Editora`.`Pedidos` (`pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_Descontos1`
    FOREIGN KEY (`desconto_id`)
    REFERENCES `Editora`.`Descontos` (`desconto_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_TipoPagamento1`
    FOREIGN KEY (`tipoPgto_id`)
    REFERENCES `Editora`.`TipoPagamento` (`tipoPgto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

```
12. **Livros**
   - Tabela para armazenar informações sobre os livros publicados pela editora, incluindo título, número de páginas, data de publicação e vínculos com autores, gêneros, áreas de conhecimento e palavras-chave.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Livros` (
  `isbn_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `num_pag` INT NOT NULL,
  `data_public` DATE NOT NULL,
  PRIMARY KEY (`isbn_id`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn_id` ASC) VISIBLE)
ENGINE = InnoDB;
```
13. **StatusEstoque**
   - Tabela para armazenar informações dos status dos livros em estoque.


```sql
CREATE TABLE IF NOT EXISTS `Editora`.`StatusEstoque` (
  `statusEstoque_id` INT NOT NULL AUTO_INCREMENT,
  `status_livros` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`statusEstoque_id`),
  UNIQUE INDEX `status_livros_UNIQUE` (`status_livros` ASC) VISIBLE)
ENGINE = InnoDB;

```
14. **Estoque**
   - Tabela para armazenar informações do estoque como quantidade disponível, localização fisica, valor unitário e número de série.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Estoque` (
  `exemplar_id` INT NOT NULL,
  `localizacao_fisica` VARCHAR(100) NOT NULL,
  `num_serie` VARCHAR(50) NOT NULL,
  `valor_unit` DECIMAL(10,2) NOT NULL,
  `quantidade` INT NOT NULL,
  `isbn_id` INT NOT NULL,
  `statusEstoque_id` INT NOT NULL,
  PRIMARY KEY (`exemplar_id`),
  UNIQUE INDEX `exemplar_id_UNIQUE` (`exemplar_id` ASC) VISIBLE,
  UNIQUE INDEX `num_serie_UNIQUE` (`num_serie` ASC) VISIBLE,
  INDEX `fk_Estoque_Livros1_idx` (`isbn_id` ASC) VISIBLE,
  INDEX `fk_Estoque_StatusEstoque1_idx` (`statusEstoque_id` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_Livros1`
    FOREIGN KEY (`isbn_id`)
    REFERENCES `Editora`.`Livros` (`isbn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Estoque_StatusEstoque1`
    FOREIGN KEY (`statusEstoque_id`)
    REFERENCES `Editora`.`StatusEstoque` (`statusEstoque_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
15. **Autores**
   - Tabela para armazenar informações pertinentes aos autores, como nome e sua biografia.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Autores` (
  `autor_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `nacionalidade` VARCHAR(100) NULL,
  `biografia` VARCHAR(500) NULL,
  `data_nasc` VARCHAR(45) NULL,
  PRIMARY KEY (`autor_id`),
  UNIQUE INDEX `autor_id_UNIQUE` (`autor_id` ASC) VISIBLE)
ENGINE = InnoDB;
```
16. **Livros por Autores**
   - Tabela auxiliar de relacionamento muitos para muitos entre a tabela Livros e Autores.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Livros_por_Autores` (
  `isbn_id` INT NOT NULL,
  `autor_id` INT NOT NULL,
  PRIMARY KEY (`isbn_id`, `autor_id`),
  INDEX `fk_Livros_has_Autores_Autores1_idx` (`autor_id` ASC) VISIBLE,
  INDEX `fk_Livros_has_Autores_Livros1_idx` (`isbn_id` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_has_Autores_Livros1`
    FOREIGN KEY (`isbn_id`)
    REFERENCES `Editora`.`Livros` (`isbn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livros_has_Autores_Autores1`
    FOREIGN KEY (`autor_id`)
    REFERENCES `Editora`.`Autores` (`autor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
17. **Áreas de Conhecimentos**
   - Tabela para armazenar informações das aáreas de conhecimentos da tabela Livros.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`AreasConhecto` (
  `area_id` INT NOT NULL,
  `areas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE INDEX `area_id_UNIQUE` (`area_id` ASC) VISIBLE,
  UNIQUE INDEX `areas_UNIQUE` (`areas` ASC) VISIBLE)
ENGINE = InnoDB;
```
18. **Palavras Chave**
   - Tabela para armazenar informações das palavras chaves usadas nas tabela Livros.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`PalavrasChave` (
  `palavra_id` INT NOT NULL,
  `palavras` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`palavra_id`),
  UNIQUE INDEX `area_id_UNIQUE` (`palavra_id` ASC) VISIBLE,
  UNIQUE INDEX `palavras_UNIQUE` (`palavras` ASC) VISIBLE)
ENGINE = InnoDB;
```
19. **Livros por Área de Conhecimento**
   - Tabela auxiliar de relacionamento muitos para muitos entre a tabela Livros e Área de Conhecimento.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Livros_por_AreasConhecto` (
  `isbn_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  PRIMARY KEY (`isbn_id`, `area_id`),
  INDEX `fk_Livros_has_AreasConhecto_AreasConhecto1_idx` (`area_id` ASC) VISIBLE,
  INDEX `fk_Livros_has_AreasConhecto_Livros1_idx` (`isbn_id` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_has_AreasConhecto_Livros1`
    FOREIGN KEY (`isbn_id`)
    REFERENCES `Editora`.`Livros` (`isbn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livros_has_AreasConhecto_AreasConhecto1`
    FOREIGN KEY (`area_id`)
    REFERENCES `Editora`.`AreasConhecto` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
20. **Livros por Palavras Chave**
   - Tabela auxiliar de relacionamento muitos para muitos entre a tabela Livros e Palavras Chave.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Livros_por_PalavrasChave` (
  `isbn_id` INT NOT NULL,
  `palavra_id` INT NOT NULL,
  PRIMARY KEY (`isbn_id`, `palavra_id`),
  INDEX `fk_Livros_has_PalavrasChave_PalavrasChave1_idx` (`palavra_id` ASC) VISIBLE,
  INDEX `fk_Livros_has_PalavrasChave_Livros1_idx` (`isbn_id` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_has_PalavrasChave_Livros1`
    FOREIGN KEY (`isbn_id`)
    REFERENCES `Editora`.`Livros` (`isbn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livros_has_PalavrasChave_PalavrasChave1`
    FOREIGN KEY (`palavra_id`)
    REFERENCES `Editora`.`PalavrasChave` (`palavra_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
21. **Pedidos por Estoque**
   - Tabela auxiliar de relacionamento muitos para muitos entre a tabela Pedidos e Estoque, também armazena a quantidade de itens do pedido.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Pedidos_por_Estoque` (
  `pedido_id` INT NOT NULL,
  `exemplar_id` INT NOT NULL,
  `qtd_vendida` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `exemplar_id`),
  INDEX `fk_Pedidos_has_Estoque_Estoque1_idx` (`exemplar_id` ASC) VISIBLE,
  INDEX `fk_Pedidos_has_Estoque_Pedidos1_idx` (`pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_has_Estoque_Pedidos1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Editora`.`Pedidos` (`pedido_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_has_Estoque_Estoque1`
    FOREIGN KEY (`exemplar_id`)
    REFERENCES `Editora`.`Estoque` (`exemplar_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```
22. **Gênero**
   - Tabela que armazena os gêneros vinculados aos livros da tabela Livros.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Genero` (
  `genero_id` INT NOT NULL,
  `generos` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`genero_id`),
  UNIQUE INDEX `genero_id_UNIQUE` (`genero_id` ASC) VISIBLE,
  UNIQUE INDEX `generos_UNIQUE` (`generos` ASC) VISIBLE)
ENGINE = InnoDB;
```
23. **Gênero por Livros**
   - Tabela auxiliar de relacionamento muitos para muitos entre a tabela Livros e Gênero.

```sql
CREATE TABLE IF NOT EXISTS `Editora`.`Genero_por_Livros` (
  `genero_id` INT NOT NULL,
  `isbn_id` INT NOT NULL,
  PRIMARY KEY (`genero_id`, `isbn_id`),
  INDEX `fk_Genero_has_Livros_Livros1_idx` (`isbn_id` ASC) VISIBLE,
  INDEX `fk_Genero_has_Livros_Genero1_idx` (`genero_id` ASC) VISIBLE,
  CONSTRAINT `fk_Genero_has_Livros_Genero1`
    FOREIGN KEY (`genero_id`)
    REFERENCES `Editora`.`Genero` (`genero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Genero_has_Livros_Livros1`
    FOREIGN KEY (`isbn_id`)
    REFERENCES `Editora`.`Livros` (`isbn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

### Views

Além das tabelas, foram criadas views para facilitar o acesso a informações complexas:

- **Dados_Clientes**
  - View que fornece informações detalhadas sobre os clientes, incluindo tipo de cliente e endereço.

```sql
DROP TABLE IF EXISTS `Editora`.`Dados_Clientes`;
USE `Editora`;
CREATE  OR REPLACE VIEW Dados_Clientes AS
select 
	c.nome as Cliente,
    t.num_doc as Documento,
    t.tipo as Natureza,
    e.rua as Rua,
    e.numero as Numero,
    e.comp as Complemento,
    e.bairro as Bairro,
    e.cidade as Cidade,
    e.uf as Estado
from Clientes as c
inner join TipoCliente as t on c.cliente_id=t.cliente_id
inner join Enderecos as e on e.endereco_id = c.endereco_id;

```

- **Catalogo**
  - View que lista os livros disponíveis, incluindo autor, gênero, área de conhecimento, palavras-chave, quantidade em estoque, preço e status.

```sql
DROP TABLE IF EXISTS `Editora`.`Catalogo`;
USE `Editora`;
CREATE  OR REPLACE VIEW Catalogo AS
SELECT
    l.isbn_id AS ISBN,
    l.titulo AS Título,
    a.nome AS Autor,
    g.generos AS Gênero,
    ac.areas AS 'Área de Conhecimento',
    GROUP_CONCAT(p.palavras SEPARATOR ', ') AS 'Palavras Chave',
    MAX(e.quantidade) AS 'Qtda Estoque',
    MAX(e.valor_unit) AS 'Preço',
    se.status_livros as 'Status Estoque'
FROM Livros AS l
INNER JOIN Livros_por_Autores AS la ON la.isbn_id = l.isbn_id
INNER JOIN Autores AS a ON a.autor_id = la.autor_id
INNER JOIN Genero_por_Livros AS gl ON gl.isbn_id = l.isbn_id
INNER JOIN Genero AS g ON g.genero_id = gl.genero_id
INNER JOIN Livros_por_AreasConhecto AS lac ON lac.isbn_id = l.isbn_id
INNER JOIN AreasConhecto AS ac ON ac.area_id = lac.area_id
INNER JOIN Livros_por_PalavrasChave AS lp ON lp.isbn_id = l.isbn_id
INNER JOIN PalavrasChave AS p ON p.palavra_id = lp.palavra_id
INNER JOIN Estoque AS e ON e.isbn_id = l.isbn_id
INNER JOIN StatusEstoque AS se ON se.statusEstoque_id = e.statusEstoque_id
GROUP BY l.isbn_id, l.titulo, a.nome, g.generos, ac.areas, se.status_livros;
```

- **Dados_Pedidos**
  - View que detalha os pedidos realizados pelos clientes, incluindo informações sobre os livros pedidos, quantidade, valor do pedido e status.

```sql
DROP TABLE IF EXISTS `Editora`.`Dados_Pedidos`;
USE `Editora`;
CREATE   OR REPLACE VIEW Dados_Pedidos AS
select
	p.data_pedido as 'Data',
    c.nome as Cliente,
    l.titulo as Livro,
    pe.qtd_vendida as Quantidade,
    p.valor_pedido as 'Valor do Pedido',
    concat(f.nome, ' ',f.sobrenome) as Vendedor,
    sp.status as 'Status Pedido'
from Pedidos as p
inner join Clientes as c on c.cliente_id = p.cliente_id
inner join Pedidos_por_Estoque as pe on pe.pedido_id = p.pedido_id
inner join Estoque as e on e.exemplar_id = pe.exemplar_id
inner join Livros as l on l.isbn_id = e.isbn_id
inner join Funcionarios as f on f.funcionario_cpf = p.funcionarios_cpf
inner join StatusPedido as sp on sp.statusPedido_id = p.statusPedido_id;
``` 

- **Dados_Funcionarios**
  - View que apresenta informações dos funcionários da editora, incluindo cargo, departamento e supervisor.

```sql
DROP TABLE IF EXISTS `Editora`.`Dados_Funcionarios`;
USE `Editora`;
CREATE  OR REPLACE VIEW Dados_Funcionarios AS
select
	concat(f.nome, ' ', f.sobrenome) as 'Nome Completo',
    f.telefone as Telefone,
    f.email as Email,
    c.nome_cargo as Cargo,
    d.nome as Departamento,
    d.responsavel as Supervisor
from Funcionarios as f
inner join Cargos as c on c.cargo_id = f.cargo_id
inner join Departamentos as d on d.departamento_id = f.departamento_id;
```

- **Dados_Vendas**
  - View que mostra informações detalhadas sobre as vendas realizadas, incluindo dados sobre os clientes, forma de pagamento, valor bruto, desconto aplicado e vendedor responsável.

```sql
DROP TABLE IF EXISTS `Editora`.`Dados_Vendas`;
USE `Editora`;
CREATE  OR REPLACE VIEW Dados_Vendas AS
select
	v.data_venda as 'Data',
    p.pedido_id as 'N. Pedido',
    c.nome as Cliente,
    tp.tipoPgto as 'Forma Pagamento',
    v.valor_bruto as 'Valor Bruto',
    v.valor_desconto as Desconto,
    v.valor_total as 'Valor Total',
    concat(f.nome, ' ',f.sobrenome) as Vendedor
from Vendas as v
inner join Pedidos as p on p.pedido_id = v.pedido_id
inner join Clientes as c on c.cliente_id = p.cliente_id
inner join TipoPagamento as tp on tp.tipoPgto_id = v.tipoPgto_id
inner join Funcionarios as f on f.funcionario_cpf = v.Funcionarios_cpf;
```

### Triggers

Também foram definidos triggers para automatizar algumas operações:

- **calcular_desconto_valor_total**
  - Trigger que calcula automaticamente o valor do desconto em uma venda com base no desconto aplicado.

```sql
DELIMITER $$
USE `Editora`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Editora`.`calcular_desconto_valor_total`
BEFORE INSERT ON `Vendas` FOR EACH ROW
BEGIN
DECLARE desconto_percentual DECIMAL(10,2);

    -- Obter o percentual de desconto baseado no desconto_id
    SELECT descontos / 100 INTO desconto_percentual 
    FROM Descontos
    WHERE desconto_id = NEW.desconto_id;

    -- Calcular o valor do desconto
    SET NEW.valor_desconto = NEW.valor_bruto * desconto_percentual;

    -- Calcular o valor total
    SET NEW.valor_total = NEW.valor_bruto - NEW.valor_desconto;
END$$
```

### Observações

- Todas as tabelas estão configuradas para utilizar o mecanismo de armazenamento InnoDB.


### Alterando Estrutura das Tabelas - DDL

**Tabela Cargos:**
  - Adiconando coluna Salário na tabela Cargos.

```sql
ALTER TABLE Cargos 
ADD COLUMN salario DECIMAL(6,2) NOT NULL;
```

**Tabela Funcionários:**
  - Adicona a coluna "data_admissao" na tabela Funcionarios.
```sql
ALTER TABLE Funcionarios
ADD COLUMN data_admissao DATE;
```
  - Adicona a coluna "tipo_sanguineo" na tabela Funcionarios.
```sql
ALTER TABLE Funcionarios
ADD COLUMN tipo_sanguineo VARCHAR(2);
```
  - Deleta a coluna "tipo_sanguineo" da tabela Funcionario.
```sql
ALTER TABLE Funcionarios
DROP COLUMN tipo_sanguineo;
```
**Tabela Vendas:**
  - Altera o tipo da coluna "valor_desconto" de DECIMAL(10,2) para DECIMAL(5,2).
```sql
ALTER TABLE Vendas
CHANGE COLUMN valor_desconto valor_desconto DECIMAL(5,2) NOT NULL;
```
**Tabela Livros**
  - Renomeando a tabela Livros para Acervo.
```sql
RENAME TABLE Livros TO Acervo;
```
**Tabela Gênero**
   - Corrigindo a tabela para o plural.
```sql
RENAME TABLE Genero TO Generos;
```

**Tabela Endereços**
  - Adicionando a coluna "cep" a tabela Endereços.
```sql 
ALTER TABLE Enderecos
ADD COLUMN cep VARCHAR(10) NOT NULL;
```
   - Adicionando a coluna "país" a tabela Endereços.
```sql
ALTER TABLE Enderecos
ADD COLUMN pais VARCHAR(10) NOT NULL;
```
  - Deletando a coluna cep.
```sql
ALTER TABLE Enderecos
DROP COLUMN cep;
```
  - Deletando a coluna país.
```sql
ALTER TABLE Enderecos
DROP COLUMN pais;
```


### Realizando Inserção de Dados no BD - DML

**Tabela Departamentos**
```sql
INSERT INTO Departamentos (
  departamento_id, nome, responsavel,
  descricao) VALUES
(1, 'Marketing', 'Ana Silva',
'Responsável por todas as campanhas de marketing e publicidade da editora'),
(2, 'Vendas', 'Carlos Souza',
'Gerencia todas as vendas e parcerias comerciais'),
(3, 'Recursos Humanos', 'Mariana Lima',
'Cuida da contratação, treinamento e bem-estar dos funcionários'),
(4, 'Financeiro', 'João Oliveira',
'Gerencia as finanças, pagamentos e orçamentos da empresa'),
(5, 'Editorial', 'Rafael Costa',
'Responsável pela edição e revisão dos livros publicados'),
(6, 'Produção', 'Fernanda Alves', 
'Coordena a produção física dos livros'),
(7, 'Tecnologia da Informação', 'Lucas Pereira', 
'Administra a infraestrutura de TI e suporte técnico'),
(8, 'Jurídico', 'Beatriz Mendes', 
'Cuida de todos os assuntos legais e contratos da editora');
```
**Cargos**
```sql
INSERT INTO Cargos (cargo_id, nome_cargo, descricao_cargo, salario) VALUES
(1, 'Gerente de Marketing', 
'Responsável por planejar e executar estratégias de marketing.', 7500.00),
(2, 'Executivo de Vendas', 
'Desenvolve e mantém relações comerciais com clientes e parceiros.', 6500.00),
(3, 'Analista de Recursos Humanos', 
'Conduz processos de recrutamento, seleção e treinamento de funcionários.', 5000.00),
(4, 'Analista Financeiro', 
'Monitora transações financeiras e prepara relatórios de orçamento.', 5500.00),
(5, 'Editor Chefe', 
'Supervisiona o processo editorial, garantindo a qualidade dos conteúdos publicados.',
 8000.00),
(6, 'Coordenador de Produção', 
'Gerencia a produção física dos livros, garantindo prazos e qualidade.', 6000.00),
(7, 'Especialista em TI', 
'Fornece suporte técnico e gerencia a infraestrutura de TI.', 7000.00),
(8, 'Advogado Corporativo', 
'Gerencia questões jurídicas e contratos da empresa.', 8500,00),
(9, 'Assistente de Marketing', 
'Auxilia na execução de campanhas e estratégias de marketing.', 3000.00),
(10, 'Representante de Vendas', 
'Suporta as atividades de vendas e manutenção de relações com clientes.', 3500.00),
(11, 'Assistente de Recursos Humanos', 
'Auxilia nos processos de recrutamento, seleção e treinamento.', 3200.00),
(12, 'Assistente Financeiro', 
'Ajuda na monitoração de transações financeiras e preparação de relatórios.', 3300.00),
(13, 'Editor Assistente', 
'Apoia o Editor Chefe na revisão e edição de conteúdos.', 4500.00),
(14, 'Assistente de Produção', 
'Auxilia na gestão da produção física dos livros.', 3100.00),
(15, 'Técnico de Suporte', 
'Fornece suporte técnico e manutenção da infraestrutura de TI.', 4000.00),
(16, 'Assistente Jurídico', 
'Apoia o Advogado Corporativo em questões jurídicas e contratos.', 3400.00);
```
**Endereços**
```sql
INSERT INTO Enderecos (endereco_id, rua, numero, comp, bairro, cidade, uf) VALUES
(1, 'Rua das Flores', '25', 'Apto 101', 'Centro', 'Recife', 'PE'),
(2, 'Avenida Atlântica', '100', 'Sala 201', 'Barra', 'Salvador', 'BA'),
(3, 'Travessa do Norte', '58', 'Bloco C', 'Cidade Alta', 'Natal', 'RN'),
(4, 'Praça da Paz', '42', 'Apto 401', 'Centro', 'Maceió', 'AL'),
(5, 'Largo do Rosário', '85', 'Sala 501', 'Rosário', 'João Pessoa', 'PB'),
(6, 'Rua Coronel Lemos', '150', 'Apto 601', 'Centro', 'Fortaleza', 'CE'),
(7, 'Avenida Sergipe', '230', 'Bloco D', 'Cidade Nova', 'Aracaju', 'SE'),
(8, 'Rua do Sol', '120', 'Apto 301', 'Centro', 'Teresina', 'PI'),
(9, 'Alameda das Acácias', '300', 'Sala 402', 'Verde Mar', 'São Luís', 'MA'),
(10, 'Rua Nova Esperança', '90', 'Bloco E', 'Vila Nova', 'Natal', 'RN'),
(11, 'Avenida Beira Mar', '345', 'Bloco F', 'Praia Grande', 'Fortaleza', 'CE'),
(12, 'Rua do Marisco', '456', 'Apto 402', 'Mangueira', 'Recife', 'PE'),
(13, 'Praça do Forte', '567', 'Sala 503', 'Fortaleza', 'Salvador', 'BA'),
(14, 'Rua das Dunas', '678', 'Apto 604', 'Beira Rio', 'Maceió', 'AL'),
(15, 'Avenida Central', '789', 'Bloco G', 'Nova Descoberta', 'Natal', 'RN'),
(16, 'Travessa dos Artistas', '890', 'Apto 705', 'Centro', 'João Pessoa', 'PB'),
(17, 'Largo do Carmo', '901', 'Sala 806', 'Carmo', 'Olinda', 'PE'),
(18, 'Rua da Praia', '12', 'Bloco H', 'Praia do Meio', 'Natal', 'RN'),
(19, 'Alameda Verde', '23', 'Apto 907', 'Jardins', 'Aracaju', 'SE'),
(20, 'Praça da Alegria', '34', 'Sala 1008', 'Centro', 'Teresina', 'PI'),
(21, 'Rua do Futuro', '45', 'Bloco I', 'Futuro', 'Fortaleza', 'CE'),
(22, 'Avenida do Contorno', '56', 'Apto 1109', 'Contorno', 'Salvador', 'BA'),
(23, 'Travessa do Sol', '67', 'Sala 1210', 'Sol Nascente', 'Maceió', 'AL'),
(24, 'Rua Nova', '78', 'Bloco J', 'Nova Esperança', 'Recife', 'PE'),
(25, 'Avenida do Farol', '89', 'Apto 1311', 'Farol', 'Maceió', 'AL'),
(26, 'Praça do Vento', '98', 'Sala 1412', 'Vento Leste', 'João Pessoa', 'PB'),
(27, 'Rua do Mangue', '107', 'Bloco K', 'Mangue', 'São Luís', 'MA'),
(28, 'Alameda das Palmeiras', '116', 'Apto 1513', 'Palmeiras', 'Fortaleza', 'CE'),
(29, 'Rua das Orquídeas', '125', 'Sala 1614', 'Jardim das Orquídeas', 'Salvador', 'BA'),
(30, 'Praça da Revolução', '134', 'Bloco L', 'Centro', 'Recife', 'PE'),
(31, 'Avenida dos Navegantes', '143', 'Apto 1715', 'Navegantes', 'Recife', 'PE'),
(32, 'Travessa da Lagoa', '152', 'Sala 1816', 'Lagoa', 'Natal', 'RN'),
(33, 'Rua da Liberdade', '161', 'Bloco M', 'Liberdade', 'Salvador', 'BA'),
(34, 'Alameda dos Anjos', '170', 'Apto 1917', 'Anjos', 'Maceió', 'AL'),
(35, 'Rua do Sossego', '179', 'Sala 2018', 'Sossego', 'Aracaju', 'SE'),
(36, 'Praça das Flores', '188', 'Bloco N', 'Flores', 'Teresina', 'PI'),
(37, 'Avenida da Praia', '197', 'Apto 2119', 'Praia', 'Fortaleza', 'CE'),
(38, 'Travessa do Sertão', '206', 'Sala 2220', 'Sertão', 'Salvador', 'BA'),
(39, 'Rua das Estrelas', '215', 'Bloco O', 'Estrelas', 'Recife', 'PE'),
(40, 'Alameda do Bosque', '224', 'Apto 2321', 'Bosque', 'Maceió', 'AL'),
(41, 'Rua dos Pescadores', '233', 'Sala 2422', 'Pescadores', 'Natal', 'RN'),
(42, 'Praça do Porto', '242', 'Bloco P', 'Porto', 'João Pessoa', 'PB'),
(43, 'Avenida do Manguezal', '251', 'Apto 2523', 'Manguezal', 'Recife', 'PE'),
(44, 'Travessa da Esperança', '260', 'Sala 2624', 'Esperança', 'Aracaju', 'SE'),
(45, 'Rua da Harmonia', '269', 'Bloco Q', 'Harmonia', 'São Luís', 'MA'),
(46, 'Alameda das Aroeiras', '278', 'Apto 2725', 'Aroeiras', 'Fortaleza', 'CE'),
(47, 'Rua do Jangadeiro', '287', 'Sala 2826', 'Jangadeiros', 'Salvador', 'BA'),
(48, 'Praça do Farol', '296', 'Bloco R', 'Farol', 'Maceió', 'AL'),
(49, 'Avenida das Américas', '305', 'Apto 2927', 'Américas', 'Recife', 'PE'),
(50, 'Travessa dos Ventos', '314', 'Sala 3028', 'Ventos', 'Natal', 'RN'),
(51, 'Rua da Alegria', '323', 'Bloco S', 'Alegria', 'João Pessoa', 'PB'),
(52, 'Alameda do Mar', '332', 'Apto 3129', 'Mar', 'Recife', 'PE'),
(53, 'Travessa do Bosque', '341', 'Sala 3230', 'Bosque', 'Aracaju', 'SE'),
(54, 'Rua do Parque', '350', 'Bloco T', 'Parque', 'São Luís', 'MA'),
(55, 'Alameda dos Coqueiros', '359', 'Apto 3331', 'Coqueiros', 'Fortaleza', 'CE'),
(56, 'Rua do Calçadão', '368', 'Sala 3432', 'Calçadão', 'Salvador', 'BA'),
(57, 'Praça da Juventude', '377', 'Bloco U', 'Juventude', 'Maceió', 'AL'),
(58, 'Avenida do Progresso', '386', 'Apto 3533', 'Progresso', 'Recife', 'PE'),
(59, 'Travessa da Paz', '395', 'Sala 3634', 'Paz', 'Natal', 'RN'),
(60, 'Rua da Fonte', '404', 'Bloco V', 'Fonte', 'João Pessoa', 'PB'),
(61, 'Alameda do Lago', '413', 'Apto 3735', 'Lago', 'Recife', 'PE'),
(62, 'Travessa da Vida', '422', 'Sala 3836', 'Vida', 'Aracaju', 'SE'),
(63, 'Rua das Palmeiras', '431', 'Bloco W', 'Palmeiras', 'São Luís', 'MA'),
(64, 'Alameda das Rosas', '440', 'Apto 3937', 'Rosas', 'Fortaleza', 'CE'),
(65, 'Rua do Mercado', '449', 'Sala 4038', 'Mercado', 'Salvador', 'BA'),
(66, 'Praça do Trabalho', '458', 'Bloco X', 'Trabalho', 'Maceió', 'AL'),
(67, 'Avenida do Litoral', '467', 'Apto 4139', 'Litoral', 'Recife', 'PE'),
(68, 'Travessa do Reggae', '476', 'Sala 4240', 'Reggae', 'Natal', 'RN'),
(69, 'Rua do Campo', '485', 'Bloco Y', 'Campo', 'João Pessoa', 'PB'),
(70, 'Alameda do Sol', '494', 'Apto 4341', 'Sol', 'Recife', 'PE'),
(71, 'Travessa do Rio', '503', 'Sala 4442', 'Rio', 'Aracaju', 'SE'),
(72, 'Rua das Águas', '512', 'Bloco Z', 'Águas', 'São Luís', 'MA'),
(73, 'Alameda da Liberdade', '521', 'Apto 4543', 'Liberdade', 'Fortaleza', 'CE'),
(74, 'Rua do Passeio', '530', 'Sala 4644', 'Passeio', 'Salvador', 'BA'),
(75, 'Praça das Artes', '539', 'Bloco AA', 'Artes', 'Maceió', 'AL'),
(76, 'Avenida do Comércio', '548', 'Apto 4745', 'Comércio', 'Recife', 'PE'),
(77, 'Travessa da Saudade', '557', 'Sala 4846', 'Saudade', 'Natal', 'RN'),
(78, 'Rua da Esperança', '566', 'Bloco BB', 'Esperança', 'João Pessoa', 'PB'),
(79, 'Alameda do Norte', '575', 'Apto 4947', 'Norte', 'Recife', 'PE'),
(80, 'Travessa do Atlântico', '584', 'Sala 5048', 'Atlântico', 'Aracaju', 'SE'),
(81, 'Rua das Estações', '593', 'Bloco CC', 'Estações', 'São Luís', 'MA'),
(82, 'Alameda do Oriente', '602', 'Apto 5149', 'Oriente', 'Fortaleza', 'CE'),
(83, 'Rua do Caribe', '611', 'Sala 5250', 'Caribe', 'Salvador', 'BA'),
(84, 'Praça do Sol', '620', 'Bloco DD', 'Sol', 'Maceió', 'AL'),
(85, 'Avenida do Porto', '629', 'Apto 5351', 'Porto', 'Recife', 'PE'),
(86, 'Travessa da Mata', '638', 'Sala 5452', 'Mata', 'Natal', 'RN'),
(87, 'Rua da União', '647', 'Bloco EE', 'União', 'João Pessoa', 'PB'),
(88, 'Alameda da Vitória', '656', 'Apto 5553', 'Vitória', 'Recife', 'PE'),
(89, 'Travessa do Coqueiral', '665', 'Sala 5654', 'Coqueiral', 'Aracaju', 'SE'),
(90, 'Rua das Canções', '674', 'Bloco FF', 'Canções', 'São Luís', 'MA'),
(91, 'Alameda do Maracatu', '683', 'Apto 5755', 'Maracatu', 'Fortaleza', 'CE'),
(92, 'Rua do Festival', '692', 'Sala 5856', 'Festival', 'Salvador', 'BA'),
(93, 'Praça da Cultura', '701', 'Bloco GG', 'Cultura', 'Maceió', 'AL'),
(94, 'Avenida da Praia', '710', 'Apto 5957', 'Praia', 'Recife', 'PE'),
(95, 'Travessa do Farol', '719', 'Sala 6058', 'Farol', 'Natal', 'RN'),
(96, 'Rua do Vento', '728', 'Bloco HH', 'Vento', 'João Pessoa', 'PB'),
(97, 'Alameda do Sertão', '737', 'Apto 6159', 'Sertão', 'Recife', 'PE'),
(98, 'Travessa da Lagoa', '746', 'Sala 6260', 'Lagoa', 'Aracaju', 'SE'),
(99, 'Rua da Brisa', '755', 'Bloco II', 'Brisa', 'São Luís', 'MA'),
(100, 'Alameda do Mergulho', '764', 'Apto 6361', 'Mergulho', 'Fortaleza', 'CE'),
(101, 'Rua das Ondas', '773', 'Sala 6462', 'Ondas', 'Salvador', 'BA'),
(102, 'Praça do Peixe', '782', 'Bloco JJ', 'Peixe', 'Maceió', 'AL'),
(103, 'Avenida do Mangue', '791', 'Apto 6563', 'Mangue', 'Recife', 'PE'),
(104, 'Travessa das Palmeiras', '800', 'Sala 6664', 'Palmeiras', 'Natal', 'RN'),
(105, 'Rua do Cais', '809', 'Bloco KK', 'Cais', 'João Pessoa', 'PB'),
(106, 'Alameda das Estrelas', '818', 'Apto 6765', 'Estrelas', 'Recife', 'PE'),
(107, 'Travessa do Paraíso', '827', 'Sala 6866', 'Paraíso', 'Aracaju', 'SE'),
(108, 'Rua do Porto', '836', 'Bloco LL', 'Porto', 'São Luís', 'MA'),
(109, 'Alameda da Beira-Mar', '845', 'Apto 6967', 'Beira-Mar', 'Fortaleza', 'CE'),
(110, 'Rua do Recife', '854', 'Sala 7068', 'Recife', 'Salvador', 'BA'),
(111, 'Praça da Marina', '863', 'Bloco MM', 'Marina', 'Maceió', 'AL'),
(112, 'Avenida das Sereias', '872', 'Apto 7169', 'Sereias', 'Recife', 'PE'),
(113, 'Travessa do Coral', '881', 'Sala 7270', 'Coral', 'Natal', 'RN'),
(114, 'Rua da Praia', '890', 'Bloco NN', 'Praia', 'João Pessoa', 'PB'),
(115, 'Alameda do Barco', '899', 'Apto 7371', 'Barco', 'Recife', 'PE'),
(116, 'Travessa do Arrecife', '908', 'Sala 7472', 'Arrecife', 'Aracaju', 'SE'),
(117, 'Rua do Farol', '917', 'Bloco OO', 'Farol', 'São Luís', 'MA'),
(118, 'Alameda das Gaivotas', '926', 'Apto 7573', 'Gaivotas', 'Fortaleza', 'CE'),
(119, 'Rua do Sal', '935', 'Sala 7674', 'Sal', 'Salvador', 'BA'),
(120, 'Praça da Areia', '944', 'Bloco PP', 'Areia', 'Maceió', 'AL'),
(121, 'Avenida do Oceano', '953', 'Apto 7775', 'Oceano', 'Recife', 'PE'),
(122, 'Travessa das Algas', '962', 'Sala 7876', 'Algas', 'Natal', 'RN'),
(123, 'Rua do Navio', '971', 'Bloco QQ', 'Navio', 'João Pessoa', 'PB'),
(124, 'Alameda do Veleiro', '980', 'Apto 7977', 'Veleiro', 'Recife', 'PE'),
(125, 'Travessa do Marujo', '989', 'Sala 8078', 'Marujo', 'Aracaju', 'SE'),
(126, 'Rua da Marina', '998', 'Bloco RR', 'Marina', 'São Luís', 'MA'),
(127, 'Alameda do Ancoradouro', '1007', 'Apto 8179', 'Ancoradouro', 'Fortaleza', 'CE'),
(128, 'Rua das Conchas', '1016', 'Sala 8280', 'Conchas', 'Salvador', 'BA'),
(129, 'Praça do Náutico', '1025', 'Bloco SS', 'Náutico', 'Maceió', 'AL'),
(130, 'Avenida do Mergulhador', '1034', 'Apto 8381', 'Mergulhador', 'Recife', 'PE'),
(131, 'Travessa da Âncora', '1043', 'Sala 8482', 'Âncora', 'Natal', 'RN'),
(132, 'Rua da Maresia', '1052', 'Bloco TT', 'Maresia', 'João Pessoa', 'PB');
```
**Funcionários**
```sql
INSERT INTO Funcionarios (
  funcionario_cpf, nome, sobrenome, telefone, email,
   departamento_id, cargo_id, endereco_id, data_admissao) VALUES
('12345678901', 'João', 'Silva', '81987654321', 
'joao.silva@email.com', 1, 1, 1, '2024-01-10'),
('23456789012', 'Maria', 'Costa', '81987654322', 
'maria.costa@email.com', 2, 2, 2, '2024-01-15'),
('34567890123', 'Carlos', 'Mendes', '81987654323', 
'carlos.mendes@email.com', 3, 3, 3, '2024-01-20'),
('45678901234', 'Ana', 'Barros', '81987654324', 
'ana.barros@email.com', 4, 4, 4, '2024-01-25'),
('56789012345', 'Patricia', 'Santos', '81987654325', 
'patricia.santos@email.com', 5, 5, 5, '2024-02-01'),
('67890123456', 'Ricardo', 'Oliveira', '81987654326', 
'ricardo.oliveira@email.com', 6, 6, 6, '2024-02-05'),
('78901234567', 'Sofia', 'Pereira', '81987654327', 
'sofia.pereira@email.com', 7, 7, 7, '2024-02-10'),
('89012345678', 'Lucas', 'Lima', '81987654328', 
'lucas.lima@email.com', 8, 8, 8, '2024-02-15'),
('90123456789', 'Paula', 'Ferreira', '81987654329', 
'paula.ferreira@email.com', 1, 10, 9, '2024-02-20'),
('01234567890', 'Pedro', 'Alves', '81987654310', 
'pedro.alves@email.com', 2, 10, 10, '2024-02-25'),
('12345678909', 'Fernanda', 'Martins', '81987654311', 
'fernanda.martins@email.com', 3, 11, 11, '2024-03-01'),
('23456789019', 'Tiago', 'Gomes', '81987654312', 
'tiago.gomes@email.com', 4, 12, 12, '2024-03-05'),
('34567890129', 'Larissa', 'Rocha', '81987654313', 
'larissa.rocha@email.com', 5, 13, 13, '2024-03-10'),
('45678901239', 'Renato', 'Souza', '81987654314', 
'renato.souza@email.com', 6, 14, 14, '2024-03-15'),
('56789012349', 'Camila', 'Carvalho', '81987654315', 
'camila.carvalho@email.com', 7, 15, 15, '2024-03-20'),
('67890123459', 'Marcos', 'Ribeiro', '81987654316', 
'marcos.ribeiro@email.com', 8, 16, 16, '2024-03-25'),
('78901234569', 'Lívia', 'Morais', '81987654317', 
'livia.morais@email.com', 1, 1, 17, '2024-01-12'),
('89012345679', 'Vitor', 'Leite', '81987654318', 
'vitor.leite@email.com', 2, 2, 18, '2024-01-18'),
('90123456790', 'Juliana', 'Cardoso', '81987654319', 
'juliana.cardoso@email.com', 3, 3, 19, '2024-01-24'),
('01234567899', 'Roberto', 'Bastos', '81987654320', 
'roberto.bastos@email.com', 4, 4, 20, '2024-02-02'),
('12345678908', 'Carla', 'Dias', '81987654321', 
'carla.dias@email.com', 5, 5, 21, '2024-02-08'),
('23456789018', 'Rodrigo', 'Pinto', '81987654322', 
'rodrigo.pinto@email.com', 6, 6, 22, '2024-02-14'),
('34567890128', 'Tatiana', 'Neves', '81987654323', 
'tatiana.neves@email.com', 7, 7, 23, '2024-02-22'),
('45678901238', 'Felipe', 'Machado', '81987654324', 
'felipe.machado@email.com', 8, 8, 24, '2024-02-28'),
('56789012348', 'Sabrina', 'Figueiredo', '81987654325', 
'sabrina.figueiredo@email.com', 1, 9, 25, '2024-03-06'),
('67890123458', 'Thiago', 'Barbosa', '81987654326', 
'thiago.barbosa@email.com', 2, 10, 26, '2024-03-12'),
('78901234568', 'Beatriz', 'Queiroz', '81987654327', 
'beatriz.queiroz@email.com', 3, 10, 27, '2024-03-18'),
('89012345680', 'Gustavo', 'Nunes', '81987654328', 
'gustavo.nunes@email.com', 4, 12, 28, '2024-03-24'),
('90123456788', 'Cecília', 'Monteiro', '81987654329', 
'cecilia.monteiro@email.com', 5, 10, 29, '2024-01-14'),
('01234567898', 'Igor', 'Silveira', '81987654330', 
'igor.silveira@email.com', 6, 14, 30, '2024-01-22'),
('12345678907', 'Monica', 'Freitas', '81987654331', 
'monica.freitas@email.com', 7, 15, 31, '2024-01-30'),
('23456789017', 'Andre', 'Correia', '81987654332', 
'andre.correia@email.com', 8, 16, 32, '2024-02-07');
```
**Clientes**
```sql
INSERT INTO Clientes (cliente_id, nome, telefone, email, endereco_id) VALUES
(1, 'Roberto Silva', '81900001111', 'roberto.silva@email.com', 33),
(2, 'Mariana Gomes', '81900002222', 'mariana.gomes@email.com', 34),
(3, 'Carlos Eduardo', '81900003333', 'carlos.eduardo@email.com', 35),
(4, 'Fernanda Castro', '81900004444', 'fernanda.castro@email.com', 36),
(5, 'Lucas Clodoaldo', '81900005555', 'lucas.martins@email.com', 37),
(6, 'Patricia Nobrega', '81900006666', 'patricia.nobrega@email.com', 38),
(7, 'Juliana Moraes', '81900007777', 'juliana.moraes@email.com', 39),
(8, 'Ricardo Almeida', '81900008888', 'ricardo.almeida@email.com', 40),
(9, 'Ana Beatriz', '81900009999', 'ana.beatriz@email.com', 41),
(10, 'Tiago Ramos', '81900001010', 'tiago.ramos@email.com', 42),
(11, 'Sandra Neves', '81900001111', 'sandra.neves@email.com', 43),
(12, 'Paulo Freitas', '81900001212', 'paulo.freitas@email.com', 44),
(13, 'Beatriz Lima', '81900001313', 'beatriz.lima@email.com', 45),
(14, 'Alexandre Torres', '81900001414', 'alexandre.torres@email.com', 46),
(15, 'Leticia Moura', '81900001515', 'leticia.moura@email.com', 47),
(16, 'Gabriel Costa', '81900001616', 'gabriel.costa@email.com', 48),
(17, 'Regina Castro', '81900001717', 'regina.castro@email.com', 49),
(18, 'André Gomes', '81900001818', 'andre.gomes@email.com', 50),
(19, 'Camila Rocha', '81900001919', 'camila.rocha@email.com', 51),
(20, 'Felipe Souza', '81900002020', 'felipe.souza@email.com', 52),
(21, 'Larissa Ribeiro', '81900002121', 'larissa.ribeiro@email.com', 53),
(22, 'Cesar Martins', '81900002222', 'cesar.martins@email.com', 54),
(23, 'Daniela Silva', '81900002323', 'daniela.silva@email.com', 55),
(24, 'Gustavo Pereira', '81900002424', 'gustavo.pereira@email.com', 56),
(25, 'Bianca Oliveira', '81900002525', 'bianca.oliveira@email.com', 57),
(26, 'Rodrigo Lima', '81900002626', 'rodrigo.lima@email.com', 58),
(27, 'Fernando Campos', '81900002727', 'fernando.campos@email.com', 59),
(28, 'Alice Santos', '81900002828', 'alice.santos@email.com', 60),
(29, 'Marcelo Almeida', '81900002929', 'marcelo.almeida@email.com', 61),
(30, 'Carla Diaz', '81900003030', 'carla.diaz@email.com', 62),
(31, 'Rafaela Mendes', '81900003131', 'rafaela.mendes@email.com', 63),
(32, 'Vinicius Morais', '81900003232', 'vinicius.morais@email.com', 64),
(33, 'Patricia Correia', '81900003333', 'patricia.correia@email.com', 65),
(34, 'Eduardo Barros', '81900003434', 'eduardo.barros@email.com', 66),
(35, 'Teresa Cardoso', '81900003535', 'teresa.cardoso@email.com', 67),
(36, 'Bruno Ferreira', '81900003636', 'bruno.ferreira@email.com', 68),
(37, 'Monica Souza', '81900003737', 'monica.souza@email.com', 69),
(38, 'Cláudio Ramos', '81900003838', 'claudio.ramos@email.com', 70),
(39, 'Eliana Ribeiro', '81900003939', 'eliana.ribeiro@email.com', 71),
(40, 'Diogo Moura', '81900004040', 'diogo.moura@email.com', 72),
(41, 'Isabela Neves', '81900004141', 'isabela.neves@email.com', 73),
(42, 'Marcela Gomes', '81900004242', 'marcela.gomes@email.com', 74),
(43, 'Ricardo Nogueira', '81900004343', 'ricardo.nogueira@email.com', 75),
(44, 'Julia Lima', '81900004444', 'julia.lima@email.com', 76),
(45, 'Heitor Torres', '81900004545', 'heitor.torres@email.com', 77),
(46, 'Renata Moura', '81900004646', 'renata.moura@email.com', 78),
(47, 'Luciano Costa', '81900004747', 'luciano.costa@email.com', 79),
(48, 'Cecilia Castro', '81900004848', 'cecilia.castro@email.com', 80),
(49, 'Marco Andrade', '81900004949', 'marco.andrade@email.com', 81),
(50, 'Luana Rocha', '81900005050', 'luana.rocha@email.com', 82),
(51, 'Nelson Souza', '81900005151', 'nelson.souza@email.com', 83),
(52, 'Giovanna Ribeiro', '81900005252', 'giovanna.ribeiro@email.com', 84),
(53, 'Matheus Barros', '81900005353', 'matheus.barros@email.com', 85),
(54, 'Fabiana Oliveira', '81900005454', 'fabiana.oliveira@email.com', 86),
(55, 'Hugo Lima', '81900005555', 'hugo.lima@email.com', 87),
(56, 'Lívia Campos', '81900005656', 'livia.campos@email.com', 88),
(57, 'Rodrigo Santos', '81900005757', 'rodrigo.santos@email.com', 89),
(58, 'Elena Almeida', '81900005858', 'elena.almeida@email.com', 90),
(59, 'Sérgio Dias', '81900005959', 'sergio.dias@email.com', 91),
(60, 'Raquel Mendes', '81900006060', 'raquel.mendes@email.com', 92),
(61, 'Otávio Morais', '81900006161', 'otavio.morais@email.com', 93),
(62, 'Simone Correia', '81900006262', 'simone.correia@email.com', 94),
(63, 'Flávio Barros', '81900006363', 'flavio.barros@email.com', 95),
(64, 'Daniela Cardoso', '81900006464', 'daniela.cardoso@email.com', 96),
(65, 'Igor Ferreira', '81900006565', 'igor.ferreira@email.com', 97),
(66, 'Sabrina Souza', '81900006666', 'sabrina.souza@email.com', 98),
(67, 'André Ramos', '81900006767', 'andre.ramos@email.com', 99),
(68, 'Catarina Ribeiro', '81900006868', 'catarina.ribeiro@email.com', 100),
(69, 'Felipe Moura', '81900006969', 'felipe.moura@email.com', 101),
(70, 'Bianca Neves', '81900007070', 'bianca.neves@email.com', 102),
(71, 'Gustavo Gomes', '81900007171', 'gustavo.gomes@email.com', 103),
(72, 'Leticia Lima', '81900007272', 'leticia.lima@email.com', 104),
(73, 'Eduardo Torres', '81900007373', 'eduardo.torres@email.com', 105),
(74, 'Veronica Moura', '81900007474', 'veronica.moura@email.com', 106),
(75, 'Roberto Costa', '81900007575', 'roberto.costa@email.com', 107),
(76, 'Fernanda Almeida', '81900007676', 'fernanda.castro@email.com', 108),
(77, 'Lucas Martins', '81900007777', 'lucas.martins@email.com', 109),
(78, 'Claudio Nobrega', '81900007878', 'patricia.nobrega@email.com', 110),
(79, 'Maria Cecilia', '81900007979', 'juliana.moraes@email.com', 111),
(80, 'Jose Mario', '81900008080', 'ricardo.almeida@email.com', 112),
(81, 'Ana Lucia', '81900008181', 'ana.beatriz@email.com', 113),
(82, 'Tiago Silva', '81900008282', 'tiago.ramos@email.com', 114),
(83, 'Severina Maria', '81900008383', 'sandra.neves@email.com', 115),
(84, 'Paulo Franca', '81900008484', 'paulo.freitas@email.com', 116),
(85, 'Williams Fernandes', '81900008585', 'beatriz.lima@email.com', 117),
(86, 'Saulo Franca', '81900008686', 'alexandre.torres@email.com', 118),
(87, 'Sanderson Franca', '81900008787', 'leticia.moura@email.com', 119),
(88, 'Antônio Nunes Franca', '81900008888', 'gabriel.costa@email.com', 120),
(89, 'Carla Castro', '81900008989', 'regina.castro@email.com', 121),
(90, 'Jonatha Franca', '81900009090', 'andre.gomes@email.com', 122),
(91, 'Camila Soares', '81900009191', 'camila.rocha@email.com', 123),
(92, 'Genobeva Souza', '81900009292', 'felipe.souza@email.com', 124),
(93, 'Severina Ribeiro', '81900009393', 'larissa.ribeiro@email.com', 125),
(94, 'Jacinta Martins', '81900009494', 'cesar.martins@email.com', 126),
(95, 'Vanessa Silva', '81900009595', 'daniela.silva@email.com', 127),
(96, 'Augusto Pereira', '81900009696', 'gustavo.pereira@email.com', 128),
(97, 'Bianca Barbosa', '81900009797', 'bianca.oliveira@email.com', 129),
(98, 'Arnaldo Cesar', '81900009898', 'rodrigo.lima@email.com', 130),
(99, 'Fernanda Campos', '81900009999', 'fernando.campos@email.com', 131),
(100, 'Maysa Santos', '81900010000', 'alice.santos@email.com', 132);
```
**TipoCliente**
```sql
INSERT INTO Editora.TipoCliente (num_doc, tipo, cliente_id) VALUES
('123.456.789-00', 'pf', 1),
('234.567.890-01', 'pf', 2),
('345.678.901-02', 'pf', 3),
('456.789.012-03', 'pf', 4),
('567.890.123-04', 'pf', 5),
('678.901.234-05', 'pf', 6),
('789.012.345-06', 'pf', 7),
('890.123.456-07', 'pf', 8),
('901.234.567-08', 'pf', 9),
('012.345.678-09', 'pf', 10),
('12.345.678/0002-90', 'pj', 11),
('23.456.789/0002-80', 'pj', 12),
('34.567.890/0002-70', 'pj', 13),
('45.678.901/0002-60', 'pj', 14),
('56.789.012/0002-50', 'pj', 15),
('67.890.123/0002-40', 'pj', 16),
('78.901.234/0002-30', 'pj', 17),
('89.012.345/0002-20', 'pj', 18),
('90.123.456/0002-10', 'pj', 19),
('01.234.567/0002-00', 'pj', 20),
('12.345.678/0003-90', 'pj', 21),
('23.456.789/0003-80', 'pj', 22),
('34.567.890/0003-70', 'pj', 23),
('45.678.901/0003-60', 'pj', 24),
('56.789.012/0003-50', 'pj', 25),
('67.890.123/0003-40', 'pj', 26),
('78.901.234/0003-30', 'pj', 27),
('89.012.345/0003-20', 'pj', 28),
('90.123.456/0003-10', 'pj', 29),
('01.234.567/0003-00', 'pj', 30),
('12.345.678/0004-90', 'pj', 31),
('23.456.789/0004-80', 'pj', 32),
('34.567.890/0004-70', 'pj', 33),
('45.678.901/0004-60', 'pj', 34),
('56.789.012/0004-50', 'pj', 35),
('67.890.123/0004-40', 'pj', 36),
('78.901.234/0004-30', 'pj', 37),
('89.012.345/0004-20', 'pj', 38),
('90.123.456/0004-10', 'pj', 39),
('01.234.567/0004-00', 'pj', 40),
('12.345.678/0005-90', 'pj', 41),
('23.456.789/0005-80', 'pj', 42),
('34.567.890/0005-70', 'pj', 43),
('45.678.901/0005-60', 'pj', 44),
('56.789.012/0005-50', 'pj', 45),
('67.890.123/0005-40', 'pj', 46),
('78.901.234/0005-30', 'pj', 47),
('89.012.345/0005-20', 'pj', 48),
('90.123.456/0005-10', 'pj', 49),
('01.234.567/0005-00', 'pj', 50),
('987.654.321-00', 'pf', 51),
('876.543.210-01', 'pf', 52),
('765.432.109-02', 'pf', 53),
('654.321.098-03', 'pf', 54),
('543.210.987-04', 'pf', 55),
('432.109.876-05', 'pf', 56),
('321.098.765-06', 'pf', 57),
('210.987.654-07', 'pf', 58),
('109.876.543-08', 'pf', 59),
('098.765.432-09', 'pf', 60),
('987.654.321-10', 'pf', 61),
('876.543.210-11', 'pf', 62),
('765.432.109-12', 'pf', 63),
('654.321.098-13', 'pf', 64),
('543.210.987-14', 'pf', 65),
('432.109.876-15', 'pf', 66),
('321.098.765-16', 'pf', 67),
('210.987.654-17', 'pf', 68),
('109.876.543-18', 'pf', 69),
('098.765.432-19', 'pf', 70),
('987.654.321-20', 'pf', 71),
('876.543.210-21', 'pf', 72),
('765.432.109-22', 'pf', 73),
('654.321.098-23', 'pf', 74),
('543.210.987-24', 'pf', 75),
('432.109.876-25', 'pf', 76),
('321.098.765-26', 'pf', 77),
('210.987.654-27', 'pf', 78),
('109.876.543-28', 'pf', 79),
('098.765.432-29', 'pf', 80),
('987.654.321-30', 'pf', 81),
('876.543.210-31', 'pf', 82),
('765.432.109-32', 'pf', 83),
('654.321.098-33', 'pf', 84),
('543.210.987-34', 'pf', 85),
('432.109.876-35', 'pf', 86),
('321.098.765-36', 'pf', 87),
('210.987.654-37', 'pf', 88),
('109.876.543-38', 'pf', 89),
('098.765.432-39', 'pf', 90),
('987.654.321-40', 'pf', 91),
('876.543.210-41', 'pf', 92),
('765.432.109-42', 'pf', 93),
('654.321.098-43', 'pf', 94),
('543.210.987-44', 'pf', 95),
('432.109.876-45', 'pf', 96),
('321.098.765-46', 'pf', 97),
('210.987.654-47', 'pf', 98),
('109.876.543-48', 'pf', 99),
('098.765.432-49', 'pf', 100);
```
**StatusPedido**
```sql
INSERT INTO Editora.StatusPedido (status) VALUES
('Pendente'),
('Processando'),
('Enviado'),
('Entregue'),
('Cancelado'),
('Devolvido'),
('Aguardando Pagamento'),
('Pagamento Confirmado'),
('Em Separação'),
('Pronto para Retirada');
```
**TipoPagamento**
```sql
INSERT INTO Editora.TipoPagamento (tipoPgto) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Boleto Bancário'),
('Transferência Bancária'),
('Pix'),
('PayPal'),
('Apple Pay'),
('Google Pay'),
('Cheque'),
('Dinheiro');
```
**Descontos**
```sql
 INSERT INTO Editora.Descontos (descontos) VALUES
(5),
(10),
(15),
(20),
(25),
(30);
```
**StatusEstoque**
```sql
 INSERT INTO Editora.StatusEstoque (status_livros) VALUES
('Disponível'),
('Indisponível'),
('Reservado'),
('Esgotado'),
('Dano');
```
**Autores**
```sql
INSERT INTO Autores (autor_id, nome, nacionalidade, data_nasc) VALUES
(1, 'J.R.R. Tolkien', 'Britânico', '1892-01-03'),
(2, 'Gabriel García Márquez', 'Colombiano', '1927-03-06'),
(3, 'Miguel de Cervantes', 'Espanhol', '1547-09-29'),
(4, 'Umberto Eco', 'Italiano', '1932-01-05'),
(5, 'George Orwell', 'Britânico', '1903-06-25'),
(6, 'Jane Austen', 'Britânica', '1775-12-16'),
(7, 'George R.R. Martin', 'Americano', '1948-09-20'),
(8, 'Markus Zusak', 'Australiano', '1975-06-23'),
(9, 'Dan Brown', 'Americano', '1964-06-22');
```
**Áreas Conhecimento**
```sql
INSERT INTO Editora.AreasConhecto (area_id, areas) VALUES
(1, 'Literatura Fantástica'),
(2, 'Realismo Mágico'),
(3, 'Cavalaria'),
(4, 'Ficção Histórica'),
(5, 'Ficção Distópica'),
(6, 'Romance'),
(7, 'Fantasia Épica'),
(8, 'Ficção Jovem Adulto'),
(9, 'Mistério'),
(10, 'Thriller');
```
**Gênero**
```sql
INSERT INTO Editora.Generos (genero_id, generos) VALUES
(1, 'Fantasia'),
(2, 'Ficção Científica'),
(3, 'Romance'),
(4, 'Aventura'),
(5, 'Mistério'),
(6, 'Distopia'),
(7, 'Terror'),
(8, 'Biografia'),
(9, 'Autoajuda');
```
**PavavrasChave**
```sql
INSERT INTO PalavrasChave (palavra_id, palavras) VALUES
(1, 'Tolkien, Fantasia, Terra-média'),
(2, 'Hobbits, Dragões, Anéis'),
(3, 'Realismo Mágico, América Latina, Macondo'),
(4, 'Cavalaria, Espanha, Dom Quixote'),
(5, 'Medieval, Mistério, Abadia'),
(6, 'Distópico, Vigilância, Totalitarismo'),
(7, 'Era da Regência, Classe Social, Amor'),
(8, 'Westeros, Dragões, Lutas pelo Poder'),
(9, 'Alemanha Nazista, Livros, Resistência'),
(10, 'Sociedades Secretas, Historia, Arte'),
(11, 'Gabriel García Márquez, Realismo Mágico'),
(12, 'Família Buendía, Macondo, Solidão'),
(13, 'Miguel de Cervantes, Cavalaria, Idade Média'),
(14, 'Dom Quixote, Sancho Pança, Sátira'),
(15, 'Umberto Eco, Ficção Histórica, Investigação'),
(16, 'Guilherme de Baskerville, Abadia, Assassinato'),
(17, 'George Orwell, Ficção Distópica, Grande Irmão'),
(18, 'Winston Smith, Big Brother, Totalitarismo'),
(19, 'Jane Austen, Era, Regência, Sociedade'),
(20, 'Elizabeth Bennet, Mr. Darcy, Preconceito'),
(21, 'George R.R. Martin, Fantasia Épica, Westeros'),
(22, 'Jon Snow, Daenerys Targaryen, Trono de Ferro'),
(23, 'Markus Zusak, Ficção, Histórica, Nazista'),
(24, 'Liesel Meminger, Max Vandenburg, Livros'),
(25, 'Dan Brown, Mistério, Símbolos'),
(26, 'Robert Langdon, Jacques Saunière, Da Vinci');
```
**Acervo**
```sql
INSERT INTO Acervo (isbn_id, titulo, num_pag, data_public) VALUES
('103573', 'O Senhor dos Anéis: A Sociedade do Anel', 423, '1954-07-29'),
('103580', 'O Senhor dos Anéis: As Duas Torres', 352, '1954-11-11'),
('103597', 'O Senhor dos Anéis: O Retorno do Rei', 416, '1955-10-20'),
('103283', 'O Hobbit', 310, '1937-09-21'),
('137275', 'O Silmarillion', 365, '1977-09-15'),
('883287', 'Cem Anos de Solidão', 417, '1967-06-05'),
('034956', 'O Amor nos Tempos do Cólera', 348, '1985-10-05'),
('729186', 'Crônica de uma Morte Anunciada', 122, '1981-04-12'),
('138143', 'Doze Contos Peregrinos', 192, '1992-11-10'),
('046895', 'Memória de Minhas Putas Tristes', 109, '2004-10-27'),
('487271', 'Dom Quixote', 1072, '1605-01-16'),
('467283', 'Novelas Exemplares', 480, '1613-07-25'),
('604947', 'O Engenhoso Fidalgo Dom Quixote de la Mancha', 1104, '1605-01-16'),
('051334', 'A Galatea', 320, '1585-09-06'),
('624044', 'Viagem ao Parnaso', 128, '1614-12-07'),
('292610', 'O Nome da Rosa', 512, '1980-11-09'),
('292634', 'O Pêndulo de Foucault', 656, '1988-10-25'),
('298285', 'Baudolino', 527, '2000-11-15'),
('292611', 'A Ilha do Dia Antes', 513, '1994-10-11'),
('292635', 'Número Zero', 224, '2015-05-19'),
('524935', '1984', 328, '1949-06-08'),
('526342', 'A Revolução dos Bichos', 112, '1945-08-17'),
('660384', 'A Caminho de Wigan Pier', 264, '1937-03-08'),
('196253', 'Homage to Catalonia', 232, '1938-10-20'),
('572178', 'Keep the Aspidistra Flying', 267, '1936-04-20'),
('803733', 'Orgulho e Preconceito', 432, '1813-01-28'),
('833556', 'Emma', 474, '1815-12-25'),
('290563', 'Razão e Sensibilidade', 409, '1811-10-30'),
('128064', 'Mansfield Park', 560, '1814-07-09'),
('350803', 'Persuasão', 272, '1818-12-20'),
('805444', 'A Guerra dos Tronos', 694, '1996-08-06'),
('579901', 'A Fúria dos Reis', 768, '1999-02-02'),
('573428', 'A Tormenta de Espadas', 992, '2000-11-08'),
('582024', 'O Festim dos Corvos', 784, '2005-10-17'),
('801477', 'A Dança dos Dragões', 1040, '2011-07-12'),
('337271', 'A Menina que Roubava Livros', 560, '2005-09-01'),
('368619', 'Eu Sou o Mensageiro', 357, '2002-10-09'),
('378212', 'When Dogs Cry', 208, '2001-08-01'),
('337288', 'Bridge of Clay', 560, '2018-10-09'),
('378229', 'The Underdog', 174, '1999-03-09'),
('272933', 'O Código Da Vinci', 489, '2003-03-18'),
('493468', 'Anjos e Demônios', 616, '2000-05-03'),
('278348', 'O Símbolo Perdido', 509, '2009-09-15'),
('537858', 'Inferno', 480, '2013-05-14'),
('474278', 'Origem', 456, '2017-10-03');
```
**Livros_por_Autores**
```sql
INSERT INTO Livros_por_Autores (isbn_id, autor_id) VALUES
('103573', 1),  -- J.R.R. Tolkien
('103580', 1),  -- J.R.R. Tolkien
('103597', 1),  -- J.R.R. Tolkien
('103283', 1),  -- J.R.R. Tolkien
('137275', 1),  -- J.R.R. Tolkien
('883287', 2),  -- Gabriel García Márquez
('034956', 2),  -- Gabriel García Márquez
('729186', 2),  -- Gabriel García Márquez
('138143', 2),  -- Gabriel García Márquez
('046895', 2),  -- Gabriel García Márquez
('487271', 3),  -- Miguel de Cervantes
('467283', 3),  -- Miguel de Cervantes
('604947', 3),  -- Miguel de Cervantes
('051334', 3),  -- Miguel de Cervantes
('624044', 3),  -- Miguel de Cervantes
('292610', 4),  -- Umberto Eco
('292634', 4),  -- Umberto Eco
('298285', 4),  -- Umberto Eco
('292611', 4),  -- Umberto Eco
('292635', 4),  -- Umberto Eco
('524935', 5),  -- George Orwell
('526342', 5),  -- George Orwell
('660384', 5),  -- George Orwell
('196253', 5),  -- George Orwell
('572178', 5),  -- George Orwell
('803733', 6),  -- Jane Austen
('833556', 6),  -- Jane Austen
('290563', 6),  -- Jane Austen
('128064', 6),  -- Jane Austen
('350803', 6),  -- Jane Austen
('805444', 7),  -- George R.R. Martin
('579901', 7),  -- George R.R. Martin
('573428', 7),  -- George R.R. Martin
('582024', 7),  -- George R.R. Martin
('801477', 7),  -- George R.R. Martin
('337271', 8),  -- Markus Zusak
('368619', 8),  -- Markus Zusak
('378212', 8),  -- Markus Zusak
('337288', 8),  -- Markus Zusak
('378229', 8),  -- Markus Zusak
('272933', 9),  -- Dan Brown
('493468', 9),  -- Dan Brown
('278348', 9),  -- Dan Brown
('537858', 9),  -- Dan Brown
('474278', 9);  -- Dan Brown
```
**Livros_por_AreasConhecto**
```sql
INSERT INTO Livros_por_AreasConhecto (isbn_id, area_id) VALUES
('103573', 1), -- O Senhor dos Anéis: A Sociedade do Anel, Literatura Fantástica
('103283', 1), -- O Hobbit, Literatura Fantástica
('883287', 2), -- Cem Anos de Solidão, Realismo Mágico
('487271', 3), -- Dom Quixote, Cavalaria
('292610', 4), -- O Nome da Rosa, Ficção Histórica e Mistério
('524935', 5), -- 1984, Ficção Distópica
('803733', 6), -- Orgulho e Preconceito, Romance
('805444', 7), -- A Guerra dos Tronos, Fantasia Épica
('337271', 8), -- A Menina que Roubava Livros, Ficção Histórica e Jovem Adulto
('272933', 9), -- O Código Da Vinci, Mistério e Thriller
('103580', 1), -- O Senhor dos Anéis: As Duas Torres, Literatura Fantástica
('103597', 1), -- O Senhor dos Anéis: O Retorno do Rei, Literatura Fantástica
('137275', 1), -- O Silmarillion, Literatura Fantástica
('034956', 2), -- O Amor nos Tempos do Cólera, Realismo Mágico
('729186', 2), -- Crônica de uma Morte Anunciada, Realismo Mágico
('138143', 2), -- Doze Contos Peregrinos, Realismo Mágico
('046895', 2), -- Memória de Minhas Putas Tristes, Realismo Mágico
('467283', 3), -- Novelas Exemplares, Cavalaria
('604947', 3), -- O Engenhoso Fidalgo Dom Quixote de la Mancha, Cavalaria
('051334', 3), -- A Galatea, Cavalaria
('624044', 3), -- Viagem ao Parnaso, Cavalaria
('292634', 4), -- O Pêndulo de Foucault, Ficção Histórica e Mistério
('298285', 4), -- Baudolino, Ficção Histórica e Mistério
('292611', 4), -- A Ilha do Dia Antes, Ficção Histórica e Mistério
('292635', 4), -- Número Zero, Ficção Histórica e Mistério
('526342', 5), -- A Revolução dos Bichos, Ficção Distópica
('660384', 5), -- A Caminho de Wigan Pier, Ficção Distópica
('196253', 5), -- Homage to Catalonia, Ficção Distópica
('572178', 5), -- Keep the Aspidistra Flying, Ficção Distópica
('833556', 6), -- Emma, Romance
('290563', 6), -- Razão e Sensibilidade, Romance
('128064', 6), -- Mansfield Park, Romance
('350803', 6), -- Persuasão, Romance
('579901', 7), -- A Fúria dos Reis, Fantasia Épica
('573428', 7), -- A Tormenta de Espadas, Fantasia Épica
('582024', 7), -- O Festim dos Corvos, Fantasia Épica
('801477', 7), -- A Dança dos Dragões, Fantasia Épica
('368619', 8), -- Eu Sou o Mensageiro, Ficção Histórica e Jovem Adulto
('378212', 8), -- When Dogs Cry, Ficção Histórica e Jovem Adulto
('337288', 8), -- Bridge of Clay, Ficção Histórica e Jovem Adulto
('378229', 8), -- The Underdog, Ficção Histórica e Jovem Adulto
('493468', 9), -- Anjos e Demônios, Mistério e Thriller
('278348', 9), -- O Símbolo Perdido, Mistério e Thriller
('537858', 9), -- Inferno, Mistério e Thriller
('474278', 9); -- Origem, Mistério e Thriller
```
**Livros_por_PalavrasChave**
```sql
INSERT INTO Livros_por_PalavrasChave (isbn_id, palavra_id) VALUES
('103573', 1),
('103573', 2),
('103573', 3),
('103580', 1),
('103580', 2),
('103580', 3),
('103597', 1),
('103597', 2),
('103597', 3),
('103283', 1),
('103283', 2),
('103283', 3),
('137275', 1),
('137275', 2),
('137275', 3),
('883287', 11),
('883287', 12),
('883287', 21),
('034956', 11),
('034956', 12),
('034956', 21),
('729186', 11),
('729186', 12),
('729186', 21),
('138143', 11),
('138143', 12),
('138143', 21),
('046895', 11),
('046895', 12),
('046895', 21),
('487271', 14),
('487271', 23),
('487271', 24),
('467283', 14),
('467283', 23),
('467283', 24),
('604947', 14),
('604947', 23),
('604947', 24),
('051334', 14),
('051334', 23),
('051334', 24),
('624044', 14),
('624044', 23),
('624044', 24),
('292610', 15),
('292610', 25),
('292610', 26),
('292634', 15),
('292634', 25),
('292634', 26),
('298285', 15),
('298285', 25),
('298285', 26),
('292611', 15),
('292611', 25),
('292611', 26),
('292635', 15),
('292635', 25),
('292635', 26),
('524935', 6),
('526342', 6),
('660384', 6),
('196253', 6),
('572178', 6),
('803733', 7),
('833556', 7),
('290563', 7),
('128064', 7),
('350803', 7),
('805444', 8),
('579901', 8),
('573428', 8),
('582024', 8),
('801477', 8),
('337271', 9),
('378212', 9),
('337288', 9),
('378229', 9),
('272933', 10),
('493468', 10),
('278348', 10),
('537858', 10),
('474278', 10);
```
**Genero_por_Livros**
```sql
INSERT INTO Genero_por_Livros (genero_id, isbn_id) VALUES
(1, '103573'), -- Literatura Fantástica
(1, '103580'), -- Literatura Fantástica
(1, '103597'), -- Literatura Fantástica
(1, '103283'), -- Literatura Fantástica
(1, '137275'), -- Literatura Fantástica
(2, '883287'), -- Realismo Mágico
(2, '034956'), -- Realismo Mágico
(2, '729186'), -- Realismo Mágico
(2, '138143'), -- Realismo Mágico
(2, '046895'), -- Realismo Mágico
(3, '487271'), -- Clássico
(3, '467283'), -- Clássico
(3, '604947'), -- Clássico
(3, '051334'), -- Clássico
(3, '624044'), -- Clássico
(4, '292610'), -- Ficção Histórica
(4, '292634'), -- Ficção Histórica
(4, '298285'), -- Ficção Histórica
(4, '292611'), -- Ficção Histórica
(4, '292635'), -- Ficção Histórica
(5, '524935'), -- Ficção Distópica
(5, '526342'), -- Ficção Distópica
(5, '660384'), -- Ficção Distópica
(5, '196253'), -- Ficção Distópica
(5, '572178'), -- Ficção Distópica
(6, '803733'), -- Romance
(6, '833556'), -- Romance
(6, '290563'), -- Romance
(6, '128064'), -- Romance
(6, '350803'), -- Romance
(7, '805444'), -- Fantasia Épica
(7, '579901'), -- Fantasia Épica
(7, '573428'), -- Fantasia Épica
(7, '582024'), -- Fantasia Épica
(7, '801477'), -- Fantasia Épica
(8, '337271'), -- Ficção Histórica
(8, '368619'), -- Ficção Histórica
(8, '378212'), -- Ficção Histórica
(8, '337288'), -- Ficção Histórica
(8, '378229'), -- Ficção Histórica
(9, '272933'), -- Thriller
(9, '493468'), -- Thriller
(9, '278348'), -- Thriller
(9, '537858'), -- Thriller
(9, '474278'); -- Thriller
```
**Estoque**
```sql
INSERT INTO Estoque (
  exemplar_id, localizacao_fisica, 
  num_serie, valor_unit, quantidade,
   isbn_id, statusEstoque_id) VALUES
(1,'prateleira A1-B1-C1','SN0001',40.00,150,103573,1),
(2,'prateleira A1-B1-C2','SN0002',40.00,120,103580,1),
(3,'prateleira A1-B1-C3','SN0003',40.00,200,103597,1),
(4,'prateleira A1-B1-C4','SN0004',35.00,220,103283,1),
(5,'prateleira A1-B1-C5','SN0005',30.00,250,137275,1),
(6,'prateleira A1-B2-C1','SN0006',35.00,140,883287,1),
(7,'prateleira A1-B2-C2','SN0007',35.00,180,34956,1),
(8,'prateleira A1-B2-C3','SN0008',25.00,160,729186,1),
(9,'prateleira A1-B2-C4','SN0009',25.00,230,138143,1),
(10,'prateleira A1-B2-C5','SN0010',30.00,200,46895,1),
(11,'prateleira A1-B3-C1','SN0011',30.00,200,487271,1),
(12,'prateleira A1-B3-C2','SN0012',25.00,200,467283,1),
(13,'prateleira A1-B3-C3','SN0013',35.00,175,604947,1),
(14,'prateleira A1-B3-C4','SN0014',30.00,190,51334,1),
(15,'prateleira A1-B3-C5','SN0015',30.00,125,624044,1),
(16,'prateleira A1-B4-C1','SN0016',30.00,300,292610,1),
(17,'prateleira A1-B4-C2','SN0017',30.00,280,292634,1),
(18,'prateleira A1-B4-C3','SN0018',40.00,260,298285,1),
(19,'prateleira A1-B4-C4','SN0019',35.00,270,292611,1),
(20,'prateleira A1-B4-C5','SN0020',30.00,290,292635,1),
(21,'prateleira A2-B1-C1','SN0021',30.00,240,524935,1),
(22,'prateleira A2-B1-C2','SN0022',20.00,255,526342,1),
(23,'prateleira A2-B1-C3','SN0023',40.00,235,660384,1),
(24,'prateleira A2-B1-C4','SN0024',30.00,215,196253,1),
(25,'prateleira A2-B1-C5','SN0025',30.00,195,572178,1),
(26,'prateleira A2-B2-C1','SN0026',30.00,110,803733,1),
(27,'prateleira A2-B2-C2','SN0027',35.00,115,833556,1),
(28,'prateleira A2-B2-C3','SN0028',30.00,300,290563,1),
(29,'prateleira A2-B2-C4','SN0029',35.00,310,128064,1),
(30,'prateleira A2-B2-C5','SN0030',30.00,320,350803,1),
(31,'prateleira A2-B3-C1','SN0031',40.00,330,805444,1),
(32,'prateleira A2-B3-C2','SN0032',40.00,340,579901,1),
(33,'prateleira A2-B3-C3','SN0033',50.00,350,573428,1),
(34,'prateleira A2-B3-C4','SN0034',50.00,325,582024,1),
(35,'prateleira A2-B3-C5','SN0035',50.00,335,801477,1),
(36,'prateleira A2-B4-C1','SN0036',30.00,105,337271,1),
(37,'prateleira A2-B4-C2','SN0037',25.00,345,368619,1),
(38,'prateleira A2-B4-C3','SN0038',25.00,100,378212,1),
(39,'prateleira A2-B4-C4','SN0039',45.00,110,337288,1),
(40,'prateleira A2-B4-C5','SN0040',25.00,120,378229,1),
(41,'prateleira A3-B1-C1','SN0041',30.00,130,272933,1),
(42,'prateleira A3-B1-C2','SN0042',30.00,140,493468,1),
(43,'prateleira A3-B1-C3','SN0043',30.00,150,278348,1),
(44,'prateleira A3-B1-C4','SN0044',30.00,160,537858,1),
(45,'prateleira A3-B1-C5','SN0045',35.00,170,474278,1);
```
**Pedidos**
```sql
INSERT INTO Pedidos (
  pedido_id, data_pedido, valor_pedido, 
  funcionarios_cpf, cliente_id, statusPedido_id, tipoPgto_id) VALUES
(1,'2024-07-01',280.00,'12345678901',1,1,1),
(2,'2024-07-02',160.00,'23456789012',45,2,2),
(3,'2024-07-03',440.00,'34567890123',3,1,3),
(4,'2024-07-04',210.00,'45678901234',23,2,1),
(5,'2024-07-05',330.00,'56789012345',5,1,2),
(6,'2024-07-06',280.00,'67890123456',12,3,1),
(7,'2024-07-07',105.00,'78901234567',7,1,2),
(8,'2024-07-08',550.00,'89012345678',56,2,3),
(9,'2024-07-09',325.00,'90123456789',9,1,1),
(10,'2024-07-10',480.00,'12345678901',65,2,2),
(11,'2024-07-11',330.00,'12345678901',11,3,3),
(12,'2024-07-12',275.00,'23456789012',100,1,1),
(13,'2024-07-13',420.00,'34567890123',24,2,2),
(14,'2024-07-14',180.00,'45678901234',37,1,3),
(15,'2024-07-15',360.00,'56789012345',15,2,1),
(16,'2024-07-16',270.00,'67890123456',60,3,2),
(17,'2024-07-17',150.00,'78901234567',80,1,3),
(18,'2024-07-18',520.00,'89012345678',52,2,1),
(19,'2024-07-19',350.00,'90123456789',19,1,2),
(20,'2024-07-20',450.00,'12345678901',83,2,3),
(21,'2024-07-21',210.00,'12345678901',21,3,1),
(22,'2024-07-22',340.00,'23456789012',22,1,2),
(23,'2024-07-23',440.00,'34567890123',94,2,3),
(24,'2024-07-24',180.00,'45678901234',41,1,1),
(25,'2024-07-25',390.00,'56789012345',25,2,2),
(26,'2024-07-26',270.00,'67890123456',66,3,1),
(27,'2024-07-27',140.00,'78901234567',27,1,2),
(28,'2024-07-28',540.00,'89012345678',13,2,3),
(29,'2024-07-29',315.00,'90123456790',85,1,1),
(30,'2024-07-30',450.00,'12345678901',30,2,2),
(31,'2024-07-31',320.00,'12345678901',54,3,3),
(32,'2024-08-01',360.00,'23456789012',72,1,1),
(33,'2024-08-02',250.00,'34567890123',90,2,2),
(34,'2024-08-03',250.00,'45678901234',53,1,3),
(35,'2024-08-04',250.00,'56789012345',35,2,1),
(36,'2024-08-05',270.00,'67890123456',81,3,2),
(37,'2024-08-06',325.00,'78901234567',18,1,3),
(38,'2024-08-07',300.00,'89012345680',38,2,1),
(39,'2024-08-08',270.00,'90123456789',70,1,2),
(40,'2024-08-09',300.00,'12345678901',40,2,3),
(41,'2024-08-10',330.00,'12345678901',41,3,1),
(42,'2024-08-11',360.00,'23456789012',42,1,2),
(43,'2024-08-12',330.00,'34567890123',43,2,3),
(44,'2024-08-13',300.00,'45678901234',44,1,1),
(45,'2024-08-14',350.00,'56789012345',99,2,2),
(46,'2024-08-15',360.00,'67890123456',46,3,1),
(47,'2024-08-16',360.00,'78901234567',47,1,2),
(48,'2024-08-17',360.00,'89012345680',48,2,3),
(49,'2024-08-18',385.00,'90123456790',29,1,1),
(50,'2024-08-19',390.00,'12345678901',50,2,2),
(51,'2024-08-20',175.00,'12345678901',17,1,1),
(52,'2024-08-21',245.00,'23456789012',52,2,2),
(53,'2024-08-22',350.00,'34567890123',53,3,3),
(54,'2024-08-23',150.00,'45678901234',54,1,1),
(55,'2024-08-24',240.00,'56789012345',55,2,2),
(56,'2024-08-25',330.00,'67890123456',56,3,3),
(57,'2024-08-26',200.00,'78901234567',57,1,1),
(58,'2024-08-27',280.00,'89012345678',58,2,2),
(59,'2024-08-28',180.00,'90123456789',59,3,3),
(60,'2024-08-29',270.00,'12345678901',60,1,1),
(61,'2024-08-30',150.00,'12345678901',61,2,2),
(62,'2024-08-31',240.00,'23456789012',62,3,3),
(63,'2024-09-01',320.00,'34567890123',63,1,1),
(64,'2024-09-02',175.00,'45678901234',64,2,2),
(65,'2024-09-03',270.00,'56789012345',65,3,3),
(66,'2024-09-04',120.00,'67890123456',66,1,1),
(67,'2024-09-05',220.00,'78901234567',67,2,2),
(68,'2024-09-06',320.00,'89012345678',68,3,3),
(69,'2024-09-07',180.00,'90123456789',69,1,1),
(70,'2024-09-08',270.00,'12345678901',70,2,2),
(71,'2024-09-09',360.00,'12345678901',71,3,3),
(72,'2024-09-10',175.00,'23456789012',72,1,1),
(73,'2024-09-11',240.00,'34567890123',73,2,2),
(74,'2024-09-12',350.00,'45678901234',74,3,3),
(75,'2024-09-13',120.00,'56789012345',75,1,1),
(76,'2024-09-14',200.00,'67890123456',76,2,2),
(77,'2024-09-15',320.00,'78901234567',77,3,3),
(78,'2024-09-16',100.00,'89012345678',78,1,1),
(79,'2024-09-17',200.00,'90123456789',79,2,2),
(80,'2024-09-18',300.00,'12345678901',80,3,3),
(81,'2024-09-19',150.00,'12345678901',81,1,1),
(82,'2024-09-20',250.00,'23456789012',82,2,2),
(83,'2024-09-21',350.00,'34567890123',83,3,3),
(84,'2024-09-22',135.00,'45678901234',84,1,1),
(85,'2024-09-23',250.00,'56789012345',85,2,2),
(86,'2024-09-24',300.00,'67890123456',86,3,3),
(87,'2024-09-25',120.00,'78901234567',87,1,1),
(88,'2024-09-26',180.00,'89012345678',88,2,2),
(89,'2024-09-27',300.00,'90123456789',89,3,3),
(90,'2024-09-28',175.00,'12345678901',90,1,1),
(91,'2024-09-29',240.00,'12345678901',91,2,2),
(92,'2024-09-30',360.00,'23456789012',92,3,3),
(93,'2024-10-01',160.00,'34567890123',93,1,1),
(94,'2024-10-02',245.00,'45678901234',94,2,2),
(95,'2024-10-03',330.00,'56789012345',95,3,3),
(96,'2024-10-04',140.00,'67890123456',96,1,1),
(97,'2024-10-05',245.00,'78901234567',97,2,2),
(98,'2024-10-06',300.00,'89012345678',98,3,3),
(99,'2024-10-07',175.00,'90123456789',99,1,1),
(100,'2024-10-08',240.00,'12345678901',100,2,2),
(101,'2024-10-09',150.00,'12345678901',10,1,1),
(102,'2024-10-10',250.00,'23456789012',20,2,2),
(103,'2024-10-11',280.00,'34567890123',30,3,3),
(104,'2024-10-12',300.00,'45678901234',40,1,1),
(105,'2024-10-13',360.00,'56789012345',50,2,2),
(106,'2024-10-14',420.00,'67890123456',60,3,3),
(107,'2024-10-15',420.00,'78901234567',70,1,1),
(108,'2024-10-16',480.00,'89012345678',80,2,2),
(109,'2024-10-17',560.00,'90123456789',90,3,3),
(110,'2024-10-18',600.00,'12345678901',13,1,1),
(111,'2024-10-19',660.00,'12345678901',25,2,2),
(112,'2024-10-20',700.00,'23456789012',14,3,3),
(113,'2024-10-21',760.00,'34567890123',22,1,1),
(114,'2024-10-22',780.00,'45678901234',31,2,2),
(115,'2024-10-23',840.00,'56789012345',42,3,3),
(116,'2024-10-24',900.00,'67890123456',53,1,1),
(117,'2024-10-25',945.00,'78901234567',64,2,2),
(118,'2024-10-26',1050.00,'89012345678',75,3,3),
(119,'2024-10-27',1050.00,'90123456789',86,1,1),
(120,'2024-10-28',1080.00,'12345678901',97,2,2),
(121,'2024-10-29',1160.00,'12345678901',5,1,1),
(122,'2024-10-30',1200.00,'23456789012',10,2,2),
(123,'2024-10-31',1250.00,'34567890123',15,3,3),
(124,'2024-11-01',1300.00,'45678901234',20,1,1),
(125,'2024-11-02',1350.00,'56789012345',25,2,2),
(126,'2024-11-03',1350.00,'67890123456',30,3,3),
(127,'2024-11-04',1425.00,'78901234567',35,1,1),
(128,'2024-11-05',1500.00,'89012345678',40,2,2),
(129,'2024-11-06',1575.00,'90123456789',45,3,3),
(130,'2024-11-07',1625.00,'12345678901',50,1,1),
(131,'2024-11-08',1350.00,'12345678901',55,2,2),
(132,'2024-11-09',1500.00,'23456789012',60,3,3),
(133,'2024-11-10',1650.00,'34567890123',65,1,1),
(134,'2024-11-11',1800.00,'45678901234',70,2,2),
(135,'2024-11-12',1750.00,'56789012345',75,3,3),
(136,'2024-11-13',2000.00,'67890123456',80,1,1),
(137,'2024-11-14',2000.00,'78901234567',85,2,2),
(138,'2024-11-15',2000.00,'89012345678',90,3,3),
(139,'2024-11-16',2100.00,'90123456789',95,1,1),
(140,'2024-11-17',2100.00,'12345678901',100,2,2),
(141,'2024-11-18',2100.00,'12345678901',1,1,1),
(142,'2024-11-19',2100.00,'23456789012',2,2,2),
(143,'2024-11-20',2250.00,'34567890123',3,3,3),
(144,'2024-11-21',2250.00,'45678901234',4,1,1),
(145,'2024-11-22',2400.00,'56789012345',5,2,2),
(146,'2024-11-23',2400.00,'67890123456',6,3,3),
(147,'2024-11-24',2375.00,'78901234567',7,1,1),
(148,'2024-11-25',2450.00,'89012345678',8,2,2),
(149,'2024-11-26',2550.00,'90123456789',9,3,3),
(150,'2024-11-27',2700.00,'12345678901',10,1,1);
```
**Vendas**
```sql
INSERT INTO Vendas (
  data_venda, valor_bruto, Funcionarios_cpf, 
  pedido_id, desconto_id, tipoPgto_id) VALUES
('2024-07-01',300.00,'90123456789',1,1,1),
('2024-07-03',150.50,'90123456789',2,2,1),
('2024-07-05',220.75,'90123456789',4,2,1),
('2024-07-07',350.00,'90123456789',5,2,1),
('2024-07-09',289.95,'90123456789',6,2,1),
('2024-07-11',320.00,'78901234568',11,2,1),
('2024-07-13',280.00,'90123456789',12,2,1),
('2024-07-15',430.50,'90123456789',13,2,1),
('2024-07-17',360.00,'90123456789',15,2,1),
('2024-07-19',275.00,'90123456789',16,2,1),
('2024-07-21',150.00,'78901234568',17,2,1),
('2024-07-23',545.00,'90123456790',18,2,1),
('2024-07-25',333.33,'90123456789',19,2,1),
('2024-07-27',475.00,'90123456789',20,2,1),
('2024-07-29',215.75,'90123456790',21,2,1),
('2024-07-31',342.00,'78901234568',22,2,1),
('2024-08-02',420.00,'90123456790',23,2,1),
('2024-08-04',188.50,'90123456789',24,2,1),
('2024-08-06',265.00,'90123456790',26,2,1),
('2024-08-08',130.00,'90123456789',27,2,1),
('2024-08-10',550.75,'78901234568',28,2,1),
('2024-08-11',480.00,'90123456788',30,1,2),
('2024-08-13',325.00,'12345678901',31,1,2),
('2024-08-15',225.00,'12345678901',33,1,2),
('2024-08-17',250.75,'12345678901',35,1,2),
('2024-08-19',285.00,'67890123458',36,1,3),
('2024-08-21',315.00,'90123456788',38,1,2),
('2024-08-25',340.00,'12345678901',41,1,2),
('2024-08-27',360.00,'12345678901',42,1,2),
('2024-08-31',330.00,'90123456788',43,1,2),
('2024-09-02',305.00,'12345678901',44,1,2),
('2024-09-06',345.00,'12345678901',45,1,2),
('2024-09-08',365.00,'67890123458',46,1,3),
('2024-09-10',375.00,'90123456788',47,1,2),
('2024-09-12',385.00,'12345678901',48,1,2),
('2024-09-14',395.00,'12345678901',49,1,2),
('2024-09-16',405.00,'12345678901',50,1,2),
('2024-09-18',150.00,'67890123458',51,1,3),
('2024-09-20',250.00,'90123456788',52,1,2),
('2024-09-22',350.00,'12345678901',53,1,2),
('2024-09-24',145.00,'12345678901',54,1,2),
('2024-09-26',235.00,'12345678901',55,1,2),
('2024-09-28',325.00,'67890123458',56,1,3),
('2024-09-30',195.00,'90123456788',57,1,2),
('2024-10-02',285.00,'12345678901',58,1,2),
('2024-10-04',175.00,'12345678901',59,1,2),
('2024-10-06',265.00,'12345678901',60,1,2),
('2024-08-23',335.00,'12345678901',63,1,2),
('2024-08-29',120.00,'67890123458',66,1,3),
('2024-10-08',210.00,'67890123458',67,1,3),
('2024-09-04',130.00,'12345678901',75,1,2),
('2024-10-07',100.00,'90123456789',78,2,1),
('2024-10-05',230.00,'90123456789',85,2,1),
('2024-10-03',180.00,'90123456789',90,2,1),
('2024-10-01',270.00,'90123456789',91,2,1),
('2024-09-29',360.00,'78901234568',92,2,1),
('2024-09-27',150.00,'90123456789',93,2,1),
('2024-09-25',240.00,'90123456789',94,2,1),
('2024-09-23',330.00,'90123456789',95,2,1),
('2024-09-21',120.00,'90123456789',96,2,1),
('2024-09-19',210.00,'78901234568',97,2,1),
('2024-09-17',300.00,'90123456789',98,2,1),
('2024-09-15',170.00,'90123456789',99,2,1),
('2024-09-13',260.00,'90123456789',100,2,1),
('2024-09-11',200.00,'90123456789',102,2,1),
('2024-09-09',250.00,'78901234568',103,2,1),
('2024-09-07',300.00,'90123456789',104,2,1),
('2024-09-05',350.00,'90123456789',105,2,1),
('2024-09-03',400.00,'90123456789',106,2,1),
('2024-09-01',450.00,'90123456789',107,2,1),
('2024-08-30',500.00,'78901234568',108,2,1),
('2024-08-28',550.00,'90123456789',109,2,1),
('2024-08-26',600.00,'90123456789',110,2,1),
('2024-08-24',650.00,'90123456789',111,2,1),
('2024-08-22',750.00,'90123456789',113,2,1),
('2024-08-20',800.00,'78901234568',114,2,1),
('2024-08-18',850.00,'90123456789',115,2,1),
('2024-08-16',900.00,'90123456789',116,2,1),
('2024-08-14',1000.00,'90123456790',118,2,1),
('2024-08-12',1050.00,'90123456790',119,2,1),
('2024-08-09',1150.00,'67890123458',121,1,3),
('2024-08-07',1200.00,'12345678901',122,1,2),
('2024-08-05',1250.00,'12345678901',123,1,2),
('2024-08-03',1300.00,'12345678901',124,1,2),
('2024-08-01',1350.00,'90123456788',125,1,2),
('2024-07-30',1400.00,'67890123458',126,1,3),
('2024-07-28',1450.00,'12345678901',127,1,2),
('2024-07-26',1500.00,'12345678901',128,1,2),
('2024-07-24',1550.00,'12345678901',129,1,2),
('2024-07-22',1600.00,'90123456788',130,1,2),
('2024-07-20',2050.00,'67890123458',139,1,3),
('2024-07-18',2150.00,'12345678901',141,1,2),
('2024-07-16',2200.00,'12345678901',142,1,2),
('2024-07-14',2250.00,'12345678901',143,1,2),
('2024-07-12',2300.00,'90123456788',144,1,2),
('2024-07-10',2350.00,'67890123458',145,1,3),
('2024-07-08',2400.00,'12345678901',146,1,2),
('2024-07-06',2500.00,'12345678901',148,1,2),
('2024-07-04',2550.00,'12345678901',149,1,2),
('2024-07-02',2600.00,'12345678901',150,1,2);
```
**Pedidos_Por_Estoque**
```sql
INSERT INTO Pedidos_por_Estoque (pedido_id, exemplar_id, qtd_vendida) VALUES
(1,1,7),
(46,1,4),
(91,1,11),
(136,1,6),
(2,2,11),
(47,2,8),
(92,2,3),
(137,2,22),
(3,3,13),
(48,3,16),
(93,3,11),
(138,3,11),
(4,4,12),
(49,4,6),
(94,4,12),
(139,4,9),
(5,5,5),
(50,5,13),
(95,5,10),
(140,5,15),
(6,6,7),
(51,6,17),
(96,6,11),
(141,6,6),
(7,7,13),
(52,7,9),
(97,7,4),
(142,7,18),
(8,8,9),
(53,8,15),
(98,8,8),
(143,8,9),
(9,9,5),
(54,9,5),
(99,9,5),
(144,9,9),
(10,10,13),
(55,10,12),
(100,10,6),
(145,10,12),
(11,11,11),
(56,11,12),
(101,11,11),
(146,11,10),
(12,12,10),
(57,12,9),
(102,12,9),
(147,12,9),
(13,13,11),
(58,13,13),
(103,13,5),
(148,13,7),
(14,14,14),
(59,14,6),
(104,14,8),
(149,14,11),
(15,15,8),
(60,15,8),
(105,15,6),
(150,15,9),
(16,16,5),
(61,16,8),
(106,16,8),
(17,17,5),
(62,17,9),
(107,17,4),
(18,18,11),
(63,18,8),
(108,18,6),
(19,19,9),
(64,19,12),
(109,19,5),
(20,20,8),
(65,20,10),
(110,20,4),
(21,21,5),
(66,21,8),
(111,21,2),
(22,22,4),
(67,22,6),
(112,22,5),
(23,23,10),
(68,23,14),
(113,23,3),
(24,24,10),
(69,24,10),
(114,24,4),
(25,25,6),
(70,25,10),
(115,25,5),
(26,26,6),
(71,26,9),
(116,26,4),
(27,27,7),
(72,27,11),
(117,27,4),
(28,28,7),
(73,28,12),
(118,28,7),
(29,29,8),
(74,29,5),
(119,29,10),
(30,30,8),
(75,30,10),
(120,30,12),
(31,31,14),
(76,31,14),
(121,31,12),
(32,32,16),
(77,32,20),
(122,32,22),
(33,33,35),
(78,33,19),
(123,33,26),
(34,34,28),
(79,34,30),
(124,34,27),
(35,35,35),
(80,35,30),
(125,35,36),
(36,36,29),
(81,36,30),
(126,36,25),
(37,37,26),
(82,37,27),
(127,37,45),
(38,38,57),
(83,38,60),
(128,38,35),
(39,39,65),
(84,39,45),
(129,39,50),
(40,40,55),
(85,40,60),
(130,40,50),
(41,41,50),
(86,41,50),
(131,41,50),
(42,42,60),
(87,42,70),
(132,42,60),
(43,43,60),
(88,43,90),
(133,43,90),
(44,44,80),
(89,44,80),
(134,44,95),
(45,45,70),
(90,45,85),
(135,45,90);
```

### Realizando Alterações em Dados das Tabelas - DML

**Tabela Estoque**
  - Atualizando estoque zerado.
```sql
UPDATE Estoque 
SET quantidade = 100
WHERE exemplar_id = 10;

UPDATE Estoque
SET quantidade = 100
WHERE exemplar_id = 11;

UPDATE Estoque
SET quantidade = 100
WHERE exemplar_id = 12;
```

**Pedidos**
  - Atualizando valor do pedido 1.
```sql
UPDATE Pedidos
SET valor_pedido = 400.00
WHERE pedido_id = 1;
```
**Pedidos por Estoque**
  - Atualizando a quantidade do pedido.
```sql
UPDATE Pedidos_por_Estoque
SET qtd_vendida = 10
WHERE pedido_id = 1 and exemplar_id = 1;
```
**Estoque**
  - Atualizando estoque.
```sql
UPDATE Estoque
SET quantidade = 140
WHERE exemplar_id = 1;

UPDATE Estoque
SET quantidade = 10
WHERE exemplar_id = 2;
```
**Vendas**
  - Atualizando valor da venda.
```sql
UPDATE Vendas
SET valor_bruto = 400.00
WHERE pedido_id = 1;

UPDATE Vendas
SET valor_desconto = 20
WHERE pedido_id = 1;

UPDATE Vendas
SET valor_total = 380.00
WHERE pedido_id = 1;
```
**Funcionario**
  - Deletando funcionário do jurídico.
```sql
DELETE FROM Funcionarios
WHERE funcionario_cpf = '45678901238';
```
**Descontos**
  - Alterando valor do desconto.
```sql
UPDATE Descontos
SET descontos = 35
WHERE desconto_id = 6;
```
**Cargos**
  - Atualizando valores dos salários.
```sql
UPDATE Cargos
SET salario = 2500.00
WHERE cargo_id = 3;

UPDATE Cargos
SET salario = 1400.00
WHERE cargo_id = 9;

UPDATE Cargos
SET salario = 1500.00
WHERE cargo_id = 14;
```
**Autores**
  - Alterando a bibografia dos autores.
```sql
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
```

### Consultas em SQL no Banco de Dados - DQL

**Departamentos e Responsáveis:**
```sql
SELECT nome, responsavel 
FROM Departamentos;
```
**Total de Clientes:**
```sql
SELECT COUNT(*) AS total_clientes
FROM Clientes;
```
**Cargos e Descrições:**
```sql
SELECT nome_cargo, descricao_cargo 
FROM Cargos;
```
**Pedidos e seus respectivos status:**
```sql
SELECT Pedidos.pedido_id, StatusPedido.status
FROM Pedidos
JOIN StatusPedido 
ON Pedidos.statusPedido_id = StatusPedido.statusPedido_id;
```
**Total de Vendas realizadas:**
```sql
SELECT SUM(valor_total) AS total_vendas
FROM Vendas;
```
**Total de Pedidos por Cliente:**
```sql
SELECT
  Clientes.nome,
  COUNT(Pedidos.pedido_id) AS total_pedidos
FROM Clientes
JOIN Pedidos 
ON Clientes.cliente_id = Pedidos.cliente_id GROUP BY Clientes.nome;
```
**Tipos de Pagamentos:**
```sql
SELECT tipoPgto 
FROM TipoPagamento;
```
**Funcionários e seus departamentos:**
```sql
SELECT
  Funcionarios.nome,
  Funcionarios.sobrenome,
  Departamentos.nome AS departamento
FROM Funcionarios
JOIN Departamentos
ON Funcionarios.departamento_id = Departamentos.departamento_id;
```

**Média dos pedidos:**
```sql
SELECT
  AVG(valor_pedido) AS valor_medio_pedido
FROM Pedidos;
```
**Descontos Disponivéis:**
```sql
SELECT descontos FROM Descontos;
```
**Vendas por funcionário:**
```sql
SELECT
  Funcionarios.nome,
  Funcionarios.sobrenome,
  COUNT(Vendas.pedido_id) AS total_vendas
FROM Funcionarios
JOIN Vendas
ON Funcionarios.funcionario_pf = Vendas.Funcionarios_cpf
GROUP BY Funcionarios.nome, Funcionarios.sobrenome;
```
**Total de Venda por mês:**
```sql
SELECT
  MONTH(data_venda) AS mes,
  COUNT(*) AS total_vendas
FROM Vendas
GROUP BY MONTH(data_venda);
```
**Número de funcionários por cargo:**
```sql
SELECT
  c.descricao_cargo AS cargo,
  COUNT(f.funcionario_cpf) AS total_funcionarios
FROM cargos c 
JOIN Funcionarios f
ON c.cargo_id = f.cargo_id
GROUP BY c.descricao_cargo;
```
**Média salarial por cargo:**
```sql
SELECT
  c.descricao_cargo AS cargo,
  truncate(AVG(c.salario),2) AS media_salarial
FROM Cargos c
JOIN Funcionarios f
ON c.cargo_id = f.cargo_id
GROUP BY c.descricao_cargo;
```
**Funcionários admitidos por ano:**
```sql
SELECT
  year(data_admissao) AS Ano,
  COUNT(*) AS total_admitidos
FROM Funcionarios
GROUP BY YEAR(data_admissao);
```
**Receita média por venda:**
```sql
SELECT
  AVG(valor_total) AS receita_media
FROM Vendas;
```
**Total de clientes por estado:**
```sql
SELECT
  e.uf,
  COUNT(c.cliente_id) AS total_clientes
FROM Clientes c
JOIN Enderecos e 
ON c.endereco_id = e.endereco_id
GROUP BY e.uf;
```

