/*
SQLyog Community v12.3.2 (64 bit)
MySQL - 5.5.33 : Database - pritienterprises
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `clients_address` */

/*Table structure for table `invoice` */

DROP TABLE IF EXISTS `invoice`;

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceId` int(11) NOT NULL,
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
  `isLast` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `invoice` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `invoice_details` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `invoice_payment` */

/*Table structure for table `invoice_type` */

DROP TABLE IF EXISTS `invoice_type`;

CREATE TABLE `invoice_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `invoice_type` */

insert  into `invoice_type`(`id`,`inv_type`) values 
(1,'Invoice'),
(2,'Purchase');

/*Table structure for table `m_uom` */

DROP TABLE IF EXISTS `m_uom`;

CREATE TABLE `m_uom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uom` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `m_uom` */

insert  into `m_uom`(`id`,`uom`) values 
(1,'Nos.'),
(2,'KG'),
(3,'Liters');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `main_products` */

insert  into `main_products`(`id`,`product_name`,`inserted_datetime`,`hsn_code`,`UOM`,`product_type`) values 
(1,'SERVIETTES','2017-09-11 18:25:47','48025450',1,1),
(2,'PAPER NAPKINS','2017-09-11 18:27:26','48025452',2,1),
(3,'TOILET ROLL','2017-09-11 18:29:36','48025450',1,1),
(4,'KITCHEN ROLLS','2017-09-11 18:30:56','48025450',1,1),
(5,'C-FOLD','2017-09-11 18:31:38','48025450',1,1),
(6,'M-FOLD','2017-09-11 18:32:40','48025450',1,1),
(7,'POP UP TISSUE','2017-09-11 18:33:23','48025450',1,1),
(8,'FACIAL TISSUE','2017-09-11 18:33:50','48025450',1,1),
(9,'HRT ROLLS','2017-09-11 18:34:21','48025450',1,1),
(10,'PAPER RAW','2017-09-25 19:54:51','865545',2,3),
(11,'clean care','2017-10-15 22:35:15','3401',1,1);

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

insert  into `my_profile`(`id`,`company_name`,`company_address`,`company_gstin`,`company_email`,`company_phone1`,`company_phone2`,`company_phone3`,`company_state`,`company_bank_name`,`company_bank_ifsc`,`company_bank_account_no`,`company_logo`,`product_threashold`,`term_condition1`,`term_condition2`,`term_condition3`) values 
(1,'Priti Enterprises','T.B. Bhandari Compound, M.G. Road, Charkop Village, Kandivali(west), Mumbai-400 067.','27AAGFM6340M1ZY ','priti@gmail.com','9874587451','9874515474','987451547',4,'Bank Of India','MAHB0001757','60248745956',NULL,0,'Any dispute regarding QTY / Quality / Rate must be reported before month end.','Payment within  30 Days.','');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payment_invoice_details` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payment_purchase_details` */

/*Table structure for table `payment_type` */

DROP TABLE IF EXISTS `payment_type`;

