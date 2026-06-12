-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: fashion_store
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user` (`user_id`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,'2026-05-07 02:34:35'),(2,2,'2026-05-07 02:34:35'),(3,4,'2026-05-07 17:12:42'),(4,5,'2026-05-08 03:59:46'),(5,6,'2026-05-14 18:09:46');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `size` varchar(10) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `fk_cart_items_cart` (`cart_id`),
  KEY `fk_cart_items_product` (`product_id`),
  CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (3,2,3,'S',1),(4,2,8,'FREE',1),(14,1,2,'32',3),(15,1,1,'S',1),(19,4,1,'S',2),(20,4,1,'M',1),(22,3,3,'M',1),(23,3,8,'FREE',1),(24,4,3,'S',1),(25,4,1,'S',1),(26,4,1,'S',1);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (5,'Accessories'),(4,'Footwear'),(3,'Kids'),(1,'Men'),(2,'Women');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `discount_type` enum('PERCENTAGE','FIXED') NOT NULL DEFAULT 'PERCENTAGE',
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) NOT NULL DEFAULT '2000.00',
  `max_discount` decimal(10,2) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `usage_limit` int NOT NULL DEFAULT '100',
  `used_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'NOVAFIT20','PERCENTAGE',20.00,2000.00,500.00,'2025-01-01','2030-12-31',1,1000,0);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `size` varchar(10) NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `fk_order_items_order` (`order_id`),
  KEY `fk_order_items_product` (`product_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'M',2,799.00),(2,1,6,'8',1,2499.00),(3,2,3,'S',1,1999.00),(4,2,8,'FREE',1,999.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'Placed',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,4097.00,'Placed','2026-05-07 02:34:46'),(2,2,2998.00,'Delivered','2026-05-07 02:34:46'),(3,1,0.00,'Placed','2026-05-07 16:22:50'),(4,1,0.00,'Placed','2026-05-07 16:39:17'),(5,1,0.00,'Placed','2026-05-07 16:42:27'),(6,4,0.00,'Placed','2026-05-07 17:12:47'),(7,4,1499.00,'Placed','2026-05-07 17:20:07'),(8,4,1499.00,'Placed','2026-05-08 01:36:08'),(9,5,1999.00,'Placed','2026-05-08 03:59:54'),(10,5,2798.00,'Placed','2026-05-08 06:16:33'),(11,5,799.00,'Placed','2026-05-08 07:57:49'),(12,5,1598.00,'Placed','2026-05-10 03:21:29'),(13,6,1598.00,'Delivered','2026-05-14 18:09:53'),(14,5,4396.00,'Placed','2026-06-10 04:31:44');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sizes`
--

DROP TABLE IF EXISTS `product_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sizes` (
  `product_size_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size` varchar(10) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`product_size_id`),
  KEY `fk_product_sizes_product` (`product_id`),
  CONSTRAINT `fk_product_sizes_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sizes`
--

LOCK TABLES `product_sizes` WRITE;
/*!40000 ALTER TABLE `product_sizes` DISABLE KEYS */;
INSERT INTO `product_sizes` VALUES (1,1,'S',10),(2,1,'M',15),(3,1,'L',12),(4,1,'XL',8),(5,2,'30',10),(6,2,'32',12),(7,2,'34',8),(8,3,'S',7),(9,3,'M',12),(10,3,'L',6),(11,4,'M',10),(12,4,'L',8),(13,4,'XL',5),(14,5,'XS',10),(15,5,'S',14),(16,5,'M',8),(17,6,'7',6),(18,6,'8',10),(19,6,'9',7),(20,6,'10',5),(21,7,'8',8),(22,7,'9',10),(23,7,'10',6),(24,8,'FREE',20),(25,9,'FREE',12),(26,10,'S',8),(27,10,'M',12),(28,10,'L',10),(29,10,'XL',6),(30,10,'XXL',4),(31,11,'S',10),(32,11,'M',15),(33,11,'L',12),(34,11,'XL',8),(35,11,'XXL',5),(36,12,'S',12),(37,12,'M',18),(38,12,'L',15),(39,12,'XL',10),(40,12,'XXL',6),(41,13,'28',8),(42,13,'30',12),(43,13,'32',14),(44,13,'34',10),(45,13,'36',6),(46,14,'S',6),(47,14,'M',10),(48,14,'L',12),(49,14,'XL',8),(50,14,'XXL',4),(51,15,'S',10),(52,15,'M',14),(53,15,'L',12),(54,15,'XL',8),(55,15,'XXL',5),(56,16,'S',8),(57,16,'M',16),(58,16,'L',14),(59,16,'XL',10),(60,16,'XXL',6),(61,17,'S',5),(62,17,'M',8),(63,17,'L',10),(64,17,'XL',6),(65,17,'XXL',3),(66,18,'S',8),(67,18,'M',12),(68,18,'L',10),(69,18,'XL',7),(70,18,'XXL',5),(71,19,'S',9),(72,19,'M',13),(73,19,'L',11),(74,19,'XL',8),(75,19,'XXL',4),(76,20,'S',10),(77,20,'M',15),(78,20,'L',12),(79,20,'XL',8),(80,20,'XXL',5),(81,21,'XS',6),(82,21,'S',12),(83,21,'M',15),(84,21,'L',10),(85,21,'XL',5),(86,22,'XS',5),(87,22,'S',10),(88,22,'M',14),(89,22,'L',9),(90,22,'XL',4),(91,23,'S',12),(92,23,'M',16),(93,23,'L',12),(94,23,'XL',8),(95,23,'XXL',4),(96,24,'Free Size',15),(97,25,'26',8),(98,25,'28',12),(99,25,'30',14),(100,25,'32',8),(101,25,'34',5),(102,26,'XS',7),(103,26,'S',14),(104,26,'M',16),(105,26,'L',10),(106,26,'XL',5),(107,27,'S',7),(108,27,'M',12),(109,27,'L',10),(110,27,'XL',6),(111,27,'XXL',3),(112,28,'XS',6),(113,28,'S',12),(114,28,'M',14),(115,28,'L',8),(116,28,'XL',4),(117,29,'S',10),(118,29,'M',15),(119,29,'L',12),(120,29,'XL',8),(121,29,'XXL',4),(122,30,'S',6),(123,30,'M',10),(124,30,'L',8),(125,30,'XL',5),(126,30,'XXL',3),(127,31,'2-3Y',8),(128,31,'4-5Y',12),(129,31,'6-7Y',10),(130,31,'8-9Y',8),(131,31,'10-11Y',5),(132,32,'2-3Y',6),(133,32,'4-5Y',10),(134,32,'6-7Y',12),(135,32,'8-9Y',7),(136,32,'10-11Y',4),(137,33,'2-3Y',5),(138,33,'4-5Y',9),(139,33,'6-7Y',11),(140,33,'8-9Y',7),(141,33,'10-11Y',4),(142,34,'2-3Y',8),(143,34,'4-5Y',12),(144,34,'6-7Y',10),(145,34,'8-9Y',8),(146,34,'10-11Y',5),(147,35,'2-3Y',7),(148,35,'4-5Y',11),(149,35,'6-7Y',12),(150,35,'8-9Y',8),(151,35,'10-11Y',5),(152,36,'2-3Y',10),(153,36,'4-5Y',14),(154,36,'6-7Y',12),(155,36,'8-9Y',9),(156,36,'10-11Y',6),(157,37,'2-3Y',6),(158,37,'4-5Y',10),(159,37,'6-7Y',9),(160,37,'8-9Y',7),(161,37,'10-11Y',4),(162,38,'2-3Y',8),(163,38,'4-5Y',12),(164,38,'6-7Y',10),(165,38,'8-9Y',8),(166,38,'10-11Y',5),(167,39,'2-3Y',8),(168,39,'4-5Y',13),(169,39,'6-7Y',11),(170,39,'8-9Y',8),(171,39,'10-11Y',5),(172,40,'2-3Y',5),(173,40,'4-5Y',9),(174,40,'6-7Y',10),(175,40,'8-9Y',7),(176,40,'10-11Y',4),(177,41,'6',7),(178,41,'7',10),(179,41,'8',12),(180,41,'9',9),(181,41,'10',5),(182,42,'6',5),(183,42,'7',8),(184,42,'8',10),(185,42,'9',7),(186,42,'10',4),(187,43,'4',5),(188,43,'5',9),(189,43,'6',11),(190,43,'7',8),(191,43,'8',4),(192,44,'4',6),(193,44,'5',10),(194,44,'6',12),(195,44,'7',8),(196,44,'8',5),(197,45,'6',8),(198,45,'7',12),(199,45,'8',14),(200,45,'9',10),(201,45,'10',6),(202,46,'6',6),(203,46,'7',10),(204,46,'8',12),(205,46,'9',8),(206,46,'10',5),(207,47,'6',5),(208,47,'7',8),(209,47,'8',9),(210,47,'9',6),(211,47,'10',4),(212,48,'1',6),(213,48,'2',10),(214,48,'3',12),(215,48,'4',8),(216,48,'5',5),(217,49,'6',8),(218,49,'7',12),(219,49,'8',10),(220,49,'9',8),(221,49,'10',5),(222,50,'6',7),(223,50,'7',11),(224,50,'8',13),(225,50,'9',9),(226,50,'10',5),(227,51,'Free Size',20),(228,52,'Free Size',25),(229,53,'Free Size',30),(230,54,'Free Size',18),(231,55,'Free Size',35),(232,56,'Free Size',28),(233,57,'Free Size',22),(234,58,'Free Size',24),(235,59,'Free Size',16),(236,60,'Free Size',40);
/*!40000 ALTER TABLE `product_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category_id` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `fk_products_category` (`category_id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Men Black T-Shirt','Premium cotton black t-shirt for men',799.00,1,'assets/images/products/men_black_tshirt.jpg','2026-05-07 02:34:20'),(2,'Men Blue Jeans','Slim fit blue jeans',1499.00,1,'assets/images/products/men_blue_jeans.jpg','2026-05-07 02:34:20'),(3,'Women Floral Dress','Elegant floral summer dress',1999.00,2,'assets/images/products/women_floral_dress.jpg','2026-05-07 02:34:20'),(4,'Women Pink Hoodie','Warm winter hoodie for women',1799.00,2,'assets/images/products/women_pink_hoodie.jpg','2026-05-07 02:34:20'),(5,'Kids Cartoon T-Shirt','Cute cartoon printed t-shirt',599.00,3,'assets/images/products/kids_cartoon_tshirt.jpg','2026-05-07 02:34:20'),(6,'Running Shoes','Comfortable sports running shoes',2499.00,4,'assets/images/products/running_shoes.jpg','2026-05-07 02:34:20'),(7,'Casual Sneakers','Stylish white sneakers',2299.00,4,'assets/images/products/casual_sneakers.jpg','2026-05-07 02:34:20'),(8,'Leather Wallet','Genuine leather wallet',999.00,5,'assets/images/products/wallet.jpg','2026-05-07 02:34:20'),(9,'Smart Watch','Digital smart watch',3499.00,5,'assets/images/products/smart_watch.jpg','2026-05-07 02:34:20'),(10,'Kelvin Levis Men Hoodie','Premium Kelvin Levis branded men hoodie with stylish design, comfortable fabric, and modern fit.',5000.00,1,'assets/images/products/ck.png','2026-05-15 04:53:29'),(11,'NovaFit Men Classic White Hoodie','Premium men white hoodie with soft cotton fabric, modern fit and comfortable daily wear style.',2499.00,1,'assets/images/ck white woodie.png','2026-05-15 18:15:10'),(12,'NovaFit Men Black Oversized T-Shirt','Trendy black oversized t-shirt designed for casual fashion with breathable cotton material.',999.00,1,'assets/images/Men Black Oversized T-Shirt.png','2026-05-15 18:15:11'),(13,'NovaFit Men Slim Blue Jeans','Stylish slim fit blue jeans with premium denim fabric and comfortable stretch finish.',2199.00,1,'assets/images/NovaFit Men Slim Blue Jeans.png','2026-05-15 18:15:28'),(14,'NovaFit Men Casual Denim Jacket','Premium denim jacket for men with smart casual design and durable stitching.',3299.00,1,'assets/images/NovaFit Men Casual Denim Jacket.png','2026-05-15 18:15:28'),(15,'NovaFit Men Formal White Shirt','Elegant white formal shirt for office, meetings and premium everyday professional styling.',1499.00,1,'assets/images/NovaFit Men Formal White Shirt.png','2026-05-15 18:15:28'),(16,'NovaFit Men Black Joggers','Comfortable black joggers with stretch fabric, perfect for travel, gym and casual wear.',1599.00,1,'assets/images/NovaFit Men Black Joggers.png','2026-05-15 18:15:28'),(17,'NovaFit Men Premium Black Blazer','Luxury black blazer for parties, formal events and premium fashion occasions.',4999.00,1,'assets/images/Men Premium Black Blazer.png','2026-05-15 18:15:28'),(18,'NovaFit Men Ethnic Kurta','Modern ethnic kurta for men with premium fabric and traditional stylish appearance.',1899.00,1,'assets/images/Men Ethnic Kurta.png','2026-05-15 18:15:28'),(19,'NovaFit Men Grey Sweatshirt','Soft grey sweatshirt with premium warm fabric and simple minimal NovaFit styling.',1799.00,1,'assets/images/Men Grey Sweatshirt.png','2026-05-15 18:15:28'),(20,'NovaFit Men Summer Shorts','Lightweight summer shorts for men with breathable fabric and relaxed comfort fit.',899.00,1,'assets/images/Men Summer Shorts.png','2026-05-15 18:15:28'),(21,'NovaFit Women Floral Summer Dress','Beautiful floral summer dress with soft flowy fabric and elegant premium design.',2299.00,2,'assets/images/products/women_floral_summer_dress.jpg','2026-05-15 18:15:28'),(22,'NovaFit Women Pink Hoodie','Stylish pink hoodie for women with cozy fabric, premium finish and modern casual look.',1999.00,2,'assets/images/products/women_pink_hoodie.jpg','2026-05-15 18:15:28'),(23,'NovaFit Women Designer Kurti','Elegant designer kurti with ethnic patterns, comfortable fit and premium stitching.',1599.00,2,'assets/images/products/women_designer_kurti.jpg','2026-05-15 18:15:28'),(24,'NovaFit Women Silk Saree','Premium silk saree with rich elegant finish, suitable for weddings and festive occasions.',3999.00,2,'assets/images/products/women_silk_saree.jpg','2026-05-15 18:15:28'),(25,'NovaFit Women High Waist Jeans','Trendy high waist jeans with stretchable denim and stylish slim-fit appearance.',2099.00,2,'assets/images/products/women_high_waist_jeans.jpg','2026-05-15 18:15:28'),(26,'NovaFit Women White Casual Top','Premium white casual top with soft breathable material and simple modern styling.',999.00,2,'assets/images/products/women_white_casual_top.jpg','2026-05-15 18:15:28'),(27,'NovaFit Women Black Blazer','Premium black blazer for women, perfect for office, formal events and smart styling.',3499.00,2,'assets/images/products/women_black_blazer.jpg','2026-05-15 18:15:29'),(28,'NovaFit Women Pleated Skirt','Elegant pleated skirt with premium fabric, stylish fall and comfortable waistband.',1399.00,2,'assets/images/products/women_pleated_skirt.jpg','2026-05-15 18:15:29'),(29,'NovaFit Women Palazzo Pants','Comfortable palazzo pants with stylish wide-leg design and breathable premium fabric.',1199.00,2,'assets/images/products/women_palazzo_pants.jpg','2026-05-15 18:15:29'),(30,'NovaFit Women Ethnic Gown','Premium ethnic gown with stylish embroidery and graceful festive fashion look.',4499.00,2,'assets/images/products/women_ethnic_gown.jpg','2026-05-15 18:15:29'),(31,'NovaFit Kids Cartoon T-Shirt','Cute cartoon printed t-shirt for kids with soft cotton and playful daily wear design.',599.00,3,'assets/images/products/kids_cartoon_tshirt.jpg','2026-05-15 18:15:29'),(32,'NovaFit Kids Denim Dungaree','Stylish denim dungaree for kids with durable stitching and comfortable playful fit.',1299.00,3,'assets/images/products/kids_denim_dungaree.jpg','2026-05-15 18:15:29'),(33,'NovaFit Kids Party Frock','Beautiful party frock for kids with premium fabric and cute fashionable look.',1599.00,3,'assets/images/products/kids_party_frock.jpg','2026-05-15 18:15:29'),(34,'NovaFit Kids Winter Hoodie','Warm winter hoodie for kids with soft inner lining and stylish casual design.',1199.00,3,'assets/images/products/kids_winter_hoodie.jpg','2026-05-15 18:15:29'),(35,'NovaFit Kids Blue Jeans','Comfortable blue jeans for kids with stretchable denim and durable daily wear quality.',999.00,3,'assets/images/products/kids_blue_jeans.jpg','2026-05-15 18:15:29'),(36,'NovaFit Kids Cotton Shorts','Lightweight cotton shorts for kids with comfortable waistband and summer-friendly design.',499.00,3,'assets/images/products/kids_cotton_shorts.jpg','2026-05-15 18:15:29'),(37,'NovaFit Kids Ethnic Kurta Set','Premium ethnic kurta set for kids, perfect for festivals, functions and celebrations.',1499.00,3,'assets/images/products/kids_ethnic_kurta_set.jpg','2026-05-15 18:15:29'),(38,'NovaFit Kids Printed Night Suit','Soft printed night suit for kids with cozy fabric and comfortable sleeping fit.',899.00,3,'assets/images/products/kids_printed_night_suit.jpg','2026-05-15 18:15:29'),(39,'NovaFit Kids Polo T-Shirt','Smart polo t-shirt for kids with premium cotton fabric and neat collar design.',699.00,3,'assets/images/products/kids_polo_tshirt.jpg','2026-05-15 18:15:29'),(40,'NovaFit Kids Rain Jacket','Water-resistant kids rain jacket with hood, bright styling and lightweight comfort.',1399.00,3,'assets/images/products/kids_rain_jacket.jpg','2026-05-15 18:15:29'),(41,'NovaFit Men White Sneakers','Premium white sneakers with cushioned sole and versatile styling for casual outfits.',2499.00,4,'assets/images/products/footwear_men_white_sneakers.jpg','2026-05-15 18:15:29'),(42,'NovaFit Men Black Formal Shoes','Elegant black formal shoes with polished finish and comfortable office wear design.',2999.00,4,'assets/images/products/footwear_men_black_formal_shoes.jpg','2026-05-15 18:15:29'),(43,'NovaFit Women High Heels','Stylish women high heels with premium finish, perfect for parties and events.',2199.00,4,'assets/images/products/footwear_women_high_heels.jpg','2026-05-15 18:15:29'),(44,'NovaFit Women Flat Sandals','Comfortable flat sandals for women with stylish straps and daily wear comfort.',1299.00,4,'assets/images/products/footwear_women_flat_sandals.jpg','2026-05-15 18:15:29'),(45,'NovaFit Running Sports Shoes','Lightweight running shoes with breathable mesh and cushioned support for active lifestyle.',2799.00,4,'assets/images/products/footwear_running_sports_shoes.jpg','2026-05-15 18:15:29'),(46,'NovaFit Casual Loafers','Smart casual loafers with premium comfort sole and elegant modern design.',1999.00,4,'assets/images/products/footwear_casual_loafers.jpg','2026-05-15 18:15:29'),(47,'NovaFit Leather Boots','Premium leather boots with durable sole and fashionable winter-ready appearance.',3499.00,4,'assets/images/products/footwear_leather_boots.jpg','2026-05-15 18:15:29'),(48,'NovaFit Kids Light-Up Shoes','Fun light-up shoes for kids with comfortable sole and attractive playful design.',1799.00,4,'assets/images/products/footwear_kids_lightup_shoes.jpg','2026-05-15 18:15:29'),(49,'NovaFit Sports Sandals','Comfortable sports sandals with adjustable straps and durable grip for outdoor use.',1499.00,4,'assets/images/products/footwear_sports_sandals.jpg','2026-05-15 18:15:29'),(50,'NovaFit Premium Slip-On Shoes','Modern slip-on shoes with soft footbed, flexible sole and easy everyday comfort.',1899.00,4,'assets/images/products/footwear_premium_slipon_shoes.jpg','2026-05-15 18:15:29'),(51,'NovaFit Luxury Analog Watch','Premium analog watch with elegant dial and stylish strap for daily and formal use.',2999.00,5,'assets/images/products/accessory_luxury_analog_watch.jpg','2026-05-15 18:15:29'),(52,'NovaFit Black Sunglasses','Stylish black sunglasses with UV protection and premium fashion frame design.',999.00,5,'assets/images/products/accessory_black_sunglasses.jpg','2026-05-15 18:15:29'),(53,'NovaFit Leather Belt','Premium leather belt with classic buckle and durable formal-casual styling.',799.00,5,'assets/images/products/accessory_leather_belt.jpg','2026-05-15 18:15:29'),(54,'NovaFit Urban Backpack','Spacious urban backpack with premium compartments, durable fabric and modern design.',1899.00,5,'assets/images/products/accessory_urban_backpack.jpg','2026-05-15 18:15:29'),(55,'NovaFit Classic Cap','Trendy classic cap with adjustable strap and stylish embroidered NovaFit look.',599.00,5,'assets/images/products/accessory_classic_cap.jpg','2026-05-15 18:15:29'),(56,'NovaFit Premium Wallet','Compact premium wallet with multiple card slots and elegant leather finish.',899.00,5,'assets/images/products/accessory_premium_wallet.jpg','2026-05-15 18:15:29'),(57,'NovaFit Minimal Bracelet','Stylish minimal bracelet with premium metal finish and modern fashion appeal.',699.00,5,'assets/images/products/accessory_minimal_bracelet.jpg','2026-05-15 18:15:29'),(58,'NovaFit Soft Winter Scarf','Soft winter scarf with warm fabric and elegant styling for premium winter fashion.',799.00,5,'assets/images/products/accessory_soft_winter_scarf.jpg','2026-05-15 18:15:29'),(59,'NovaFit Women Handbag','Premium women handbag with elegant design, spacious storage and stylish finish.',2499.00,5,'assets/images/products/accessory_women_handbag.jpg','2026-05-15 18:15:29'),(60,'NovaFit Cotton Socks Pack','Comfortable cotton socks pack with breathable fabric and soft everyday wear quality.',499.00,5,'assets/images/products/accessory_cotton_socks_pack.jpg','2026-05-15 18:15:29');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Pramod Gowda','pramod@gmail.com','1234','9876543210','Mysore','2026-05-07 02:34:31'),(2,'Rahul Sharma','rahul@gmail.com','1234','9876543211','Bangalore','2026-05-07 02:34:31'),(3,'Sneha R','sneha@gmail.com','1234','9876543212','Hyderabad','2026-05-07 02:34:31'),(4,'Nishchith U','nishchith2345@gmail.com','Newpassword#04','8217267181','Vidya vikas Institute Of engineering And Technology,Mysuru','2026-05-07 17:12:07'),(5,'Pramod Gowda','pramodgowda7377@gmail.com','Newpassword#04','8217267181','Mandya Karnataka','2026-05-08 03:43:14'),(6,'Nishchith Gowda U','nishchith7377@gmail.com','Newpassword#04','8217267181','Vidya Viaks Institute Of Engineering And Technology','2026-05-14 17:24:41'),(7,'prajwal','prajwalprajju0526@gmail.com','Praju@8426','8431320526','Mysore','2026-05-20 14:28:36');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-10 16:21:12
