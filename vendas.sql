-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 06-Maio-2022 às 15:41
-- Versão do servidor: 8.0.27-0ubuntu0.20.04.1
-- versão do PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `vendas`
--
CREATE DATABASE IF NOT EXISTS `vendas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `vendas`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `cliente_id` int NOT NULL,
  `cliente_nome` varchar(50) NOT NULL,
  `provincia_codigo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`cliente_id`, `cliente_nome`, `provincia_codigo`) VALUES
(1, 'JOSE DA SILVA', 1),
(2, 'CARLOS PEREIRA', 2),
(3, 'JOSE SILVEIRA', 3),
(4, 'CARLOS ANTONIO', 4),
(5, 'SILVIO JOSE', 1),
(6, 'ANTONIO CARLOS', 2),
(7, 'JOÃO CARLOS', 3),
(8, 'Aires Langa', 5),
(9, 'Edy Langa', 5),
(10, 'Edy Langa', 5),
(13, 'Sebstiao', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `grupo`
--

CREATE TABLE `grupo` (
  `grupo_codigo` int NOT NULL,
  `grupo_nome` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `grupo`
--

INSERT INTO `grupo` (`grupo_codigo`, `grupo_nome`) VALUES
(1, 'ESCRITÓRIO'),
(2, 'LIMPEZA'),
(3, 'INFORMÁTICA');

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

CREATE TABLE `item` (
  `item_id` int NOT NULL,
  `pedido_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `item_qtde` int NOT NULL,
  `item_punit` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `item`
--

INSERT INTO `item` (`item_id`, `pedido_id`, `produto_id`, `item_qtde`, `item_punit`) VALUES
(1, 1, 1, 10, 7.00),
(2, 1, 2, 8, 1.00),
(3, 1, 3, 2, 38.00),
(4, 2, 1, 3, 8.00),
(5, 2, 3, 1, 40.00),
(6, 3, 4, 2, 78.00),
(7, 3, 5, 20, 0.00),
(8, 4, 6, 30, 2.00),
(9, 4, 1, 5, 8.00),
(10, 4, 2, 10, 2.00),
(11, 5, 3, 3, 40.00),
(12, 5, 4, 1, 80.00),
(13, 6, 6, 3, 2.00),
(14, 6, 5, 20, 1.00),
(15, 7, 1, 12, 8.00),
(16, 7, 2, 20, 2.00),
(17, 8, 3, 4, 35.00),
(18, 9, 4, 5, 73.00),
(19, 10, 5, 25, 1.00),
(20, 1, 6, 2, 2.00);

--
-- Acionadores `item`
--
DELIMITER $$
CREATE TRIGGER `tgr_update_stoque_prod` AFTER INSERT ON `item` FOR EACH ROW BEGIN

UPDATE produto SET produto_qtde = produto_qtde - NEW.item_qtde WHERE produto_codigo = NEW.produto_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

CREATE TABLE `pedido` (
  `pedido_id` int NOT NULL,
  `pedido_tipopg` varchar(20) DEFAULT NULL,
  `cliente_id` int NOT NULL,
  `pedido_data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`pedido_id`, `pedido_tipopg`, `cliente_id`, `pedido_data`) VALUES
(1, 'VVI', 1, '2017-05-14'),
(2, 'VPR', 1, '2017-05-30'),
(3, 'VPR', 2, '2017-05-28'),
(4, 'VVI', 2, '2017-05-25'),
(5, 'VPR', 3, '2017-06-01'),
(6, 'VVI', 4, '2017-06-14'),
(7, 'VPR', 5, '2017-06-14'),
(8, 'VVI', 6, '2017-06-13'),
(9, 'VPR', 7, '2017-06-12'),
(10, 'VVI', 7, '2017-05-12');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `produto_codigo` int NOT NULL,
  `produto_nome` varchar(50) NOT NULL,
  `produto_punit` double(10,2) NOT NULL,
  `produto_qtde` int NOT NULL,
  `grupo_codigo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`produto_codigo`, `produto_nome`, `produto_punit`, `produto_qtde`, `grupo_codigo`) VALUES
(1, 'SABONETE LIQUIDO', 8.25, 10, 2),
(2, 'CANETA ESFEROGRÁFICA', 2.00, 100, 1),
(3, 'USB 8', 40.00, 50, 3),
(4, 'USB 32', 80.00, 20, 3),
(5, 'LAPIS PRETO', 1.00, 80, 1),
(6, 'DETERGENTE', 2.00, 118, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `provincia`
--

CREATE TABLE `provincia` (
  `provincia_codigo` int NOT NULL,
  `provincia_nome` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `provincia`
--

INSERT INTO `provincia` (`provincia_codigo`, `provincia_nome`) VALUES
(1, 'MPT'),
(2, 'GZA'),
(3, 'INHA'),
(4, 'TETE'),
(5, 'CAD');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_id`),
  ADD KEY `estado_codigo` (`provincia_codigo`);

--
-- Índices para tabela `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`grupo_codigo`);

--
-- Índices para tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices para tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`pedido_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`produto_codigo`),
  ADD KEY `grupo_codigo` (`grupo_codigo`);

--
-- Índices para tabela `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`provincia_codigo`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `grupo`
--
ALTER TABLE `grupo`
  MODIFY `grupo_codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `pedido_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `produto_codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `provincia`
--
ALTER TABLE `provincia`
  MODIFY `provincia_codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`provincia_codigo`) REFERENCES `provincia` (`provincia_codigo`);

--
-- Limitadores para a tabela `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`pedido_id`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`produto_codigo`);

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`);

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`grupo_codigo`) REFERENCES `grupo` (`grupo_codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
