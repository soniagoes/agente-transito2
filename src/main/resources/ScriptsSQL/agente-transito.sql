/*
SQLyog Community v10.51 
MySQL - 5.6.11-log : Database - agente_transito_bd
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`agente_transito_bd` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `agente_transito_bd`;

/*Table structure for table `cidade` */

DROP TABLE IF EXISTS `cidade`;

CREATE TABLE `cidade` (
  `IdCidade` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(80) NOT NULL,
  PRIMARY KEY (`IdCidade`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `cidade` */

insert  into `cidade`(`IdCidade`,`Nome`) values (1,'CAMPO GRANDE'),(2,'FATIMA DO SUL'),(3,'VICENTINA'),(4,'FIGUEIRAO'),(5,'SELVIRIA'),(6,'BONITO'),(7,'JARDIM'),(8,'LAGUNA CAARAPÃ'),(9,'PONTA PORÃ'),(10,'ROCHEDO'),(11,'SIDROLANDIA');

/*Table structure for table `endereco` */

DROP TABLE IF EXISTS `endereco`;

CREATE TABLE `endereco` (
  `IdEndereco` int(11) NOT NULL AUTO_INCREMENT,
  `Bairro` varchar(80) DEFAULT NULL,
  `CEP` varchar(9) DEFAULT NULL,
  `Complemento` int(11) DEFAULT NULL,
  `NomeLogradouro` varchar(80) DEFAULT NULL,
  `Numero` int(11) DEFAULT NULL,
  `IdCidade` int(11) NOT NULL,
  `IdEstado` int(11) NOT NULL,
  `IdPessoa` int(11) DEFAULT NULL,
  `IdTipoEndereco` int(11) NOT NULL,
  `IdTipoLogradouro` int(11) NOT NULL,
  PRIMARY KEY (`IdEndereco`),
  KEY `EnderecoTipoEndereco` (`IdTipoEndereco`),
  KEY `EnderecoTipoLogradouro` (`IdTipoLogradouro`),
  KEY `EnderecoPessoa` (`IdPessoa`),
  KEY `EnderecoCidade` (`IdCidade`),
  KEY `EnderecoEstado` (`IdEstado`),
  CONSTRAINT `EnderecoEstado` FOREIGN KEY (`IdEstado`) REFERENCES `estado` (`IdEstado`),
  CONSTRAINT `EnderecoCidade` FOREIGN KEY (`IdCidade`) REFERENCES `cidade` (`IdCidade`),
  CONSTRAINT `EnderecoPessoa` FOREIGN KEY (`IdPessoa`) REFERENCES `pessoa` (`IdPessoa`),
  CONSTRAINT `EnderecoTipoEndereco` FOREIGN KEY (`IdTipoEndereco`) REFERENCES `tipoendereco` (`IdTipoEndereco`),
  CONSTRAINT `EnderecoTipoLogradouro` FOREIGN KEY (`IdTipoLogradouro`) REFERENCES `tipologradouro` (`IdTipoLogradouro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `endereco` */

insert  into `endereco`(`IdEndereco`,`Bairro`,`CEP`,`Complemento`,`NomeLogradouro`,`Numero`,`IdCidade`,`IdEstado`,`IdPessoa`,`IdTipoEndereco`,`IdTipoLogradouro`) values (4,'CENTRO','79004140',1,'RUA DAS FLORES',555,1,1,1,1,1),(5,'MONTE LIBANO','79004-140',NULL,'RUA DAS FLORES',999,1,1,2,1,1),(6,'JARDIM MONTE LIBANO','79004-140',NULL,'RUA DAS FLORES',9999,1,1,3,1,1);

/*Table structure for table `estado` */

DROP TABLE IF EXISTS `estado`;

CREATE TABLE `estado` (
  `IdEstado` int(11) NOT NULL AUTO_INCREMENT,
  `NomeEstado` varchar(40) NOT NULL,
  PRIMARY KEY (`IdEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `estado` */

insert  into `estado`(`IdEstado`,`NomeEstado`) values (1,'MATO GROSSO DO SUL');

/*Table structure for table `pessoa` */

DROP TABLE IF EXISTS `pessoa`;

CREATE TABLE `pessoa` (
  `IdPessoa` int(11) NOT NULL AUTO_INCREMENT,
  `CPF` varchar(14) NOT NULL,
  `DataDeCadastro` date NOT NULL,
  `DataDeNascimento` date NOT NULL,
  `Email` varchar(80) NOT NULL,
  `Login` varchar(25) DEFAULT NULL,
  `Name` varchar(80) NOT NULL,
  `Permissao` varchar(36) DEFAULT NULL,
  `Senha` varchar(40) DEFAULT NULL,
  `Telefone` varchar(15) NOT NULL,
  `IdSexo` int(11) NOT NULL,
  PRIMARY KEY (`IdPessoa`),
  UNIQUE KEY `Login` (`Login`),
  KEY `PessoaSexo` (`IdSexo`),
  CONSTRAINT `PessoaSexo` FOREIGN KEY (`IdSexo`) REFERENCES `sexo` (`IdSexo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `pessoa` */

insert  into `pessoa`(`IdPessoa`,`CPF`,`DataDeCadastro`,`DataDeNascimento`,`Email`,`Login`,`Name`,`Permissao`,`Senha`,`Telefone`,`IdSexo`) values (1,'366.943.201-91','0205-07-24','1990-08-08','teste@b.c','sonia','Sonia Goes','ROLE_ADMIN','40fdaeddab9567ad24bb9610ca88930ae1b2d7cc','(67)9999-9999',2),(2,'505.898.429-60','2015-07-27','2005-08-31','soniagoes@gmail.com','soniagoes','SONIA GOES','ROLE_ADMIN','0c3c98be69c3a18656bc07b7b5a0ff750527d404','(67) 9800-8152',2),(3,'36694320191','2015-07-28','1975-07-30','soniagoes@gmail.com','sgoes','SONIA GOES','ROLE_ADMIN','da39a3ee5e6b4b0d3255bfef95601890afd80709','(67) 9999-9999',2);

/*Table structure for table `sexo` */

DROP TABLE IF EXISTS `sexo`;

CREATE TABLE `sexo` (
  `IdSexo` int(11) NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(9) NOT NULL,
  PRIMARY KEY (`IdSexo`),
  UNIQUE KEY `Descricao` (`Descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sexo` */

insert  into `sexo`(`IdSexo`,`Descricao`) values (2,'Feminino'),(1,'Masculino');

/*Table structure for table `tipoendereco` */

DROP TABLE IF EXISTS `tipoendereco`;

CREATE TABLE `tipoendereco` (
  `IdTipoEndereco` int(11) NOT NULL AUTO_INCREMENT,
  `DescricaoTipoEndereco` varchar(35) NOT NULL,
  PRIMARY KEY (`IdTipoEndereco`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tipoendereco` */

insert  into `tipoendereco`(`IdTipoEndereco`,`DescricaoTipoEndereco`) values (1,'RESIDENCIAL');

/*Table structure for table `tipologradouro` */

DROP TABLE IF EXISTS `tipologradouro`;

CREATE TABLE `tipologradouro` (
  `IdTipoLogradouro` int(11) NOT NULL AUTO_INCREMENT,
  `DescricaoTipoLogradouro` varchar(40) NOT NULL,
  PRIMARY KEY (`IdTipoLogradouro`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tipologradouro` */

insert  into `tipologradouro`(`IdTipoLogradouro`,`DescricaoTipoLogradouro`) values (1,'AVENIDA');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
