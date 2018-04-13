-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: pritienterprises.cdgcwodm9mrp.ap-south-1.rds.amazonaws.com    Database: pritienterprises
-- ------------------------------------------------------
-- Server version	5.6.37-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients_address`
--

DROP TABLE IF EXISTS `clients_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients_address`
--

LOCK TABLES `clients_address` WRITE;
/*!40000 ALTER TABLE `clients_address` DISABLE KEYS */;
INSERT INTO `clients_address` VALUES (1,'Sunrise','101, Maa Krupa Apartment, Near Jain Derasar,Katargam, Surat - 395004','24CRPPS6364F1ZA','2018-04-13 06:58:23','','+918000505027','','',13,'','',''),(2,'Surbhi Restaurant & Bar','Sayli Road, Near Gurudev complex, Silvassa - 396230','26ACBPD3018Q2ZN','2018-04-13 07:03:50','','+919737878150','','',9,'','',''),(3,'Hotel Suraj','Naroli Road, Behind DCB Bank, Silvaasa - 396230','26AACFH9125P1ZY','2018-04-13 07:19:06','','+919723156108','','',9,'','',''),(4,'Raj Traders','Opposite To Bus Stop, Chikli','24AARFR9040C1Z6','2018-04-13 07:24:08','','+919737919999','','',13,'','','');
/*!40000 ALTER TABLE `clients_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companyproductsprice`
--

DROP TABLE IF EXISTS `companyproductsprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companyproductsprice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compIdFk_idx` (`companyId`),
  KEY `producIdFk_idx` (`productId`),
  CONSTRAINT `compIdFk` FOREIGN KEY (`companyId`) REFERENCES `clients_address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `producIdFk` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companyproductsprice`
--

LOCK TABLES `companyproductsprice` WRITE;
/*!40000 ALTER TABLE `companyproductsprice` DISABLE KEYS */;
INSERT INTO `companyproductsprice` VALUES (1,1,1,9),(2,1,2,8),(3,1,3,12),(4,1,15,11),(5,1,4,0),(6,1,5,8),(7,1,6,18),(8,1,7,0),(9,1,8,24),(10,1,9,0),(11,1,10,0),(12,1,11,0),(13,1,12,0),(14,1,13,0),(15,1,14,0),(16,2,1,0),(17,2,2,0),(18,2,3,0),(19,2,15,0),(20,2,4,15),(21,2,5,0),(22,2,6,0),(23,2,7,0),(24,2,8,0),(25,2,9,0),(26,2,10,0),(27,2,11,0),(28,2,12,0),(29,2,13,0),(30,2,14,0),(31,3,1,0),(32,3,2,0),(33,3,3,0),(34,3,15,0),(35,3,4,0),(36,3,5,12),(37,3,6,0),(38,3,7,0),(39,3,8,0),(40,3,9,0),(41,3,10,0),(42,3,11,0),(43,3,12,0),(44,3,13,0),(45,3,14,0),(46,4,1,0),(47,4,2,0),(48,4,3,0),(49,4,15,0),(50,4,16,12),(51,4,4,12),(52,4,5,0),(53,4,6,0),(54,4,7,0),(55,4,8,0),(56,4,9,0),(57,4,10,0),(58,4,11,0),(59,4,12,0),(60,4,13,0),(61,4,14,0);
/*!40000 ALTER TABLE `companyproductsprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceId` int(11) NOT NULL,
  `invoice_num` varchar(45) DEFAULT NULL,
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_details`
--

DROP TABLE IF EXISTS `invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `product_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_details`
--

LOCK TABLES `invoice_details` WRITE;
/*!40000 ALTER TABLE `invoice_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_payment`
--

DROP TABLE IF EXISTS `invoice_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_payment`
--

LOCK TABLES `invoice_payment` WRITE;
/*!40000 ALTER TABLE `invoice_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_type`
--

DROP TABLE IF EXISTS `invoice_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_type`
--

LOCK TABLES `invoice_type` WRITE;
/*!40000 ALTER TABLE `invoice_type` DISABLE KEYS */;
INSERT INTO `invoice_type` VALUES (1,'Invoice'),(2,'Purchase');
/*!40000 ALTER TABLE `invoice_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_uom`
--

DROP TABLE IF EXISTS `m_uom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_uom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uom` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_uom`
--