CREATE TABLE `payment_type` (
  `id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payment_type` */

insert  into `payment_type`(`id`,`type`) values 
(0,'Not Paid'),
(1,'Paid'),
(2,'Partially Paid');

/*Table structure for table `product_type` */

DROP TABLE IF EXISTS `product_type`;

CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `product_type` */

insert  into `product_type`(`id`,`type_name`) values 
(1,'Main Product'),
(2,'Packing Material'),
(3,'Raw Material');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `products` */

insert  into `products`(`id`,`product_name`,`product_shotform`,`product_main_id`,`qty`,`inserted_datetime`) values 
(1,'n 100 PULLS','30CM X 30 CM - 100 PULLS',1,-60,'2017-09-11 18:25:51'),
(2,'27CM X 30 CM - 100 PULLS','27CM X 30 CM - 100 PULLS',1,-10,'2017-09-11 18:25:52'),
(3,'33CM X 33 CM - 50 PULLS X 2 PLY','33CM X 33 CM - 50 PULLS X 2 PLY',1,-10,'2017-09-11 18:25:56'),
(4,'30CM X 30 CM - 100 PULLS','30CM X 30 CM - 100 PULLS',2,0,'2017-09-11 18:27:26'),
(5,'30CM X 30 CM - 100 PULLS','27CM X 30 CM - 100 PULLS',2,0,'2017-09-11 18:27:26'),
(6,'30CM X 30 CM - 100 PULLS','22CM X 22 CM - 80 PULLS',2,0,'2017-09-11 18:27:26'),
(7,'30CM X 30 CM - 100 PULLS','20CM X 22 CM - 80 PULLS',2,0,'2017-09-11 18:27:26'),
(8,'9.5CM X 11CM - 200 PULLS','9.5CM X 11cM - 200 PULLS',3,0,'2017-09-11 18:29:36'),
(9,'9.5CM X 11 CM - 300 PULLS','9.5CM X 11 CM - 300 PULLS',3,0,'2017-09-11 18:29:36'),
(10,'9.5CM X 11 CM - 400 PULLS','9.5CM X 11 CM - 400 PULLS',3,0,'2017-09-11 18:29:36'),
(11,'23CM X 20 CM - 70 PULLS 1X1','23CM X 20 CM - 70 PULLS 1X1',4,-100,'2017-09-11 18:30:56'),
(12,'23CM X 20 CM - 70 PULLS 2X1','23CM X 20 CM - 70 PULLS 2X1',4,10,'2017-09-11 18:30:56'),
(13,'23CM X 20 CM - 70 PULLS 4X1','23CM X 20 CM - 70 PULLS 4X1',4,-89,'2017-09-11 18:30:56'),
(14,'21CM X 27 CM - 100 PULLS','21CM X 27 CM - 100 PULLS',5,0,'2017-09-11 18:31:38'),
(15,'21CM X 27 CM - 125 PULLS','21CM X 27 CM - 125 PULLS',5,0,'2017-09-11 18:31:38'),
(16,'21CM X 27 CM - 150 PULLS','21CM X 27 CM - 150 PULLS',5,0,'2017-09-11 18:31:38'),
(17,'21CM X 21CM - 115 PULLS','21CM X 21CM - 115 PULLS',6,0,'2017-09-11 18:32:40'),
(18,'21CM X 21CM - 125 PULLS','21CM X 21CM - 125 PULLS',6,0,'2017-09-11 18:32:41'),
(19,'21CM X 21CM - 150 PULLS','21CM X 21CM - 150 PULLS',6,0,'2017-09-11 18:32:41'),
(20,'21CM X 23CM - 150 PULLS','21CM X 23CM - 150 PULLS',6,0,'2017-09-11 18:32:41'),
(21,'20CM X 10 CM - 115 PULLS','20CM X 10 CM - 115 PULLS',7,0,'2017-09-11 18:33:23'),
(22,'20CM X 10 CM - 125 PULLS','20CM X 10 CM - 125 PULLS',7,0,'2017-09-11 18:33:23'),
(23,'20CM X 10 CM - 150 PULLS','20CM X 10 CM - 150 PULLS',7,0,'2017-09-11 18:33:23'),
(24,'20CM X 20 CM - 110 PULLS','20CM X 20 CM - 110 PULLS',8,0,'2017-09-11 18:33:50'),
(25,'20CM X 1.5 KG','20CM X 1.5 KG',9,0,'2017-09-11 18:34:21'),
(26,'20CM X 22 CM - 80 PULLS',NULL,1,0,'2017-09-11 22:32:21'),
(27,'21CM X 23CM - 200 PULLS',NULL,6,0,'2017-09-11 22:51:38'),
(28,'RAW PAPERS','RAW PAPERS',10,0,'2017-09-25 19:54:51'),
(29,'wet tissue','wet tissue',11,0,'2017-10-15 22:35:15');

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
  `isLast` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `purchase` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `purchase_details` */

/*Table structure for table `state` */

DROP TABLE IF EXISTS `state`;

CREATE TABLE `state` (
  `id` int(11) DEFAULT NULL,
  `state_name` varchar(200) DEFAULT NULL,
  `state_tin` int(11) DEFAULT NULL,
  `state_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `state` */

insert  into `state`(`id`,`state_name`,`state_tin`,`state_code`) values 
(1,'AndamanandNicobarIslands',35,'AN\r'),
(2,'AndhraPradesh',28,'AP\r'),
(3,'AndhraPradesh(New)',37,'AD\r'),
(4,'ArunachalPradesh',12,'AR\r'),
(5,'Assam',18,'AS\r'),
(6,'Bihar',10,'BH\r'),
(7,'Chandigarh',4,'CH\r'),
(8,'Chattisgarh',22,'CT\r'),
(9,'DadraandNagarHaveli',26,'DN\r'),
(10,'DamanandDiu',25,'DD\r'),
(11,'Delhi',7,'DL\r'),
(12,'Goa',30,'GA\r'),
(13,'Gujarat',24,'GJ\r'),
(14,'Haryana',6,'HR\r'),
(15,'HimachalPradesh',2,'HP\r'),
(16,'JammuandKashmir',1,'JK\r'),
(17,'Jharkhand',20,'JH\r'),
(18,'Karnataka',29,'KA\r'),
(19,'Kerala',32,'KL\r'),
(20,'LakshadweepIslands',31,'LD\r'),
(21,'MadhyaPradesh',23,'MP\r'),
(22,'Maharashtra',27,'MH\r'),
(23,'Manipur',14,'MN\r'),
(24,'Meghalaya',17,'ME\r'),
(25,'Mizoram',15,'MI\r'),
(26,'Nagaland',13,'NL\r'),
(27,'Odisha',21,'OR\r'),
(28,'Pondicherry',34,'PY\r'),
(29,'Punjab',3,'PB\r'),
(30,'Rajasthan',8,'RJ\r'),
(31,'Sikkim',11,'SK\r'),
(32,'TamilNadu',33,'TN\r'),
(33,'Telangana',36,'TS\r'),
(34,'Tripura',16,'TR\r'),
(35,'UttarPradesh',9,'UP\r'),
(36,'Uttarakhand',5,'UT\r'),
(37,'WestBengal',19,'WB\r');

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nae` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `test` */

insert  into `test`(`id`,`nae`) values 
(1,'a'),
(2,'b');

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

insert  into `users`(`id`,`user_name`,`password`,`inserted_datetime`) values 
(1,'PritiEnterprises','root','0000-00-00 00:00:00');

/* Procedure structure for procedure `addCompanyAddress` */

/*!50003 DROP PROCEDURE IF EXISTS  `addCompanyAddress` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `addCompanyAddress`(comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin varchar(200),comp_email varchar(150),
comp_phone1 varchar(20),comp_phone2 VARCHAR(20),comp_phone3 VARCHAR(20),comp_state int,compBankName varchar(500),cmpIfsc varchar(300),cmpAccNo varchar(300))
BEGIN
		insert into clients_address(company_name,company_address,company_gstin,`company_email`,`company_phone1`,`company_phone2`,`company_phone3`,`company_state`,`company_bank_name`,`company_bank_ifsc`,`company_bank_account_no`) 
		values(comp_name,comp_add,comp_gstin,comp_email,comp_phone1,comp_phone2,comp_phone3,comp_state,compBankName,cmpIfsc,cmpAccNo);
		
		select LAST_INSERT_ID();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `addProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `addProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `addProduct`(product_id_in int,qty_in int)
BEGIN
		
DECLARE totalQty INT;
		
		SELECT (qty+qty_in) into totalQty FROM `products` WHERE `id`=product_id_in;
		
		
update `products`
set qty= totalQty
WHERE `id`=product_id_in;		
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `checkLogin` */

/*!50003 DROP PROCEDURE IF EXISTS  `checkLogin` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `checkLogin`(username_in varchar(500), password_in varchar(200))
BEGIN
		select count(id) from users
		where `user_name`=username_in and `password`=password_in;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deleteInvoice`(id_in int)
BEGIN
    declare maxId int;
    select max(id) into maxId from invoice;
    
    DELETE FROM `invoice` where id= id_in;
    
    
    SET @query = CONCAT(' ALTER TABLE `invoice` AUTO_INCREMENT =',maxId);
    PREPARE stmt FROM @query; 
    EXECUTE stmt; 
    
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteInvoiceDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteInvoiceDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deleteInvoiceDetails`(id_in int)
BEGIN
	delete from invoice_details
	where id=id_in;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deleteProduct`(product_id_in INT,qty_in INT)
BEGIN
		
DECLARE totalQty INT;
		
		SELECT (qty-qty_in) INTO totalQty FROM `products` WHERE `id`=product_id_in;
		
		
UPDATE `products`
SET qty= totalQty
WHERE `id`=product_id_in;	
	
SELECT ROW_COUNT();
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `deletePurchaseDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `deletePurchaseDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deletePurchaseDetails`(id_in INT)
BEGIN
	DELETE FROM purchase_details
	WHERE id=id_in;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `deletePurchasee` */

/*!50003 DROP PROCEDURE IF EXISTS  `deletePurchasee` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `deletePurchasee`(id_in INT)
BEGIN
    DECLARE maxId INT;
    SELECT MAX(id) INTO maxId FROM purchase;
    
    DELETE FROM `purchase` WHERE id= id_in;
    
    SET @QUERY = CONCAT(' ALTER TABLE `purchase` AUTO_INCREMENT =',maxId);
    PREPARE stmt FROM @QUERY; 
    EXECUTE stmt; 
       
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllProducts` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getAllProducts`()
BEGIN
		SELECT p.`id`, CONCAT(mp.`product_name`,' : ', p.`product_name`) as 'product_name',p.`product_shotform`,p.`product_main_id`
		FROM `products` p JOIN `main_products` mp
		ON mp.id = p.`product_main_id`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllProductType` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllProductType` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getAllProductType`()
BEGIN
		SELECT `id`,`type_name`
		FROM `product_type`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllSubProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllSubProducts` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getAllSubProducts`()
BEGIN
		SELECT `id`,`product_name`,`product_shotform`,`product_main_id`
		FROM `sub_products`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getAllUOM` */

/*!50003 DROP PROCEDURE IF EXISTS  `getAllUOM` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getAllUOM`()
BEGIN
		SELECT `id`,`uom`
		FROM `m_uom`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getCompanyDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getCompanyDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getCompanyDetails`(id_in int)
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,c.`company_phone1`,
		c.`company_phone2`,c.`company_phone3`,s.`state_name`,s.`state_tin`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,c.`company_bank_account_no`
		FROM `clients_address` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		where c.id=id_in;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getCompanyList` */

/*!50003 DROP PROCEDURE IF EXISTS  `getCompanyList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getCompanyList`()
BEGIN
		select c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,c.`company_phone1`,
		c.`company_phone2`,c.`company_phone3`,s.`state_name`,s.`state_code`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,c.`company_bank_account_no`
		FROM `clients_address` c JOIN `state`  s
		ON c.`company_state` =s.`id`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `getInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getInvoice`(id_in int)
BEGIN
		select `id`,
		`invoiceId`,
		`date`,
		`reverse_charge`,
		`state`,
		`code`,
		`transport_mode`,
		`vehicle_no`,
		`date_of_supply`,
		`place_of_supply`,`bill_to_party`,`ship_to_party`,
		`total_amount_before_tax`,
		`cgst_perc`,`cgst_amount`,
		`sgst_perc`,`sgst_amount`,
		`igst_perc`,`igst_amount`,
		`total_amount_after_tax`,
		`round_off`,
		`bill_amount`,
		`bill_amount_in_words`,
		`total_amount_gst`,
		`gst_on_reverse_charge`
		from `invoice`
		where `id` = id_in;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getInvoiceDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getInvoiceDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getInvoiceDetails`(id_in int)
BEGIN
		select p.`product_name`,
		i.`qty`,
		i.`amount`,
		i.`total_amount`,
		i.`cgst_perc`,
		i.`cgst_amount`,
		i.`sgst_perc`,
		i.`sgst_amount`,
		i.`igst_perc`,
		i.`igst_amount`,
		i.`totalAmountAfterTax`,
		i.hsn,
		i.uom,
		i.`product_id`,
		i.id
		from `invoice_details` i join `products` p 
		on p.id=i.`product_id`
		where i.`invoice_id` = id_in;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getInvoiceList` */

/*!50003 DROP PROCEDURE IF EXISTS  `getInvoiceList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getInvoiceList`()
BEGIN
		select p.id,p.invoiceId,p.date,bill_amount,cs.`company_name`,p.`isPaymentDone`,p.isLast
		from `invoice` p join `clients_address` cs 
		on p.bill_to_party = cs.id
		
		order by p.id desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getInvoiceListBetweenDates` */

/*!50003 DROP PROCEDURE IF EXISTS  `getInvoiceListBetweenDates` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getInvoiceListBetweenDates`(fromDate date,todate date)
BEGIN
SELECT id FROM invoice
WHERE `date` BETWEEN fromDate AND todate
ORDER BY id ASC;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getInvoicePaymentDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getInvoicePaymentDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getInvoicePaymentDetails`(id_in int)
BEGIN
SELECT ip.*,i.isPaymentDone FROM invoice_payment ip JOIN payment_invoice_details id
ON ip.id = id.invoice_payment_id JOIN invoice i
ON i.id = id.invoice_id
WHERE i.id = id_in;		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getLatestInvoiceNumber` */

/*!50003 DROP PROCEDURE IF EXISTS  `getLatestInvoiceNumber` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getLatestInvoiceNumber`()
BEGIN
		SELECT invoiceId+1
		FROM `invoice`
		WHERE id = (SELECT MAX(id) FROM invoice);
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getLedgerDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getLedgerDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getLedgerDetails`(date_from date,date_to date)
BEGIN
SELECT i.*,inv.id AS 'invoice_num',c.`company_name`
FROM `invoice_payment` i 
JOIN `payment_invoice_details` p
	ON i.id = p.invoice_payment_id 
JOIN `invoice` inv
	ON p.invoice_id= inv.id 
JOIN `clients_address` c
	ON inv.`bill_to_party` = c.`id`
WHERE payment_date BETWEEN date_from AND date_to
UNION
SELECT i.* ,pu.`invoice_num` AS 'invoice_num',c.`company_name`
FROM `invoice_payment` i 
JOIN `payment_purchase_details` ip
	ON i.id = ip.invoice_payment_id 
JOIN `purchase` pu
	ON ip.`purchase_id`= pu.id 
JOIN `clients_address` c
	ON pu.`client_id` = c.`id`
WHERE payment_date BETWEEN date_from AND date_to
ORDER BY payment_date ASC;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getMainProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getMainProducts` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getMainProducts`()
BEGIN
		SELECT mp.`id`,mp.`product_name`,mp.`hsn_code`,mp.`UOM`,mu.`uom`,mp.`product_type`,pt.`type_name`
		FROM `main_products` mp join `m_uom` mu
		on mp.UOM = mu.`id` join `product_type` pt
		on pt.id = mp.product_type;
		
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getMainProductsInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `getMainProductsInfo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getMainProductsInfo`(id_in int)
BEGIN
		SELECT mp.`id`,mp.`product_name`,mp.`hsn_code`,mp.`UOM`,mu.`uom`,mp.`product_type`,pt.`type_name`
		FROM `main_products` mp JOIN `m_uom` mu
		ON mp.UOM = mu.`id` JOIN `product_type` pt
		ON pt.id = mp.product_type
		where mp.id=id_in;
		
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getMyProfileDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getMyProfileDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getMyProfileDetails`()
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,
		c.`company_phone1`,c.`company_phone2`,c.`company_phone3`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,
		c.`company_bank_account_no`,c.`company_logo`,s.`state_name`,s.`state_tin`,c.`term_condition1`,c.`term_condition2`
,c.`term_condition3`		FROM `my_profile` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		WHERE c.id=1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPendingInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPendingInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPendingInvoice`(id_in int)
BEGIN
				select p.id,p.invoiceId,p.date,bill_amount,cs.`company_name`
		from `invoice` p join `clients_address` cs 
		on p.bill_to_party = cs.id
		where isPaymentDone=0
		and p.bill_to_party = id_in
		order by p.Date desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPendingPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPendingPurchase` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPendingPurchase`(id_in INT)
BEGIN
		select invoice_num,invoice_date,`totalAmountAfterTax`,cs.`company_name`,p.id
		from purchase p join `clients_address` cs 
		on p.client_id = cs.id
		where isPaymentDone=0
		and p.client_id = id_in
		order by invoice_Date desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getProductThreshold` */

/*!50003 DROP PROCEDURE IF EXISTS  `getProductThreshold` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getProductThreshold`(		)
BEGIN
		select `product_threashold`
		from `my_profile`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchase` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchase`(id_in INT)
BEGIN
		SELECT `id`,
		`invoice_num`,
		`invoice_date` as 'date',
		
		`client_id`,
		`totalamount`,
		`cgst_perc`,
		`cgst_amount`,
		`sgst_perc`,
		`sgst_amount`,
		`igst_perc`,
		`igst_amount`,
		`totalAmountAfterTax`,
		`round_off`,
		`bill_amount`,
		`bill_amount_in_words`,
		`total_amount_gst`,
		`gst_on_reverse_charge`
		FROM `purchase`
		WHERE `id` = id_in;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchaseDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchaseDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchaseDetails`(id_in INT)
BEGIN
		SELECT p.`product_name`,
		i.`qty`,
		i.`amount`,
		i.`total_amount`,
		i.`cgst_perc`,
		i.`cgst_amount`,
		i.`sgst_perc`,
		i.`sgst_amount`,
		i.`igst_perc`,
		i.`igst_amount`,
		i.`totalAmountAfterTax`,
		i.hsn,
		i.uom,
		i.`product_id`,
		i.id
		FROM `purchase_details` i JOIN `products` p 
		ON p.id=i.`product_id`
		WHERE i.`purchase_id` = id_in;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchaseList` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchaseList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchaseList`()
BEGIN
				SELECT p.id,p.`invoice_num`,p.`invoice_date` as 'date',bill_amount,cs.`company_name`,p.isPaymentDone,p.isLast
		FROM `purchase` p JOIN `clients_address` cs 
		ON p.`client_id` = cs.id
		
		ORDER BY p.`id` desc;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchaseListBetweenDates` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchaseListBetweenDates` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchaseListBetweenDates`(fromDate DATE,todate DATE)
BEGIN
SELECT id FROM Purchase
WHERE `invoice_date` BETWEEN fromDate AND todate
ORDER BY id ASC;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchaseMonthWise` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchaseMonthWise` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchaseMonthWise`(fromDate date, toDate date)
BEGIN
    
        SELECT CONCAT(SUBSTRING(MONTHNAME(p1.invoice_date),1,3),' ' ,YEAR(p1.invoice_date) ) as 'monthDate' ,
    SUM(p1.bill_amount) as 'total' , SUM(p2.bill_amount) as 'paid' , SUM(p3.bill_amount) as 'unpaid'
    FROM purchase p1 left join purchase p2
    on p1.id = p2.id and p2.isPaymentDone =  1
    left join purchase p3 on p1.id = p3.id  and p3.isPaymentDone = 0
    where p1.invoice_date between fromDate and toDate
	GROUP BY YEAR(p1.invoice_date), MONTH(p1.invoice_date);
    
       
    
    
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurchasePaymentDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurchasePaymentDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getPurchasePaymentDetails`(id_in int)
BEGIN
SELECT ip.*,i.isPaymentDone FROM invoice_payment ip JOIN payment_purchase_details id
ON ip.id = id.invoice_payment_id JOIN purchase i
ON i.id = id.purchase_id
WHERE i.id = id_in;		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getRAWProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getRAWProducts` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getRAWProducts`()
BEGIN
		SELECT p.`id`, CONCAT(mp.`product_name`,' : ', p.`product_name`) as 'product_name'
		FROM `products` p JOIN `main_products` mp
		ON mp.id = p.`product_main_id`
		where mp.`product_type` = 3;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getSalesMonthWise` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSalesMonthWise` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getSalesMonthWise`(fromDate date, toDate date)
BEGIN
        SELECT CONCAT(SUBSTRING(MONTHNAME(p1.date),1,3),' ' ,YEAR(p1.date) ) as 'monthDate' ,
    SUM(p1.bill_amount) as 'total' , SUM(p2.bill_amount) as 'paid' , SUM(p3.bill_amount) as 'unpaid'
    FROM invoice p1 left join invoice p2
    on p1.id = p2.id and p2.isPaymentDone =  1
    left join invoice p3 on p1.id = p3.id  and p3.isPaymentDone = 0
    where p1.date between fromDate and toDate
	GROUP BY YEAR(p1.date), MONTH(p1.date);
    
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getStateList` */

/*!50003 DROP PROCEDURE IF EXISTS  `getStateList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getStateList`()
BEGIN
		SELECT `id`,`state_name`,`state_tin`
		FROM `state`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getSubProducts` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSubProducts` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getSubProducts`(main_id_in int)
BEGIN
		SELECT id,`product_name`,`qty`
		from `products`
		where `product_main_id` = main_id_in;
		
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getUOMAndHSN` */

/*!50003 DROP PROCEDURE IF EXISTS  `getUOMAndHSN` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `getUOMAndHSN`( id_in INT)
BEGIN
		select m.`hsn_code`,mu.`uom`,m.`product_type`,p.qty
		from `main_products` m join `m_uom` mu
		on m.`UOM` = mu.id join `products` p
			on m.id=p.`product_main_id`
		where p.id=id_in;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertInvoice`(
	invoice_date_in DATE,
	reverse_charge_in varchar(10),
	state_in varchar(100),
	code_in int,
	transport_mode_in varchar(250),
	vehicle_no_in varchar(100),
	date_of_supply_in date,
	place_of_supply_in varchar(100),
	bill_to_party_in int,
	ship_to_party_in int,
	total_amount_before_tax_in double,
	cgst_perc_in double,
	cgst_amount_in double,
	sgst_perc_in DOUBLE,
	sgst_amount_in DOUBLE,
	igst_perc_in DOUBLE,
	igst_amount_in DOUBLE,
	total_amount_after_tax_in double,
	rounnd_off_in double,
	bill_amount_in int, 
	bill_amount_in_words_in varchar(800),
	total_amount_gst_in double,
	gst_on_reverse_charge_in double,
	invoiceId_in int)
BEGIN

update invoice
set isLast=0;

		INSERT INTO `invoice`(
			`date`,
			`reverse_charge`,
			`state`,
			`code`,
			`transport_mode`,
			`vehicle_no`,
			`date_of_supply`,
			`place_of_supply`,
			`bill_to_party`,
			`ship_to_party`,
			`total_amount_before_tax`,
			`cgst_perc`,
			`cgst_amount`,
			`sgst_perc`,
			`sgst_amount`,
			`igst_perc`,
			`igst_amount`,
			`total_amount_after_tax`,
			`round_off`,
			`bill_amount`,
			`bill_amount_in_words`,
			`total_amount_gst`,
			`gst_on_reverse_charge`,
			`invoiceId`)
		VALUES (invoice_date_in ,reverse_charge_in ,state_in , code_in ,
transport_mode_in ,vehicle_no_in ,date_of_supply_in ,place_of_supply_in,bill_to_party_in ,ship_to_party_in ,total_amount_before_tax_in ,
cgst_perc_in ,cgst_amount_in ,sgst_perc_in ,sgst_amount_in ,igst_perc_in ,igst_amount_in ,total_amount_after_tax_in ,
rounnd_off_in ,bill_amount_in , bill_amount_in_words_in,total_amount_gst_in,gst_on_reverse_charge_in,invoiceId_in );
		
		SELECT LAST_INSERT_ID() ;
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertInvoiceDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertInvoiceDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertInvoiceDetails`(product_id_in INT,qty DOUBLE,amount_in DOUBLE,total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,cgst_amt_in DOUBLE,sgst_perc_in DOUBLE,sgst_amt_in DOUBLE,igst_perc_in DOUBLE,igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,invoice_id_in INT,hsn_in varchar(100),uom_in varchar(50))
BEGIN
		INSERT INTO `invoice_details`(`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,
		`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`invoice_id`,`hsn`,`uom`)
		VALUES(product_id_in ,qty ,amount_in,total_amount_in ,
		cgst_perc_in  ,cgst_amt_in ,sgst_perc_in ,sgst_amt_in ,igst_perc_in ,igst_amt_in ,
		total_amount_after_tax_in ,invoice_id_in,hsn_in,uom_in );
		
		SELECT LAST_INSERT_ID();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertInvoicePayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertInvoicePayment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertInvoicePayment`(
		pay_date_in DATE, 
		pay_mode_in VARCHAR(10),
		chq_no_in VARCHAR(200),
		chq_date_in DATE,
		bank_name_in VARCHAR(500),
		pay_amount_in DOUBLE,
		utr_no_in varchar(150),
		ifsc_code_in varchar(150),
		invoice_type_in int)
BEGIN
		insert into`invoice_payment` (`payment_date`,`payment_mode`,`cheque_no`,`cheque_date`,`bank_name`,`payment_amount`,`utr_no`,`ifsc_code`,`invoice_type`)
		values(pay_date_in,pay_mode_in,chq_no_in,chq_date_in,bank_name_in,pay_amount_in,utr_no_in,ifsc_code_in,invoice_type_in );
		
		SELECT LAST_INSERT_ID() ;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertInvoicePaymentDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertInvoicePaymentDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertInvoicePaymentDetails`(invoice_payment_id_in int,invoice_id_in int)
BEGIN
	declare i int;
		insert into`payment_invoice_details` (`invoice_payment_id`,`invoice_id`)
		values(invoice_payment_id_in,invoice_id_in);
		
		SELECT LAST_INSERT_ID() into i ;
		
		IF i <> 0 THEN
			update `invoice`
			set `isPaymentDone` = 1
			where `id` = invoice_id_in;
			
		end if;
		
				
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertMainProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertMainProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertMainProduct`(productName varchar(500),product_hsn VARCHAR(500),product_uom int, product_type int)
BEGIN
		insert into `main_products`(`product_name`,`hsn_code`,`UOM`,`product_type`)
		values(productName,product_hsn,product_uom,product_type);
		
		select LAST_INSERT_ID();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertPurchase` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertPurchase`(invoice_date_in date,invoice_num_in varchar(50),
		total_amount_in double,cgst_perc_in double ,cgst_amt_in double,sgst_perc_in DOUBLE,sgst_amt_in double,igst_perc_in double,igst_amt_in DOUBLE,
		total_amount_after_tax_in double,client_id_in int,rounnd_off_in double,
	bill_amount_in int, 
	bill_amount_in_words_in varchar(800),
	total_amount_gst_in double,
	gst_on_reverse_charge_in double)
BEGIN

update purchase
set isLast=0;

		INSERT INTO `purchase`(`invoice_date`,`invoice_num`,`totalamount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`client_id`,
			`round_off`,
			`bill_amount`,
			`bill_amount_in_words`,
			`total_amount_gst`,
			`gst_on_reverse_charge`)
		VALUES(invoice_date_in,invoice_num_in,total_amount_in,cgst_perc_in ,cgst_amt_in ,sgst_perc_in ,sgst_amt_in ,igst_perc_in ,igst_amt_in ,total_amount_after_tax_in,client_id_in,
rounnd_off_in ,bill_amount_in , bill_amount_in_words_in,total_amount_gst_in,gst_on_reverse_charge_in );
		
		select LAST_INsert_id();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertPurchaseDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertPurchaseDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertPurchaseDetails`(product_id_in int,qty double,amount_in double,total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,cgst_amt_in DOUBLE,sgst_perc_in DOUBLE,sgst_amt_in DOUBLE,igst_perc_in DOUBLE,igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,purchase_id_in INT,hsn_in VARCHAR(100),uom_in VARCHAR(50))
BEGIN
		INSERT INTO `purchase_details`(`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,
		`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`purchase_id`,`hsn`,`uom`)
		VALUES(product_id_in ,qty ,amount_in,total_amount_in ,
		cgst_perc_in  ,cgst_amt_in ,sgst_perc_in ,sgst_amt_in ,igst_perc_in ,igst_amt_in ,
		total_amount_after_tax_in ,purchase_id_in,hsn_in,uom_in);
		
		SELECT LAST_INSERT_ID();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertPurchasePaymentDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertPurchasePaymentDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertPurchasePaymentDetails`(invoice_payment_id_in INT,purchase_id_in INT)
BEGIN
	DECLARE i INT;
		INSERT INTO `payment_purchase_details` (`invoice_payment_id`,`purchase_id`)
		VALUES(invoice_payment_id_in,purchase_id_in);
		
		SELECT LAST_INSERT_ID() INTO i ;
		
		IF i <> 0 THEN
			UPDATE `purchase`
			SET `isPaymentDone` = 1
			WHERE `id` = purchase_id_in;
			
		END IF;
		
				
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertSubProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertSubProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `insertSubProduct`(subProductName varchar(500),subProductCode varchar(500),mainProductId int)
BEGIN
		insert into `products`(`product_name`,`product_shotform`,`product_main_id`)
		values(subProductName,subProductCode,mainProductId);
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateCompanyDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateCompanyDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateCompanyDetails`(id_in int,comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin varchar(200),comp_email VARCHAR(150),
comp_phone1 VARCHAR(20),comp_phone2 VARCHAR(20),comp_phone3 VARCHAR(20),comp_state int,compBankName VARCHAR(500),cmpIfsc VARCHAR(300),cmpAccNo VARCHAR(300))
BEGIN
		update `clients_address`
		set `company_name`= comp_name,
		`company_address`=comp_add,
		`company_gstin`=comp_gstin,
		`company_email`=comp_email,
		`company_phone1`=comp_phone1,
		`company_phone2`=comp_phone2,
		`company_phone3`=comp_phone3,
		`company_state`=comp_state,
		`company_bank_name`=compBankName,
		`company_bank_ifsc`=cmpIfsc,
		`company_bank_account_no`=cmpAccNo
		where id=id_in;
		
		select ROW_COUNT() ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateInvoice`(
	invoice_date_in DATE,
	reverse_charge_in varchar(10),
	state_in varchar(100),
	code_in int,
	transport_mode_in varchar(250),
	vehicle_no_in varchar(100),
	date_of_supply_in date,
	place_of_supply_in varchar(100),
	bill_to_party_in int,
	ship_to_party_in int,
	total_amount_before_tax_in double,
	cgst_perc_in double,
	cgst_amount_in double,
	sgst_perc_in DOUBLE,
	sgst_amount_in DOUBLE,
	igst_perc_in DOUBLE,
	igst_amount_in DOUBLE,
	total_amount_after_tax_in double,
	rounnd_off_in double,
	bill_amount_in int, 
	bill_amount_in_words_in varchar(800),
	total_amount_gst_in double,
	gst_on_reverse_charge_in double,
	invoice_id_in int,
	`invoiceNum_in` int)
BEGIN
		update`invoice`
		set 
			`date`=invoice_date_in ,
			`reverse_charge`=reverse_charge_in ,
			`state`=state_in , 
			`code`=code_in ,
			`transport_mode`=transport_mode_in ,
			`vehicle_no`=vehicle_no_in ,
			`date_of_supply`=date_of_supply_in ,
			`place_of_supply`=place_of_supply_in,
			`bill_to_party`=bill_to_party_in ,
			`ship_to_party`=ship_to_party_in ,
			`total_amount_before_tax`=total_amount_before_tax_in ,
			`cgst_perc`=cgst_perc_in ,
			`cgst_amount`=cgst_amount_in ,
			`sgst_perc`=sgst_perc_in ,
			`sgst_amount`=sgst_amount_in ,
			`igst_perc`=igst_perc_in ,
			`igst_amount`=igst_amount_in ,
			`total_amount_after_tax`=total_amount_after_tax_in ,
			`round_off`=rounnd_off_in ,
			`bill_amount`=bill_amount_in ,
			`bill_amount_in_words`= bill_amount_in_words_in,
			`total_amount_gst`=total_amount_gst_in,
			`gst_on_reverse_charge`=gst_on_reverse_charge_in,
			`invoiceId` = invoiceNum_in
		where id=invoice_id_in;
	
		SELECT ROW_COUNT();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateInvoiceDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateInvoiceDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateInvoiceDetails`(product_id_in INT,
qty DOUBLE,
amount_in DOUBLE,
total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,
		cgst_amt_in DOUBLE,
		sgst_perc_in DOUBLE,
		sgst_amt_in DOUBLE,
		igst_perc_in DOUBLE,
		igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,
		invoice_id_in INT,
hsn_in VARCHAR(100),
uom_in VARCHAR(50),
invoice_detail_id int)
BEGIN
		update `invoice_details`
		set `product_id`=product_id_in ,
`qty`=qty ,
`amount`=amount_in,
`total_amount`=total_amount_in ,
`cgst_perc`=cgst_perc_in  ,
		`cgst_amount`=cgst_amt_in ,
		`sgst_perc`=sgst_perc_in ,
		`sgst_amount`=sgst_amt_in ,
		`igst_perc`=igst_perc_in ,
		`igst_amount`=igst_amt_in ,
		`totalAmountAfterTax`=total_amount_after_tax_in ,
		`invoice_id`=invoice_id_in,
		`hsn`=hsn_in,
		`uom`=uom_in
		WHERE id=invoice_detail_id;
		
		SELECT ROW_COUNT();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateMainProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateMainProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateMainProduct`(productName varchar(500),product_hsn VARCHAR(500),product_uom int, product_type int,product_id int)
BEGIN
		update `main_products`
		set `product_name`=productName,
		`hsn_code`=product_hsn,
		`UOM`=product_uom,
		`product_type`=product_type
		where `id` = product_id;
		
		select ROW_COUNT();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateMyProfileDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateMyProfileDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateMyProfileDetails`(id_in INT,comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin VARCHAR(200),comp_email VARCHAR(150),
comp_phone1 VARCHAR(20),comp_phone2 VARCHAR(20),comp_phone3 VARCHAR(20),comp_state INT,comp_bank_name varchar(500),
comp_bank_ifsc VARCHAR(300),comp_bank_acc_no VARCHAR(300),comp_logo varchar(1000),termsAndCondition1_in varchar(1000),termsAndCondition2_in VARCHAR(1000),termsAndCondition3_in VARCHAR(1000))
BEGIN
		UPDATE `my_profile`
		SET `company_name`= comp_name,
		`company_address`=comp_add,
		`company_gstin`=comp_gstin,
		`company_email`=comp_email,
		`company_phone1`=comp_phone1,
		`company_phone2`=comp_phone2,
		`company_phone3`=comp_phone3,
		`company_state`=comp_state,
		`company_bank_name`=comp_bank_name,
		`company_bank_ifsc`=comp_bank_ifsc,
		`company_bank_account_no`=comp_bank_acc_no,
		`company_logo`=comp_logo,
		`term_condition1`=termsAndCondition1_in,
		`term_condition2`=termsAndCondition2_in,
		`term_condition3`=termsAndCondition3_in
		
		WHERE id=1;
		
		SELECT ROW_COUNT() ;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updatePaymentInvoice` */

/*!50003 DROP PROCEDURE IF EXISTS  `updatePaymentInvoice` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updatePaymentInvoice`(id_in INT,date_in DATE,pay_date_in DATE, pay_mode_in VARCHAR(10),
		chq_no_in VARCHAR(200),bank_name_in VARCHAR(500),pay_amount_in DOUBLE)
BEGIN
		UPDATE `invoice`
		SET `isPaymentDone`=1,
		`payment_mode`=pay_mode_in,
		`cheque_no`=chq_no_in,
		`bank_name`=bank_name_in,
		`cheque_date`=pay_date_in,
		`payment_amount`=pay_amount_in
		WHERE `id`=id_in AND `date` = date_in;
		
		SELECT ROW_COUNT() ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updatePaymentPurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `updatePaymentPurchase` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updatePaymentPurchase`(invoice_num_in int,invoice_date_in date,pay_date_in date, pay_mode_in varchar(10),
		chq_no_in varchar(200),bank_name_in varchar(500),pay_amount_in double)
BEGIN
		update `purchase`
		set `isPaymentDone`=1,
		`payment_mode`=pay_mode_in,
		`cheque_no`=chq_no_in,
		`bank_name`=bank_name_in,
		`cheque_date`=pay_date_in,
		`payment_amount`=pay_amount_in
		where `invoice_num`=invoice_num_in and `invoice_date` = invoice_date_in;
		
		select ROW_COUNT() ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateProductThreshold` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateProductThreshold` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateProductThreshold`( val int)
BEGIN
		
		update `my_profile`
		set `product_threashold` =val
		where id=1;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updatePurchase` */

/*!50003 DROP PROCEDURE IF EXISTS  `updatePurchase` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updatePurchase`(
		invoice_date_in DATE,
		invoice_num_in VARCHAR(50),
		total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,
		cgst_amt_in DOUBLE,
		sgst_perc_in DOUBLE,
		sgst_amt_in DOUBLE,
		igst_perc_in DOUBLE,
		igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,
		client_id_in INT,
		rounnd_off_in DOUBLE,
		bill_amount_in INT, 
		bill_amount_in_words_in VARCHAR(800),
		total_amount_gst_in DOUBLE,
		gst_on_reverse_charge_in DOUBLE,
		id_in int)
BEGIN
		update `purchase`
		set 
			`invoice_date`=invoice_date_in,
			`invoice_num`=invoice_num_in,
			`totalamount`=total_amount_in,
			`cgst_perc`=cgst_perc_in ,
			`cgst_amount`=cgst_amt_in ,
			`sgst_perc`=sgst_perc_in ,
			`sgst_amount`=sgst_amt_in ,
			`igst_perc`=igst_perc_in ,
			`igst_amount`=igst_amt_in ,
			`totalAmountAfterTax`=total_amount_after_tax_in,
			`client_id`=client_id_in,
			`round_off`=rounnd_off_in ,
			`bill_amount`=bill_amount_in , 
			`bill_amount_in_words`=bill_amount_in_words_in,
			`total_amount_gst`=total_amount_gst_in,
			`gst_on_reverse_charge`=gst_on_reverse_charge_in
		where id = id_in;
			SELECT ROW_COUNT();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updatePurchaseDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `updatePurchaseDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updatePurchaseDetails`(
		product_id_in INT,
		qty DOUBLE,
		amount_in DOUBLE,
		total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,
		cgst_amt_in DOUBLE,
		sgst_perc_in DOUBLE,
		sgst_amt_in DOUBLE,
		igst_perc_in DOUBLE,
		igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,
		purchase_id_in INT,
		hsn_in VARCHAR(100),
		uom_in VARCHAR(50),
		id_in int)
BEGIN
		UPDATE `purchase_details`
		SET
		`product_id`=product_id_in ,
		`qty`=qty ,
		`amount`=amount_in,
		`total_amount`=total_amount_in ,
		`cgst_perc`=cgst_perc_in  ,
		`cgst_amount`=cgst_amt_in ,
		`sgst_perc`=sgst_perc_in ,
		`sgst_amount`=sgst_amt_in ,
		`igst_perc`=igst_perc_in ,
		`igst_amount`=igst_amt_in ,
		`totalAmountAfterTax`=total_amount_after_tax_in ,
		`purchase_id`=purchase_id_in,
		`hsn`=hsn_in,
		`uom`=uom_in
		where id= id_in;
		
		SELECT ROW_COUNT();
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateSubProduct` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateSubProduct` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `updateSubProduct`(subproductId int , subProductName varchar(500),subProductQTY varchar(500),mainProductId int)
BEGIN
		
		
		
if subproductId = 0 then
		insert into `products`(`product_name`,`qty`,`product_main_id`)
		values(subProductName,subProductQTY,mainProductId);
else		
		
UPDATE `products`
		SET `product_name`=subProductName,
		`qty`=subProductQTY
		WHERE `id`=subproductId;
		
		end if;
		
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
