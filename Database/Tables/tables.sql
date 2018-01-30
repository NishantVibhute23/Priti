/*
SQLyog Community v8.82 
MySQL - 5.5.11 : Database - pritienterprises
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pritienterprises` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `pritienterprises`;

/*Table structure for table `clients_address` */

DROP TABLE IF EXISTS `clients_address`;

CREATE TABLE `clients_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(500) NOT NULL,
  `company_address` varchar(500) NOT NULL,
  `company_gstin` varchar(200) NOT NULL,
  `inserted_date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `company_email` varchar(150) DEFAULT NULL,
  `company_phone1` varchar(20) DEFAULT NULL,
  `company_phone2` varchar(20) DEFAULT NULL,
  `company_phone3` varchar(20) DEFAULT NULL,
  `company_state` int(11) DEFAULT NULL,
  `company_bank_name` varchar(500) DEFAULT NULL,
  `company_bank_ifsc` varchar(300) DEFAULT NULL,
  `company_bank_account_no` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`company_gstin`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `clients_address` */

insert  into `clients_address`(`id`,`company_name`,`company_address`,`company_gstin`,`inserted_date_time`,`company_email`,`company_phone1`,`company_phone2`,`company_phone3`,`company_state`,`company_bank_name`,`company_bank_ifsc`,`company_bank_account_no`) values (1,'Nishant','nisahfdsjfn','GSDFT5556556','0000-00-00 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'dfs','sg','sdfg','0000-00-00 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'DDFs','adsfdsf','adsfdsaf','0000-00-00 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'SagarAndBros.','Kalyan','GSTIN123465','0000-00-00 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'','','','2017-08-02 14:37:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'ABC','Gorai, CD787/C-8, ABC Co. Op. HSG. LTD. ','GSTIN798797787','2017-09-05 11:54:18','abc@gmail.com','985874587','4587744587','45447458775',NULL,NULL,NULL,NULL),(9,'xyz','sfg fdsgfsd sdfgfdghdsfghsdfhgdfshgdsfgdfsg dfsg sdf glkjsdfg isdfglksdjfg iosdfug sdlfkgio sdfgfdsg ijfdsio fdsgsdfgjsdfigi sdfdsjgoisdf sdfg fsd;g ','GSTIN798797788','2017-09-05 12:28:26','nishant.vibhute92@gmail.com','98874544577','4544447874','',7,NULL,NULL,NULL),(10,'fdsg','fdsg','sfdg','2017-09-05 14:20:24','','','','',0,NULL,NULL,NULL),(11,'ABC','fjsadfil jadfh asdjfasldjf asdfsldkahfawr.iasfh askdfnasdfh war nafhadsklf nasdhfqry324 wf jhady 4q2r sdafhasdfar2394 hrwaksfhf','4874577','2017-09-11 18:56:45','abc@gmail.com','1111111111111','222222222222','333333333333',23,'Maharashtra','897978','4477878'),(12,'Test','Gorai(2)','547745FGD778','2018-01-27 11:08:26','abc@gmail.com','985689855','4587445587','5599565445',1,'5599565445','5599565445','5599565445'),(16,'Test2','Mumbai','GSTIN798797788w','2018-01-27 11:17:00','abc@ymail.com','878987','','',1,'MUmbia','897978','4477878'),(18,'adsfdasf','adsfdsf','asdfdsf','2018-01-28 18:35:37','adsfdsf@gmail.com','adsfdsf','','',11,'','','');

/*Table structure for table `invoice` */

DROP TABLE IF EXISTS `invoice`;

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `reverse_charge` varchar(10) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `transport_mode` varchar(250) DEFAULT NULL,
  `vehicle_no` varchar(100) DEFAULT NULL,
  `date_of_supply` date DEFAULT NULL,
  `place_of_supply` varchar(100) DEFAULT NULL,
  `bill_to_party` int(11) DEFAULT NULL,
  `ship_to_party` int(11) DEFAULT NULL,
  `total_amount_before_tax` double DEFAULT NULL,
  `cgst_perc` double DEFAULT NULL,
  `cgst_amount` double DEFAULT NULL,
  `sgst_perc` double DEFAULT NULL,
  `sgst_amount` double DEFAULT NULL,
  `igst_perc` double DEFAULT NULL,
  `igst_amount` double DEFAULT NULL,
  `total_amount_after_tax` double DEFAULT NULL,
  `round_off` double DEFAULT NULL,
  `bill_amount` int(11) DEFAULT NULL,
  `bill_amount_in_words` varchar(800) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isPaymentDone` int(11) DEFAULT '0',
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(200) DEFAULT NULL,
  `bank_name` varchar(500) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `total_amount_gst` double DEFAULT NULL,
  `gst_on_reverse_charge` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `invoice` */

insert  into `invoice`(`id`,`date`,`reverse_charge`,`state`,`code`,`transport_mode`,`vehicle_no`,`date_of_supply`,`place_of_supply`,`bill_to_party`,`ship_to_party`,`total_amount_before_tax`,`cgst_perc`,`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`total_amount_after_tax`,`round_off`,`bill_amount`,`bill_amount_in_words`,`inserted_datetime`,`isPaymentDone`,`payment_mode`,`cheque_no`,`bank_name`,`cheque_date`,`payment_amount`,`total_amount_gst`,`gst_on_reverse_charge`) values (1,'2017-10-01','no','ArunachalPradesh',12,'','',NULL,'',9,0,1100,9,99,9,99,0,0,1298,0,1298,'One Thousand Two Hundred and Ninety Eight rupees only','2017-10-12 12:00:46',1,NULL,NULL,NULL,NULL,NULL,198,0),(2,'2017-10-09','no','ArunachalPradesh',12,'Bike','',NULL,'',9,0,5310,9,477.9,9,477.9,0,0,6265.8,0.2,6266,'Six Thousand Two Hundred and Sixty Six rupees only','2017-10-12 12:05:45',1,NULL,NULL,NULL,NULL,NULL,955.8,0),(3,'2018-01-25','no','ArunachalPradesh',12,'','',NULL,'',12,0,1000,0,0,0,0,18,180,1180,0,1180,'One Thousand One Hundred Eighty rupees only','2018-01-27 23:29:52',1,NULL,NULL,NULL,NULL,NULL,180,0),(4,'2018-01-01','no','ArunachalPradesh',12,'','',NULL,'',12,9,10000,9,900,9,900,0,0,11800,0,11800,'Eleven Thousand Eight Hundred rupees only','2018-01-28 01:38:07',0,NULL,NULL,NULL,NULL,NULL,1800,0),(5,'2018-01-10','no','ArunachalPradesh',12,'','',NULL,'',16,0,10000,0,0,0,0,18,1800,11800,0,11800,'Eleven Thousand Eight Hundred rupees only','2018-01-28 13:06:32',0,NULL,NULL,NULL,NULL,NULL,1800,0),(6,'2018-01-18','no','ArunachalPradesh',12,'','',NULL,'',9,0,11500,0,0,0,0,18,2070,13570,0,13570,'Thirteen Thousand Five Hundred Seventy rupees only','2018-01-28 13:10:04',0,NULL,NULL,NULL,NULL,NULL,2070,0),(7,'2018-01-16','no','ArunachalPradesh',12,'','',NULL,'',12,0,2000,9,180,9,180,0,0,2360,0,2360,'Two Thousand Three Hundred Sixty rupees only','2018-01-28 13:26:02',0,NULL,NULL,NULL,NULL,NULL,360,0),(8,'2018-01-17','no','ArunachalPradesh',12,'','',NULL,'',12,0,1000,0,0,0,0,18,180,1180,0,1180,'One Thousand One Hundred Eighty rupees only','2018-01-28 13:32:52',0,NULL,NULL,NULL,NULL,NULL,180,0),(9,'2018-01-11','no','ArunachalPradesh',12,'','',NULL,'',18,0,110,0,0,0,0,18,19.8,129.8,0.2,130,'One Hundred Thirty rupees only','2018-01-28 20:40:55',0,NULL,NULL,NULL,NULL,NULL,19.8,0);

