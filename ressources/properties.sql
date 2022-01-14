/*
SQLyog Ultimate v12.01 (64 bit)
MySQL - 5.7.20-enterprise-commercial-advanced : Database - pricer
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pricer` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `pricer`;

/*Data for the table `properties_prp` */

insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (1,94,'BALANCE_CODE',1,1,100,1,'BALANCE_CODE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (2,84,'CALIBRE',1,1,100,1,'CALIBRE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (3,81,'CATEGORIE',1,1,100,1,'CATEGORIE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (4,410,'CONTENANCE_ITEM',1,1,100,1,'CONTENANCE_ITEM','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (5,411,'CONTENANCE_UNIT',1,1,100,1,'CONTENANCE_UNIT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (6,406,'COUNTRY_CODE',1,1,100,1,'COUNTRY_CODE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (7,407,'COUNTRY_LEBELLE',1,1,100,1,'COUNTRY_LEBELLE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (8,321,'DATE_DELIV',1,1,20,1,'DATE_DELIV','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (9,35,'DEEE',1,1,20,1,'DEEE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (10,37,'DISCOUNT_PRICE_FLAG',1,1,2,1,'DISCOUNT_PRICE_FLAG','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (11,53,'EAN_CONSIGNE',1,1,20,1,'EAN_CONSIGNE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (12,417,'EAN_FORMAT',1,1,10,1,'EAN_FORMAT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (13,34,'FLAG_DEEE',1,1,10,1,'FLAG_DEEE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (14,888,'FLASH',1,1,2,1,'FLASH','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (15,999,'FLASH_COMMENT',1,1,2,1,'FLASH_COMMENT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (16,414,'GONDOLA',1,1,100,1,'GONDOLA','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (17,415,'GONDOLA_HORI',1,1,100,1,'GONDOLA_HORI','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (18,416,'GONDOLA_VERTI',1,1,100,1,'GONDOLA_VERTI','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (19,206,'IMAGE',1,1,100,1,'IMAGE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (20,51,'ITEM_CONSIGNE',1,1,10,1,'ITEM_CONSIGNE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (21,418,'ITEM_NAME_2',1,1,100,1,'ITEM_NAME_2','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (22,9,'ITEM_NAME_3',1,1,100,1,'ITEM_NAME_3','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (23,12,'ITEM_SIZE',1,1,20,1,'ITEM_SIZE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (24,3,'ITEM_UNDER_FAMILY',1,1,20,1,'ITEM_UNDER_FAMILY','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (25,346,'LAST_SALES_DATE',1,1,30,1,'LAST_SALES_DATE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (26,401,'LIBELLE_AFFICHETTE',1,1,100,1,'LIBELLE_AFFICHETTE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (27,4,'LIFE_CYCLE',1,1,10,1,'LIFE_CYCLE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (28,50,'LINK_CONSIGNE',1,1,10,1,'LINK_CONSIGNE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (29,200,'LOGO',1,1,100,1,'LOGO','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (30,322,'MAX_SALES',1,1,10,1,'MAX_SALES','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (31,340,'NATURE_FAMILY',1,1,10,1,'NATURE_FAMILY','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (32,341,'ORDERING',1,1,20,1,'ORDERING','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (33,342,'ORDERING_UNIT',1,1,20,1,'ORDERING_UNIT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (34,80,'ORIGINE',1,1,100,1,'ORIGINE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (35,52,'ORIGIN_PRICE',1,1,10,1,'ORIGIN_PRICE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (36,8,'PLBARCODE',2,1,30,1,'PLBARCODE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (37,49,'PRICE_NEEDED',1,1,10,1,'PRICE_NEEDED','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (38,320,'QTY_IN_ORDER',1,1,20,1,'QTY_IN_ORDER','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (39,409,'QTY_LOT',1,1,100,1,'QTY_LOT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (40,48,'QTY_NEEDED',1,1,10,1,'QTY_NEEDED','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (41,343,'RESERVE_DAY_NBR',1,1,20,1,'RESERVE_DAY_NBR','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (42,344,'RESERVE_QTY',1,1,20,1,'RESERVE_QTY','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (43,345,'RESERVE_QTY_UNIT',1,1,20,1,'RESERVE_QTY_UNIT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (44,421,'STATUS_CENTRAL',1,1,5,1,'STATUS_CENTRAL','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (45,420,'STATUS_STORE',1,1,5,1,'STATUS_STORE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (46,318,'STOCK_MINI',1,1,20,1,'STOCK_MINI','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (47,323,'STOCK_THEO',1,1,10,1,'STOCK_THEO','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (48,413,'TEXTILE_COLOR',1,1,100,1,'TEXTILE_COLOR','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (49,412,'TEXTILE_SIZE',1,1,100,1,'TEXTILE_SIZE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (50,83,'TRAITEMENT',1,1,100,1,'TRAITEMENT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (51,47,'TVA_CODE',1,1,10,1,'TVA_CODE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (52,71,'UNIT_CODE',1,1,20,1,'UNIT_CODE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (53,326,'UNIT_DELIV',1,1,20,1,'UNIT_DELIV','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (54,45,'UNIT_PRICE',1,1,20,2,'UNIT_PRICE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (55,46,'UNIT_PRICE_LOT',1,1,20,1,'UNIT_PRICE_LOT','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (56,328,'UNIT_SALES',1,1,20,1,'UNIT_SALES','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (57,325,'UNIT_STOCK',1,1,10,1,'UNIT_STOCK','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (58,327,'UNIT_UVC',1,1,20,1,'UNIT_UVC','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (59,92,'VARIETE',1,1,100,1,'VARIETE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (60,55,'FLAG_BEFORE_PROMO',1,1,10,1,'FLAG_BEFORE_PROMO','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (61,56,'FREE1',1,1,10,1,'FREE1','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (62,57,'MARGE',1,1,10,1,'MARGE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (63,54,'PRICE_BEFORE_PROMO',1,1,10,1,'PRICE_BEFORE_PROMO','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (65,800,'OP_TYPE',1,1,100,1,'OP_TYPE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (66,801,'OP_VALUE',1,1,100,1,'OP_VALUE','',0);
insert  into `properties_prp`(`id`,`number`,`name`,`sourceType`,`visible`,`size`,`type`,`readable_name`,`description`,`history_length`) values (67,802,'OP_NB',1,1,100,1,'OP_NB','',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