LOCK TABLES `m_uom` WRITE;
/*!40000 ALTER TABLE `m_uom` DISABLE KEYS */;
INSERT INTO `m_uom` VALUES (1,'Nos.'),(2,'KG'),(3,'Liters');
/*!40000 ALTER TABLE `m_uom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_products`
--

DROP TABLE IF EXISTS `main_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_products`
--

LOCK TABLES `main_products` WRITE;
/*!40000 ALTER TABLE `main_products` DISABLE KEYS */;
INSERT INTO `main_products` VALUES (1,'Serviettes','2018-04-12 08:27:44','4818',1,1),(2,'Paper Napkin','2018-04-12 08:42:19','4818',1,1),(3,'Toilet Roll','2018-04-12 08:47:11','4818',1,1),(4,'Kitchen Roll','2018-04-12 08:48:14','4818',1,1),(5,'N Fold','2018-04-12 08:49:46','4818',1,1),(6,'Table Top','2018-04-12 08:51:03','4818',1,1),(7,'Facial Tissue','2018-04-12 08:55:33','4818',1,1);
/*!40000 ALTER TABLE `main_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_profile`
--

DROP TABLE IF EXISTS `my_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_profile`
--

LOCK TABLES `my_profile` WRITE;
/*!40000 ALTER TABLE `my_profile` DISABLE KEYS */;
INSERT INTO `my_profile` VALUES (1,'Priti Enterprises','Plot no. 23, Survey No. 126/P, Dhanashree Industrial Gala, 66 KVA, Amli, Silvassa - 396230','26AKKPM5283H1ZT','priti.enterprises@yahoo.in','+919601535678','+919624034500','',9,'State Bank Of India','SBIN0006586','33862336004',NULL,0,'Any dispute regarding QTY / Quality / Rate must be reported before month end.','Payment within  15 Days.','Subject to silvassa juridication.');
/*!40000 ALTER TABLE `my_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_invoice_details`
--

DROP TABLE IF EXISTS `payment_invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_invoice_details`
--

LOCK TABLES `payment_invoice_details` WRITE;
/*!40000 ALTER TABLE `payment_invoice_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_invoice_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_purchase_details`
--

DROP TABLE IF EXISTS `payment_purchase_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_purchase_details`
--

LOCK TABLES `payment_purchase_details` WRITE;
/*!40000 ALTER TABLE `payment_purchase_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_purchase_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_type` (
  `id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_type`
--

LOCK TABLES `payment_type` WRITE;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` VALUES (0,'Not Paid'),(1,'Paid'),(2,'Partially Paid');
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
INSERT INTO `product_type` VALUES (1,'Main Product'),(2,'Packing Material'),(3,'Raw Material');
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(300) NOT NULL,
  `product_shotform` varchar(200) DEFAULT NULL,
  `product_main_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` int(11) DEFAULT '0',
  `price` double DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_main_id` (`product_main_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_main_id`) REFERENCES `main_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'11x12 Paper Napkin','11x12 Paper Napkin',1,0,'2018-04-12 08:27:44',0,0),(2,'9X10 Paper Napkin',NULL,1,0,'2018-04-12 08:38:08',0,0),(3,'12x12 Paper Napkin',NULL,1,0,'2018-04-12 08:40:53',0,0),(4,'11x12 Paper Napkin','11x12 Paper Napkin',2,0,'2018-04-12 08:42:19',0,0),(5,'9X9 Paper Napkin',NULL,2,0,'2018-04-12 08:45:57',0,0),(6,'Toilet Roll 400 pulls','Toilet Roll 400 pulls',3,0,'2018-04-12 08:47:11',0,0),(7,'Toilet Roll 300 pulls',NULL,3,0,'2018-04-12 08:47:28',0,0),(8,'Kitchen Roll 1x1','Kitchen Roll 1x1',4,0,'2018-04-12 08:48:14',0,0),(9,'Kitchen Roll 2x1',NULL,4,0,'2018-04-12 08:48:44',0,0),(10,'Kitchen Roll 4x1',NULL,4,0,'2018-04-12 08:48:44',0,0),(11,'N Fold 115 pulls','N fold 115 pulls',5,0,'2018-04-12 08:49:46',0,0),(12,'N Fold 125 pulls',NULL,5,0,'2018-04-12 08:50:16',0,0),(13,'Table Top 115 pulls','Table Top 115 pulls',6,0,'2018-04-12 08:51:03',0,0),(14,'Facial Tissue ','Facial Tissue ',7,0,'2018-04-12 08:55:33',0,0),(15,'11x12 Paper Napkin cleanup',NULL,1,0,'2018-04-13 06:55:07',0,0),(16,'12x12 Soft Paper Napkin RT',NULL,1,0,'2018-04-13 07:22:13',0,0),(17,'12x12 Hard Paper Napkin RT',NULL,2,0,'2018-04-13 07:24:29',0,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_details`
--

DROP TABLE IF EXISTS `purchase_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_details`
--

LOCK TABLES `purchase_details` WRITE;
/*!40000 ALTER TABLE `purchase_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) DEFAULT NULL,
  `state_name` varchar(200) DEFAULT NULL,
  `state_tin` int(11) DEFAULT NULL,
  `state_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'AndamanandNicobarIslands',35,'AN\r'),(2,'AndhraPradesh',28,'AP\r'),(3,'AndhraPradesh(New)',37,'AD\r'),(4,'ArunachalPradesh',12,'AR\r'),(5,'Assam',18,'AS\r'),(6,'Bihar',10,'BH\r'),(7,'Chandigarh',4,'CH\r'),(8,'Chattisgarh',22,'CT\r'),(9,'DadraandNagarHaveli',26,'DN\r'),(10,'DamanandDiu',25,'DD\r'),(11,'Delhi',7,'DL\r'),(12,'Goa',30,'GA\r'),(13,'Gujarat',24,'GJ\r'),(14,'Haryana',6,'HR\r'),(15,'HimachalPradesh',2,'HP\r'),(16,'JammuandKashmir',1,'JK\r'),(17,'Jharkhand',20,'JH\r'),(18,'Karnataka',29,'KA\r'),(19,'Kerala',32,'KL\r'),(20,'LakshadweepIslands',31,'LD\r'),(21,'MadhyaPradesh',23,'MP\r'),(22,'Maharashtra',27,'MH\r'),(23,'Manipur',14,'MN\r'),(24,'Meghalaya',17,'ME\r'),(25,'Mizoram',15,'MI\r'),(26,'Nagaland',13,'NL\r'),(27,'Odisha',21,'OR\r'),(28,'Pondicherry',34,'PY\r'),(29,'Punjab',3,'PB\r'),(30,'Rajasthan',8,'RJ\r'),(31,'Sikkim',11,'SK\r'),(32,'TamilNadu',33,'TN\r'),(33,'Telangana',36,'TS\r'),(34,'Tripura',16,'TR\r'),(35,'UttarPradesh',9,'UP\r'),(36,'Uttarakhand',5,'UT\r'),(37,'WestBengal',19,'WB\r');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nae` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'a'),(2,'b');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `inserted_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'PritiEnterprises','root','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pritienterprises'
--

--
-- Dumping routines for database 'pritienterprises'
--
/*!50003 DROP PROCEDURE IF EXISTS `addCompanyAddress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `addCompanyAddress`(comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin varchar(200),comp_email varchar(150),
comp_phone1 varchar(20),comp_phone2 VARCHAR(20),comp_phone3 VARCHAR(20),comp_state int,compBankName varchar(500),cmpIfsc varchar(300),cmpAccNo varchar(300))
BEGIN
		insert into clients_address(company_name,company_address,company_gstin,`company_email`,`company_phone1`,`company_phone2`,`company_phone3`,`company_state`,`company_bank_name`,`company_bank_ifsc`,`company_bank_account_no`) 
		values(comp_name,comp_add,comp_gstin,comp_email,comp_phone1,comp_phone2,comp_phone3,comp_state,compBankName,cmpIfsc,cmpAccNo);
		
		select LAST_INSERT_ID();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addCompnyProductPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `addCompnyProductPrice`(companyIdin int,productIdin int,pricein double)
BEGIN
	insert into companyproductsprice(companyId,productId,price)
    values(companyIdin,productIdin,pricein);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `addProduct`(product_id_in int,qty_in int)
BEGIN
		
DECLARE totalQty INT;
		
		SELECT (qty+qty_in) into totalQty FROM `products` WHERE `id`=product_id_in;
		
		
update `products`
set qty= totalQty
WHERE `id`=product_id_in;		
		
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `checkLogin`(username_in varchar(500), password_in varchar(200))
BEGIN
		select count(id) from users
		where `user_name`=username_in and `password`=password_in;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `deleteInvoice`(id_in int)
BEGIN
    declare maxId int;
    select max(id) into maxId from invoice;
    
    DELETE FROM `invoice` where id= id_in;
    
    
    SET @query = CONCAT(' ALTER TABLE `invoice` AUTO_INCREMENT =',maxId);
    PREPARE stmt FROM @query; 
    EXECUTE stmt; 
    
    
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteInvoiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `deleteInvoiceDetails`(id_in int)
BEGIN
	delete from invoice_details
	where id=id_in;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `deleteProduct`(product_id_in INT,qty_in INT)
BEGIN
		
DECLARE totalQty INT;
		
		SELECT (qty-qty_in) INTO totalQty FROM `products` WHERE `id`=product_id_in;
		
		
UPDATE `products`
SET qty= totalQty
WHERE `id`=product_id_in;	
	
SELECT ROW_COUNT();
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePurchaseDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `deletePurchaseDetails`(id_in INT)
BEGIN
	DELETE FROM purchase_details
	WHERE id=id_in;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePurchasee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `deletePurchasee`(id_in INT)
BEGIN
    DECLARE maxId INT;
    SELECT MAX(id) INTO maxId FROM purchase;
    
    DELETE FROM `purchase` WHERE id= id_in;
    
    SET @QUERY = CONCAT(' ALTER TABLE `purchase` AUTO_INCREMENT =',maxId);
    PREPARE stmt FROM @QUERY; 
    EXECUTE stmt; 
       
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getAllProducts`()
BEGIN
		SELECT p.`id`, CONCAT(mp.`product_name`,' : ', p.`product_name`) as 'product_name',p.`product_shotform`,p.`product_main_id`
		FROM `products` p JOIN `main_products` mp
		ON mp.id = p.`product_main_id` and p.isDeleted = 0;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllProductType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getAllProductType`()
BEGIN
		SELECT `id`,`type_name`
		FROM `product_type`;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllSubProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getAllSubProducts`()
BEGIN
		SELECT `id`,`product_name`,`product_shotform`,`product_main_id`
		FROM `sub_products`;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllUOM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getAllUOM`()
BEGIN
		SELECT `id`,`uom`
		FROM `m_uom`;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCompanyDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getCompanyDetails`(id_in int)
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,c.`company_phone1`,
		c.`company_phone2`,c.`company_phone3`,s.`state_name`,s.`state_tin`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,c.`company_bank_account_no`
		FROM `clients_address` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		where c.id=id_in;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCompanyList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getCompanyList`()
BEGIN
		select c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,c.`company_phone1`,
		c.`company_phone2`,c.`company_phone3`,s.`state_name`,s.`state_code`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,c.`company_bank_account_no`
		FROM `clients_address` c JOIN `state`  s
		ON c.`company_state` =s.`id`;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCompanyProductsPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getCompanyProductsPrice`(main_id_in int,companyIdin int)
BEGIN

		SELECT p.id,p.`product_name`,c.`price`,p.isDeleted
		from `main_products` mp join products p
        on p.product_main_id = mp.id join companyproductsprice c
        on p.id = c.productId
       
		where p.`product_main_id` = main_id_in and c.companyId = companyIdin;
		
		
		
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getInvoice`(id_in int)
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
		`gst_on_reverse_charge`,
        invoice_num
		from `invoice`
		where `id` = id_in;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInvoiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getInvoiceDetails`(id_in int)
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
		i.id,
        i.product_type
		from `invoice_details` i join `products` p 
		on p.id=i.`product_id`
		where i.`invoice_id` = id_in;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInvoiceList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getInvoiceList`()
BEGIN
		select p.id,p.invoice_num,p.date,bill_amount,cs.`company_name`,p.`isPaymentDone`,p.isLast
		from `invoice` p join `clients_address` cs 
		on p.bill_to_party = cs.id
		
		order by p.id desc;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInvoiceListBetweenDates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getInvoiceListBetweenDates`(fromDate date,todate date)
BEGIN
SELECT id FROM invoice
WHERE `date` BETWEEN fromDate AND todate
ORDER BY id ASC;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInvoicePaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getInvoicePaymentDetails`(id_in int)
BEGIN
SELECT ip.*,i.isPaymentDone FROM invoice_payment ip JOIN payment_invoice_details id
ON ip.id = id.invoice_payment_id JOIN invoice i
ON i.id = id.invoice_id
WHERE i.id = id_in;		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLatestInvoiceNumber` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getLatestInvoiceNumber`()
BEGIN
		SELECT invoiceId+1
		FROM `invoice`
		WHERE id = (SELECT MAX(id) FROM invoice);
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLedgerDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getLedgerDetails`(date_from date,date_to date)
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
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMainProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getMainProducts`()
BEGIN
		SELECT mp.`id`,mp.`product_name`,mp.`hsn_code`,mp.`UOM`,mu.`uom`,mp.`product_type`,pt.`type_name`
		FROM `main_products` mp join `m_uom` mu
		on mp.UOM = mu.`id` join `product_type` pt
		on pt.id = mp.product_type;
		
		
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMainProductsInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getMainProductsInfo`(id_in int)
BEGIN
		SELECT mp.`id`,mp.`product_name`,mp.`hsn_code`,mp.`UOM`,mu.`uom`,mp.`product_type`,pt.`type_name`
		FROM `main_products` mp JOIN `m_uom` mu
		ON mp.UOM = mu.`id` JOIN `product_type` pt
		ON pt.id = mp.product_type
		where mp.id=id_in;
		
		
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMyProfileDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getMyProfileDetails`()
BEGIN
		SELECT c.`id`,c.`company_name`,c.`company_address`,c.`company_gstin`,c.`company_email`,
		c.`company_phone1`,c.`company_phone2`,c.`company_phone3`,c.`company_state`,c.`company_bank_name`,c.`company_bank_ifsc`,
		c.`company_bank_account_no`,c.`company_logo`,s.`state_name`,s.`state_tin`,c.`term_condition1`,c.`term_condition2`
,c.`term_condition3`		FROM `my_profile` c JOIN `state`  s
		ON c.`company_state` =s.`id`
		WHERE c.id=1;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPendingInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPendingInvoice`(id_in int)
BEGIN
				select p.id,p.invoiceId,p.date,bill_amount,cs.`company_name`,p.invoice_num
		from `invoice` p join `clients_address` cs 
		on p.bill_to_party = cs.id
		where isPaymentDone=0
		and p.bill_to_party = id_in
		order by p.Date desc;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPendingPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPendingPurchase`(id_in INT)
BEGIN
		select invoice_num,invoice_date,`totalAmountAfterTax`,cs.`company_name`,p.id
		from purchase p join `clients_address` cs 
		on p.client_id = cs.id
		where isPaymentDone=0
		and p.client_id = id_in
		order by invoice_Date desc;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getProductThreshold` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getProductThreshold`(		)
BEGIN
		select `product_threashold`
		from `my_profile`;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchase`(id_in INT)
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
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchaseDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchaseDetails`(id_in INT)
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
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchaseList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchaseList`()
BEGIN
				SELECT p.id,p.`invoice_num`,p.`invoice_date` as 'date',bill_amount,cs.`company_name`,p.isPaymentDone,p.isLast
		FROM `purchase` p JOIN `clients_address` cs 
		ON p.`client_id` = cs.id
		
		ORDER BY p.`id` desc;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchaseListBetweenDates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchaseListBetweenDates`(fromDate DATE,todate DATE)
BEGIN
SELECT id FROM Purchase
WHERE `invoice_date` BETWEEN fromDate AND todate
ORDER BY id ASC;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchaseMonthWise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchaseMonthWise`(fromDate date, toDate date)
BEGIN
    
        SELECT CONCAT(SUBSTRING(MONTHNAME(p1.invoice_date),1,3),' ' ,YEAR(p1.invoice_date) ) as 'monthDate' ,
    SUM(p1.bill_amount) as 'total' , SUM(p2.bill_amount) as 'paid' , SUM(p3.bill_amount) as 'unpaid'
    FROM purchase p1 left join purchase p2
    on p1.id = p2.id and p2.isPaymentDone =  1
    left join purchase p3 on p1.id = p3.id  and p3.isPaymentDone = 0
    where p1.invoice_date between fromDate and toDate
	GROUP BY YEAR(p1.invoice_date), MONTH(p1.invoice_date);
    
       
    
    
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPurchasePaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getPurchasePaymentDetails`(id_in int)
BEGIN
SELECT ip.*,i.isPaymentDone FROM invoice_payment ip JOIN payment_purchase_details id
ON ip.id = id.invoice_payment_id JOIN purchase i
ON i.id = id.purchase_id
WHERE i.id = id_in;		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRAWProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getRAWProducts`()
BEGIN
		SELECT p.`id`, CONCAT(mp.`product_name`,' : ', p.`product_name`) as 'product_name'
		FROM `products` p JOIN `main_products` mp
		ON mp.id = p.`product_main_id`
		where mp.`product_type` = 3;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSalesMonthWise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getSalesMonthWise`(fromDate date, toDate date)
BEGIN
        SELECT CONCAT(SUBSTRING(MONTHNAME(p1.date),1,3),' ' ,YEAR(p1.date) ) as 'monthDate' ,
    SUM(p1.bill_amount) as 'total' , SUM(p2.bill_amount) as 'paid' , SUM(p3.bill_amount) as 'unpaid'
    FROM invoice p1 left join invoice p2
    on p1.id = p2.id and p2.isPaymentDone =  1
    left join invoice p3 on p1.id = p3.id  and p3.isPaymentDone = 0
    where p1.date between fromDate and toDate
	GROUP BY YEAR(p1.date), MONTH(p1.date);
    
	
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getStateList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getStateList`()
BEGIN
		SELECT `id`,`state_name`,`state_tin`
		FROM `state`;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSubProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getSubProducts`(main_id_in int)
BEGIN
		SELECT id,`product_name`,`qty`,isDeleted
		from `products`
		where `product_main_id` = main_id_in;
		
		
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUOMAndHSN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getUOMAndHSN`( id_in INT)
BEGIN
		select m.`hsn_code`,mu.`uom`,m.`product_type`,p.qty
		from `main_products` m join `m_uom` mu
		on m.`UOM` = mu.id join `products` p
			on m.id=p.`product_main_id`
		where p.id=id_in;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUOMAndHSNAndPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `getUOMAndHSNAndPrice`( id_in INT,companyId_in int)
BEGIN
select m.`hsn_code`,mu.`uom`,m.`product_type`,p.qty,c.price,m.product_type
		from `main_products` m join `m_uom` mu
		on m.`UOM` = mu.id join `products` p
			on m.id=p.`product_main_id` join companyproductsprice c
        on p.id = c.productId
		where p.id=id_in and c.companyId = companyId_in;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertInvoice`(
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
	invoiceId_in int,
    invoiceNumber_in varchar(45))
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
			`invoiceId`,
            invoice_num)
		VALUES (invoice_date_in ,reverse_charge_in ,state_in , code_in ,
transport_mode_in ,vehicle_no_in ,date_of_supply_in ,place_of_supply_in,bill_to_party_in ,ship_to_party_in ,total_amount_before_tax_in ,
cgst_perc_in ,cgst_amount_in ,sgst_perc_in ,sgst_amount_in ,igst_perc_in ,igst_amount_in ,total_amount_after_tax_in ,
rounnd_off_in ,bill_amount_in , bill_amount_in_words_in,total_amount_gst_in,gst_on_reverse_charge_in,invoiceId_in,invoiceNumber_in );
		
		SELECT LAST_INSERT_ID() ;
		
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertInvoiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertInvoiceDetails`(product_id_in INT,qty DOUBLE,amount_in DOUBLE,total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,cgst_amt_in DOUBLE,sgst_perc_in DOUBLE,sgst_amt_in DOUBLE,igst_perc_in DOUBLE,igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,invoice_id_in INT,hsn_in varchar(100),uom_in varchar(50),product_type_in int)
BEGIN
		INSERT INTO `invoice_details`(`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,
		`cgst_amount`,`sgst_perc`,`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`invoice_id`,`hsn`,`uom`,product_type)
		VALUES(product_id_in ,qty ,amount_in,total_amount_in ,
		cgst_perc_in  ,cgst_amt_in ,sgst_perc_in ,sgst_amt_in ,igst_perc_in ,igst_amt_in ,
		total_amount_after_tax_in ,invoice_id_in,hsn_in,uom_in,product_type_in );
		
		SELECT LAST_INSERT_ID();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertInvoicePayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertInvoicePayment`(
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
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertInvoicePaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertInvoicePaymentDetails`(invoice_payment_id_in int,invoice_id_in int)
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
		
				
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertMainProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertMainProduct`(productName varchar(500),product_hsn VARCHAR(500),product_uom int, product_type int)
BEGIN
		insert into `main_products`(`product_name`,`hsn_code`,`UOM`,`product_type`)
		values(productName,product_hsn,product_uom,product_type);
		
		select LAST_INSERT_ID();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertPurchase`(invoice_date_in date,invoice_num_in varchar(50),
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPurchaseDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertPurchaseDetails`(product_id_in int,qty double,amount_in double,total_amount_in DOUBLE,
		cgst_perc_in DOUBLE ,cgst_amt_in DOUBLE,sgst_perc_in DOUBLE,sgst_amt_in DOUBLE,igst_perc_in DOUBLE,igst_amt_in DOUBLE,
		total_amount_after_tax_in DOUBLE,purchase_id_in INT,hsn_in VARCHAR(100),uom_in VARCHAR(50))
BEGIN
		INSERT INTO `purchase_details`(`product_id`,`qty`,`amount`,`total_amount`,`cgst_perc`,`cgst_amount`,`sgst_perc`,
		`sgst_amount`,`igst_perc`,`igst_amount`,`totalAmountAfterTax`,`purchase_id`,`hsn`,`uom`)
		VALUES(product_id_in ,qty ,amount_in,total_amount_in ,
		cgst_perc_in  ,cgst_amt_in ,sgst_perc_in ,sgst_amt_in ,igst_perc_in ,igst_amt_in ,
		total_amount_after_tax_in ,purchase_id_in,hsn_in,uom_in);
		
		SELECT LAST_INSERT_ID();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPurchasePaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertPurchasePaymentDetails`(invoice_payment_id_in INT,purchase_id_in INT)
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
		
				
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertSubProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `insertSubProduct`(subProductName varchar(500),subProductCode varchar(500),mainProductId int,priceIn int)
BEGIN
		insert into `products`(`product_name`,`product_shotform`,`product_main_id`,price)
		values(subProductName,subProductCode,mainProductId,priceIn);
		
		select LAST_INSERT_ID();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCompanyDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateCompanyDetails`(id_in int,comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin varchar(200),comp_email VARCHAR(150),
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCompnyProductPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateCompnyProductPrice`(companyIdin int,productIdin int,pricein double)
BEGIN

update companyproductsprice
set price = pricein
where companyId = companyIdin and productId = productIdin;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateInvoice`(
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateInvoiceDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateInvoiceDetails`(product_id_in INT,
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMainProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateMainProduct`(productName varchar(500),product_hsn VARCHAR(500),product_uom int, product_type int,product_id int)
BEGIN
		update `main_products`
		set `product_name`=productName,
		`hsn_code`=product_hsn,
		`UOM`=product_uom,
		`product_type`=product_type
		where `id` = product_id;
		
		select ROW_COUNT();
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMyProfileDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateMyProfileDetails`(id_in INT,comp_name VARCHAR(500), comp_add VARCHAR(500),comp_gstin VARCHAR(200),comp_email VARCHAR(150),
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
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePaymentInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updatePaymentInvoice`(id_in INT,date_in DATE,pay_date_in DATE, pay_mode_in VARCHAR(10),
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePaymentPurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updatePaymentPurchase`(invoice_num_in int,invoice_date_in date,pay_date_in date, pay_mode_in varchar(10),
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateProductThreshold` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateProductThreshold`( val int)
BEGIN
		
		update `my_profile`
		set `product_threashold` =val
		where id=1;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePurchase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updatePurchase`(
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePurchaseDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updatePurchaseDetails`(
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateSubProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`pritienterprises`@`%` PROCEDURE `updateSubProduct`(subproductId int , subProductName varchar(500),subProductQTY varchar(500),mainProductId int,isdeletedin int)
BEGIN
		
		
		
if subproductId = 0 then
		insert into `products`(`product_name`,`qty`,`product_main_id`)
		values(subProductName,subProductQTY,mainProductId);
else		
		
UPDATE `products`
		SET `product_name`=subProductName,
		`qty`=subProductQTY,
        isDeleted = isdeletedin
		WHERE `id`=subproductId;
		
		end if;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-13 16:22:46