/*Table structure for table `invoice_details` */

DROP TABLE IF EXISTS `invoice_details`;

CREATE TABLE `invoice_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `cgst_perc` double DEFAULT NULL,
  `cgst_amount` double DEFAULT NULL,
  `sgst_perc` double DEFAULT NULL,
  `sgst_amount` double DEFAULT NULL,
  `igst_perc` double DEFAULT NULL,
  `igst_amount` double DEFAULT NULL,
  `totalAmountAfterTax` double DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hsn` varchar(100) DEFAULT NULL,
  `uom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `invoice_details` */

insert  into `invoice_details`(`id`,`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`invoice_id`,`inserted_datetime`,`hsn`,`uom`) values (1,3,10,100,1000,9,90,9,90,0,0,1180,1,'2017-10-12 12:00:46','48025450','Nos.'),(2,4,5,20,100,9,9,9,9,0,0,118,1,'2017-10-12 12:00:46','48025452','KG'),(3,3,59,90,5310,9,477.9,9,477.9,0,0,6265.8,2,'2017-10-12 12:05:45','48025450','Nos.'),(4,12,10,100,1000,0,0,0,0,18,180,1180,3,'2018-01-27 23:29:52','48025450','Nos.'),(14,11,110,1,110,0,0,0,0,18,19.8,129.8,9,'2018-01-28 21:55:18','48025450','Nos.');

