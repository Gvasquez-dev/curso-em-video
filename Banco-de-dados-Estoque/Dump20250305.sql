CREATE DATABASE  IF NOT EXISTS `estoque` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `estoque`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: estoque
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carnes`
--

DROP TABLE IF EXISTS `carnes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carnes` (
  `id_carnes` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `temperatura_recebimento` decimal(5,2) DEFAULT NULL,
  `recebimento` date DEFAULT NULL,
  `validade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` decimal(5,2) DEFAULT NULL,
  `estoque_risco` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_carnes`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carnes`
--

LOCK TABLES `carnes` WRITE;
/*!40000 ALTER TABLE `carnes` DISABLE KEYS */;
INSERT INTO `carnes` VALUES (1,'carne',4.00,'2025-02-18','10 dias',20.00,'10'),(2,'mignon',4.00,'2025-02-18','10 dias',20.00,'7.5'),(3,'picanha',4.00,'2025-02-18','10 dias',20.00,'9'),(4,'lombo',4.00,'2025-02-18','10 dias',25.30,'12.5'),(5,'costela',4.00,'2025-02-18','10 dias',30.00,'11'),(6,'peito',4.00,'2025-02-18','14 dias',30.00,'15'),(7,'coxa',4.00,'2025-02-18','14 dias',8.00,'14'),(8,'tilápia',2.00,'2025-02-18','2 dias',12.50,NULL),(9,'salmão',2.00,'2025-02-18','2 dias',10.80,NULL),(10,'pernil',4.00,'2025-02-18','10 dias',8.00,NULL),(11,'músculo',4.00,'2025-02-18','10 dias',12.00,NULL),(12,'asa',4.00,'2025-02-18','14 dias',20.00,NULL),(13,'bisteca',4.00,'2025-02-18','10 dias',15.50,NULL),(14,'filé',4.00,'2025-02-18','14 dias',18.10,NULL),(15,'merluza',2.00,'2025-02-18','2 dias',8.20,NULL),(16,'linguiça',4.00,'2025-02-18','10 dias',10.00,NULL);
/*!40000 ALTER TABLE `carnes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controle_estoque_carnes_update` AFTER UPDATE ON `carnes` FOR EACH ROW BEGIN
    IF NEW.quantidade < NEW.estoque_risco THEN
        INSERT INTO compras (nome, quantidade, situacao, carnes)
        VALUES (NEW.nome, NEW.quantidade, 'pendente', NEW.id_carnes)
        ON DUPLICATE KEY UPDATE quantidade = NEW.quantidade;
    ELSE
        DELETE FROM compras WHERE carnes = NEW.id_carnes;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `situacao` enum('pendente','comprado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pendente',
  `carnes` int DEFAULT NULL,
  `descartaveis` int DEFAULT NULL,
  `estocaveis` int DEFAULT NULL,
  `hortfruit` int DEFAULT NULL,
  `laticinios` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carnes` (`carnes`),
  KEY `descartaveis` (`descartaveis`),
  KEY `estocaveis` (`estocaveis`),
  KEY `hortfruit` (`hortfruit`),
  KEY `laticinios` (`laticinios`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descartaveis`
--

DROP TABLE IF EXISTS `descartaveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descartaveis` (
  `id_descartaveis` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recebimento` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estoque_risco` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_descartaveis`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descartaveis`
--

LOCK TABLES `descartaveis` WRITE;
/*!40000 ALTER TABLE `descartaveis` DISABLE KEYS */;
INSERT INTO `descartaveis` VALUES (1,'Prato descartável','Semanal','300','250'),(2,'Copo plástico 200ml','Semanal','600','500'),(3,'Copo plástico 300ml','Semanal','600','400'),(4,'Talher descartável (garfo)','Semanal','600 unidades','300'),(5,'Talher descartável (faca)','Semanal','600 unidades','300'),(6,'Talher descartável (colher)','Semanal','600 unidades','300'),(7,'Guardanapo de papel','Semanal','2000 folhas','1000'),(8,'Toalha de papel','Semanal','1000 folhas','500'),(9,'Papel higiênico','Semanal','100 rolos','50'),(10,'Saco de lixo 30L','Semanal','200 unidades','10'),(11,'Saco de lixo 50L','Semanal','150 unidades','75'),(12,'Saco de lixo 100L','Semanal','100 unidades','50'),(13,'Canudo plástico','Semanal','500 unidades','250'),(14,'Guardanapo de papel','Semanal','2000 unidades','1000'),(15,'Luva descartável','Semanal','300 unidades','150'),(16,'Papel toalha','Semanal','500 rolos','250'),(17,'Aluminho','Semanal','150 rolos','75'),(18,'Papel manteiga','Semanal','100 pacotes','50'),(19,'Saco para pão','Semanal','500 unidades','250'),(20,'Saco para lixo grande','Semanal','100 unidades','50'),(21,'Fralda descartável','Semanal','100 pacotes','50'),(22,'Copo descartável','Semanal','1000 unidades','500'),(23,'Bolsas plásticas','Semanal','500 unidades','250'),(24,'Papel filme','Semanal','100 rolos','50'),(25,'Sacolas plásticas','Semanal','1500 unidades','750'),(26,'Embalagem para comida','Semanal','400 pacotes','200'),(27,'Saco plástico transparente','Semanal','2000 unidades','1000'),(28,'Balde descartável','Semanal','50 unidades','25'),(29,'Tampa descartável para copo','Semanal','1000 unidades','500'),(30,'Papel kraft','Semanal','200 metros','100');
/*!40000 ALTER TABLE `descartaveis` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controle_estoque_descartaveis_update` AFTER UPDATE ON `descartaveis` FOR EACH ROW BEGIN
    IF NEW.quantidade < NEW.estoque_risco THEN
        INSERT INTO compras (nome, quantidade, situacao, descartaveis)
        VALUES (NEW.nome, NEW.quantidade, 'pendente', NEW.id_descartaveis)
        ON DUPLICATE KEY UPDATE quantidade = NEW.quantidade;
    ELSE
        DELETE FROM compras WHERE descartaveis = NEW.id_descartaveis;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `estocaveis`
--

DROP TABLE IF EXISTS `estocaveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estocaveis` (
  `id_estocaveis` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recebimento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `validade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estoque_risco` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_estocaveis`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estocaveis`
--

LOCK TABLES `estocaveis` WRITE;
/*!40000 ALTER TABLE `estocaveis` DISABLE KEYS */;
INSERT INTO `estocaveis` VALUES (1,'Arroz','Mensal','12 meses','500 kg','250'),(2,'Feijão','Mensal','12 meses','400 kg','200'),(3,'Açúcar','Mensal','24 meses','300 kg','150'),(4,'Sal','Bimestral','Indeterminado','200 kg','100'),(5,'Farinha de trigo','Mensal','8 meses','250 kg','125'),(6,'Farinha de mandioca','Mensal','8 meses','200 kg','100'),(7,'Óleo de soja','Mensal','12 meses','500 litros','250'),(8,'Macarrão','Mensal','12 meses','300 pacotes','150'),(9,'Molho de tomate','Mensal','12 meses','150 latas','75'),(10,'Tomate pelado','Mensal','18 meses','100 latas','50'),(11,'Ervilha','Mensal','12 meses','200 latas','100'),(12,'Milho','Mensal','12 meses','250 latas','125'),(13,'Biscoito','Mensal','18 meses','500 pacotes','250'),(14,'Café','Mensal','12 meses','100 kg','50'),(15,'Chá','Mensal','12 meses','50 pacotes','25'),(16,'Leite condensado','Mensal','12 meses','200 latas','100'),(17,'Farinha de rosca','Mensal','12 meses','50 kg','25'),(18,'Azeite de oliva','Mensal','18 meses','100 garrafas','50'),(19,'Cereal','Mensal','12 meses','100 caixas','50'),(20,'Chocolate em pó','Mensal','12 meses','50 kg','25'),(21,'Cacau em pó','Mensal','12 meses','40 kg','20'),(22,'Farinha de milho','Mensal','12 meses','100 kg','50'),(23,'Amido de milho','Mensal','12 meses','200 kg','100'),(24,'Coco ralado','Mensal','12 meses','100 kg','25'),(25,'Castanha de caju','Mensal','12 meses','50 kg','25'),(26,'Nozes','Mensal','12 meses','30 kg','15'),(27,'Pistache','Mensal','12 meses','20 kg','10'),(28,'Semente de abóbora','Mensal','12 meses','10 kg','5'),(29,'Semente de girassol','Mensal','12 meses','15 kg','7'),(30,'Macadâmia','Mensal','12 meses','25 kg','15'),(31,'Manteiga de amendoim','Mensal','12 meses','50 kg','25'),(32,'Leite em pó','Mensal','12 meses','200 kg','100'),(33,'Suco concentrado','Mensal','12 meses','100 litros','50'),(34,'Caldo de carne','Mensal','12 meses','200 pacotes','100'),(35,'Geleia','Mensal','12 meses','100 potes','50'),(36,'Molho shoyu','Mensal','12 meses','100 frascos','50'),(37,'Açúcar mascavo','Mensal','12 meses','150 kg','75'),(38,'Coco seco','Mensal','12 meses','50 kg','25'),(39,'Frutas secas','Mensal','12 meses','50 kg','25'),(40,'Bebida energética','Mensal','12 meses','100 garrafas','50');
/*!40000 ALTER TABLE `estocaveis` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controle_estoque_estocaveis_update` AFTER UPDATE ON `estocaveis` FOR EACH ROW BEGIN
    IF NEW.quantidade < NEW.estoque_risco THEN
        INSERT INTO compras (nome, quantidade, situacao, estocaveis)
        VALUES (NEW.nome, NEW.quantidade, 'pendente', NEW.id_estocaveis)
        ON DUPLICATE KEY UPDATE quantidade = NEW.quantidade;
    ELSE
        DELETE FROM compras WHERE descartaveis = NEW.id_estocaveis;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hortfruit`
--

DROP TABLE IF EXISTS `hortfruit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hortfruit` (
  `id_hortfruit` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recebimento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estoque_risco` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_hortfruit`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hortfruit`
--

LOCK TABLES `hortfruit` WRITE;
/*!40000 ALTER TABLE `hortfruit` DISABLE KEYS */;
INSERT INTO `hortfruit` VALUES (1,'Alface','Diário','50 maços','25'),(2,'Rúcula','Diário','30 maços','15'),(3,'Couve','Diário','40 maços','20'),(4,'Espinafre','Diário','35 maços','15'),(5,'Repolho','Diário','25 unidades','15'),(6,'Cenoura','Diário','60 kg','30'),(7,'Beterraba','Diário','50 kg','25'),(8,'Batata','Diário','100 kg','50'),(9,'Batata-doce','Diário','80 kg','40'),(10,'Tomate','Diário','70 kg','30'),(11,'Pepino','Diário','40 kg','20'),(12,'Pimentão','Diário','35 kg','15'),(13,'Abobrinha','Diário','45 kg','25'),(14,'Berinjela','Diário','30 kg','15'),(15,'Cebola','Diário','90 kg','45'),(16,'Alho','Semanal','20 kg','10'),(17,'Laranja','Diário','100 kg','50'),(18,'Banana','Diário','80 kg','40'),(19,'Maçã','Diário','60 kg','30'),(20,'Uva','Diário','50 kg','25');
/*!40000 ALTER TABLE `hortfruit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controle_estoque_hortfruit_update` AFTER UPDATE ON `hortfruit` FOR EACH ROW BEGIN
    IF NEW.quantidade < NEW.estoque_risco THEN
        INSERT INTO compras (nome, quantidade, situacao, hortfruit)
        VALUES (NEW.nome, NEW.quantidade, 'pendente', NEW.id_hortfruit)
        ON DUPLICATE KEY UPDATE quantidade = NEW.quantidade;
    ELSE
        DELETE FROM compras WHERE descartaveis = NEW.id_hortfruit;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `laticinios`
--

DROP TABLE IF EXISTS `laticinios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laticinios` (
  `id_laticinio` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `temperatura_recebimento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recebimento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `validade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantidade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estoque_risco` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_laticinio`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laticinios`
--

LOCK TABLES `laticinios` WRITE;
/*!40000 ALTER TABLE `laticinios` DISABLE KEYS */;
INSERT INTO `laticinios` VALUES (1,'Leite pasteurizado','0°C a 4°C','Diário','5 dias','50 litros','25'),(2,'Queijo muçarela','0°C a 5°C','Semanal','30 dias','50 kg','25'),(3,'Queijo prato','0°C a 5°C','Semanal','30 dias','40 kg','20'),(4,'Queijo parmesão','0°C a 5°C','Mensal','60 dias','30 kg','15'),(5,'Ovos','4°C a 8°C','Semanal','30 dias','300 unidades','150'),(6,'Queijo fresco','0°C a 5°C','Semanal','10 dias','10 kg','5'),(7,'Iogurte','0°C a 4°C','Semanal','15 dias','30 potes','15'),(8,'Presunto','0°C a 4°C','Semanal','7 dias','5 kg','5'),(9,'Manteiga','0°C a 4°C','Quinzenal','30 dias','8 kg','4'),(10,'Creme de leite','0°C a 5°C','Semanal','10 dias','20 latas','10');
/*!40000 ALTER TABLE `laticinios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controle_estoque_laticinios_update` AFTER UPDATE ON `laticinios` FOR EACH ROW BEGIN
    IF NEW.quantidade < NEW.estoque_risco THEN
        INSERT INTO compras (nome, quantidade, situacao, laticinios)
        VALUES (NEW.nome, NEW.quantidade, 'pendente', NEW.id_laticinio)
        ON DUPLICATE KEY UPDATE quantidade = NEW.quantidade;
    ELSE
        DELETE FROM compras WHERE descartaveis = NEW.id_laticinio;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'estoque'
--

--
-- Dumping routines for database 'estoque'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-05 10:13:51
