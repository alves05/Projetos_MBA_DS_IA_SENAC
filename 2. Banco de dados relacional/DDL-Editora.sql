-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Editora
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Editora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Editora` ;
USE `Editora` ;

-- -----------------------------------------------------
-- Table `Editora`.`Departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Departamentos` (
  `departamento_id` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `responsavel` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(200) NULL,
  PRIMARY KEY (`departamento_id`),
  UNIQUE INDEX `departamento_id_UNIQUE` (`departamento_id` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Cargos` (
  `cargo_id` INT NOT NULL,
  `nome_cargo` VARCHAR(100) NOT NULL,
  `descricao_cargo` VARCHAR(200) NULL,
  PRIMARY KEY (`cargo_id`),
  UNIQUE INDEX `cargo_id_UNIQUE` (`cargo_id` ASC) VISIBLE,
  UNIQUE INDEX `nome_cargo_UNIQUE` (`nome_cargo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Enderecos`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Funcionarios`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Clientes`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`StatusPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`StatusPedido` (
  `statusPedido_id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`statusPedido_id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`TipoPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`TipoPagamento` (
  `tipoPgto_id` INT NOT NULL AUTO_INCREMENT,
  `tipoPgto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipoPgto_id`),
  UNIQUE INDEX `tipoPgto_UNIQUE` (`tipoPgto` ASC) VISIBLE,
  UNIQUE INDEX `tipoPgto_id_UNIQUE` (`tipoPgto_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Pedidos`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`TipoCliente`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Descontos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Descontos` (
  `desconto_id` INT NOT NULL AUTO_INCREMENT,
  `descontos` FLOAT NOT NULL,
  PRIMARY KEY (`desconto_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Vendas`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Livros` (
  `isbn_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `num_pag` INT NOT NULL,
  `data_public` DATE NOT NULL,
  PRIMARY KEY (`isbn_id`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`StatusEstoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`StatusEstoque` (
  `statusEstoque_id` INT NOT NULL AUTO_INCREMENT,
  `status_livros` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`statusEstoque_id`),
  UNIQUE INDEX `status_livros_UNIQUE` (`status_livros` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Estoque`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Autores` (
  `autor_id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `nacionalidade` VARCHAR(100) NULL,
  `biografia` VARCHAR(500) NULL,
  `data_nasc` VARCHAR(45) NULL,
  PRIMARY KEY (`autor_id`),
  UNIQUE INDEX `autor_id_UNIQUE` (`autor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Livros_por_Autores`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`AreasConhecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`AreasConhecto` (
  `area_id` INT NOT NULL,
  `areas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE INDEX `area_id_UNIQUE` (`area_id` ASC) VISIBLE,
  UNIQUE INDEX `areas_UNIQUE` (`areas` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`PalavrasChave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`PalavrasChave` (
  `palavra_id` INT NOT NULL,
  `palavras` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`palavra_id`),
  UNIQUE INDEX `area_id_UNIQUE` (`palavra_id` ASC) VISIBLE,
  UNIQUE INDEX `palavras_UNIQUE` (`palavras` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Livros_por_AreasConhecto`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Livros_por_PalavrasChave`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Pedidos_por_Estoque`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `Editora`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Genero` (
  `genero_id` INT NOT NULL,
  `generos` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`genero_id`),
  UNIQUE INDEX `genero_id_UNIQUE` (`genero_id` ASC) VISIBLE,
  UNIQUE INDEX `generos_UNIQUE` (`generos` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Editora`.`Genero_por_Livros`
-- -----------------------------------------------------
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

USE `Editora` ;

-- -----------------------------------------------------
-- Placeholder table for view `Editora`.`Dados_Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Dados_Clientes` (`Cliente` INT, `Documento` INT, `Natureza` INT, `Rua` INT, `Numero` INT, `Complemento` INT, `Bairro` INT, `Cidade` INT, `Estado` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Editora`.`Catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Catalogo` (`ISBN` INT, `Título` INT, `Autor` INT, `Gênero` INT, `'Área de Conhecimento'` INT, `'Palavras Chave'` INT, `'Qtda Estoque'` INT, `'Preço'` INT, `'Status Estoque'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Editora`.`Dados_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Dados_Pedidos` (`'Data'` INT, `Cliente` INT, `Livro` INT, `Quantidade` INT, `'Valor do Pedido'` INT, `Vendedor` INT, `'Status Pedido'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Editora`.`Dados_Funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Dados_Funcionarios` (`'Nome Completo'` INT, `Telefone` INT, `Email` INT, `Cargo` INT, `Departamento` INT, `Supervisor` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Editora`.`Dados_Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Editora`.`Dados_Vendas` (`'Data'` INT, `'N. Pedido'` INT, `Cliente` INT, `'Forma Pagamento'` INT, `'Valor Bruto'` INT, `Desconto` INT, `'Valor Total'` INT, `Vendedor` INT);

-- -----------------------------------------------------
-- View `Editora`.`Dados_Clientes`
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- View `Editora`.`Catalogo`
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- View `Editora`.`Dados_Pedidos`
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- View `Editora`.`Dados_Funcionarios`
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- View `Editora`.`Dados_Vendas`
-- -----------------------------------------------------
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
USE `Editora`;

DELIMITER $$
USE `Editora`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Editora`.`calcular_desconto_valor_total` BEFORE INSERT ON `Vendas` FOR EACH ROW
BEGIN
DECLARE desconto_percentual DECIMAL(10,2);

    -- Obter o percentual de desconto baseado no desconto_id
    SELECT descontos / 100 INTO desconto_percentual FROM Descontos WHERE desconto_id = NEW.desconto_id;

    -- Calcular o valor do desconto
    SET NEW.valor_desconto = NEW.valor_bruto * desconto_percentual;

    -- Calcular o valor total
    SET NEW.valor_total = NEW.valor_bruto - NEW.valor_desconto;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