/*Table structure for table `invoice_payment` */

DROP TABLE IF EXISTS `invoice_payment`;

CREATE TABLE `invoice_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_mode` varchar(50) DEFAULT NULL,
  `cheque_no` varchar(200) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `bank_name` varchar(500) DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `inserted_Date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_date` date NOT NULL,
  `utr_no` varchar(150) DEFAULT NULL,
  `ifsc_code` varchar(150) DEFAULT NULL,
  `invoice_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `invoice_payment` */

insert  into `invoice_payment`(`id`,`payment_mode`,`cheque_no`,`cheque_date`,`bank_name`,`payment_amount`,`inserted_Date_time`,`payment_date`,`utr_no`,`ifsc_code`,`invoice_type`) values (1,'cash',NULL,NULL,NULL,7564,'2017-10-12 12:06:41','2017-11-01',NULL,NULL,1),(2,'cheque','8224.6','2017-10-01','BOI',8224.6,'2017-10-12 12:07:25','2017-10-09',NULL,NULL,2),(3,'cash',NULL,NULL,NULL,1180,'2017-10-12 13:46:37','2017-10-01',NULL,NULL,2),(4,'cash',NULL,NULL,NULL,1180,'2018-01-28 01:41:34','2018-01-29',NULL,NULL,1),(5,'cash',NULL,NULL,NULL,2360,'2018-01-28 22:47:28','2018-01-16',NULL,NULL,2);

/*Table structure for table `invoice_type` */

DROP TABLE IF EXISTS `invoice_type`;

CREATE TABLE `invoice_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `invoice_type` */

insert  into `invoice_type`(`id`,`inv_type`) values (1,'Invoice'),(2,'Purchase');

/*Table structure for table `m_uom` */

DROP TABLE IF EXISTS `m_uom`;

CREATE TABLE `m_uom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uom` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `m_uom` */

insert  into `m_uom`(`id`,`uom`) values (1,'Nos.'),(2,'KG'),(3,'Liters');

/*Table structure for table `main_products` */

DROP TABLE IF EXISTS `main_products`;

CREATE TABLE `main_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hsn_code` varchar(50) DEFAULT NULL,
  `UOM` int(11) DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UOM` (`UOM`),
  KEY `product_type` (`product_type`),
  CONSTRAINT `main_products_ibfk_1` FOREIGN KEY (`UOM`) REFERENCES `m_uom` (`id`),
  CONSTRAINT `main_products_ibfk_2` FOREIGN KEY (`product_type`) REFERENCES `main_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `main_products` */

