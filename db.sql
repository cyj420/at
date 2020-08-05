/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.11-MariaDB : Database - at
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`at` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `at`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `displayStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `title` char(200) NOT NULL,
  `body` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `articleReply` */

DROP TABLE IF EXISTS `articleReply`;

CREATE TABLE `articleReply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `articleId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `body` char(200) NOT NULL,
  `displayStatus` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