insert  into `main_products`(`id`,`product_name`,`inserted_datetime`,`hsn_code`,`UOM`,`product_type`) values (1,'SERVIETTES','2017-09-11 12:55:47','48025450',1,1),(2,'PAPER NAPKINS','2017-09-11 12:57:26','48025452',2,1),(3,'TOILET ROLL','2017-09-11 12:59:36','48025450',1,1),(4,'KITCHEN ROLLS','2017-09-11 13:00:56','48025450',1,1),(5,'C-FOLD','2017-09-11 13:01:38','48025450',1,1),(6,'M-FOLD','2017-09-11 13:02:40','48025450',1,1),(7,'POP UP TISSUE','2017-09-11 13:03:23','48025450',1,1),(8,'FACIAL TISSUE','2017-09-11 13:03:50','48025450',1,1),(9,'HRT ROLLS','2017-09-11 13:04:21','48025450',1,1),(10,'PAPER RAW','2017-09-25 14:24:51','865545',2,3),(11,'clean care','2017-10-15 17:05:15','3401',1,1);

/*Table structure for table `my_profile` */

DROP TABLE IF EXISTS `my_profile`;

CREATE TABLE `my_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(300) DEFAULT NULL,
  `company_address` varchar(500) DEFAULT NULL,
  `company_gstin` varchar(200) DEFAULT NULL,
  `company_email` varchar(150) DEFAULT NULL,
  `company_phone1` varchar(20) DEFAULT NULL,
  `company_phone2` varchar(20) DEFAULT NULL,
  `company_phone3` varchar(20) DEFAULT NULL,
  `company_state` int(11) DEFAULT NULL,
  `company_bank_name` varchar(500) DEFAULT NULL,
  `company_bank_ifsc` varchar(300) DEFAULT NULL,
  `company_bank_account_no` varchar(300) DEFAULT NULL,
  `company_logo` varchar(1000) DEFAULT NULL,
  `product_threashold` int(11) DEFAULT NULL,
  `term_condition1` varchar(1000) DEFAULT NULL,
  `term_condition2` varchar(1000) DEFAULT NULL,
  `term_condition3` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `my_profile` */

insert  into `my_profile`(`id`,`company_name`,`company_address`,`company_gstin`,`company_email`,`company_phone1`,`company_phone2`,`company_phone3`,`company_state`,`company_bank_name`,`company_bank_ifsc`,`company_bank_account_no`,`company_logo`,`product_threashold`,`term_condition1`,`term_condition2`,`term_condition3`) values (1,'Priti Enterprises','T.B. Bhandari Compound, M.G. Road, Charkop Village, Kandivali(west), Mumbai-400 067.','27AAGFM6340M1ZY ','priti@gmail.com','9874587451','9874515474','987451547',4,'Bank Of India','MAHB0001757','60248745956',NULL,0,'Any dispute regarding QTY / Quality / Rate must be reported before month end.','Payment within  30 Days.','');

/*Table structure for table `payment_invoice_details` */

DROP TABLE IF EXISTS `payment_invoice_details`;

CREATE TABLE `payment_invoice_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_payment_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `invoice_payment_id` (`invoice_payment_id`),
  CONSTRAINT `payment_invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `payment_invoice_details_ibfk_2` FOREIGN KEY (`invoice_payment_id`) REFERENCES `invoice_payment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `payment_invoice_details` */

insert  into `payment_invoice_details`(`id`,`invoice_payment_id`,`invoice_id`) values (1,1,2),(2,1,1),(3,4,3);

/*Table structure for table `payment_purchase_details` */

DROP TABLE IF EXISTS `payment_purchase_details`;

CREATE TABLE `payment_purchase_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_payment_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `invoice_payment_id` (`invoice_payment_id`),
  CONSTRAINT `payment_purchase_details_ibfk_1` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`id`),
  CONSTRAINT `payment_purchase_details_ibfk_2` FOREIGN KEY (`invoice_payment_id`) REFERENCES `invoice_payment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `payment_purchase_details` */

insert  into `payment_purchase_details`(`id`,`invoice_payment_id`,`purchase_id`) values (1,2,1),(2,3,2),(3,5,3);

/*Table structure for table `payment_type` */

DROP TABLE IF EXISTS `payment_type`;

CREATE TABLE `payment_type` (
  `id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payment_type` */

insert  into `payment_type`(`id`,`type`) values (0,'Not Paid'),(1,'Paid'),(2,'Partially Paid');

/*Table structure for table `product_type` */

DROP TABLE IF EXISTS `product_type`;

CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `product_type` */

insert  into `product_type`(`id`,`type_name`) values (1,'Main Product'),(2,'Packing Material'),(3,'Raw Material');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(300) NOT NULL,
  `product_shotform` varchar(200) DEFAULT NULL,
  `product_main_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_main_id` (`product_main_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_main_id`) REFERENCES `main_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `products` */

insert  into `products`(`id`,`product_name`,`product_shotform`,`product_main_id`,`qty`,`inserted_datetime`) values (1,'n 100 PULLS','30CM X 30 CM - 100 PULLS',1,1,'2017-09-11 12:55:51'),(2,'27CM X 30 CM - 100 PULLS','27CM X 30 CM - 100 PULLS',1,20,'2017-09-11 12:55:52'),(3,'33CM X 33 CM - 50 PULLS X 2 PLY','33CM X 33 CM - 50 PULLS X 2 PLY',1,-55,'2017-09-11 12:55:56'),(4,'30CM X 30 CM - 100 PULLS','30CM X 30 CM - 100 PULLS',2,-47,'2017-09-11 12:57:26'),(5,'30CM X 30 CM - 100 PULLS','27CM X 30 CM - 100 PULLS',2,55,'2017-09-11 12:57:26'),(6,'30CM X 30 CM - 100 PULLS','22CM X 22 CM - 80 PULLS',2,0,'2017-09-11 12:57:26'),(7,'30CM X 30 CM - 100 PULLS','20CM X 22 CM - 80 PULLS',2,12,'2017-09-11 12:57:26'),(8,'9.5CM X 11CM - 200 PULLS','9.5CM X 11cM - 200 PULLS',3,23,'2017-09-11 12:59:36'),(9,'9.5CM X 11 CM - 300 PULLS','9.5CM X 11 CM - 300 PULLS',3,11,'2017-09-11 12:59:36'),(10,'9.5CM X 11 CM - 400 PULLS','9.5CM X 11 CM - 400 PULLS',3,100,'2017-09-11 12:59:36'),(11,'23CM X 20 CM - 70 PULLS 1X1','23CM X 20 CM - 70 PULLS 1X1',4,-75,'2017-09-11 13:00:56'),(12,'23CM X 20 CM - 70 PULLS 2X1','23CM X 20 CM - 70 PULLS 2X1',4,10,'2017-09-11 13:00:56'),(13,'23CM X 20 CM - 70 PULLS 4X1','23CM X 20 CM - 70 PULLS 4X1',4,10,'2017-09-11 13:00:56'),(14,'21CM X 27 CM - 100 PULLS','21CM X 27 CM - 100 PULLS',5,0,'2017-09-11 13:01:38'),(15,'21CM X 27 CM - 125 PULLS','21CM X 27 CM - 125 PULLS',5,-30,'2017-09-11 13:01:38'),(16,'21CM X 27 CM - 150 PULLS','21CM X 27 CM - 150 PULLS',5,0,'2017-09-11 13:01:38'),(17,'21CM X 21CM - 115 PULLS','21CM X 21CM - 115 PULLS',6,0,'2017-09-11 13:02:40'),(18,'21CM X 21CM - 125 PULLS','21CM X 21CM - 125 PULLS',6,0,'2017-09-11 13:02:41'),(19,'21CM X 21CM - 150 PULLS','21CM X 21CM - 150 PULLS',6,0,'2017-09-11 13:02:41'),(20,'21CM X 23CM - 150 PULLS','21CM X 23CM - 150 PULLS',6,0,'2017-09-11 13:02:41'),(21,'20CM X 10 CM - 115 PULLS','20CM X 10 CM - 115 PULLS',7,0,'2017-09-11 13:03:23'),(22,'20CM X 10 CM - 125 PULLS','20CM X 10 CM - 125 PULLS',7,0,'2017-09-11 13:03:23'),(23,'20CM X 10 CM - 150 PULLS','20CM X 10 CM - 150 PULLS',7,0,'2017-09-11 13:03:23'),(24,'20CM X 20 CM - 110 PULLS','20CM X 20 CM - 110 PULLS',8,0,'2017-09-11 13:03:50'),(25,'20CM X 1.5 KG','20CM X 1.5 KG',9,80,'2017-09-11 13:04:21'),(26,'20CM X 22 CM - 80 PULLS',NULL,1,13,'2017-09-11 17:02:21'),(27,'21CM X 23CM - 200 PULLS',NULL,6,0,'2017-09-11 17:21:38'),(28,'RAW PAPERS','RAW PAPERS',10,174,'2017-09-25 14:24:51'),(29,'wet tissue','wet tissue',11,0,'2017-10-15 17:05:15');

/*Table structure for table `purchase` */

DROP TABLE IF EXISTS `purchase`;

CREATE TABLE `purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_date` varchar(300) DEFAULT NULL,
  `invoice_num` varchar(200) DEFAULT NULL,
  `totalamount` double DEFAULT NULL,
  `cgst_perc` double DEFAULT NULL,
  `cgst_amount` double DEFAULT NULL,
  `sgst_perc` double DEFAULT NULL,
  `sgst_amount` double DEFAULT NULL,
  `igst_perc` double DEFAULT NULL,
  `igst_amount` double DEFAULT NULL,
  `totalAmountAfterTax` double DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isPaymentDone` int(11) NOT NULL DEFAULT '0',
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(200) DEFAULT NULL,
  `bank_name` varchar(500) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `round_off` double DEFAULT NULL,
  `bill_amount` int(11) DEFAULT NULL,
  `bill_amount_in_words` varchar(800) DEFAULT NULL,
  `total_amount_gst` double DEFAULT NULL,
  `gst_on_reverse_charge` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients_address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `purchase` */

insert  into `purchase`(`id`,`invoice_date`,`invoice_num`,`totalamount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`client_id`,`inserted_datetime`,`isPaymentDone`,`payment_mode`,`cheque_no`,`bank_name`,`cheque_date`,`payment_amount`,`round_off`,`bill_amount`,`bill_amount_in_words`,`total_amount_gst`,`gst_on_reverse_charge`) values (1,'2017-10-12','IN01',6970,9,627.3,9,627.3,0,0,8224.6,9,'2017-10-12 12:04:59',1,NULL,NULL,NULL,NULL,NULL,0.4,8225,'Eight Thousand Two Hundred and Twenty Five rupees only',1254.6,0),(2,'2017-10-12','IN02',1000,0,0,0,0,18,180,1180,9,'2017-10-12 13:46:22',1,NULL,NULL,NULL,NULL,NULL,0,1180,'One Thousand One Hundred Eighty rupees only',180,0),(3,'2018-01-17','INV04',2000,0,0,0,0,18,360,2360,12,'2018-01-27 23:37:55',1,NULL,NULL,NULL,NULL,NULL,0,2360,'Two Thousand Three Hundred Sixty rupees only',360,0),(4,'2018-01-17','INV25',2024,9,182.16,9,182.16,0,0,2388.32,11,'2018-01-28 22:25:09',0,NULL,NULL,NULL,NULL,NULL,-0.32,2388,'Two Thousand Three Hundred and Eighty Eight rupees only',364.32,0);

/*Table structure for table `purchase_details` */

DROP TABLE IF EXISTS `purchase_details`;

CREATE TABLE `purchase_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `cgst_perc` double DEFAULT NULL,
  `cgst_amount` double DEFAULT NULL,
  `sgst_perc` double DEFAULT NULL,
  `sgst_amount` double DEFAULT NULL,
  `igst_perc` double DEFAULT NULL,
  `igst_amount` double DEFAULT NULL,
  `totalAmountAfterTax` double DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hsn` varchar(100) DEFAULT NULL,
  `uom` varchar(50) DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `purchase_details_ibfk_1` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`id`),
  CONSTRAINT `purchase_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `purchase_details` */

insert  into `purchase_details`(`id`,`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`purchase_id`,`inserted_datetime`,`hsn`,`uom`,`product_type`) values (3,13,10,100,1000,0,0,0,0,18,180,1180,2,'2017-10-12 13:46:22','48025450','Nos.',NULL),(5,2,10,200,2000,0,0,0,0,18,360,2360,3,'2018-01-27 23:39:04','48025450','Nos.',NULL),(11,15,10,100,1000,9,90,9,90,0,0,1180,4,'2018-01-28 22:46:46','48025450','Nos.',NULL),(12,8,5,98,490,9,44.1,9,44.1,0,0,578.2,4,'2018-01-28 22:46:46','48025450','Nos.',NULL),(13,1,6,89,534,9,48.06,9,48.06,0,0,630.12,4,'2018-01-28 22:46:46','48025450','Nos.',NULL);

/*Table structure for table `state` */

DROP TABLE IF EXISTS `state`;

CREATE TABLE `state` (
  `id` int(11) DEFAULT NULL,
  `state_name` varchar(200) DEFAULT NULL,
  `state_tin` int(11) DEFAULT NULL,
  `state_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `state` */

insert  into `state`(`id`,`state_name`,`state_tin`,`state_code`) values (1,'AndamanandNicobarIslands',35,'AN\r'),(2,'AndhraPradesh',28,'AP\r'),(3,'AndhraPradesh(New)',37,'AD\r'),(4,'ArunachalPradesh',12,'AR\r'),(5,'Assam',18,'AS\r'),(6,'Bihar',10,'BH\r'),(7,'Chandigarh',4,'CH\r'),(8,'Chattisgarh',22,'CT\r'),(9,'DadraandNagarHaveli',26,'DN\r'),(10,'DamanandDiu',25,'DD\r'),(11,'Delhi',7,'DL\r'),(12,'Goa',30,'GA\r'),(13,'Gujarat',24,'GJ\r'),(14,'Haryana',6,'HR\r'),(15,'HimachalPradesh',2,'HP\r'),(16,'JammuandKashmir',1,'JK\r'),(17,'Jharkhand',20,'JH\r'),(18,'Karnataka',29,'KA\r'),(19,'Kerala',32,'KL\r'),(20,'LakshadweepIslands',31,'LD\r'),(21,'MadhyaPradesh',23,'MP\r'),(22,'Maharashtra',27,'MH\r'),(23,'Manipur',14,'MN\r'),(24,'Meghalaya',17,'ME\r'),(25,'Mizoram',15,'MI\r'),(26,'Nagaland',13,'NL\r'),(27,'Odisha',21,'OR\r'),(28,'Pondicherry',34,'PY\r'),(29,'Punjab',3,'PB\r'),(30,'Rajasthan',8,'RJ\r'),(31,'Sikkim',11,'SK\r'),(32,'TamilNadu',33,'TN\r'),(33,'Telangana',36,'TS\r'),(34,'Tripura',16,'TR\r'),(35,'UttarPradesh',9,'UP\r'),(36,'Uttarakhand',5,'UT\r'),(37,'WestBengal',19,'WB\r');

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nae` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `test` */

insert  into `test`(`id`,`nae`) values (1,'a'),(2,'b');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`user_name`,`password`,`inserted_datetime`) values (1,'PritiEnterprises','root','0000-00-00 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
