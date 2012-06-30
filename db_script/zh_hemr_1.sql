-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.8-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4058
-- Date/time:                    2012-05-07 18:06:20
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for procedure hosted_emr.activatefreeplan
DROP PROCEDURE IF EXISTS `activatefreeplan`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `activatefreeplan`(IN `Pid` BIGINT, IN `sessionid` VARCHAR(150), IN `hf_id` BIGINT)
    COMMENT 'UPDATE PLAN STATUS IN CASE USER SELECT FREE PLAN'
BEGIN
	
	DECLARE invoiceno varchar(50);
	
	update customer_selected_plan set payment_status='Completed',payment_date=curdate(),payment_error_message='',plan_status='1',plan_activated_date=curdate() 
	where plan_id=Pid and hf_id=hf_id;
	
	select invoice_number into invoiceno from customer_invoice where plan_id=1 and hf_id=hf_id and amount=0 and payment_status='Pending' and invoice_date=curdate();
	
	update cart set cstatus=1,invoice_no=invoiceno where cartsession=sessionid and hf_id=hf_id;
	
	update customer_invoice set payment_status='Completed',payment_date=curdate() where hf_id=hf_id;
END//
DELIMITER ;


-- Dumping structure for procedure hosted_emr.add_custome_price_product
DROP PROCEDURE IF EXISTS `add_custome_price_product`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_custome_price_product`(IN `pid` BIGINT, IN `pcostid` BIGINT, IN `sessionid` VARCHAR(150), IN `hf_id` BIGINT, OUT `result` INT)
BEGIN
	DECLARE productname VARCHAR(150) DEFAULT "Product";
	DECLARE pcost FLOAT(20) DEFAULT 0.00;
	DECLARE uprice INT DEFAULT 0;
	DECLARE cdate DATE DEFAULT CURDATE();
	DECLARE cartidcount INT DEFAULT 0;
	DECLARE qty_from INT DEFAULT 0;
	DECLARE qty INT DEFAULT 0;

	SELECT product_name INTO productname FROM products WHERE idproducts=pid;

	select user_from,user_to,cost INTO qty_from,qty,pcost from product_price where idproduct_feature=pcostid and idproducts=pid;
	
	SELECT COUNT(idcart) INTO cartidcount FROM cart WHERE cartsession=sessionid AND product_id=pid AND hf_id=hf_id AND invoice_no IS NULL;
	IF cartidcount = 0 THEN
		INSERT INTO cart(cartsession,product_id,hf_id,description,qty_from,qty,unit_price,discount,cstatus,cart_date)VALUES(sessionid,pid,hf_id,productname,qty_from,qty,pcost,0,0,cdate);
		SET result=1;
	ELSE
		SET result=0;
	END IF;
END//
DELIMITER ;


-- Dumping structure for procedure hosted_emr.add_product
DROP PROCEDURE IF EXISTS `add_product`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product`(IN `pid` INT, IN `providerno` INT, IN `sessionid` VARBINARY(150), IN `hf_id` INT)
BEGIN
	DECLARE productname VARCHAR(150) DEFAULT "Product";
	DECLARE pcost FLOAT(20) DEFAULT 0.00;
	DECLARE setupfee FLOAT(20) DEFAULT 0.00;
	DECLARE uprice INT DEFAULT 0;
	DECLARE cdate DATE DEFAULT CURDATE();
	DECLARE cartidcount INT DEFAULT 0;
	
	SELECT product_name,cost,setup_fee INTO productname,pcost,setupfee FROM products WHERE idproducts=pid;

		SELECT COUNT(idcart) into cartidcount FROM cart WHERE cartsession=sessionid AND product_id=pid AND hf_id=hf_id AND invoice_no is null;
	IF cartidcount = 0 THEN
		SET uprice = pcost;
		SET pcost = pcost * providerno;
				INSERT INTO cart(cartsession,product_id,hf_id,description,qty,unit_price,setupfee,discount,cstatus,cart_date)VALUES(sessionid,pid,hf_id,productname,providerno,uprice,setupfee,0,0,cdate);
		select 1;
	ELSE
		select 0;
	END IF;
END//
DELIMITER ;


-- Dumping structure for table hosted_emr.admin_details
DROP TABLE IF EXISTS `admin_details`;
CREATE TABLE IF NOT EXISTS `admin_details` (
  `AdminId` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(50) NOT NULL,
  `AdminUserId` varchar(20) NOT NULL,
  `AdminPassword` varchar(20) NOT NULL,
  `AdminFullName` varchar(150) NOT NULL,
  `AdminEmail` varchar(150) NOT NULL,
  `AdminRoll` varchar(150) NOT NULL,
  `AdminLastLogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AdminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Administrator Login Informations';

-- Dumping data for table hosted_emr.admin_details: ~1 rows (approximately)
DELETE FROM `admin_details`;
/*!40000 ALTER TABLE `admin_details` DISABLE KEYS */;
INSERT INTO `admin_details` (`AdminId`, `customer_id`, `AdminUserId`, `AdminPassword`, `AdminFullName`, `AdminEmail`, `AdminRoll`, `AdminLastLogin`) VALUES
	(1, 1, 'admin', 'admin', 'Administrator', 'pradeep@zhservices.com', 'admin', '2012-02-23 17:25:20');
/*!40000 ALTER TABLE `admin_details` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.cart
DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `idcart` bigint(20) NOT NULL AUTO_INCREMENT,
  `cartsession` varchar(50) NOT NULL DEFAULT '0',
  `plan_id` bigint(20) NOT NULL DEFAULT '0',
  `product_id` bigint(20) NOT NULL DEFAULT '0',
  `hf_id` float NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '0',
  `qty_from` int(11) NOT NULL DEFAULT '0',
  `qty` int(11) NOT NULL DEFAULT '1',
  `unit_price` float NOT NULL DEFAULT '0',
  `setupfee` float NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `setupfee_discount` float NOT NULL DEFAULT '0',
  `total` float NOT NULL DEFAULT '0',
  `cstatus` tinyint(4) NOT NULL DEFAULT '0',
  `cart_date` date NOT NULL,
  `invoice_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcart`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=latin1 COMMENT='Shopping Cart';

-- Dumping data for table hosted_emr.cart: ~39 rows (approximately)
DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`idcart`, `cartsession`, `plan_id`, `product_id`, `hf_id`, `description`, `qty_from`, `qty`, `unit_price`, `setupfee`, `discount`, `setupfee_discount`, `total`, `cstatus`, `cart_date`, `invoice_no`) VALUES
	(167, 'ibh0v6tejbl288l347vhpbq5q6', 1, 0, 77, 'Plan 1 Subscription', 0, 2, 75, 1250, 6, 25, 1300, 0, '2012-05-03', NULL),
	(168, 'ibh0v6tejbl288l347vhpbq5q6', 0, 29, 77, 'Advanced Billing Module', 0, 2, 75, 1000, 0, 0, 0, 0, '2012-05-03', NULL),
	(169, 'ibh0v6tejbl288l347vhpbq5q6', 0, 30, 77, 'eRx', 0, 2, 35, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(170, 'ibh0v6tejbl288l347vhpbq5q6', 0, 31, 77, 'Lab Exchange', 0, 2, 50, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(171, 'ibh0v6tejbl288l347vhpbq5q6', 0, 1, 77, 'ZHOpenEMR', 0, 2, 75, 1250, 0, 0, 0, 0, '2012-05-03', NULL),
	(172, 'nhl8dmn95dl1c73gr2nid2njd6', 1, 0, 78, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-03', NULL),
	(173, 'nhl8dmn95dl1c73gr2nid2njd6', 0, 31, 78, 'Lab Exchange', 0, 3, 50, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(174, '13jjs75a15peklkji4tgpd7k31', 1, 0, 79, 'Plan 1 Subscription', 0, 2, 75, 1250, 6, 25, 1300, 0, '2012-05-03', NULL),
	(175, '13jjs75a15peklkji4tgpd7k31', 0, 29, 79, 'Advanced Billing Module', 0, 2, 75, 1000, 0, 0, 0, 0, '2012-05-03', NULL),
	(176, '13jjs75a15peklkji4tgpd7k31', 0, 30, 79, 'eRx', 0, 2, 35, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(177, '13jjs75a15peklkji4tgpd7k31', 0, 31, 79, 'Lab Exchange', 0, 2, 50, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(178, '13jjs75a15peklkji4tgpd7k31', 1, 0, 80, 'Plan 1 Subscription', 0, 4, 75, 1250, 12, 25, 1300, 0, '2012-05-03', NULL),
	(179, '64s8nkf8pjv6o18iknmpavh3d3', 1, 0, 81, 'Plan 1 Subscription', 0, 1, 75, 1250, 3, 25, 1300, 0, '2012-05-03', NULL),
	(180, '64s8nkf8pjv6o18iknmpavh3d3', 0, 29, 81, 'Advanced Billing Module', 0, 1, 75, 1000, 0, 0, 0, 0, '2012-05-03', NULL),
	(181, '64s8nkf8pjv6o18iknmpavh3d3', 0, 30, 81, 'eRx', 0, 1, 35, 400, 0, 0, 0, 0, '2012-05-03', NULL),
	(182, '9prb8aafdlrlsapg2u8d560k27', 1, 0, 82, 'Plan 1 Subscription', 0, 6, 75, 1250, 17, 25, 1300, 0, '2012-05-03', NULL),
	(183, '9prb8aafdlrlsapg2u8d560k27', 0, 29, 82, 'Advanced Billing Module', 0, 6, 75, 1000, 0, 0, 0, 0, '2012-05-03', NULL),
	(184, 'p5ja7qqf1hol3uso6v6g2a0203', 1, 0, 83, 'Plan 1 Subscription', 0, 7, 75, 1250, 20, 25, 1300, 0, '2012-05-03', NULL),
	(185, 'kmk9gnbghe70q71jbarfpckc91', 1, 0, 84, 'Plan 1 Subscription', 0, 17, 75, 1250, 49, 25, 1300, 0, '2012-05-03', NULL),
	(186, 'kmk9gnbghe70q71jbarfpckc91', 1, 0, 85, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-03', NULL),
	(187, 'kmk9gnbghe70q71jbarfpckc91', 0, 29, 85, 'Advanced Billing Module', 0, 3, 75, 1000, 0, 0, 0, 0, '2012-05-03', NULL),
	(188, 'ltcl6r7vsnfsu3evs1drgme8i2', 15, 0, 86, 'Plan 2 Subscription', 0, 1, 235, 3050, 35, 1000, 2285, 0, '2012-05-03', NULL),
	(189, 'p4vo43oke79qpeq89l86fmtg46', 15, 0, 87, 'Plan 2 Subscription', 0, 4, 185, 2650, 35, 1000, 1835, 0, '2012-05-03', NULL),
	(190, '006r4v0fond3536mp6nffvdkv6', 1, 0, 88, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-04', 'ZH-2012-05-04-00041'),
	(192, '006r4v0fond3536mp6nffvdkv6', 0, 31, 88, 'Lab Exchange', 0, 3, 50, 400, 0, 0, 0, 0, '2012-05-04', 'ZH-2012-05-04-00041'),
	(193, 'nabigqgvfes3te9jhq67jekc37', 1, 0, 89, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-04', 'ZH-2012-05-04-00040'),
	(194, 'nabigqgvfes3te9jhq67jekc37', 0, 31, 89, 'Lab Exchange', 0, 3, 50, 400, 0, 0, 0, 0, '2012-05-04', 'ZH-2012-05-04-00040'),
	(195, 'gthbtf651b57m1fddhv0jeuti3', 1, 0, 90, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-04', NULL),
	(196, 'gthbtf651b57m1fddhv0jeuti3', 0, 31, 90, 'Lab Exchange', 0, 3, 50, 400, 0, 0, 0, 0, '2012-05-04', NULL),
	(197, 'pmoefeppevcptttb2paft11b23', 1, 0, 91, 'Plan 1 Subscription', 0, 3, 75, 1250, 9, 25, 1300, 0, '2012-05-04', 'ZH-2012-05-04-00042'),
	(198, 'pmoefeppevcptttb2paft11b23', 0, 31, 91, 'Lab Exchange', 0, 3, 50, 400, 0, 0, 0, 0, '2012-05-04', 'ZH-2012-05-04-00042'),
	(199, 'leho4m1aqs9sjdunhge5603ne1', 15, 0, 92, 'Plan 2 Subscription', 0, 4, 185, 2650, 35, 1000, 1835, 1, '2012-05-04', 'ZH-2012-05-04-00046'),
	(200, 'leho4m1aqs9sjdunhge5603ne1', 0, 31, 92, 'Lab Exchange', 0, 4, 50, 400, 0, 0, 0, 1, '2012-05-04', 'ZH-2012-05-04-00046'),
	(201, 'leho4m1aqs9sjdunhge5603ne1', 1, 0, 93, 'Plan 1 Subscription', 0, 1, 75, 1250, 3, 25, 1300, 1, '2012-05-04', 'ZH-2012-05-04-00046'),
	(202, 'leho4m1aqs9sjdunhge5603ne1', 0, 30, 93, 'eRx', 0, 1, 35, 400, 0, 0, 0, 1, '2012-05-04', 'ZH-2012-05-04-00046'),
	(203, 'leho4m1aqs9sjdunhge5603ne1', 0, 30, 93, 'eRx', 0, 1, 35, 400, 0, 0, 0, 0, '2012-05-04', 'ZH-2012-05-04-00046'),
	(204, 'uk3g1c5b2r967u08228tbjor67', 15, 0, 94, 'Plan 2 Subscription', 0, 3, 185, 2650, 35, 1000, 1835, 1, '2012-05-04', 'ZH-2012-05-04-00047'),
	(205, 'c3oq51s2p7ageqsamnh7qk78f7', 1, 0, 95, 'Plan 1 Subscription', 0, 4, 75, 1250, 12, 25, 1300, 0, '2012-05-04', 'ZH-2012-05-04-00048'),
	(206, 'c3oq51s2p7ageqsamnh7qk78f7', 0, 30, 95, 'eRx', 0, 4, 35, 400, 0, 0, 0, 0, '2012-05-04', 'ZH-2012-05-04-00048');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;


-- Dumping structure for procedure hosted_emr.cart_products
DROP PROCEDURE IF EXISTS `cart_products`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `cart_products`(IN `hf_idvar` BIGINT, IN `cusid` BIGINT)
BEGIN
     SELECT idproducts,product_name,product_feature,cost,setup_fee,payment_term FROM products WHERE 
customer_id=cusid AND product_status='1'  AND idproducts NOT IN(SELECT idproducts FROM customer_products WHERE 
hf_id=hf_idvar) ORDER BY product_sort_order;
   
    END//
DELIMITER ;


-- Dumping structure for table hosted_emr.cms
DROP TABLE IF EXISTS `cms`;
CREATE TABLE IF NOT EXISTS `cms` (
  `cms_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cms_sec` varchar(50) NOT NULL,
  `cms_title` varchar(50) NOT NULL,
  `cms_details` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.cms: ~4 rows (approximately)
DELETE FROM `cms`;
/*!40000 ALTER TABLE `cms` DISABLE KEYS */;
INSERT INTO `cms` (`cms_id`, `cms_sec`, `cms_title`, `cms_details`, `status`) VALUES
	(1, 'Login page content', '', '<p>\r\n  You have entered a restricted area in our web site. You need to be specially authorized by the administrator to view and use this page. If you are a valid user, please enter your username and password in the area provided.\r\n</p>\r\n<p>\r\n  Features provided by Hosted OpenEMR:\r\n</p>\r\n<ol>\r\n  <li>One</li>\r\n  <li>Two</li>\r\n  <li>Three</li>\r\n</ol>', 1),
	(2, 'User_reg_Confirm', '', 'Thanks for registering with ZHOEMR. Your registration is successful with the selected plan. Your login information is providing below:', 1),
	(3, 'Paypal_intimation', '', 'Paypal is our authorized merchant to accept the payment. Please proceed with instructions to make your payment.', 1),
	(4, 'User_welcome_after_login', 'Welcome', 'Welcome to EMR user section. Please go through the dashboard section to get your sections.', 1);
/*!40000 ALTER TABLE `cms` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.controllers
DROP TABLE IF EXISTS `controllers`;
CREATE TABLE IF NOT EXISTS `controllers` (
  `controller_id` int(10) NOT NULL AUTO_INCREMENT,
  `module_id` int(10) NOT NULL DEFAULT '0',
  `controller_name` varchar(50) NOT NULL DEFAULT '0',
  `controller_display_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`controller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Controller Section of Module (ACL)';

-- Dumping data for table hosted_emr.controllers: ~3 rows (approximately)
DELETE FROM `controllers`;
/*!40000 ALTER TABLE `controllers` DISABLE KEYS */;
INSERT INTO `controllers` (`controller_id`, `module_id`, `controller_name`, `controller_display_name`) VALUES
	(1, 1, 'Admin', 'Admin Module'),
	(2, 1, 'Index', 'Home'),
	(3, 1, 'Logout', 'Logout');
/*!40000 ALTER TABLE `controllers` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.country
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` float(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint(6) DEFAULT NULL,
  `Population` int(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` float(3,1) DEFAULT NULL,
  `GNP` float(10,2) DEFAULT NULL,
  `GNPOld` float(10,2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int(11) DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.country: 237 rows
DELETE FROM `country`;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`Code`, `Name`, `Continent`, `Region`, `SurfaceArea`, `IndepYear`, `Population`, `LifeExpectancy`, `GNP`, `GNPOld`, `LocalName`, `GovernmentForm`, `HeadOfState`, `Capital`, `Code2`) VALUES
	('AFG', 'Afghanistan', 'Asia', 'Southern and Central Asia', 652090.00, 1919, 22720000, 45.9, 5976.00, NULL, 'Afganistan/Afqanestan', 'Islamic Emirate', 'Mohammad Omar', 1, 'AF'),
	('ALB', 'Albania', 'Europe', 'Southern Europe', 28748.00, 1912, 3401200, 71.6, 3205.00, 2500.00, 'ShqipÃ«ria', 'Republic', 'Rexhep Mejdani', 34, 'AL'),
	('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.00, 1962, 31471000, 69.7, 49982.00, 46966.00, 'Al-Jazaâ€™ir/AlgÃ©rie', 'Republic', 'Abdelaziz Bouteflika', 35, 'DZ'),
	('ASM', 'American Samoa', 'Oceania', 'Polynesia', 199.00, NULL, 68000, 75.1, 334.00, NULL, 'Amerika Samoa', 'US Territory', 'George W. Bush', 54, 'AS'),
	('AND', 'Andorra', 'Europe', 'Southern Europe', 468.00, 1278, 78000, 83.5, 1630.00, NULL, 'Andorra', 'Parliamentary Coprincipality', '', 55, 'AD'),
	('AGO', 'Angola', 'Africa', 'Central Africa', 1246700.00, 1975, 12878000, 38.3, 6648.00, 7984.00, 'Angola', 'Republic', 'JosÃ© Eduardo dos Santos', 56, 'AO'),
	('AIA', 'Anguilla', 'North America', 'Caribbean', 96.00, NULL, 8000, 76.1, 63.20, NULL, 'Anguilla', 'Dependent Territory of the UK', 'Elisabeth II', 62, 'AI'),
	('ATG', 'Antigua and Barbuda', 'North America', 'Caribbean', 442.00, 1981, 68000, 70.5, 612.00, 584.00, 'Antigua and Barbuda', 'Constitutional Monarchy', 'Elisabeth II', 63, 'AG'),
	('ARE', 'United Arab Emirates', 'Asia', 'Middle East', 83600.00, 1971, 2441000, 74.1, 37966.00, 36846.00, 'Al-Imarat al-Â´Arabiya al-Muttahida', 'Emirate Federation', 'Zayid bin Sultan al-Nahayan', 65, 'AE'),
	('ARG', 'Argentina', 'South America', 'South America', 2780400.00, 1816, 37032000, 75.1, 340238.00, 323310.00, 'Argentina', 'Federal Republic', 'Fernando de la RÃºa', 69, 'AR'),
	('ARM', 'Armenia', 'Asia', 'Middle East', 29800.00, 1991, 3520000, 66.4, 1813.00, 1627.00, 'Hajastan', 'Republic', 'Robert KotÅ¡arjan', 126, 'AM'),
	('ABW', 'Aruba', 'North America', 'Caribbean', 193.00, NULL, 103000, 78.4, 828.00, 793.00, 'Aruba', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', 129, 'AW'),
	('AUS', 'Australia', 'Oceania', 'Australia and New Zealand', 7741220.00, 1901, 18886000, 79.8, 351182.00, 392911.00, 'Australia', 'Constitutional Monarchy, Federation', 'Elisabeth II', 135, 'AU'),
	('AZE', 'Azerbaijan', 'Asia', 'Middle East', 86600.00, 1991, 7734000, 62.9, 4127.00, 4100.00, 'AzÃ¤rbaycan', 'Federal Republic', 'HeydÃ¤r Ã„liyev', 144, 'AZ'),
	('BHS', 'Bahamas', 'North America', 'Caribbean', 13878.00, 1973, 307000, 71.1, 3527.00, 3347.00, 'The Bahamas', 'Constitutional Monarchy', 'Elisabeth II', 148, 'BS'),
	('BHR', 'Bahrain', 'Asia', 'Middle East', 694.00, 1971, 617000, 73.0, 6366.00, 6097.00, 'Al-Bahrayn', 'Monarchy (Emirate)', 'Hamad ibn Isa al-Khalifa', 149, 'BH'),
	('BGD', 'Bangladesh', 'Asia', 'Southern and Central Asia', 143998.00, 1971, 129155000, 60.2, 32852.00, 31966.00, 'Bangladesh', 'Republic', 'Shahabuddin Ahmad', 150, 'BD'),
	('BRB', 'Barbados', 'North America', 'Caribbean', 430.00, 1966, 270000, 73.0, 2223.00, 2186.00, 'Barbados', 'Constitutional Monarchy', 'Elisabeth II', 174, 'BB'),
	('BEL', 'Belgium', 'Europe', 'Western Europe', 30518.00, 1830, 10239000, 77.8, 249704.00, 243948.00, 'BelgiÃ«/Belgique', 'Constitutional Monarchy, Federation', 'Albert II', 179, 'BE'),
	('BLZ', 'Belize', 'North America', 'Central America', 22696.00, 1981, 241000, 70.9, 630.00, 616.00, 'Belize', 'Constitutional Monarchy', 'Elisabeth II', 185, 'BZ'),
	('BEN', 'Benin', 'Africa', 'Western Africa', 112622.00, 1960, 6097000, 50.2, 2357.00, 2141.00, 'BÃ©nin', 'Republic', 'Mathieu KÃ©rÃ©kou', 187, 'BJ'),
	('BMU', 'Bermuda', 'North America', 'North America', 53.00, NULL, 65000, 76.9, 2328.00, 2190.00, 'Bermuda', 'Dependent Territory of the UK', 'Elisabeth II', 191, 'BM'),
	('BTN', 'Bhutan', 'Asia', 'Southern and Central Asia', 47000.00, 1910, 2124000, 52.4, 372.00, 383.00, 'Druk-Yul', 'Monarchy', 'Jigme Singye Wangchuk', 192, 'BT'),
	('BOL', 'Bolivia', 'South America', 'South America', 1098581.00, 1825, 8329000, 63.7, 8571.00, 7967.00, 'Bolivia', 'Republic', 'Hugo BÃ¡nzer SuÃ¡rez', 194, 'BO'),
	('BIH', 'Bosnia and Herzegovina', 'Europe', 'Southern Europe', 51197.00, 1992, 3972000, 71.5, 2841.00, NULL, 'Bosna i Hercegovina', 'Federal Republic', 'Ante Jelavic', 201, 'BA'),
	('BWA', 'Botswana', 'Africa', 'Southern Africa', 581730.00, 1966, 1622000, 39.3, 4834.00, 4935.00, 'Botswana', 'Republic', 'Festus G. Mogae', 204, 'BW'),
	('BRA', 'Brazil', 'South America', 'South America', 8547403.00, 1822, 170115000, 62.9, 776739.00, 804108.00, 'Brasil', 'Federal Republic', 'Fernando Henrique Cardoso', 211, 'BR'),
	('GBR', 'United Kingdom', 'Europe', 'British Islands', 242900.00, 1066, 59623400, 77.7, 1378330.00, 1296830.00, 'United Kingdom', 'Constitutional Monarchy', 'Elisabeth II', 456, 'GB'),
	('VGB', 'Virgin Islands, British', 'North America', 'Caribbean', 151.00, NULL, 21000, 75.4, 612.00, 573.00, 'British Virgin Islands', 'Dependent Territory of the UK', 'Elisabeth II', 537, 'VG'),
	('BRN', 'Brunei', 'Asia', 'Southeast Asia', 5765.00, 1984, 328000, 73.6, 11705.00, 12460.00, 'Brunei Darussalam', 'Monarchy (Sultanate)', 'Haji Hassan al-Bolkiah', 538, 'BN'),
	('BGR', 'Bulgaria', 'Europe', 'Eastern Europe', 110994.00, 1908, 8190900, 70.9, 12178.00, 10169.00, 'Balgarija', 'Republic', 'Petar Stojanov', 539, 'BG'),
	('BFA', 'Burkina Faso', 'Africa', 'Western Africa', 274000.00, 1960, 11937000, 46.7, 2425.00, 2201.00, 'Burkina Faso', 'Republic', 'Blaise CompaorÃ©', 549, 'BF'),
	('BDI', 'Burundi', 'Africa', 'Eastern Africa', 27834.00, 1962, 6695000, 46.2, 903.00, 982.00, 'Burundi/Uburundi', 'Republic', 'Pierre Buyoya', 552, 'BI'),
	('CYM', 'Cayman Islands', 'North America', 'Caribbean', 264.00, NULL, 38000, 78.9, 1263.00, 1186.00, 'Cayman Islands', 'Dependent Territory of the UK', 'Elisabeth II', 553, 'KY'),
	('CHL', 'Chile', 'South America', 'South America', 756626.00, 1810, 15211000, 75.7, 72949.00, 75780.00, 'Chile', 'Republic', 'Ricardo Lagos Escobar', 554, 'CL'),
	('COK', 'Cook Islands', 'Oceania', 'Polynesia', 236.00, NULL, 20000, 71.1, 100.00, NULL, 'The Cook Islands', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 583, 'CK'),
	('CRI', 'Costa Rica', 'North America', 'Central America', 51100.00, 1821, 4023000, 75.8, 10226.00, 9757.00, 'Costa Rica', 'Republic', 'Miguel Ãngel RodrÃ­guez EcheverrÃ­a', 584, 'CR'),
	('DJI', 'Djibouti', 'Africa', 'Eastern Africa', 23200.00, 1977, 638000, 50.8, 382.00, 373.00, 'Djibouti/Jibuti', 'Republic', 'Ismail Omar Guelleh', 585, 'DJ'),
	('DMA', 'Dominica', 'North America', 'Caribbean', 751.00, 1978, 71000, 73.4, 256.00, 243.00, 'Dominica', 'Republic', 'Vernon Shaw', 586, 'DM'),
	('DOM', 'Dominican Republic', 'North America', 'Caribbean', 48511.00, 1844, 8495000, 73.2, 15846.00, 15076.00, 'RepÃºblica Dominicana', 'Republic', 'HipÃ³lito MejÃ­a DomÃ­nguez', 587, 'DO'),
	('ECU', 'Ecuador', 'South America', 'South America', 283561.00, 1822, 12646000, 71.1, 19770.00, 19769.00, 'Ecuador', 'Republic', 'Gustavo Noboa Bejarano', 594, 'EC'),
	('EGY', 'Egypt', 'Africa', 'Northern Africa', 1001449.00, 1922, 68470000, 63.3, 82710.00, 75617.00, 'Misr', 'Republic', 'Hosni Mubarak', 608, 'EG'),
	('SLV', 'El Salvador', 'North America', 'Central America', 21041.00, 1841, 6276000, 69.7, 11863.00, 11203.00, 'El Salvador', 'Republic', 'Francisco Guillermo Flores PÃ©rez', 645, 'SV'),
	('ERI', 'Eritrea', 'Africa', 'Eastern Africa', 117600.00, 1993, 3850000, 55.8, 650.00, 755.00, 'Ertra', 'Republic', 'Isayas Afewerki [Isaias Afwerki]', 652, 'ER'),
	('ESP', 'Spain', 'Europe', 'Southern Europe', 505992.00, 1492, 39441700, 78.8, 553233.00, 532031.00, 'EspaÃ±a', 'Constitutional Monarchy', 'Juan Carlos I', 653, 'ES'),
	('ZAF', 'South Africa', 'Africa', 'Southern Africa', 1221037.00, 1910, 40377000, 51.1, 116729.00, 129092.00, 'South Africa', 'Republic', 'Thabo Mbeki', 716, 'ZA'),
	('ETH', 'Ethiopia', 'Africa', 'Eastern Africa', 1104300.00, -1000, 62565000, 45.2, 6353.00, 6180.00, 'YeItyopÂ´iya', 'Republic', 'Negasso Gidada', 756, 'ET'),
	('FLK', 'Falkland Islands', 'South America', 'South America', 12173.00, NULL, 2000, NULL, 0.00, NULL, 'Falkland Islands', 'Dependent Territory of the UK', 'Elisabeth II', 763, 'FK'),
	('FJI', 'Fiji Islands', 'Oceania', 'Melanesia', 18274.00, 1970, 817000, 67.9, 1536.00, 2149.00, 'Fiji Islands', 'Republic', 'Josefa Iloilo', 764, 'FJ'),
	('PHL', 'Philippines', 'Asia', 'Southeast Asia', 300000.00, 1946, 75967000, 67.5, 65107.00, 82239.00, 'Pilipinas', 'Republic', 'Gloria Macapagal-Arroyo', 766, 'PH'),
	('FRO', 'Faroe Islands', 'Europe', 'Nordic Countries', 1399.00, NULL, 43000, 78.4, 0.00, NULL, 'FÃ¸royar', 'Part of Denmark', 'Margrethe II', 901, 'FO'),
	('GAB', 'Gabon', 'Africa', 'Central Africa', 267668.00, 1960, 1226000, 50.1, 5493.00, 5279.00, 'Le Gabon', 'Republic', 'Omar Bongo', 902, 'GA'),
	('GMB', 'Gambia', 'Africa', 'Western Africa', 11295.00, 1965, 1305000, 53.2, 320.00, 325.00, 'The Gambia', 'Republic', 'Yahya Jammeh', 904, 'GM'),
	('GEO', 'Georgia', 'Asia', 'Middle East', 69700.00, 1991, 4968000, 64.5, 6064.00, 5924.00, 'Sakartvelo', 'Republic', 'Eduard Å evardnadze', 905, 'GE'),
	('GHA', 'Ghana', 'Africa', 'Western Africa', 238533.00, 1957, 20212000, 57.4, 7137.00, 6884.00, 'Ghana', 'Republic', 'John Kufuor', 910, 'GH'),
	('GIB', 'Gibraltar', 'Europe', 'Southern Europe', 6.00, NULL, 25000, 79.0, 258.00, NULL, 'Gibraltar', 'Dependent Territory of the UK', 'Elisabeth II', 915, 'GI'),
	('GRD', 'Grenada', 'North America', 'Caribbean', 344.00, 1974, 94000, 64.5, 318.00, NULL, 'Grenada', 'Constitutional Monarchy', 'Elisabeth II', 916, 'GD'),
	('GRL', 'Greenland', 'North America', 'North America', 2166090.00, NULL, 56000, 68.1, 0.00, NULL, 'Kalaallit Nunaat/GrÃ¸nland', 'Part of Denmark', 'Margrethe II', 917, 'GL'),
	('GLP', 'Guadeloupe', 'North America', 'Caribbean', 1705.00, NULL, 456000, 77.0, 3501.00, NULL, 'Guadeloupe', 'Overseas Department of France', 'Jacques Chirac', 919, 'GP'),
	('GUM', 'Guam', 'Oceania', 'Micronesia', 549.00, NULL, 168000, 77.8, 1197.00, 1136.00, 'Guam', 'US Territory', 'George W. Bush', 921, 'GU'),
	('GTM', 'Guatemala', 'North America', 'Central America', 108889.00, 1821, 11385000, 66.2, 19008.00, 17797.00, 'Guatemala', 'Republic', 'Alfonso Portillo Cabrera', 922, 'GT'),
	('GIN', 'Guinea', 'Africa', 'Western Africa', 245857.00, 1958, 7430000, 45.6, 2352.00, 2383.00, 'GuinÃ©e', 'Republic', 'Lansana ContÃ©', 926, 'GN'),
	('GNB', 'Guinea-Bissau', 'Africa', 'Western Africa', 36125.00, 1974, 1213000, 49.0, 293.00, 272.00, 'GuinÃ©-Bissau', 'Republic', 'Kumba IalÃ¡', 927, 'GW'),
	('GUY', 'Guyana', 'South America', 'South America', 214969.00, 1966, 861000, 64.0, 722.00, 743.00, 'Guyana', 'Republic', 'Bharrat Jagdeo', 928, 'GY'),
	('HTI', 'Haiti', 'North America', 'Caribbean', 27750.00, 1804, 8222000, 49.2, 3459.00, 3107.00, 'HaÃ¯ti/Dayti', 'Republic', 'Jean-Bertrand Aristide', 929, 'HT'),
	('HND', 'Honduras', 'North America', 'Central America', 112088.00, 1838, 6485000, 69.9, 5333.00, 4697.00, 'Honduras', 'Republic', 'Carlos Roberto Flores FacussÃ©', 933, 'HN'),
	('HKG', 'Hong Kong', 'Asia', 'Eastern Asia', 1075.00, NULL, 6782000, 79.5, 166448.00, 173610.00, 'Xianggang/Hong Kong', 'Special Administrative Region of China', 'Jiang Zemin', 937, 'HK'),
	('SJM', 'Svalbard and Jan Mayen', 'Europe', 'Nordic Countries', 62422.00, NULL, 3200, NULL, 0.00, NULL, 'Svalbard og Jan Mayen', 'Dependent Territory of Norway', 'Harald V', 938, 'SJ'),
	('IDN', 'Indonesia', 'Asia', 'Southeast Asia', 1904569.00, 1945, 212107000, 68.0, 84982.00, 215002.00, 'Indonesia', 'Republic', 'Abdurrahman Wahid', 939, 'ID'),
	('IND', 'India', 'Asia', 'Southern and Central Asia', 3287263.00, 1947, 1013662000, 62.5, 447114.00, 430572.00, 'Bharat/India', 'Federal Republic', 'Kocheril Raman Narayanan', 1109, 'IN'),
	('IRQ', 'Iraq', 'Asia', 'Middle East', 438317.00, 1932, 23115000, 66.5, 11500.00, NULL, 'Al-Â´Iraq', 'Republic', 'Saddam Hussein al-Takriti', 1365, 'IQ'),
	('IRN', 'Iran', 'Asia', 'Southern and Central Asia', 1648195.00, 1906, 67702000, 69.7, 195746.00, 160151.00, 'Iran', 'Islamic Republic', 'Ali Mohammad Khatami-Ardakani', 1380, 'IR'),
	('IRL', 'Ireland', 'Europe', 'British Islands', 70273.00, 1921, 3775100, 76.8, 75921.00, 73132.00, 'Ireland/Ã‰ire', 'Republic', 'Mary McAleese', 1447, 'IE'),
	('ISL', 'Iceland', 'Europe', 'Nordic Countries', 103000.00, 1944, 279000, 79.4, 8255.00, 7474.00, 'Ãsland', 'Republic', 'Ã“lafur Ragnar GrÃ­msson', 1449, 'IS'),
	('ISR', 'Israel', 'Asia', 'Middle East', 21056.00, 1948, 6217000, 78.6, 97477.00, 98577.00, 'Yisraâ€™el/Israâ€™il', 'Republic', 'Moshe Katzav', 1450, 'IL'),
	('ITA', 'Italy', 'Europe', 'Southern Europe', 301316.00, 1861, 57680000, 79.0, 1161755.00, 1145372.00, 'Italia', 'Republic', 'Carlo Azeglio Ciampi', 1464, 'IT'),
	('TMP', 'East Timor', 'Asia', 'Southeast Asia', 14874.00, NULL, 885000, 46.0, 0.00, NULL, 'Timor Timur', 'Administrated by the UN', 'JosÃ© Alexandre GusmÃ£o', 1522, 'TP'),
	('AUT', 'Austria', 'Europe', 'Western Europe', 83859.00, 1918, 8091800, 77.7, 211860.00, 206025.00, 'Ã–sterreich', 'Federal Republic', 'Thomas Klestil', 1523, 'AT'),
	('JAM', 'Jamaica', 'North America', 'Caribbean', 10990.00, 1962, 2583000, 75.2, 6871.00, 6722.00, 'Jamaica', 'Constitutional Monarchy', 'Elisabeth II', 1530, 'JM'),
	('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.00, -660, 126714000, 80.7, 3787042.00, 4192638.00, 'Nihon/Nippon', 'Constitutional Monarchy', 'Akihito', 1532, 'JP'),
	('YEM', 'Yemen', 'Asia', 'Middle East', 527968.00, 1918, 18112000, 59.8, 6041.00, 5729.00, 'Al-Yaman', 'Republic', 'Ali Abdallah Salih', 1780, 'YE'),
	('JOR', 'Jordan', 'Asia', 'Middle East', 88946.00, 1946, 5083000, 77.4, 7526.00, 7051.00, 'Al-Urdunn', 'Constitutional Monarchy', 'Abdullah II', 1786, 'JO'),
	('CXR', 'Christmas Island', 'Oceania', 'Australia and New Zealand', 135.00, NULL, 2500, NULL, 0.00, NULL, 'Christmas Island', 'Territory of Australia', 'Elisabeth II', 1791, 'CX'),
	('YUG', 'Yugoslavia', 'Europe', 'Southern Europe', 102173.00, 1918, 10640000, 72.4, 17000.00, NULL, 'Jugoslavija', 'Federal Republic', 'Vojislav KoÅ¡tunica', 1792, 'YU'),
	('KHM', 'Cambodia', 'Asia', 'Southeast Asia', 181035.00, 1953, 11168000, 56.5, 5121.00, 5670.00, 'KÃ¢mpuchÃ©a', 'Constitutional Monarchy', 'Norodom Sihanouk', 1800, 'KH'),
	('CMR', 'Cameroon', 'Africa', 'Central Africa', 475442.00, 1960, 15085000, 54.8, 9174.00, 8596.00, 'Cameroun/Cameroon', 'Republic', 'Paul Biya', 1804, 'CM'),
	('CAN', 'Canada', 'North America', 'North America', 9970610.00, 1867, 31147000, 79.4, 598862.00, 625626.00, 'Canada', 'Constitutional Monarchy, Federation', 'Elisabeth II', 1822, 'CA'),
	('CPV', 'Cape Verde', 'Africa', 'Western Africa', 4033.00, 1975, 428000, 68.9, 435.00, 420.00, 'Cabo Verde', 'Republic', 'AntÃ³nio Mascarenhas Monteiro', 1859, 'CV'),
	('KAZ', 'Kazakstan', 'Asia', 'Southern and Central Asia', 2724900.00, 1991, 16223000, 63.2, 24375.00, 23383.00, 'Qazaqstan', 'Republic', 'Nursultan Nazarbajev', 1864, 'KZ'),
	('KEN', 'Kenya', 'Africa', 'Eastern Africa', 580367.00, 1963, 30080000, 48.0, 9217.00, 10241.00, 'Kenya', 'Republic', 'Daniel arap Moi', 1881, 'KE'),
	('CAF', 'Central African Republic', 'Africa', 'Central Africa', 622984.00, 1960, 3615000, 44.0, 1054.00, 993.00, 'Centrafrique/BÃª-AfrÃ®ka', 'Republic', 'Ange-FÃ©lix PatassÃ©', 1889, 'CF'),
	('CHN', 'China', 'Asia', 'Eastern Asia', 9572900.00, -1523, 1277558000, 71.4, 982268.00, 917719.00, 'Zhongquo', 'People\'sRepublic', 'Jiang Zemin', 1891, 'CN'),
	('KGZ', 'Kyrgyzstan', 'Asia', 'Southern and Central Asia', 199900.00, 1991, 4699000, 63.4, 1626.00, 1767.00, 'Kyrgyzstan', 'Republic', 'Askar Akajev', 2253, 'KG'),
	('KIR', 'Kiribati', 'Oceania', 'Micronesia', 726.00, 1979, 83000, 59.8, 40.70, NULL, 'Kiribati', 'Republic', 'Teburoro Tito', 2256, 'KI'),
	('COL', 'Colombia', 'South America', 'South America', 1138914.00, 1810, 42321000, 70.3, 102896.00, 105116.00, 'Colombia', 'Republic', 'AndrÃ©s Pastrana Arango', 2257, 'CO'),
	('COM', 'Comoros', 'Africa', 'Eastern Africa', 1862.00, 1975, 578000, 60.0, 4401.00, 4361.00, 'Komori/Comores', 'Republic', 'Azali Assoumani', 2295, 'KM'),
	('COG', 'Congo', 'Africa', 'Central Africa', 342000.00, 1960, 2943000, 47.4, 2108.00, 2287.00, 'Congo', 'Republic', 'Denis Sassou-Nguesso', 2296, 'CG'),
	('COD', 'Congo, The Democratic Republic of the', 'Africa', 'Central Africa', 2344858.00, 1960, 51654000, 48.8, 6964.00, 2474.00, 'RÃ©publique DÃ©mocratique du Congo', 'Republic', 'Joseph Kabila', 2298, 'CD'),
	('CCK', 'Cocos (Keeling) Islands', 'Oceania', 'Australia and New Zealand', 14.00, NULL, 600, NULL, 0.00, NULL, 'Cocos (Keeling) Islands', 'Territory of Australia', 'Elisabeth II', 2317, 'CC'),
	('PRK', 'North Korea', 'Asia', 'Eastern Asia', 120538.00, 1948, 24039000, 70.7, 5332.00, NULL, 'Choson Minjujuui InÂ´min Konghwaguk (Bukhan)', 'Socialistic Republic', 'Kim Jong-il', 2318, 'KP'),
	('KOR', 'South Korea', 'Asia', 'Eastern Asia', 99434.00, 1948, 46844000, 74.4, 320749.00, 442544.00, 'Taehan Minâ€™guk (Namhan)', 'Republic', 'Kim Dae-jung', 2331, 'KR'),
	('GRC', 'Greece', 'Europe', 'Southern Europe', 131626.00, 1830, 10545700, 78.4, 120724.00, 119946.00, 'EllÃ¡da', 'Republic', 'Kostis Stefanopoulos', 2401, 'GR'),
	('HRV', 'Croatia', 'Europe', 'Southern Europe', 56538.00, 1991, 4473000, 73.7, 20208.00, 19300.00, 'Hrvatska', 'Republic', 'Å tipe Mesic', 2409, 'HR'),
	('CUB', 'Cuba', 'North America', 'Caribbean', 110861.00, 1902, 11201000, 76.2, 17843.00, 18862.00, 'Cuba', 'Socialistic Republic', 'Fidel Castro Ruz', 2413, 'CU'),
	('KWT', 'Kuwait', 'Asia', 'Middle East', 17818.00, 1961, 1972000, 76.1, 27037.00, 30373.00, 'Al-Kuwayt', 'Constitutional Monarchy (Emirate)', 'Jabir al-Ahmad al-Jabir al-Sabah', 2429, 'KW'),
	('CYP', 'Cyprus', 'Asia', 'Middle East', 9251.00, 1960, 754700, 76.7, 9333.00, 8246.00, 'KÃ½pros/Kibris', 'Republic', 'Glafkos Klerides', 2430, 'CY'),
	('LAO', 'Laos', 'Asia', 'Southeast Asia', 236800.00, 1953, 5433000, 53.1, 1292.00, 1746.00, 'Lao', 'Republic', 'Khamtay Siphandone', 2432, 'LA'),
	('LVA', 'Latvia', 'Europe', 'Baltic Countries', 64589.00, 1991, 2424200, 68.4, 6398.00, 5639.00, 'Latvija', 'Republic', 'Vaira Vike-Freiberga', 2434, 'LV'),
	('LSO', 'Lesotho', 'Africa', 'Southern Africa', 30355.00, 1966, 2153000, 50.8, 1061.00, 1161.00, 'Lesotho', 'Constitutional Monarchy', 'Letsie III', 2437, 'LS'),
	('LBN', 'Lebanon', 'Asia', 'Middle East', 10400.00, 1941, 3282000, 71.3, 17121.00, 15129.00, 'Lubnan', 'Republic', 'Ã‰mile Lahoud', 2438, 'LB'),
	('LBR', 'Liberia', 'Africa', 'Western Africa', 111369.00, 1847, 3154000, 51.0, 2012.00, NULL, 'Liberia', 'Republic', 'Charles Taylor', 2440, 'LR'),
	('LBY', 'Libyan Arab Jamahiriya', 'Africa', 'Northern Africa', 1759540.00, 1951, 5605000, 75.5, 44806.00, 40562.00, 'Libiya', 'Socialistic State', 'Muammar al-Qadhafi', 2441, 'LY'),
	('LIE', 'Liechtenstein', 'Europe', 'Western Europe', 160.00, 1806, 32300, 78.8, 1119.00, 1084.00, 'Liechtenstein', 'Constitutional Monarchy', 'Hans-Adam II', 2446, 'LI'),
	('LTU', 'Lithuania', 'Europe', 'Baltic Countries', 65301.00, 1991, 3698500, 69.1, 10692.00, 9585.00, 'Lietuva', 'Republic', 'Valdas Adamkus', 2447, 'LT'),
	('LUX', 'Luxembourg', 'Europe', 'Western Europe', 2586.00, 1867, 435700, 77.1, 16321.00, 15519.00, 'Luxembourg/LÃ«tzebuerg', 'Constitutional Monarchy', 'Henri', 2452, 'LU'),
	('ESH', 'Western Sahara', 'Africa', 'Northern Africa', 266000.00, NULL, 293000, 49.8, 60.00, NULL, 'As-Sahrawiya', 'Occupied by Marocco', 'Mohammed Abdel Aziz', 2453, 'EH'),
	('MAC', 'Macao', 'Asia', 'Eastern Asia', 18.00, NULL, 473000, 81.6, 5749.00, 5940.00, 'Macau/Aomen', 'Special Administrative Region of China', 'Jiang Zemin', 2454, 'MO'),
	('MDG', 'Madagascar', 'Africa', 'Eastern Africa', 587041.00, 1960, 15942000, 55.0, 3750.00, 3545.00, 'Madagasikara/Madagascar', 'Federal Republic', 'Didier Ratsiraka', 2455, 'MG'),
	('MKD', 'Macedonia', 'Europe', 'Southern Europe', 25713.00, 1991, 2024000, 73.8, 1694.00, 1915.00, 'Makedonija', 'Republic', 'Boris Trajkovski', 2460, 'MK'),
	('MWI', 'Malawi', 'Africa', 'Eastern Africa', 118484.00, 1964, 10925000, 37.6, 1687.00, 2527.00, 'Malawi', 'Republic', 'Bakili Muluzi', 2462, 'MW'),
	('MDV', 'Maldives', 'Asia', 'Southern and Central Asia', 298.00, 1965, 286000, 62.2, 199.00, NULL, 'Dhivehi Raajje/Maldives', 'Republic', 'Maumoon Abdul Gayoom', 2463, 'MV'),
	('MYS', 'Malaysia', 'Asia', 'Southeast Asia', 329758.00, 1957, 22244000, 70.8, 69213.00, 97884.00, 'Malaysia', 'Constitutional Monarchy, Federation', 'Salahuddin Abdul Aziz Shah Alhaj', 2464, 'MY'),
	('MLI', 'Mali', 'Africa', 'Western Africa', 1240192.00, 1960, 11234000, 46.7, 2642.00, 2453.00, 'Mali', 'Republic', 'Alpha Oumar KonarÃ©', 2482, 'ML'),
	('MLT', 'Malta', 'Europe', 'Southern Europe', 316.00, 1964, 380200, 77.9, 3512.00, 3338.00, 'Malta', 'Republic', 'Guido de Marco', 2484, 'MT'),
	('MAR', 'Morocco', 'Africa', 'Northern Africa', 446550.00, 1956, 28351000, 69.1, 36124.00, 33514.00, 'Al-Maghrib', 'Constitutional Monarchy', 'Mohammed VI', 2486, 'MA'),
	('MHL', 'Marshall Islands', 'Oceania', 'Micronesia', 181.00, 1990, 64000, 65.5, 97.00, NULL, 'Marshall Islands/Majol', 'Republic', 'Kessai Note', 2507, 'MH'),
	('MTQ', 'Martinique', 'North America', 'Caribbean', 1102.00, NULL, 395000, 78.3, 2731.00, 2559.00, 'Martinique', 'Overseas Department of France', 'Jacques Chirac', 2508, 'MQ'),
	('MRT', 'Mauritania', 'Africa', 'Western Africa', 1025520.00, 1960, 2670000, 50.8, 998.00, 1081.00, 'Muritaniya/Mauritanie', 'Republic', 'Maaouiya Ould SidÂ´Ahmad Taya', 2509, 'MR'),
	('MUS', 'Mauritius', 'Africa', 'Eastern Africa', 2040.00, 1968, 1158000, 71.0, 4251.00, 4186.00, 'Mauritius', 'Republic', 'Cassam Uteem', 2511, 'MU'),
	('MYT', 'Mayotte', 'Africa', 'Eastern Africa', 373.00, NULL, 149000, 59.5, 0.00, NULL, 'Mayotte', 'Territorial Collectivity of France', 'Jacques Chirac', 2514, 'YT'),
	('MEX', 'Mexico', 'North America', 'Central America', 1958201.00, 1810, 98881000, 71.5, 414972.00, 401461.00, 'MÃ©xico', 'Federal Republic', 'Vicente Fox Quesada', 2515, 'MX'),
	('FSM', 'Micronesia, Federated States of', 'Oceania', 'Micronesia', 702.00, 1990, 119000, 68.6, 212.00, NULL, 'Micronesia', 'Federal Republic', 'Leo A. Falcam', 2689, 'FM'),
	('MDA', 'Moldova', 'Europe', 'Eastern Europe', 33851.00, 1991, 4380000, 64.5, 1579.00, 1872.00, 'Moldova', 'Republic', 'Vladimir Voronin', 2690, 'MD'),
	('MCO', 'Monaco', 'Europe', 'Western Europe', 1.50, 1861, 34000, 78.8, 776.00, NULL, 'Monaco', 'Constitutional Monarchy', 'Rainier III', 2695, 'MC'),
	('MNG', 'Mongolia', 'Asia', 'Eastern Asia', 1566500.00, 1921, 2662000, 67.3, 1043.00, 933.00, 'Mongol Uls', 'Republic', 'Natsagiin Bagabandi', 2696, 'MN'),
	('MSR', 'Montserrat', 'North America', 'Caribbean', 102.00, NULL, 11000, 78.0, 109.00, NULL, 'Montserrat', 'Dependent Territory of the UK', 'Elisabeth II', 2697, 'MS'),
	('MOZ', 'Mozambique', 'Africa', 'Eastern Africa', 801590.00, 1975, 19680000, 37.5, 2891.00, 2711.00, 'MoÃ§ambique', 'Republic', 'JoaquÃ­m A. Chissano', 2698, 'MZ'),
	('MMR', 'Myanmar', 'Asia', 'Southeast Asia', 676578.00, 1948, 45611000, 54.9, 180375.00, 171028.00, 'Myanma Pye', 'Republic', 'kenraali Than Shwe', 2710, 'MM'),
	('NAM', 'Namibia', 'Africa', 'Southern Africa', 824292.00, 1990, 1726000, 42.5, 3101.00, 3384.00, 'Namibia', 'Republic', 'Sam Nujoma', 2726, 'NA'),
	('NRU', 'Nauru', 'Oceania', 'Micronesia', 21.00, 1968, 12000, 60.8, 197.00, NULL, 'Naoero/Nauru', 'Republic', 'Bernard Dowiyogo', 2728, 'NR'),
	('NPL', 'Nepal', 'Asia', 'Southern and Central Asia', 147181.00, 1769, 23930000, 57.8, 4768.00, 4837.00, 'Nepal', 'Constitutional Monarchy', 'Gyanendra Bir Bikram', 2729, 'NP'),
	('NIC', 'Nicaragua', 'North America', 'Central America', 130000.00, 1838, 5074000, 68.7, 1988.00, 2023.00, 'Nicaragua', 'Republic', 'Arnoldo AlemÃ¡n Lacayo', 2734, 'NI'),
	('NER', 'Niger', 'Africa', 'Western Africa', 1267000.00, 1960, 10730000, 41.3, 1706.00, 1580.00, 'Niger', 'Republic', 'Mamadou Tandja', 2738, 'NE'),
	('NGA', 'Nigeria', 'Africa', 'Western Africa', 923768.00, 1960, 111506000, 51.6, 65707.00, 58623.00, 'Nigeria', 'Federal Republic', 'Olusegun Obasanjo', 2754, 'NG'),
	('NIU', 'Niue', 'Oceania', 'Polynesia', 260.00, NULL, 2000, NULL, 0.00, NULL, 'Niue', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 2805, 'NU'),
	('NFK', 'Norfolk Island', 'Oceania', 'Australia and New Zealand', 36.00, NULL, 2000, NULL, 0.00, NULL, 'Norfolk Island', 'Territory of Australia', 'Elisabeth II', 2806, 'NF'),
	('NOR', 'Norway', 'Europe', 'Nordic Countries', 323877.00, 1905, 4478500, 78.7, 145895.00, 153370.00, 'Norge', 'Constitutional Monarchy', 'Harald V', 2807, 'NO'),
	('CIV', 'CÃ´te dâ€™Ivoire', 'Africa', 'Western Africa', 322463.00, 1960, 14786000, 45.2, 11345.00, 10285.00, 'CÃ´te dâ€™Ivoire', 'Republic', 'Laurent Gbagbo', 2814, 'CI'),
	('OMN', 'Oman', 'Asia', 'Middle East', 309500.00, 1951, 2542000, 71.8, 16904.00, 16153.00, 'Â´Uman', 'Monarchy (Sultanate)', 'Qabus ibn SaÂ´id', 2821, 'OM'),
	('PAK', 'Pakistan', 'Asia', 'Southern and Central Asia', 796095.00, 1947, 156483000, 61.1, 61289.00, 58549.00, 'Pakistan', 'Republic', 'Mohammad Rafiq Tarar', 2831, 'PK'),
	('PLW', 'Palau', 'Oceania', 'Micronesia', 459.00, 1994, 19000, 68.6, 105.00, NULL, 'Belau/Palau', 'Republic', 'Kuniwo Nakamura', 2881, 'PW'),
	('PAN', 'Panama', 'North America', 'Central America', 75517.00, 1903, 2856000, 75.5, 9131.00, 8700.00, 'PanamÃ¡', 'Republic', 'Mireya Elisa Moscoso RodrÃ­guez', 2882, 'PA'),
	('PNG', 'Papua New Guinea', 'Oceania', 'Melanesia', 462840.00, 1975, 4807000, 63.1, 4988.00, 6328.00, 'Papua New Guinea/Papua Niugini', 'Constitutional Monarchy', 'Elisabeth II', 2884, 'PG'),
	('PRY', 'Paraguay', 'South America', 'South America', 406752.00, 1811, 5496000, 73.7, 8444.00, 9555.00, 'Paraguay', 'Republic', 'Luis Ãngel GonzÃ¡lez Macchi', 2885, 'PY'),
	('PER', 'Peru', 'South America', 'South America', 1285216.00, 1821, 25662000, 70.0, 64140.00, 65186.00, 'PerÃº/Piruw', 'Republic', 'Valentin Paniagua Corazao', 2890, 'PE'),
	('PCN', 'Pitcairn', 'Oceania', 'Polynesia', 49.00, NULL, 50, NULL, 0.00, NULL, 'Pitcairn', 'Dependent Territory of the UK', 'Elisabeth II', 2912, 'PN'),
	('MNP', 'Northern Mariana Islands', 'Oceania', 'Micronesia', 464.00, NULL, 78000, 75.5, 0.00, NULL, 'Northern Mariana Islands', 'Commonwealth of the US', 'George W. Bush', 2913, 'MP'),
	('PRT', 'Portugal', 'Europe', 'Southern Europe', 91982.00, 1143, 9997600, 75.8, 105954.00, 102133.00, 'Portugal', 'Republic', 'Jorge SampÃ£io', 2914, 'PT'),
	('PRI', 'Puerto Rico', 'North America', 'Caribbean', 8875.00, NULL, 3869000, 75.6, 34100.00, 32100.00, 'Puerto Rico', 'Commonwealth of the US', 'George W. Bush', 2919, 'PR'),
	('POL', 'Poland', 'Europe', 'Eastern Europe', 323250.00, 1918, 38653600, 73.2, 151697.00, 135636.00, 'Polska', 'Republic', 'Aleksander Kwasniewski', 2928, 'PL'),
	('GNQ', 'Equatorial Guinea', 'Africa', 'Central Africa', 28051.00, 1968, 453000, 53.6, 283.00, 542.00, 'Guinea Ecuatorial', 'Republic', 'Teodoro Obiang Nguema Mbasogo', 2972, 'GQ'),
	('QAT', 'Qatar', 'Asia', 'Middle East', 11000.00, 1971, 599000, 72.4, 9472.00, 8920.00, 'Qatar', 'Monarchy', 'Hamad ibn Khalifa al-Thani', 2973, 'QA'),
	('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 843, 59225700, 78.8, 1424285.00, 1392448.00, 'France', 'Republic', 'Jacques Chirac', 2974, 'FR'),
	('GUF', 'French Guiana', 'South America', 'South America', 90000.00, NULL, 181000, 76.1, 681.00, NULL, 'Guyane franÃ§aise', 'Overseas Department of France', 'Jacques Chirac', 3014, 'GF'),
	('PYF', 'French Polynesia', 'Oceania', 'Polynesia', 4000.00, NULL, 235000, 74.8, 818.00, 781.00, 'PolynÃ©sie franÃ§aise', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3016, 'PF'),
	('REU', 'RÃ©union', 'Africa', 'Eastern Africa', 2510.00, NULL, 699000, 72.7, 8287.00, 7988.00, 'RÃ©union', 'Overseas Department of France', 'Jacques Chirac', 3017, 'RE'),
	('ROM', 'Romania', 'Europe', 'Eastern Europe', 238391.00, 1878, 22455500, 69.9, 38158.00, 34843.00, 'RomÃ¢nia', 'Republic', 'Ion Iliescu', 3018, 'RO'),
	('RWA', 'Rwanda', 'Africa', 'Eastern Africa', 26338.00, 1962, 7733000, 39.3, 2036.00, 1863.00, 'Rwanda/Urwanda', 'Republic', 'Paul Kagame', 3047, 'RW'),
	('SWE', 'Sweden', 'Europe', 'Nordic Countries', 449964.00, 836, 8861400, 79.6, 226492.00, 227757.00, 'Sverige', 'Constitutional Monarchy', 'Carl XVI Gustaf', 3048, 'SE'),
	('SHN', 'Saint Helena', 'Africa', 'Western Africa', 314.00, NULL, 6000, 76.8, 0.00, NULL, 'Saint Helena', 'Dependent Territory of the UK', 'Elisabeth II', 3063, 'SH'),
	('KNA', 'Saint Kitts and Nevis', 'North America', 'Caribbean', 261.00, 1983, 38000, 70.7, 299.00, NULL, 'Saint Kitts and Nevis', 'Constitutional Monarchy', 'Elisabeth II', 3064, 'KN'),
	('LCA', 'Saint Lucia', 'North America', 'Caribbean', 622.00, 1979, 154000, 72.3, 571.00, NULL, 'Saint Lucia', 'Constitutional Monarchy', 'Elisabeth II', 3065, 'LC'),
	('VCT', 'Saint Vincent and the Grenadines', 'North America', 'Caribbean', 388.00, 1979, 114000, 72.3, 285.00, NULL, 'Saint Vincent and the Grenadines', 'Constitutional Monarchy', 'Elisabeth II', 3066, 'VC'),
	('SPM', 'Saint Pierre and Miquelon', 'North America', 'North America', 242.00, NULL, 7000, 77.6, 0.00, NULL, 'Saint-Pierre-et-Miquelon', 'Territorial Collectivity of France', 'Jacques Chirac', 3067, 'PM'),
	('DEU', 'Germany', 'Europe', 'Western Europe', 357022.00, 1955, 82164700, 77.4, 2133367.00, 2102826.00, 'Deutschland', 'Federal Republic', 'Johannes Rau', 3068, 'DE'),
	('SLB', 'Solomon Islands', 'Oceania', 'Melanesia', 28896.00, 1978, 444000, 71.3, 182.00, 220.00, 'Solomon Islands', 'Constitutional Monarchy', 'Elisabeth II', 3161, 'SB'),
	('ZMB', 'Zambia', 'Africa', 'Eastern Africa', 752618.00, 1964, 9169000, 37.2, 3377.00, 3922.00, 'Zambia', 'Republic', 'Frederick Chiluba', 3162, 'ZM'),
	('WSM', 'Samoa', 'Oceania', 'Polynesia', 2831.00, 1962, 180000, 69.2, 141.00, 157.00, 'Samoa', 'Parlementary Monarchy', 'Malietoa Tanumafili II', 3169, 'WS'),
	('SMR', 'San Marino', 'Europe', 'Southern Europe', 61.00, 885, 27000, 81.1, 510.00, NULL, 'San Marino', 'Republic', NULL, 3171, 'SM'),
	('STP', 'Sao Tome and Principe', 'Africa', 'Central Africa', 964.00, 1975, 147000, 65.3, 6.00, NULL, 'SÃ£o TomÃ© e PrÃ­ncipe', 'Republic', 'Miguel Trovoada', 3172, 'ST'),
	('SAU', 'Saudi Arabia', 'Asia', 'Middle East', 2149690.00, 1932, 21607000, 67.8, 137635.00, 146171.00, 'Al-Â´Arabiya as-SaÂ´udiya', 'Monarchy', 'Fahd ibn Abdul-Aziz al-SaÂ´ud', 3173, 'SA'),
	('SEN', 'Senegal', 'Africa', 'Western Africa', 196722.00, 1960, 9481000, 62.2, 4787.00, 4542.00, 'SÃ©nÃ©gal/Sounougal', 'Republic', 'Abdoulaye Wade', 3198, 'SN'),
	('SYC', 'Seychelles', 'Africa', 'Eastern Africa', 455.00, 1976, 77000, 70.4, 536.00, 539.00, 'Sesel/Seychelles', 'Republic', 'France-Albert RenÃ©', 3206, 'SC'),
	('SLE', 'Sierra Leone', 'Africa', 'Western Africa', 71740.00, 1961, 4854000, 45.3, 746.00, 858.00, 'Sierra Leone', 'Republic', 'Ahmed Tejan Kabbah', 3207, 'SL'),
	('SGP', 'Singapore', 'Asia', 'Southeast Asia', 618.00, 1965, 3567000, 80.1, 86503.00, 96318.00, 'Singapore/Singapura/Xinjiapo/Singapur', 'Republic', 'Sellapan Rama Nathan', 3208, 'SG'),
	('SVK', 'Slovakia', 'Europe', 'Eastern Europe', 49012.00, 1993, 5398700, 73.7, 20594.00, 19452.00, 'Slovensko', 'Republic', 'Rudolf Schuster', 3209, 'SK'),
	('SVN', 'Slovenia', 'Europe', 'Southern Europe', 20256.00, 1991, 1987800, 74.9, 19756.00, 18202.00, 'Slovenija', 'Republic', 'Milan Kucan', 3212, 'SI'),
	('SOM', 'Somalia', 'Africa', 'Eastern Africa', 637657.00, 1960, 10097000, 46.2, 935.00, NULL, 'Soomaaliya', 'Republic', 'Abdiqassim Salad Hassan', 3214, 'SO'),
	('LKA', 'Sri Lanka', 'Asia', 'Southern and Central Asia', 65610.00, 1948, 18827000, 71.8, 15706.00, 15091.00, 'Sri Lanka/Ilankai', 'Republic', 'Chandrika Kumaratunga', 3217, 'LK'),
	('SDN', 'Sudan', 'Africa', 'Northern Africa', 2505813.00, 1956, 29490000, 56.6, 10162.00, NULL, 'As-Sudan', 'Islamic Republic', 'Omar Hassan Ahmad al-Bashir', 3225, 'SD'),
	('FIN', 'Finland', 'Europe', 'Nordic Countries', 338145.00, 1917, 5171300, 77.4, 121914.00, 119833.00, 'Suomi', 'Republic', 'Tarja Halonen', 3236, 'FI'),
	('SUR', 'Suriname', 'South America', 'South America', 163265.00, 1975, 417000, 71.4, 870.00, 706.00, 'Suriname', 'Republic', 'Ronald Venetiaan', 3243, 'SR'),
	('SWZ', 'Swaziland', 'Africa', 'Southern Africa', 17364.00, 1968, 1008000, 40.4, 1206.00, 1312.00, 'kaNgwane', 'Monarchy', 'Mswati III', 3244, 'SZ'),
	('CHE', 'Switzerland', 'Europe', 'Western Europe', 41284.00, 1499, 7160400, 79.6, 264478.00, 256092.00, 'Schweiz/Suisse/Svizzera/Svizra', 'Federation', 'Adolf Ogi', 3248, 'CH'),
	('SYR', 'Syria', 'Asia', 'Middle East', 185180.00, 1941, 16125000, 68.5, 65984.00, 64926.00, 'Suriya', 'Republic', 'Bashar al-Assad', 3250, 'SY'),
	('TJK', 'Tajikistan', 'Asia', 'Southern and Central Asia', 143100.00, 1991, 6188000, 64.1, 1990.00, 1056.00, 'ToÃ§ikiston', 'Republic', 'Emomali Rahmonov', 3261, 'TJ'),
	('TWN', 'Taiwan', 'Asia', 'Eastern Asia', 36188.00, 1945, 22256000, 76.4, 256254.00, 263451.00, 'Tâ€™ai-wan', 'Republic', 'Chen Shui-bian', 3263, 'TW'),
	('TZA', 'Tanzania', 'Africa', 'Eastern Africa', 883749.00, 1961, 33517000, 52.3, 8005.00, 7388.00, 'Tanzania', 'Republic', 'Benjamin William Mkapa', 3306, 'TZ'),
	('DNK', 'Denmark', 'Europe', 'Nordic Countries', 43094.00, 800, 5330000, 76.5, 174099.00, 169264.00, 'Danmark', 'Constitutional Monarchy', 'Margrethe II', 3315, 'DK'),
	('THA', 'Thailand', 'Asia', 'Southeast Asia', 513115.00, 1350, 61399000, 68.6, 116416.00, 153907.00, 'Prathet Thai', 'Constitutional Monarchy', 'Bhumibol Adulyadej', 3320, 'TH'),
	('TGO', 'Togo', 'Africa', 'Western Africa', 56785.00, 1960, 4629000, 54.7, 1449.00, 1400.00, 'Togo', 'Republic', 'GnassingbÃ© EyadÃ©ma', 3332, 'TG'),
	('TKL', 'Tokelau', 'Oceania', 'Polynesia', 12.00, NULL, 2000, NULL, 0.00, NULL, 'Tokelau', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 3333, 'TK'),
	('TON', 'Tonga', 'Oceania', 'Polynesia', 650.00, 1970, 99000, 67.9, 146.00, 170.00, 'Tonga', 'Monarchy', 'Taufa\'ahau Tupou IV', 3334, 'TO'),
	('TTO', 'Trinidad and Tobago', 'North America', 'Caribbean', 5130.00, 1962, 1295000, 68.0, 6232.00, 5867.00, 'Trinidad and Tobago', 'Republic', 'Arthur N. R. Robinson', 3336, 'TT'),
	('TCD', 'Chad', 'Africa', 'Central Africa', 1284000.00, 1960, 7651000, 50.5, 1208.00, 1102.00, 'Tchad/Tshad', 'Republic', 'Idriss DÃ©by', 3337, 'TD'),
	('CZE', 'Czech Republic', 'Europe', 'Eastern Europe', 78866.00, 1993, 10278100, 74.5, 55017.00, 52037.00, 'Â¸esko', 'Republic', 'VÃ¡clav Havel', 3339, 'CZ'),
	('TUN', 'Tunisia', 'Africa', 'Northern Africa', 163610.00, 1956, 9586000, 73.7, 20026.00, 18898.00, 'Tunis/Tunisie', 'Republic', 'Zine al-Abidine Ben Ali', 3349, 'TN'),
	('TUR', 'Turkey', 'Asia', 'Middle East', 774815.00, 1923, 66591000, 71.0, 210721.00, 189122.00, 'TÃ¼rkiye', 'Republic', 'Ahmet Necdet Sezer', 3358, 'TR'),
	('TKM', 'Turkmenistan', 'Asia', 'Southern and Central Asia', 488100.00, 1991, 4459000, 60.9, 4397.00, 2000.00, 'TÃ¼rkmenostan', 'Republic', 'Saparmurad Nijazov', 3419, 'TM'),
	('TCA', 'Turks and Caicos Islands', 'North America', 'Caribbean', 430.00, NULL, 17000, 73.3, 96.00, NULL, 'The Turks and Caicos Islands', 'Dependent Territory of the UK', 'Elisabeth II', 3423, 'TC'),
	('TUV', 'Tuvalu', 'Oceania', 'Polynesia', 26.00, 1978, 12000, 66.3, 6.00, NULL, 'Tuvalu', 'Constitutional Monarchy', 'Elisabeth II', 3424, 'TV'),
	('UGA', 'Uganda', 'Africa', 'Eastern Africa', 241038.00, 1962, 21778000, 42.9, 6313.00, 6887.00, 'Uganda', 'Republic', 'Yoweri Museveni', 3425, 'UG'),
	('UKR', 'Ukraine', 'Europe', 'Eastern Europe', 603700.00, 1991, 50456000, 66.0, 42168.00, 49677.00, 'Ukrajina', 'Republic', 'Leonid KutÅ¡ma', 3426, 'UA'),
	('HUN', 'Hungary', 'Europe', 'Eastern Europe', 93030.00, 1918, 10043200, 71.4, 48267.00, 45914.00, 'MagyarorszÃ¡g', 'Republic', 'Ferenc MÃ¡dl', 3483, 'HU'),
	('URY', 'Uruguay', 'South America', 'South America', 175016.00, 1828, 3337000, 75.2, 20831.00, 19967.00, 'Uruguay', 'Republic', 'Jorge Batlle IbÃ¡Ã±ez', 3492, 'UY'),
	('NCL', 'New Caledonia', 'Oceania', 'Melanesia', 18575.00, NULL, 214000, 72.8, 3563.00, NULL, 'Nouvelle-CalÃ©donie', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3493, 'NC'),
	('NZL', 'New Zealand', 'Oceania', 'Australia and New Zealand', 270534.00, 1907, 3862000, 77.8, 54669.00, 64960.00, 'New Zealand/Aotearoa', 'Constitutional Monarchy', 'Elisabeth II', 3499, 'NZ'),
	('UZB', 'Uzbekistan', 'Asia', 'Southern and Central Asia', 447400.00, 1991, 24318000, 63.7, 14194.00, 21300.00, 'Uzbekiston', 'Republic', 'Islam Karimov', 3503, 'UZ'),
	('BLR', 'Belarus', 'Europe', 'Eastern Europe', 207600.00, 1991, 10236000, 68.0, 13714.00, NULL, 'Belarus', 'Republic', 'Aljaksandr LukaÅ¡enka', 3520, 'BY'),
	('WLF', 'Wallis and Futuna', 'Oceania', 'Polynesia', 200.00, NULL, 15000, NULL, 0.00, NULL, 'Wallis-et-Futuna', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3536, 'WF'),
	('VUT', 'Vanuatu', 'Oceania', 'Melanesia', 12189.00, 1980, 190000, 60.6, 261.00, 246.00, 'Vanuatu', 'Republic', 'John Bani', 3537, 'VU'),
	('VAT', 'Holy See (Vatican City State)', 'Europe', 'Southern Europe', 0.40, 1929, 1000, NULL, 9.00, NULL, 'Santa Sede/CittÃ  del Vaticano', 'Independent Church State', 'Johannes Paavali II', 3538, 'VA'),
	('VEN', 'Venezuela', 'South America', 'South America', 912050.00, 1811, 24170000, 73.1, 95023.00, 88434.00, 'Venezuela', 'Federal Republic', 'Hugo ChÃ¡vez FrÃ­as', 3539, 'VE'),
	('RUS', 'Russian Federation', 'Europe', 'Eastern Europe', 17075400.00, 1991, 146934000, 67.2, 276608.00, 442989.00, 'Rossija', 'Federal Republic', 'Vladimir Putin', 3580, 'RU'),
	('VNM', 'Vietnam', 'Asia', 'Southeast Asia', 331689.00, 1945, 79832000, 69.3, 21929.00, 22834.00, 'ViÃªt Nam', 'Socialistic Republic', 'TrÃ¢n Duc Luong', 3770, 'VN'),
	('EST', 'Estonia', 'Europe', 'Baltic Countries', 45227.00, 1991, 1439200, 69.5, 5328.00, 3371.00, 'Eesti', 'Republic', 'Lennart Meri', 3791, 'EE'),
	('USA', 'United States', 'North America', 'North America', 9363520.00, 1776, 278357000, 77.1, 8510700.00, 8110900.00, 'United States', 'Federal Republic', 'George W. Bush', 3813, 'US'),
	('VIR', 'Virgin Islands, U.S.', 'North America', 'Caribbean', 347.00, NULL, 93000, 78.1, 0.00, NULL, 'Virgin Islands of the United States', 'US Territory', 'George W. Bush', 4067, 'VI'),
	('ZWE', 'Zimbabwe', 'Africa', 'Eastern Africa', 390757.00, 1980, 11669000, 37.8, 5951.00, 8670.00, 'Zimbabwe', 'Republic', 'Robert G. Mugabe', 4068, 'ZW'),
	('PSE', 'Palestine', 'Asia', 'Middle East', 6257.00, NULL, 3101000, 71.4, 4173.00, NULL, 'Filastin', 'Autonomous Area', 'Yasser (Yasir) Arafat', 4074, 'PS'),
	('ATA', 'Antarctica', 'Antarctica', 'Antarctica', 13120000.00, NULL, 0, NULL, 0.00, NULL, 'â€“', 'Co-administrated', '', NULL, 'AQ'),
	('BVT', 'Bouvet Island', 'Antarctica', 'Antarctica', 59.00, NULL, 0, NULL, 0.00, NULL, 'BouvetÃ¸ya', 'Dependent Territory of Norway', 'Harald V', NULL, 'BV'),
	('IOT', 'British Indian Ocean Territory', 'Africa', 'Eastern Africa', 78.00, NULL, 0, NULL, 0.00, NULL, 'British Indian Ocean Territory', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'IO'),
	('SGS', 'South Georgia and the South Sandwich Islands', 'Antarctica', 'Antarctica', 3903.00, NULL, 0, NULL, 0.00, NULL, 'South Georgia and the South Sandwich Islands', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'GS'),
	('HMD', 'Heard Island and McDonald Islands', 'Antarctica', 'Antarctica', 359.00, NULL, 0, NULL, 0.00, NULL, 'Heard and McDonald Islands', 'Territory of Australia', 'Elisabeth II', NULL, 'HM'),
	('ATF', 'French Southern territories', 'Antarctica', 'Antarctica', 7780.00, NULL, 0, NULL, 0.00, NULL, 'Terres australes franÃ§aises', 'Nonmetropolitan Territory of France', 'Jacques Chirac', NULL, 'TF'),
	('UMI', 'United States Minor Outlying Islands', 'Oceania', 'Micronesia/Caribbean', 16.00, NULL, 0, NULL, 0.00, NULL, 'United States Minor Outlying Islands', 'Dependent Territory of the US', 'George W. Bush', NULL, 'UM');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_invoice
DROP TABLE IF EXISTS `customer_invoice`;
CREATE TABLE IF NOT EXISTS `customer_invoice` (
  `idcustomer_invoice` bigint(20) NOT NULL AUTO_INCREMENT,
  `plan_id` bigint(20) DEFAULT NULL,
  `hf_id` bigint(20) DEFAULT '0',
  `invoice_number` varchar(50) DEFAULT '0',
  `cartsessionid` varchar(255) DEFAULT '0',
  `particulars` text,
  `amount` float DEFAULT '0',
  `setupfee` float DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT '0',
  `transaction_id` varchar(50) DEFAULT '0',
  `status_message` text,
  `invoice_date` date DEFAULT NULL,
  `paypal_string` text,
  `subscription_amount` float DEFAULT NULL,
  `subscr_id` varchar(100) DEFAULT NULL,
  `discount_percentage` float DEFAULT NULL,
  `discount_amount` float DEFAULT NULL,
  PRIMARY KEY (`idcustomer_invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1 COMMENT='Invoice Details of Customers';

-- Dumping data for table hosted_emr.customer_invoice: ~2 rows (approximately)
DELETE FROM `customer_invoice`;
/*!40000 ALTER TABLE `customer_invoice` DISABLE KEYS */;
INSERT INTO `customer_invoice` (`idcustomer_invoice`, `plan_id`, `hf_id`, `invoice_number`, `cartsessionid`, `particulars`, `amount`, `setupfee`, `payment_date`, `payment_status`, `transaction_id`, `status_message`, `invoice_date`, `paypal_string`, `subscription_amount`, `subscr_id`, `discount_percentage`, `discount_amount`) VALUES
	(47, 15, 94, 'ZH-2012-05-04-00047', 'uk3g1c5b2r967u08228tbjor67', 'Plan 2 Subscription,', 520, 1650, '2012-05-04', 'Pending', '84K33310XA658723D', 'Pending', '2012-05-04', 'cmd=_notify-validate&transaction_subject=Plan+2+Subscription%2C&txn_type=subscr_payment&payment_date=05%3A10%3A33+May+04%2C+2012+PDT&subscr_id=I-WWX4FGSJBMG6&last_name=TP&residence_country=US&pending_reason=echeck&item_name=Plan+2+Subscription%2C&payment_gross=2170.00&mc_currency=USD&business=pradee_1332324973_biz%40zhservices.com&payment_type=echeck&protection_eligibility=Ineligible&verify_sign=Ay1W706h0Yb0Y0cKNIpFuCfE4VPgAte.dg2Wq89uEkL6qA-l7.Z1nDlC&payer_status=verified&test_ipn=1&payer_email=pradee_1332324929_per%40zhservices.com&txn_id=84K33310XA658723D&receiver_email=pradee_1332324973_biz%40zhservices.com&first_name=Pradeep&payer_id=XYJX84WE3ZA86&receiver_id=YGNAL2SBMRD2G&item_number=ZH-2012-05-04-00047&payment_status=Pending&mc_gross=2170.00&custom=ZH-2012-05-04-00047&charset=windows-1252&notify_version=3.4&ipn_track_id=7fc2298c7ab92', 520, 'I-WWX4FGSJBMG6', 0, 1035),
	(48, 1, 95, 'ZH-2012-05-04-00048', 'c3oq51s2p7ageqsamnh7qk78f7', 'Plan 1 Subscription,eRx', 428, 1625, NULL, 'Pending', '0', 'Pending', '2012-05-04', NULL, 428, NULL, 0, 37);
/*!40000 ALTER TABLE `customer_invoice` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_products
DROP TABLE IF EXISTS `customer_products`;
CREATE TABLE IF NOT EXISTS `customer_products` (
  `idcustomer_products` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL,
  `hp_id` bigint(20) NOT NULL,
  `idproducts` bigint(20) NOT NULL,
  `product_name` varchar(150) DEFAULT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `product_feature` text,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `setup_fee` float DEFAULT NULL,
  `payment_term` smallint(6) DEFAULT NULL COMMENT '0 one time, 1 monthly',
  `product_sort_order` bigint(20) DEFAULT NULL,
  `product_status` tinyint(4) DEFAULT NULL,
  `actual_cost` float DEFAULT NULL,
  `actual_setupfee` float DEFAULT NULL,
  `discount_provided_by` varchar(50) DEFAULT NULL,
  `discount_given_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcustomer_products`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=latin1 COMMENT='Products Master Table';

-- Dumping data for table hosted_emr.customer_products: ~4 rows (approximately)
DELETE FROM `customer_products`;
/*!40000 ALTER TABLE `customer_products` DISABLE KEYS */;
INSERT INTO `customer_products` (`idcustomer_products`, `hf_id`, `hp_id`, `idproducts`, `product_name`, `customer_id`, `product_feature`, `user_from`, `user_to`, `cost`, `setup_fee`, `payment_term`, `product_sort_order`, `product_status`, `actual_cost`, `actual_setupfee`, `discount_provided_by`, `discount_given_date`) VALUES
	(128, 94, 15, 1, 'ZHOpenEMR', '1', '<p>\r\n	Zh open EMR is a custom plan for advanced users who looking for the following section</p>\r\n<ul>\r\n	<li>\r\n		Billing Module</li>\r\n	<li>\r\n		Patient portal</li>\r\n	<li>\r\n		Billing information</li>\r\n</ul>\r\n', NULL, NULL, 75, 1250, 1, 1, 1, NULL, NULL, NULL, NULL),
	(129, 94, 15, 29, 'Advanced Billing Module', '1', '<p>\r\n	Billing Module</p>\r\n', NULL, NULL, 75, 1000, 1, 2, 1, NULL, NULL, NULL, NULL),
	(130, 94, 15, 30, 'eRx', '1', '<p>\r\n	eRx Module</p>\r\n', NULL, NULL, 35, 400, 1, 3, 1, NULL, NULL, NULL, NULL),
	(131, 95, 1, 1, 'ZHOpenEMR', '1', '<p>\r\n	Zh open EMR is a custom plan for advanced users who looking for the following section</p>\r\n<ul>\r\n	<li>\r\n		Billing Module</li>\r\n	<li>\r\n		Patient portal</li>\r\n	<li>\r\n		Billing information</li>\r\n</ul>\r\n', NULL, NULL, 75, 1250, 1, 1, 1, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `customer_products` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_selected_plan
DROP TABLE IF EXISTS `customer_selected_plan`;
CREATE TABLE IF NOT EXISTS `customer_selected_plan` (
  `idcustomer_selected_plan` bigint(20) NOT NULL AUTO_INCREMENT,
  `plan_id` bigint(20) DEFAULT NULL,
  `plan_name` varchar(45) DEFAULT NULL,
  `provider_no` bigint(20) DEFAULT NULL,
  `hf_id` bigint(20) DEFAULT NULL,
  `dashboard_userid` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `one_time_payment` float DEFAULT '0',
  `monthly_payment` float DEFAULT '0',
  `setupfee` float DEFAULT '0',
  `discount_percentage` float DEFAULT '0',
  `discount_amount` float DEFAULT '0',
  `total_payment` float DEFAULT '0',
  `payment_status` varchar(20) DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `payment_error_message` text,
  `plan_status` int(11) DEFAULT '0' COMMENT '0: Not Active, 1: Active, 2: Disabled, 3: Expired, 4:deleted',
  `plan_activated_date` date DEFAULT NULL,
  `plan_disabled_date` date DEFAULT NULL,
  `plan_expired_date` date DEFAULT NULL,
  `plan_deleted_date` date DEFAULT NULL,
  `emr_path` varchar(255) DEFAULT NULL,
  `mac_ip` tinyint(4) DEFAULT '1' COMMENT '0-Mac Address, 1-IP Address',
  `facility` text,
  `npi` text,
  `license` tinyint(4) DEFAULT '0' COMMENT '0-not generate, 1- Generate',
  PRIMARY KEY (`idcustomer_selected_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1 COMMENT='Customer Selected Plan and its Features';

-- Dumping data for table hosted_emr.customer_selected_plan: ~2 rows (approximately)
DELETE FROM `customer_selected_plan`;
/*!40000 ALTER TABLE `customer_selected_plan` DISABLE KEYS */;
INSERT INTO `customer_selected_plan` (`idcustomer_selected_plan`, `plan_id`, `plan_name`, `provider_no`, `hf_id`, `dashboard_userid`, `created_date`, `one_time_payment`, `monthly_payment`, `setupfee`, `discount_percentage`, `discount_amount`, `total_payment`, `payment_status`, `payment_date`, `payment_error_message`, `plan_status`, `plan_activated_date`, `plan_disabled_date`, `plan_expired_date`, `plan_deleted_date`, `emr_path`, `mac_ip`, `facility`, `npi`, `license`) VALUES
	(61, 15, 'Plan 2', 3, 94, 'tppradeep@hotmail.com', '2012-05-04', 0, 520, 1650, 0, 0, 2170, 'Pending', '2012-05-04', '', 0, '2012-05-04', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(62, 1, 'Plan 1', 4, 95, 'pradeep@zhservices.com', '2012-05-04', 0, 288, 1225, 0, 0, 1513, '0', NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0);
/*!40000 ALTER TABLE `customer_selected_plan` ENABLE KEYS */;


-- Dumping structure for procedure hosted_emr.empty_cart_junk
DROP PROCEDURE IF EXISTS `empty_cart_junk`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `empty_cart_junk`()
    COMMENT 'Deleting All Junk details of cart'
BEGIN
	delete FROM cart
	 WHERE  DATE_SUB(CURDATE(),INTERVAL 2 DAY) > cart_date and CSTATUS='0' and (invoice_no='' or invoice_no is null);
END//
DELIMITER ;


-- Dumping structure for table hosted_emr.help
DROP TABLE IF EXISTS `help`;
CREATE TABLE IF NOT EXISTS `help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `module` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COMMENT='This Table Contains the details of help data for entire site';

-- Dumping data for table hosted_emr.help: ~13 rows (approximately)
DELETE FROM `help`;
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` (`id`, `module`, `section`, `details`) VALUES
	(2, 'UserRegistrtion', 'FacilityIdentifier', 'Facility Identifier meant by the unique Identifier of your business. In most of the cases this will be the Name of the hospital or registration name of organization.'),
	(3, 'UserRegistrtion', 'name', 'You have to fill your full name in this section. For Example "Philip Jason"'),
	(4, 'UserRegistrtion', 'Speciality', 'Specialty will be the special focusing area of you are looking. ex:  plastic surgery'),
	(5, 'UserRegistrtion', 'DashboardUserId', 'Enter Your Login Id to this system. Your User Id should be alphanumeric and can enter maximum 25 characters'),
	(6, 'UserRegistrtion', 'Dashboardpassword', 'Please Enter Your Password. Password should be alphanumeric and of maximum 15 Character length.'),
	(7, 'UserRegistrtion', 'ConfirmDashboardPassword', 'Please enter confirm Password as similar as of password'),
	(8, 'UserRegistrtion', 'EmailAddress', 'Please enter your valid email address. All communication in future we do with your entered email address'),
	(9, 'UserRegistrtion', 'StreetAddress', 'Street Address'),
	(10, 'UserRegistrtion', 'PhoneNumber', 'Phone Number'),
	(11, 'UserRegistrtion', 'Fax', 'Fax'),
	(12, 'UserRegistrtion', 'TaxID', 'Tax ID'),
	(13, 'UserRegistrtion', 'NPI', 'NPI'),
	(14, 'qwe', 'qwe', '<p>\r\n	qwe</p>\r\n');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_facilities
DROP TABLE IF EXISTS `hosted_facilities`;
CREATE TABLE IF NOT EXISTS `hosted_facilities` (
  `hf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `hf_facility_identifier` varchar(150) DEFAULT NULL,
  `hf_facility_name` varchar(150) DEFAULT NULL,
  `hf_speciality` varchar(150) DEFAULT NULL,
  `dashboard_password` varchar(256) DEFAULT NULL,
  `hf_email` varchar(150) DEFAULT NULL,
  `hf_phone` varchar(150) DEFAULT NULL,
  `hf_address` varchar(150) DEFAULT NULL,
  `hf_fax` varchar(150) DEFAULT NULL,
  `hf_city` varchar(150) DEFAULT NULL,
  `hf_zip` varchar(150) DEFAULT NULL,
  `hf_state` varchar(150) DEFAULT NULL,
  `hf_tax_id` varchar(150) DEFAULT NULL,
  `hf_country` varchar(150) DEFAULT NULL,
  `hf_npi` varchar(150) DEFAULT NULL,
  `reg_date` date DEFAULT NULL,
  `user_status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`hf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_facilities: ~2 rows (approximately)
DELETE FROM `hosted_facilities`;
/*!40000 ALTER TABLE `hosted_facilities` DISABLE KEYS */;
INSERT INTO `hosted_facilities` (`hf_id`, `customer_id`, `hf_facility_identifier`, `hf_facility_name`, `hf_speciality`, `dashboard_password`, `hf_email`, `hf_phone`, `hf_address`, `hf_fax`, `hf_city`, `hf_zip`, `hf_state`, `hf_tax_id`, `hf_country`, `hf_npi`, `reg_date`, `user_status`) VALUES
	(94, 1, 'Sunrise', 'Pradeep T P', 'MD', '48058e0c99bf7d689ce71c360699a14ce2f99774', 'tppradeep@hotmail.com', '564', 'Demo', '564', 'Tcr', '54687', 'Kerala', '564', 'USA', '546', '2012-05-04', 1),
	(95, 1, 'sunrise', 'pradeep', 'md', '48058e0c99bf7d689ce71c360699a14ce2f99774', 'pradeep@zhservices.com', '456', 'Demo', '564', 'demo', '654', 'kerala', '564', 'USA', '546', '2012-05-04', 1);
/*!40000 ALTER TABLE `hosted_facilities` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_plans
DROP TABLE IF EXISTS `hosted_plans`;
CREATE TABLE IF NOT EXISTS `hosted_plans` (
  `hp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `hp_name` varchar(50) DEFAULT '0',
  `hp_caption` varchar(50) DEFAULT '0',
  `hp_sortorder` int(11) DEFAULT '0',
  `hp_status` int(11) DEFAULT '0',
  `bundle_discount_type` int(11) DEFAULT '0',
  `bundle_discount_per_cost` float DEFAULT '0',
  `bundle_discount_per_setup` float DEFAULT '0',
  `bundle_cost` float DEFAULT '0',
  `bundle_setup_cost` float DEFAULT '0',
  `discount` float DEFAULT '0',
  `discount_start_date` date DEFAULT NULL,
  `discount_end_date` date DEFAULT NULL,
  `Imagename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_plans: ~4 rows (approximately)
DELETE FROM `hosted_plans`;
/*!40000 ALTER TABLE `hosted_plans` DISABLE KEYS */;
INSERT INTO `hosted_plans` (`hp_id`, `customer_id`, `hp_name`, `hp_caption`, `hp_sortorder`, `hp_status`, `bundle_discount_type`, `bundle_discount_per_cost`, `bundle_discount_per_setup`, `bundle_cost`, `bundle_setup_cost`, `discount`, `discount_start_date`, `discount_end_date`, `Imagename`) VALUES
	(1, 1, 'Plan 1', 'plan1', 1, 1, 1, 4, 2, 72, 1225, NULL, NULL, NULL, '1.png'),
	(15, 1, 'Plan 2', 'Plan2', 2, 1, 2, 35, 1000, 150, 1650, NULL, NULL, NULL, '15.png'),
	(16, 1, 'Plan 3', 'Plan3', 3, 1, 2, 35, 50, 200, 3000, NULL, NULL, NULL, '16.png'),
	(17, 1, 'Test Plan', 'Demo', 4, 1, 2, 50, 1000, 150, 1400, NULL, NULL, NULL, '17.jpg');
/*!40000 ALTER TABLE `hosted_plans` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hs_payment_details
DROP TABLE IF EXISTS `hs_payment_details`;
CREATE TABLE IF NOT EXISTS `hs_payment_details` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL DEFAULT '0',
  `hp_id` bigint(20) NOT NULL DEFAULT '0',
  `setup_fee` float NOT NULL DEFAULT '0',
  `monthly_fee` float NOT NULL DEFAULT '0',
  `total_fee` float NOT NULL DEFAULT '0',
  `payment_date` datetime NOT NULL,
  `payment_status` int(11) NOT NULL,
  `paypal_email` varchar(250) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Paypal Details';

-- Dumping data for table hosted_emr.hs_payment_details: ~0 rows (approximately)
DELETE FROM `hs_payment_details`;
/*!40000 ALTER TABLE `hs_payment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `hs_payment_details` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.modules
DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `module_id` int(10) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL DEFAULT '0',
  `module_controller` varchar(50) NOT NULL DEFAULT '0',
  `module_display_name` varchar(50) NOT NULL DEFAULT '0',
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Main Module Table (ACL)';

-- Dumping data for table hosted_emr.modules: ~5 rows (approximately)
DELETE FROM `modules`;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`module_id`, `module_name`, `module_controller`, `module_display_name`, `customer_id`) VALUES
	(1, 'Admin', 'Plans', 'Plans', 1),
	(2, 'Admin', 'Products', 'Products', 1),
	(3, 'Admin', 'Help', 'Help', 1),
	(4, 'Admin', 'PageHelp', 'Page Wise Help', 1),
	(5, 'Admin', 'Users', 'Registered Customers', 1);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.notusing_customer_product
DROP TABLE IF EXISTS `notusing_customer_product`;
CREATE TABLE IF NOT EXISTS `notusing_customer_product` (
  `idcustomer_product` bigint(20) NOT NULL AUTO_INCREMENT,
  `idproducts` bigint(20) DEFAULT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `hf_id` bigint(20) DEFAULT NULL,
  `dashboard_userid` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `one_time_payment` float DEFAULT '0',
  `monthly_payment` float DEFAULT '0',
  `discount_percentage` float DEFAULT '0',
  `discount_amount` float DEFAULT '0',
  `total_payment` float DEFAULT '0',
  `payment_status` varchar(20) DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `plan_status` int(11) DEFAULT '0' COMMENT '0: Not Active, 1: Active, 2: Disabled, 3: Expired, 4:deleted',
  `plan_activated_date` date DEFAULT NULL,
  `plan_disabled_date` date DEFAULT NULL,
  `plan_expired_date` date DEFAULT NULL,
  `plan_deleted_date` date DEFAULT NULL,
  PRIMARY KEY (`idcustomer_product`),
  KEY `FK_customer_product` (`idproducts`),
  CONSTRAINT `FK_customer_product` FOREIGN KEY (`idproducts`) REFERENCES `products` (`idproducts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Customer Selected Plan and its Features';

-- Dumping data for table hosted_emr.notusing_customer_product: ~0 rows (approximately)
DELETE FROM `notusing_customer_product`;
/*!40000 ALTER TABLE `notusing_customer_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `notusing_customer_product` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.notusing_customer_product_feature
DROP TABLE IF EXISTS `notusing_customer_product_feature`;
CREATE TABLE IF NOT EXISTS `notusing_customer_product_feature` (
  `idcustomer_product_feature` bigint(20) NOT NULL AUTO_INCREMENT,
  `idcustomer_product` bigint(20) DEFAULT NULL,
  `idproduct_feature` bigint(20) DEFAULT NULL,
  `cost` bigint(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idcustomer_product_feature`),
  KEY `FK_customer_product_feature` (`idcustomer_product`),
  KEY `FK_product_feature` (`idproduct_feature`),
  CONSTRAINT `FK_customer_product_feature` FOREIGN KEY (`idcustomer_product`) REFERENCES `notusing_customer_product` (`idcustomer_product`),
  CONSTRAINT `FK_product_feature` FOREIGN KEY (`idproduct_feature`) REFERENCES `product_price` (`idproduct_feature`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='In this table all features of customer selected product will in';

-- Dumping data for table hosted_emr.notusing_customer_product_feature: ~0 rows (approximately)
DELETE FROM `notusing_customer_product_feature`;
/*!40000 ALTER TABLE `notusing_customer_product_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `notusing_customer_product_feature` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.notusing_customer_selected_plan_features
DROP TABLE IF EXISTS `notusing_customer_selected_plan_features`;
CREATE TABLE IF NOT EXISTS `notusing_customer_selected_plan_features` (
  `idcustomer_selected_plan_features` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) DEFAULT NULL,
  `idcustomer_selected_plan` bigint(20) DEFAULT NULL,
  `hpcm_type_id` bigint(20) DEFAULT NULL,
  `value_type` varchar(10) DEFAULT NULL,
  `hsc_value` varchar(50) DEFAULT NULL,
  `hp_id` bigint(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `additional_providers` int(10) DEFAULT NULL,
  PRIMARY KEY (`idcustomer_selected_plan_features`)
) ENGINE=InnoDB AUTO_INCREMENT=2966 DEFAULT CHARSET=latin1 COMMENT='In this table all features of customer selected plan will in';

-- Dumping data for table hosted_emr.notusing_customer_selected_plan_features: ~114 rows (approximately)
DELETE FROM `notusing_customer_selected_plan_features`;
/*!40000 ALTER TABLE `notusing_customer_selected_plan_features` DISABLE KEYS */;
INSERT INTO `notusing_customer_selected_plan_features` (`idcustomer_selected_plan_features`, `hf_id`, `idcustomer_selected_plan`, `hpcm_type_id`, `value_type`, `hsc_value`, `hp_id`, `payment_term`, `additional_providers`) VALUES
	(2852, 92, 74, 2, '$', '2', 15, 0, 0),
	(2853, 92, 74, 3, '$', '3', 15, 0, 3),
	(2854, 92, 74, 4, '$', '2', 15, 1, 0),
	(2855, 92, 74, 5, '$', '20', 15, 1, 4),
	(2856, 92, 74, 6, 'F', '6% of Total Bill', 15, 1, 0),
	(2857, 92, 74, 7, 'F', 'Yes', 15, 0, 0),
	(2858, 92, 74, 8, 'F', 'Yes', 15, 0, 0),
	(2859, 92, 74, 9, 'F', 'Yes', 15, 0, 0),
	(2860, 92, 74, 10, 'F', 'Yes', 15, 0, 0),
	(2861, 92, 74, 11, 'F', 'Yes', 15, 0, 0),
	(2862, 92, 74, 12, 'F', 'Yes', 15, 0, 0),
	(2863, 92, 74, 13, 'D', 'Yes', 15, 0, 0),
	(2864, 92, 74, 14, 'F', 'Yes', 15, 0, 0),
	(2865, 92, 74, 15, 'F', 'No', 15, 0, 0),
	(2866, 92, 74, 16, 'F', 'No', 15, 0, 0),
	(2867, 92, 74, 17, 'F', 'Yes', 15, 0, 0),
	(2868, 92, 74, 18, 'F', 'Yes', 15, 0, 0),
	(2869, 92, 74, 19, 'F', 'Yes', 15, 0, 0),
	(2870, 92, 74, 20, 'F', 'Yes', 15, 0, 0),
	(2871, 92, 74, 21, 'F', 'Yes', 15, 0, 0),
	(2872, 92, 74, 22, 'F', 'Yes', 15, 0, 0),
	(2873, 92, 74, 23, 'F', 'Yes', 15, 0, 0),
	(2874, 92, 74, 24, 'F', 'Yes', 15, 0, 0),
	(2875, 92, 74, 25, 'F', 'Yes', 15, 0, 0),
	(2876, 92, 74, 26, 'F', 'Yes', 15, 0, 0),
	(2877, 92, 74, 27, 'F', 'Yes', 15, 0, 0),
	(2878, 92, 74, 28, 'F', 'Yes', 15, 0, 0),
	(2879, 92, 74, 29, 'F', 'Yes', 15, 0, 0),
	(2880, 92, 74, 30, 'F', 'Yes', 15, 0, 0),
	(2881, 92, 74, 31, 'F', 'Yes', 15, 0, 0),
	(2882, 92, 74, 32, 'F', 'Yes', 15, 0, 0),
	(2883, 92, 74, 33, 'F', 'Yes', 15, 0, 0),
	(2884, 92, 74, 34, 'F', 'Yes', 15, 0, 0),
	(2885, 92, 74, 35, '$', '3', 15, 0, 0),
	(2886, 92, 74, 36, 'F', 'Yes', 15, 0, 0),
	(2887, 92, 74, 37, 'F', 'Yes', 15, 0, 0),
	(2888, 92, 74, 38, 'F', 'Yes', 15, 0, 0),
	(2889, 92, 74, 39, 'F', 'Yes', 15, 0, 0),
	(2890, 92, 74, 40, 'F', 'Yes', 15, 0, 0),
	(2891, 92, 74, 41, 'F', 'Yes', 15, 0, 0),
	(2892, 92, 74, 42, 'F', 'Yes', 15, 0, 0),
	(2893, 92, 74, 43, 'F', 'Yes', 15, 0, 0),
	(2894, 92, 74, 44, 'F', 'Yes', 15, 0, 0),
	(2895, 92, 74, 45, 'F', 'Yes', 15, 0, 0),
	(2896, 92, 74, 46, 'F', 'Yes', 15, 0, 0),
	(2897, 92, 74, 47, 'F', 'Yes', 15, 0, 0),
	(2898, 92, 74, 48, 'F', 'Yes', 15, 0, 0),
	(2899, 92, 74, 49, 'F', 'Yes', 15, 0, 0),
	(2900, 92, 74, 50, 'D', '1 GB', 15, 0, 0),
	(2901, 92, 74, 51, 'F', 'Yes', 15, 0, 0),
	(2902, 92, 74, 52, '$', '2', 15, 0, 0),
	(2903, 92, 74, 53, '$', '2', 15, 0, 0),
	(2904, 92, 74, 54, 'D', '500', 15, 0, 0),
	(2905, 92, 74, 55, 'F', 'Yes', 15, 0, 0),
	(2906, 92, 74, 56, 'D', '50', 15, 0, 0),
	(2907, 92, 74, 57, 'F', 'No', 15, 0, 0),
	(2908, 92, 74, 58, 'F', 'Quote', 15, 0, 0),
	(2909, 93, 75, 2, '$', '2', 15, 0, 0),
	(2910, 93, 75, 3, '$', '0', 15, 0, 0),
	(2911, 93, 75, 4, '$', '2', 15, 1, 0),
	(2912, 93, 75, 5, '$', '0', 15, 1, 0),
	(2913, 93, 75, 6, 'F', '6% of Total Bill', 15, 1, 0),
	(2914, 93, 75, 7, 'F', 'Yes', 15, 0, 0),
	(2915, 93, 75, 8, 'F', 'Yes', 15, 0, 0),
	(2916, 93, 75, 9, 'F', 'Yes', 15, 0, 0),
	(2917, 93, 75, 10, 'F', 'Yes', 15, 0, 0),
	(2918, 93, 75, 11, 'F', 'Yes', 15, 0, 0),
	(2919, 93, 75, 12, 'F', 'Yes', 15, 0, 0),
	(2920, 93, 75, 13, 'D', 'Yes', 15, 0, 0),
	(2921, 93, 75, 14, 'F', 'Yes', 15, 0, 0),
	(2922, 93, 75, 15, 'F', 'No', 15, 0, 0),
	(2923, 93, 75, 16, 'F', 'No', 15, 0, 0),
	(2924, 93, 75, 17, 'F', 'Yes', 15, 0, 0),
	(2925, 93, 75, 18, 'F', 'Yes', 15, 0, 0),
	(2926, 93, 75, 19, 'F', 'Yes', 15, 0, 0),
	(2927, 93, 75, 20, 'F', 'Yes', 15, 0, 0),
	(2928, 93, 75, 21, 'F', 'Yes', 15, 0, 0),
	(2929, 93, 75, 22, 'F', 'Yes', 15, 0, 0),
	(2930, 93, 75, 23, 'F', 'Yes', 15, 0, 0),
	(2931, 93, 75, 24, 'F', 'Yes', 15, 0, 0),
	(2932, 93, 75, 25, 'F', 'Yes', 15, 0, 0),
	(2933, 93, 75, 26, 'F', 'Yes', 15, 0, 0),
	(2934, 93, 75, 27, 'F', 'Yes', 15, 0, 0),
	(2935, 93, 75, 28, 'F', 'Yes', 15, 0, 0),
	(2936, 93, 75, 29, 'F', 'Yes', 15, 0, 0),
	(2937, 93, 75, 30, 'F', 'Yes', 15, 0, 0),
	(2938, 93, 75, 31, 'F', 'Yes', 15, 0, 0),
	(2939, 93, 75, 32, 'F', 'Yes', 15, 0, 0),
	(2940, 93, 75, 33, 'F', 'Yes', 15, 0, 0),
	(2941, 93, 75, 34, 'F', 'Yes', 15, 0, 0),
	(2942, 93, 75, 35, '$', '3', 15, 0, 0),
	(2943, 93, 75, 36, 'F', 'Yes', 15, 0, 0),
	(2944, 93, 75, 37, 'F', 'Yes', 15, 0, 0),
	(2945, 93, 75, 38, 'F', 'Yes', 15, 0, 0),
	(2946, 93, 75, 39, 'F', 'Yes', 15, 0, 0),
	(2947, 93, 75, 40, 'F', 'Yes', 15, 0, 0),
	(2948, 93, 75, 41, 'F', 'Yes', 15, 0, 0),
	(2949, 93, 75, 42, 'F', 'Yes', 15, 0, 0),
	(2950, 93, 75, 43, 'F', 'Yes', 15, 0, 0),
	(2951, 93, 75, 44, 'F', 'Yes', 15, 0, 0),
	(2952, 93, 75, 45, 'F', 'Yes', 15, 0, 0),
	(2953, 93, 75, 46, 'F', 'Yes', 15, 0, 0),
	(2954, 93, 75, 47, 'F', 'Yes', 15, 0, 0),
	(2955, 93, 75, 48, 'F', 'Yes', 15, 0, 0),
	(2956, 93, 75, 49, 'F', 'Yes', 15, 0, 0),
	(2957, 93, 75, 50, 'D', '1 GB', 15, 0, 0),
	(2958, 93, 75, 51, 'F', 'Yes', 15, 0, 0),
	(2959, 93, 75, 52, '$', '2', 15, 0, 0),
	(2960, 93, 75, 53, '$', '2', 15, 0, 0),
	(2961, 93, 75, 54, 'D', '500', 15, 0, 0),
	(2962, 93, 75, 55, 'F', 'Yes', 15, 0, 0),
	(2963, 93, 75, 56, 'D', '50', 15, 0, 0),
	(2964, 93, 75, 57, 'F', 'No', 15, 0, 0),
	(2965, 93, 75, 58, 'F', 'Quote', 15, 0, 0);
/*!40000 ALTER TABLE `notusing_customer_selected_plan_features` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.notusing_hosted_plan_content_mapping
DROP TABLE IF EXISTS `notusing_hosted_plan_content_mapping`;
CREATE TABLE IF NOT EXISTS `notusing_hosted_plan_content_mapping` (
  `hpcm_type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `hpcm_type_name` varchar(150) DEFAULT NULL,
  `hpcm_order` int(10) DEFAULT NULL,
  `hpcm_level` int(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT 'if zero then one time, if one then montyly',
  `delete` tinyint(4) DEFAULT '1',
  `min_val` int(11) DEFAULT NULL,
  `custom_label1` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hpcm_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='This table storing the Main Features of Plan (master collection)';

-- Dumping data for table hosted_emr.notusing_hosted_plan_content_mapping: ~57 rows (approximately)
DELETE FROM `notusing_hosted_plan_content_mapping`;
/*!40000 ALTER TABLE `notusing_hosted_plan_content_mapping` DISABLE KEYS */;
INSERT INTO `notusing_hosted_plan_content_mapping` (`hpcm_type_id`, `customer_id`, `hpcm_type_name`, `hpcm_order`, `hpcm_level`, `status`, `delete`, `min_val`, `custom_label1`) VALUES
	(2, 1, 'One time Setup Fee : First Provider', 1, 1, 1, 0, 1, NULL),
	(3, 1, 'One time Setup Fee: Additional Providers', 2, 1, 1, 0, 3, 'Multiplication of '),
	(4, 1, 'Monthly Fee : First provider', 3, 1, 1, 0, 1, NULL),
	(5, 1, 'Monthly Fee : Additional providers', 4, 1, 1, 0, 4, 'Multiplication of'),
	(6, 1, 'Monthly Billing Fees', 5, 1, 1, 1, NULL, NULL),
	(7, 1, 'EMR hosted on our server', 6, 1, 1, 1, NULL, NULL),
	(8, 1, 'Key Features', 7, 1, 1, 1, NULL, NULL),
	(9, 1, 'Patient Portal', 8, 1, 1, 1, NULL, NULL),
	(10, 1, 'Scheduling', 9, 1, 1, 1, NULL, NULL),
	(11, 1, 'Patient Records', 10, 1, 1, 1, NULL, NULL),
	(12, 1, 'Charting', 11, 1, 1, 1, NULL, NULL),
	(13, 1, 'Document Management', 12, 1, 1, 1, NULL, NULL),
	(14, 1, 'Billing', 13, 1, 1, 1, NULL, NULL),
	(15, 1, 'Collections', 14, 1, 1, 1, NULL, NULL),
	(16, 1, 'Hundreds of templates', 15, 1, 1, 1, NULL, NULL),
	(17, 1, 'Reports', 16, 1, 1, 1, NULL, NULL),
	(18, 1, 'Specialty Modules', 17, 1, 1, 1, NULL, NULL),
	(19, 1, 'Advanced Billing Module', 18, 1, 1, 1, NULL, NULL),
	(20, 1, 'Template based Fee sheets', 19, 1, 1, 1, NULL, NULL),
	(21, 1, 'Contract Management', 20, 1, 1, 1, NULL, NULL),
	(22, 1, 'Capitation Billing', 21, 1, 1, 1, NULL, NULL),
	(23, 1, 'Pre-authorizations', 22, 1, 1, 1, NULL, NULL),
	(24, 1, 'Clearing house integration*', 23, 1, 1, 1, NULL, NULL),
	(25, 1, 'AR Management', 24, 1, 1, 1, NULL, NULL),
	(26, 1, 'Patient Ledgers', 25, 1, 1, 1, NULL, NULL),
	(27, 1, 'Advanced Reporting', 26, 1, 1, 1, NULL, NULL),
	(28, 1, 'Customizable reports', 27, 1, 1, 1, NULL, NULL),
	(29, 1, 'e-Prescription Ready', 28, 1, 1, 1, NULL, NULL),
	(30, 1, 'Lab Exchange Ready', 29, 1, 1, 1, NULL, NULL),
	(31, 1, 'Integrated e-Prescription', 30, 1, 1, 1, NULL, NULL),
	(32, 1, 'Integrated Lab Exchange', 31, 1, 1, 1, NULL, NULL),
	(33, 1, 'Private Branding one time @$1000 and $50 per month', 32, 1, 1, 1, NULL, NULL),
	(34, 1, 'Go-live support', 33, 1, 1, 1, NULL, NULL),
	(35, 1, 'Staff training', 34, 1, 1, 1, NULL, NULL),
	(36, 1, 'Auto appt reminder calls (@ $0.10 per call)', 35, 1, 1, 1, NULL, NULL),
	(37, 1, 'Automatic updates', 36, 1, 1, 1, NULL, NULL),
	(38, 1, 'Monthly maintenance', 37, 1, 1, 1, NULL, NULL),
	(39, 1, 'Monthly hosting and support', 38, 1, 1, 1, NULL, NULL),
	(40, 1, 'Medical Billing Services - We bill for you', 39, 1, 1, 1, NULL, NULL),
	(41, 1, 'Insurance Billing', 40, 1, 1, 1, NULL, NULL),
	(42, 1, 'Patient Billing', 41, 1, 1, 1, NULL, NULL),
	(43, 1, 'Verification of benefits', 42, 1, 1, 1, NULL, NULL),
	(44, 1, 'Pre-Auth services', 43, 1, 1, 1, NULL, NULL),
	(45, 1, 'Credentialing', 44, 1, 1, 1, NULL, NULL),
	(46, 1, 'Claims submission', 45, 1, 1, 1, NULL, NULL),
	(47, 1, 'EOB Posting', 46, 1, 1, 1, NULL, NULL),
	(48, 1, 'Receivables', 47, 1, 1, 1, NULL, NULL),
	(49, 1, 'EFT', 48, 1, 1, 1, NULL, NULL),
	(50, 1, 'Storage Space', 49, 1, 1, 1, NULL, NULL),
	(51, 1, 'Additional Space per GB per year', 50, 1, 1, 1, NULL, NULL),
	(52, 1, 'Onsite Services Hourly Rate', 51, 1, 1, 1, NULL, NULL),
	(53, 1, 'Remote Services Hourly Rate', 52, 1, 1, 1, NULL, NULL),
	(54, 1, 'Data Conversion from your system', 53, 1, 1, 1, NULL, NULL),
	(55, 1, 'Medisoft', 54, 1, 1, 1, NULL, NULL),
	(56, 1, 'TotalMD', 55, 1, 1, 1, NULL, NULL),
	(57, 1, 'Lytec', 56, 1, 1, 1, NULL, NULL),
	(58, 1, 'Others', 57, 1, 1, 1, NULL, NULL);
/*!40000 ALTER TABLE `notusing_hosted_plan_content_mapping` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.notusing_hosted_site_content
DROP TABLE IF EXISTS `notusing_hosted_site_content`;
CREATE TABLE IF NOT EXISTS `notusing_hosted_site_content` (
  `hpcm_type_id` bigint(20) NOT NULL,
  `hsc_value` varchar(50) DEFAULT NULL,
  `value_type` varchar(50) DEFAULT NULL,
  `hp_id` bigint(20) NOT NULL,
  `payment_term` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-one time, 1 monthly',
  KEY `FK_hosted_site_content_hosted_plan_content_mapping` (`hpcm_type_id`),
  KEY `FK_hosted_site_content_hosted_plans` (`hp_id`),
  CONSTRAINT `FK_hosted_site_content_hosted_plans` FOREIGN KEY (`hp_id`) REFERENCES `hosted_plans` (`hp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.notusing_hosted_site_content: ~171 rows (approximately)
DELETE FROM `notusing_hosted_site_content`;
/*!40000 ALTER TABLE `notusing_hosted_site_content` DISABLE KEYS */;
INSERT INTO `notusing_hosted_site_content` (`hpcm_type_id`, `hsc_value`, `value_type`, `hp_id`, `payment_term`) VALUES
	(2, '2', '$', 15, 0),
	(3, '1', '$', 15, 0),
	(4, '2', '$', 15, 1),
	(5, '5', '$', 15, 1),
	(6, '6% of Total Bill', 'F', 15, 1),
	(7, 'Yes', 'F', 15, 0),
	(8, 'Yes', 'F', 15, 0),
	(9, 'Yes', 'F', 15, 0),
	(10, 'Yes', 'F', 15, 0),
	(11, 'Yes', 'F', 15, 0),
	(12, 'Yes', 'F', 15, 0),
	(13, 'Yes', 'D', 15, 0),
	(14, 'Yes', 'F', 15, 0),
	(15, 'No', 'F', 15, 0),
	(16, 'No', 'F', 15, 0),
	(17, 'Yes', 'F', 15, 0),
	(18, 'Yes', 'F', 15, 0),
	(19, 'Yes', 'F', 15, 0),
	(20, 'Yes', 'F', 15, 0),
	(21, 'Yes', 'F', 15, 0),
	(22, 'Yes', 'F', 15, 0),
	(23, 'Yes', 'F', 15, 0),
	(24, 'Yes', 'F', 15, 0),
	(25, 'Yes', 'F', 15, 0),
	(26, 'Yes', 'F', 15, 0),
	(27, 'Yes', 'F', 15, 0),
	(28, 'Yes', 'F', 15, 0),
	(29, 'Yes', 'F', 15, 0),
	(30, 'Yes', 'F', 15, 0),
	(31, 'Yes', 'F', 15, 0),
	(32, 'Yes', 'F', 15, 0),
	(33, 'Yes', 'F', 15, 0),
	(34, 'Yes', 'F', 15, 0),
	(35, '3', '$', 15, 0),
	(36, 'Yes', 'F', 15, 0),
	(37, 'Yes', 'F', 15, 0),
	(38, 'Yes', 'F', 15, 0),
	(39, 'Yes', 'F', 15, 0),
	(40, 'Yes', 'F', 15, 0),
	(41, 'Yes', 'F', 15, 0),
	(42, 'Yes', 'F', 15, 0),
	(43, 'Yes', 'F', 15, 0),
	(44, 'Yes', 'F', 15, 0),
	(45, 'Yes', 'F', 15, 0),
	(46, 'Yes', 'F', 15, 0),
	(47, 'Yes', 'F', 15, 0),
	(48, 'Yes', 'F', 15, 0),
	(49, 'Yes', 'F', 15, 0),
	(50, '1 GB', 'D', 15, 0),
	(51, 'Yes', 'F', 15, 0),
	(52, '2', '$', 15, 0),
	(53, '2', '$', 15, 0),
	(54, '500', 'D', 15, 0),
	(55, 'Yes', 'F', 15, 0),
	(56, '50', 'D', 15, 0),
	(57, 'No', 'F', 15, 0),
	(58, 'Quote', 'F', 15, 0),
	(2, '0', '$', 1, 0),
	(3, '0', '$', 1, 0),
	(4, '0', '$', 1, 0),
	(5, '0', '$', 1, 0),
	(6, '0', '$', 1, 0),
	(7, 'Yes', 'F', 1, 0),
	(8, 'Yes', 'F', 1, 0),
	(9, 'Yes', 'F', 1, 0),
	(10, 'Yes', 'F', 1, 0),
	(11, 'Yes', 'F', 1, 0),
	(12, 'Yes', 'F', 1, 0),
	(13, 'Yes', 'F', 1, 0),
	(14, 'No', 'F', 1, 0),
	(15, 'No', 'F', 1, 0),
	(16, 'No', 'F', 1, 0),
	(17, 'Yes', 'F', 1, 0),
	(18, 'No', 'F', 1, 0),
	(19, 'No', 'F', 1, 0),
	(20, 'No', 'F', 1, 0),
	(21, 'No', 'F', 1, 0),
	(22, 'No', 'F', 1, 0),
	(23, 'No', 'F', 1, 0),
	(24, 'No', 'F', 1, 0),
	(25, 'No', 'F', 1, 0),
	(26, 'Yes', 'F', 1, 0),
	(27, 'No', 'F', 1, 0),
	(28, 'No', 'F', 1, 0),
	(29, 'No', 'F', 1, 0),
	(30, 'Yes', 'F', 1, 0),
	(31, 'No', 'F', 1, 0),
	(32, 'No', 'F', 1, 0),
	(33, 'No', 'F', 1, 0),
	(34, 'No', 'F', 1, 0),
	(35, 'No', 'F', 1, 0),
	(36, 'No', 'F', 1, 0),
	(37, 'No', 'F', 1, 0),
	(38, 'No', 'F', 1, 0),
	(39, 'No', 'F', 1, 0),
	(40, 'No', 'F', 1, 0),
	(41, 'No', 'F', 1, 0),
	(42, 'No', 'F', 1, 0),
	(43, 'Yes', 'F', 1, 0),
	(44, 'No', 'F', 1, 0),
	(45, 'No', 'F', 1, 0),
	(46, 'No', 'F', 1, 0),
	(47, 'Yes', 'F', 1, 0),
	(48, 'Yes', 'F', 1, 0),
	(49, 'No', 'F', 1, 0),
	(50, '1 GB', 'D', 1, 0),
	(51, 'No', 'F', 1, 0),
	(52, '0', '$', 1, 0),
	(53, '0', '$', 1, 0),
	(54, '500', 'D', 1, 0),
	(55, 'No', 'F', 1, 0),
	(56, '50', 'D', 1, 0),
	(57, 'No', 'F', 1, 0),
	(58, 'Quote', 'F', 1, 0),
	(2, '2', '$', 16, 0),
	(3, '2', '$', 16, 1),
	(4, '1', '$', 16, 1),
	(5, '1', '$', 16, 1),
	(6, '7% of Total Bill', 'F', 16, 0),
	(7, 'Yes', 'F', 16, 0),
	(8, 'Yes', 'F', 16, 0),
	(9, 'Yes', 'F', 16, 0),
	(10, 'Yes', 'F', 16, 0),
	(11, 'Yes', 'F', 16, 0),
	(12, 'Yes', 'F', 16, 0),
	(13, 'Yes', 'F', 16, 0),
	(14, 'Yes', 'F', 16, 1),
	(15, 'Yes', 'F', 16, 1),
	(16, 'No', 'F', 16, 0),
	(17, 'Yes', 'F', 16, 0),
	(18, 'No', 'F', 16, 0),
	(19, 'No', 'F', 16, 0),
	(20, 'No', 'F', 16, 0),
	(21, 'No', 'F', 16, 0),
	(22, 'No', 'F', 16, 0),
	(23, 'No', 'F', 16, 0),
	(24, 'No', 'F', 16, 0),
	(25, 'No', 'F', 16, 0),
	(26, 'Yes', 'F', 16, 0),
	(27, 'No', 'F', 16, 0),
	(28, 'No', 'F', 16, 0),
	(29, 'No', 'F', 16, 0),
	(30, 'Yes', 'F', 16, 0),
	(31, 'No', 'F', 16, 0),
	(32, 'No', 'F', 16, 0),
	(33, 'No', 'F', 16, 0),
	(34, 'No', 'F', 16, 0),
	(35, '1', '$', 16, 1),
	(36, 'No', 'F', 16, 0),
	(37, 'No', 'F', 16, 0),
	(38, 'No', 'F', 16, 0),
	(39, 'No', 'F', 16, 0),
	(40, 'No', 'F', 16, 0),
	(41, 'No', 'F', 16, 0),
	(42, 'No', 'F', 16, 0),
	(43, 'Yes', 'F', 16, 0),
	(44, 'No', 'F', 16, 0),
	(45, 'No', 'F', 16, 0),
	(46, 'No', 'F', 16, 0),
	(47, 'Yes', 'F', 16, 0),
	(48, 'Yes', 'F', 16, 0),
	(49, 'No', 'F', 16, 0),
	(50, '1 GB', 'D', 16, 0),
	(51, 'No', 'F', 16, 0),
	(52, '25', 'F', 16, 1),
	(53, '1', '$', 16, 1),
	(54, '2', '$', 16, 1),
	(55, 'No', 'F', 16, 0),
	(56, '50', 'F', 16, 1),
	(57, 'No', 'F', 16, 0),
	(58, 'Quote', 'F', 16, 0);
/*!40000 ALTER TABLE `notusing_hosted_site_content` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.page_help
DROP TABLE IF EXISTS `page_help`;
CREATE TABLE IF NOT EXISTS `page_help` (
  `page_help_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `module` varchar(50) NOT NULL,
  `Section` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`page_help_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Help Related to a Page. contains, Text, Image Gallery, Videos';

-- Dumping data for table hosted_emr.page_help: ~1 rows (approximately)
DELETE FROM `page_help`;
/*!40000 ALTER TABLE `page_help` DISABLE KEYS */;
INSERT INTO `page_help` (`page_help_id`, `module`, `Section`, `title`, `description`) VALUES
	(1, 'Registration', 'User Registration', 'Registration Procedure', '<div id="lipsum">\r\n	<p>\r\n		Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent at ligula non arcu tincidunt tempus non eu tortor. Aliquam tristique suscipit metus in tempor. Ut aliquet, orci id condimentum blandit, erat magna tempus ipsum, a adipiscing turpis risus sit amet turpis. Sed gravida dolor eu nibh porttitor at eleifend nisl consectetur. Aliquam erat volutpat. Integer facilisis eros a metus faucibus interdum. Pellentesque eget sapien odio. Sed in vestibulum lorem. Sed sit amet sem ipsum.</p>\r\n	<p>\r\n		Duis diam nibh, elementum ut dignissim ut, tincidunt nec turpis. Vivamus ac enim velit, nec faucibus odio. Quisque a mi nisl. Donec lorem enim, viverra vitae ullamcorper vitae, mattis sit amet quam. Curabitur mattis, purus ac dictum mattis, odio neque venenatis ante, vel mattis felis nunc vitae quam. Donec eu lacus elit, hendrerit pharetra orci. Aliquam lacinia elementum leo eu aliquet.</p>\r\n	<p>\r\n		Etiam venenatis iaculis erat, sed ullamcorper velit feugiat in. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas mauris leo, pulvinar vitae imperdiet ac, bibendum eget tortor. Morbi volutpat facilisis enim, eu tincidunt purus fringilla id. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus interdum diam ac dolor molestie euismod. Cras sollicitudin libero eget augue vulputate tristique. Quisque sit amet congue ipsum.</p>\r\n	<p>\r\n		In hac habitasse platea dictumst. Nullam auctor porta vestibulum. Duis nulla dui, ultrices sit amet porttitor sed, sollicitudin sed tortor. Aenean tempor, orci id rutrum vehicula, augue enim imperdiet leo, sit amet sollicitudin dui elit id lacus. Mauris tincidunt posuere nulla ut mollis. Etiam et tristique neque. Vestibulum at dignissim nisl. Sed dapibus elementum enim ac ullamcorper. Praesent sed neque id erat hendrerit rutrum vitae at nisi.</p>\r\n	<p>\r\n		Etiam sit amet elit ante, ut placerat urna. Sed magna sem, dignissim a sodales vitae, volutpat sed ligula. Praesent tempor imperdiet pretium. Integer consequat turpis ac tellus rutrum porta. Suspendisse lacus nibh, aliquam vitae cursus et, congue venenatis ligula. Cras ut quam erat, eget euismod dolor. Praesent semper urna nec turpis porttitor et vestibulum nisl tempor. Phasellus tincidunt accumsan tortor vitae condimentum.</p>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n');
/*!40000 ALTER TABLE `page_help` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.page_help_images
DROP TABLE IF EXISTS `page_help_images`;
CREATE TABLE IF NOT EXISTS `page_help_images` (
  `page_help_images_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_help_id` bigint(20) NOT NULL,
  `image_title` varchar(150) NOT NULL,
  `image_description` text NOT NULL,
  `image_name` varchar(150) NOT NULL,
  `sortorder` bigint(20) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`page_help_images_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Image Gallery Of Page Help';

-- Dumping data for table hosted_emr.page_help_images: ~6 rows (approximately)
DELETE FROM `page_help_images`;
/*!40000 ALTER TABLE `page_help_images` DISABLE KEYS */;
INSERT INTO `page_help_images` (`page_help_images_id`, `page_help_id`, `image_title`, `image_description`, `image_name`, `sortorder`, `status`) VALUES
	(2, 1, 'Lorem Ipsum is simply dummy text of the printing a', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Koala.jpg', 2, 1),
	(3, 1, 'lk', 'kl', 'Chrysanthemum.jpg', 2, 1),
	(4, 1, 'hj', 'hj', 'Lighthouse.jpg', 3, 1),
	(5, 1, 'fg', 'fg', 'Hydrangeas.jpg', 4, 1),
	(6, 1, 'vf', 'fv', 'Hydrangeas.jpg', 6, 1),
	(7, 1, 'vf', 'fv', 'Hydrangeas.jpg', 6, 1);
/*!40000 ALTER TABLE `page_help_images` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.page_help_video
DROP TABLE IF EXISTS `page_help_video`;
CREATE TABLE IF NOT EXISTS `page_help_video` (
  `page_help_video_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_help_id` bigint(20) NOT NULL,
  `video_title` varchar(255) NOT NULL,
  `utube_url` text NOT NULL,
  `sortorder` bigint(20) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_help_video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Video Gallery Of Page Help';

-- Dumping data for table hosted_emr.page_help_video: ~2 rows (approximately)
DELETE FROM `page_help_video`;
/*!40000 ALTER TABLE `page_help_video` DISABLE KEYS */;
INSERT INTO `page_help_video` (`page_help_video_id`, `page_help_id`, `video_title`, `utube_url`, `sortorder`, `status`) VALUES
	(2, 1, 'OpenEMR Tutorial - Multiple Fee Sheets and Templates - ZH Healthcare Version ', 'http://youtu.be/rvNxSVyrS-0?hd=1', 2, 1),
	(3, 1, 'OpenEMR Tutorial - 2A - Setting up your clinic - Z', 'http://youtu.be/vKgr78LxsQo', 2, 1);
/*!40000 ALTER TABLE `page_help_video` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.plan_products
DROP TABLE IF EXISTS `plan_products`;
CREATE TABLE IF NOT EXISTS `plan_products` (
  `idplanproducts` bigint(20) NOT NULL AUTO_INCREMENT,
  `idplan` bigint(20) DEFAULT NULL,
  `idproducts` bigint(20) DEFAULT NULL,
  `added_date` date NOT NULL,
  `compulsory` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idplanproducts`),
  KEY `FK_plan_products_to_products` (`idproducts`),
  KEY `FK_plan_products_products` (`idplan`),
  CONSTRAINT `FK_plan_products_products` FOREIGN KEY (`idplan`) REFERENCES `hosted_plans` (`hp_id`),
  CONSTRAINT `FK_plan_products_to_products` FOREIGN KEY (`idproducts`) REFERENCES `products` (`idproducts`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.plan_products: ~11 rows (approximately)
DELETE FROM `plan_products`;
/*!40000 ALTER TABLE `plan_products` DISABLE KEYS */;
INSERT INTO `plan_products` (`idplanproducts`, `idplan`, `idproducts`, `added_date`, `compulsory`) VALUES
	(111, 1, 1, '2012-04-19', 0),
	(122, 16, 1, '2012-04-27', 0),
	(123, 16, 29, '2012-04-27', 0),
	(124, 16, 30, '2012-04-27', 0),
	(125, 16, 31, '2012-04-27', 0),
	(174, 15, 1, '2012-05-04', 0),
	(175, 15, 29, '2012-05-04', 0),
	(176, 15, 30, '2012-05-04', 0),
	(177, 17, 1, '2012-05-05', 0),
	(178, 17, 29, '2012-05-05', 0),
	(179, 17, 32, '2012-05-05', 0);
/*!40000 ALTER TABLE `plan_products` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.privileges
DROP TABLE IF EXISTS `privileges`;
CREATE TABLE IF NOT EXISTS `privileges` (
  `privilege_id` int(10) NOT NULL AUTO_INCREMENT,
  `controller_id` int(10) NOT NULL DEFAULT '0',
  `privilege_name` varchar(50) NOT NULL DEFAULT '0',
  `privilege_display_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Privileges Section of ACL\r\nConnecting with Controllers Table';

-- Dumping data for table hosted_emr.privileges: ~1 rows (approximately)
DELETE FROM `privileges`;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
INSERT INTO `privileges` (`privilege_id`, `controller_id`, `privilege_name`, `privilege_display_name`) VALUES
	(1, 1, 'Add', 'Add');
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `idproducts` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) DEFAULT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `product_feature` text,
  `cost` float DEFAULT NULL,
  `setup_fee` float DEFAULT '0',
  `payment_term` smallint(6) DEFAULT NULL COMMENT '0 one time, 1 monthly',
  `product_sort_order` bigint(20) DEFAULT NULL,
  `product_status` tinyint(4) DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `ProductType` tinyint(4) NOT NULL DEFAULT '3' COMMENT '1-link with Plan,2- Not Link with Plan,3-both',
  `provider_cost_nature` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:not increment with provider number ; 1: increment with provider number',
  `provider_setup_nature` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:not increment with provider number ; 1: increment with provider number',
  PRIMARY KEY (`idproducts`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1 COMMENT='Products Master Table';

-- Dumping data for table hosted_emr.products: ~5 rows (approximately)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`idproducts`, `product_name`, `customer_id`, `product_feature`, `cost`, `setup_fee`, `payment_term`, `product_sort_order`, `product_status`, `added_date`, `ProductType`, `provider_cost_nature`, `provider_setup_nature`) VALUES
	(1, 'ZHOpenEMR', '1', '<p>\r\n	Zh open EMR is a custom plan for advanced users who looking for the following section</p>\r\n<ul>\r\n	<li>\r\n		Billing Module</li>\r\n	<li>\r\n		Patient portal</li>\r\n	<li>\r\n		Billing information</li>\r\n</ul>\r\n', 75, 1250, 1, 1, 1, '2012-04-01', 1, 1, 0),
	(29, 'Advanced Billing Module', '1', '<p>\r\n	Billing Module</p>\r\n', 75, 1000, 1, 2, 1, '2012-04-27', 3, 1, 0),
	(30, 'eRx', '1', '<p>\r\n	eRx Module</p>\r\n', 35, 400, 1, 3, 1, '2012-04-27', 3, 1, 0),
	(31, 'Lab Exchange', '1', '<p>\r\n	Lab Exchange Module</p>\r\n', 50, 400, 1, 4, 1, '2012-04-27', 3, 1, 0),
	(32, 'Test Product', '1', '<p>\r\n	<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n', 50, 150, 1, 7, 1, '2012-05-05', 3, 1, 0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;


-- Dumping structure for procedure hosted_emr.product_cost
DROP PROCEDURE IF EXISTS `product_cost`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `product_cost`(IN `idproduct` BIGINT)
    COMMENT 'Retriving product costs based on idproducts'
BEGIN
select idproduct_feature,idproducts,user_from,user_to,cost from product_price where idproducts=idproduct and status=1 order by sortorder asc;
END//
DELIMITER ;


-- Dumping structure for procedure hosted_emr.product_description
DROP PROCEDURE IF EXISTS `product_description`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `product_description`(IN pid BIGINT)
BEGIN
	SELECT product_feature FROM products WHERE idproducts=pid;
    END//
DELIMITER ;


-- Dumping structure for procedure hosted_emr.product_payment_term
DROP PROCEDURE IF EXISTS `product_payment_term`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `product_payment_term`(IN `pid` BIGINT)
    COMMENT 'retriving product payment term is monthly or one time with product cost'
BEGIN
	DECLARE productcost float default 0;
	DECLARE payterm int default 0;
	select cost,setup_fee,payment_term  from products where idproducts=pid and product_status=1;
END//
DELIMITER ;


-- Dumping structure for table hosted_emr.product_price
DROP TABLE IF EXISTS `product_price`;
CREATE TABLE IF NOT EXISTS `product_price` (
  `idproduct_feature` bigint(20) NOT NULL AUTO_INCREMENT,
  `idproducts` bigint(20) DEFAULT '0',
  `user_from` bigint(20) DEFAULT '0',
  `user_to` bigint(20) DEFAULT '0',
  `cost` float NOT NULL DEFAULT '0',
  `sortorder` bigint(20) NOT NULL DEFAULT '1',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `added_date` date NOT NULL,
  PRIMARY KEY (`idproduct_feature`),
  KEY `FK_product_feature_Products` (`idproducts`),
  CONSTRAINT `FK_product_feature_Products` FOREIGN KEY (`idproducts`) REFERENCES `products` (`idproducts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Product Feature Main Table';

-- Dumping data for table hosted_emr.product_price: ~0 rows (approximately)
DELETE FROM `product_price`;
/*!40000 ALTER TABLE `product_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_price` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='Roles of ACL';

-- Dumping data for table hosted_emr.roles: ~4 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`role_id`, `role_name`) VALUES
	(1, 'Add'),
	(2, 'Edit'),
	(3, 'Delete'),
	(4, 'View');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.role_privilege_relation
DROP TABLE IF EXISTS `role_privilege_relation`;
CREATE TABLE IF NOT EXISTS `role_privilege_relation` (
  `role_id` int(10) DEFAULT NULL,
  `privilege_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Role Privilege Relation (ACL)';

-- Dumping data for table hosted_emr.role_privilege_relation: ~1 rows (approximately)
DELETE FROM `role_privilege_relation`;
/*!40000 ALTER TABLE `role_privilege_relation` DISABLE KEYS */;
INSERT INTO `role_privilege_relation` (`role_id`, `privilege_id`) VALUES
	(1, 1);
/*!40000 ALTER TABLE `role_privilege_relation` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.sub_product_list
DROP TABLE IF EXISTS `sub_product_list`;
CREATE TABLE IF NOT EXISTS `sub_product_list` (
  `sub_product_listId` bigint(20) NOT NULL AUTO_INCREMENT,
  `idproducts` bigint(20) NOT NULL DEFAULT '0',
  `sub_idproducts` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sub_product_listId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Link products wth a master product for compulsory inserting';

-- Dumping data for table hosted_emr.sub_product_list: ~1 rows (approximately)
DELETE FROM `sub_product_list`;
/*!40000 ALTER TABLE `sub_product_list` DISABLE KEYS */;
INSERT INTO `sub_product_list` (`sub_product_listId`, `idproducts`, `sub_idproducts`) VALUES
	(1, 1, 29);
/*!40000 ALTER TABLE `sub_product_list` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.unit
DROP TABLE IF EXISTS `unit`;
CREATE TABLE IF NOT EXISTS `unit` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` float(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint(6) DEFAULT NULL,
  `Population` int(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` float(3,1) DEFAULT NULL,
  `GNP` float(10,2) DEFAULT NULL,
  `GNPOld` float(10,2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int(11) DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.unit: 237 rows
DELETE FROM `unit`;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` (`Code`, `Name`, `Continent`, `Region`, `SurfaceArea`, `IndepYear`, `Population`, `LifeExpectancy`, `GNP`, `GNPOld`, `LocalName`, `GovernmentForm`, `HeadOfState`, `Capital`, `Code2`) VALUES
	('AFG', 'Afghanistan', 'Asia', 'Southern and Central Asia', 652090.00, 1919, 22720000, 45.9, 5976.00, NULL, 'Afganistan/Afqanestan', 'Islamic Emirate', 'Mohammad Omar', 1, 'AF'),
	('ALB', 'Albania', 'Europe', 'Southern Europe', 28748.00, 1912, 3401200, 71.6, 3205.00, 2500.00, 'ShqipÃ«ria', 'Republic', 'Rexhep Mejdani', 34, 'AL'),
	('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.00, 1962, 31471000, 69.7, 49982.00, 46966.00, 'Al-Jazaâ€™ir/AlgÃ©rie', 'Republic', 'Abdelaziz Bouteflika', 35, 'DZ'),
	('ASM', 'American Samoa', 'Oceania', 'Polynesia', 199.00, NULL, 68000, 75.1, 334.00, NULL, 'Amerika Samoa', 'US Territory', 'George W. Bush', 54, 'AS'),
	('AND', 'Andorra', 'Europe', 'Southern Europe', 468.00, 1278, 78000, 83.5, 1630.00, NULL, 'Andorra', 'Parliamentary Coprincipality', '', 55, 'AD'),
	('AGO', 'Angola', 'Africa', 'Central Africa', 1246700.00, 1975, 12878000, 38.3, 6648.00, 7984.00, 'Angola', 'Republic', 'JosÃ© Eduardo dos Santos', 56, 'AO'),
	('AIA', 'Anguilla', 'North America', 'Caribbean', 96.00, NULL, 8000, 76.1, 63.20, NULL, 'Anguilla', 'Dependent Territory of the UK', 'Elisabeth II', 62, 'AI'),
	('ATG', 'Antigua and Barbuda', 'North America', 'Caribbean', 442.00, 1981, 68000, 70.5, 612.00, 584.00, 'Antigua and Barbuda', 'Constitutional Monarchy', 'Elisabeth II', 63, 'AG'),
	('ARE', 'United Arab Emirates', 'Asia', 'Middle East', 83600.00, 1971, 2441000, 74.1, 37966.00, 36846.00, 'Al-Imarat al-Â´Arabiya al-Muttahida', 'Emirate Federation', 'Zayid bin Sultan al-Nahayan', 65, 'AE'),
	('ARG', 'Argentina', 'South America', 'South America', 2780400.00, 1816, 37032000, 75.1, 340238.00, 323310.00, 'Argentina', 'Federal Republic', 'Fernando de la RÃºa', 69, 'AR'),
	('ARM', 'Armenia', 'Asia', 'Middle East', 29800.00, 1991, 3520000, 66.4, 1813.00, 1627.00, 'Hajastan', 'Republic', 'Robert KotÅ¡arjan', 126, 'AM'),
	('ABW', 'Aruba', 'North America', 'Caribbean', 193.00, NULL, 103000, 78.4, 828.00, 793.00, 'Aruba', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', 129, 'AW'),
	('AUS', 'Australia', 'Oceania', 'Australia and New Zealand', 7741220.00, 1901, 18886000, 79.8, 351182.00, 392911.00, 'Australia', 'Constitutional Monarchy, Federation', 'Elisabeth II', 135, 'AU'),
	('AZE', 'Azerbaijan', 'Asia', 'Middle East', 86600.00, 1991, 7734000, 62.9, 4127.00, 4100.00, 'AzÃ¤rbaycan', 'Federal Republic', 'HeydÃ¤r Ã„liyev', 144, 'AZ'),
	('BHS', 'Bahamas', 'North America', 'Caribbean', 13878.00, 1973, 307000, 71.1, 3527.00, 3347.00, 'The Bahamas', 'Constitutional Monarchy', 'Elisabeth II', 148, 'BS'),
	('BHR', 'Bahrain', 'Asia', 'Middle East', 694.00, 1971, 617000, 73.0, 6366.00, 6097.00, 'Al-Bahrayn', 'Monarchy (Emirate)', 'Hamad ibn Isa al-Khalifa', 149, 'BH'),
	('BGD', 'Bangladesh', 'Asia', 'Southern and Central Asia', 143998.00, 1971, 129155000, 60.2, 32852.00, 31966.00, 'Bangladesh', 'Republic', 'Shahabuddin Ahmad', 150, 'BD'),
	('BRB', 'Barbados', 'North America', 'Caribbean', 430.00, 1966, 270000, 73.0, 2223.00, 2186.00, 'Barbados', 'Constitutional Monarchy', 'Elisabeth II', 174, 'BB'),
	('BEL', 'Belgium', 'Europe', 'Western Europe', 30518.00, 1830, 10239000, 77.8, 249704.00, 243948.00, 'BelgiÃ«/Belgique', 'Constitutional Monarchy, Federation', 'Albert II', 179, 'BE'),
	('BLZ', 'Belize', 'North America', 'Central America', 22696.00, 1981, 241000, 70.9, 630.00, 616.00, 'Belize', 'Constitutional Monarchy', 'Elisabeth II', 185, 'BZ'),
	('BEN', 'Benin', 'Africa', 'Western Africa', 112622.00, 1960, 6097000, 50.2, 2357.00, 2141.00, 'BÃ©nin', 'Republic', 'Mathieu KÃ©rÃ©kou', 187, 'BJ'),
	('BMU', 'Bermuda', 'North America', 'North America', 53.00, NULL, 65000, 76.9, 2328.00, 2190.00, 'Bermuda', 'Dependent Territory of the UK', 'Elisabeth II', 191, 'BM'),
	('BTN', 'Bhutan', 'Asia', 'Southern and Central Asia', 47000.00, 1910, 2124000, 52.4, 372.00, 383.00, 'Druk-Yul', 'Monarchy', 'Jigme Singye Wangchuk', 192, 'BT'),
	('BOL', 'Bolivia', 'South America', 'South America', 1098581.00, 1825, 8329000, 63.7, 8571.00, 7967.00, 'Bolivia', 'Republic', 'Hugo BÃ¡nzer SuÃ¡rez', 194, 'BO'),
	('BIH', 'Bosnia and Herzegovina', 'Europe', 'Southern Europe', 51197.00, 1992, 3972000, 71.5, 2841.00, NULL, 'Bosna i Hercegovina', 'Federal Republic', 'Ante Jelavic', 201, 'BA'),
	('BWA', 'Botswana', 'Africa', 'Southern Africa', 581730.00, 1966, 1622000, 39.3, 4834.00, 4935.00, 'Botswana', 'Republic', 'Festus G. Mogae', 204, 'BW'),
	('BRA', 'Brazil', 'South America', 'South America', 8547403.00, 1822, 170115000, 62.9, 776739.00, 804108.00, 'Brasil', 'Federal Republic', 'Fernando Henrique Cardoso', 211, 'BR'),
	('GBR', 'United Kingdom', 'Europe', 'British Islands', 242900.00, 1066, 59623400, 77.7, 1378330.00, 1296830.00, 'United Kingdom', 'Constitutional Monarchy', 'Elisabeth II', 456, 'GB'),
	('VGB', 'Virgin Islands, British', 'North America', 'Caribbean', 151.00, NULL, 21000, 75.4, 612.00, 573.00, 'British Virgin Islands', 'Dependent Territory of the UK', 'Elisabeth II', 537, 'VG'),
	('BRN', 'Brunei', 'Asia', 'Southeast Asia', 5765.00, 1984, 328000, 73.6, 11705.00, 12460.00, 'Brunei Darussalam', 'Monarchy (Sultanate)', 'Haji Hassan al-Bolkiah', 538, 'BN'),
	('BGR', 'Bulgaria', 'Europe', 'Eastern Europe', 110994.00, 1908, 8190900, 70.9, 12178.00, 10169.00, 'Balgarija', 'Republic', 'Petar Stojanov', 539, 'BG'),
	('BFA', 'Burkina Faso', 'Africa', 'Western Africa', 274000.00, 1960, 11937000, 46.7, 2425.00, 2201.00, 'Burkina Faso', 'Republic', 'Blaise CompaorÃ©', 549, 'BF'),
	('BDI', 'Burundi', 'Africa', 'Eastern Africa', 27834.00, 1962, 6695000, 46.2, 903.00, 982.00, 'Burundi/Uburundi', 'Republic', 'Pierre Buyoya', 552, 'BI'),
	('CYM', 'Cayman Islands', 'North America', 'Caribbean', 264.00, NULL, 38000, 78.9, 1263.00, 1186.00, 'Cayman Islands', 'Dependent Territory of the UK', 'Elisabeth II', 553, 'KY'),
	('CHL', 'Chile', 'South America', 'South America', 756626.00, 1810, 15211000, 75.7, 72949.00, 75780.00, 'Chile', 'Republic', 'Ricardo Lagos Escobar', 554, 'CL'),
	('COK', 'Cook Islands', 'Oceania', 'Polynesia', 236.00, NULL, 20000, 71.1, 100.00, NULL, 'The Cook Islands', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 583, 'CK'),
	('CRI', 'Costa Rica', 'North America', 'Central America', 51100.00, 1821, 4023000, 75.8, 10226.00, 9757.00, 'Costa Rica', 'Republic', 'Miguel Ãngel RodrÃ­guez EcheverrÃ­a', 584, 'CR'),
	('DJI', 'Djibouti', 'Africa', 'Eastern Africa', 23200.00, 1977, 638000, 50.8, 382.00, 373.00, 'Djibouti/Jibuti', 'Republic', 'Ismail Omar Guelleh', 585, 'DJ'),
	('DMA', 'Dominica', 'North America', 'Caribbean', 751.00, 1978, 71000, 73.4, 256.00, 243.00, 'Dominica', 'Republic', 'Vernon Shaw', 586, 'DM'),
	('DOM', 'Dominican Republic', 'North America', 'Caribbean', 48511.00, 1844, 8495000, 73.2, 15846.00, 15076.00, 'RepÃºblica Dominicana', 'Republic', 'HipÃ³lito MejÃ­a DomÃ­nguez', 587, 'DO'),
	('ECU', 'Ecuador', 'South America', 'South America', 283561.00, 1822, 12646000, 71.1, 19770.00, 19769.00, 'Ecuador', 'Republic', 'Gustavo Noboa Bejarano', 594, 'EC'),
	('EGY', 'Egypt', 'Africa', 'Northern Africa', 1001449.00, 1922, 68470000, 63.3, 82710.00, 75617.00, 'Misr', 'Republic', 'Hosni Mubarak', 608, 'EG'),
	('SLV', 'El Salvador', 'North America', 'Central America', 21041.00, 1841, 6276000, 69.7, 11863.00, 11203.00, 'El Salvador', 'Republic', 'Francisco Guillermo Flores PÃ©rez', 645, 'SV'),
	('ERI', 'Eritrea', 'Africa', 'Eastern Africa', 117600.00, 1993, 3850000, 55.8, 650.00, 755.00, 'Ertra', 'Republic', 'Isayas Afewerki [Isaias Afwerki]', 652, 'ER'),
	('ESP', 'Spain', 'Europe', 'Southern Europe', 505992.00, 1492, 39441700, 78.8, 553233.00, 532031.00, 'EspaÃ±a', 'Constitutional Monarchy', 'Juan Carlos I', 653, 'ES'),
	('ZAF', 'South Africa', 'Africa', 'Southern Africa', 1221037.00, 1910, 40377000, 51.1, 116729.00, 129092.00, 'South Africa', 'Republic', 'Thabo Mbeki', 716, 'ZA'),
	('ETH', 'Ethiopia', 'Africa', 'Eastern Africa', 1104300.00, -1000, 62565000, 45.2, 6353.00, 6180.00, 'YeItyopÂ´iya', 'Republic', 'Negasso Gidada', 756, 'ET'),
	('FLK', 'Falkland Islands', 'South America', 'South America', 12173.00, NULL, 2000, NULL, 0.00, NULL, 'Falkland Islands', 'Dependent Territory of the UK', 'Elisabeth II', 763, 'FK'),
	('FJI', 'Fiji Islands', 'Oceania', 'Melanesia', 18274.00, 1970, 817000, 67.9, 1536.00, 2149.00, 'Fiji Islands', 'Republic', 'Josefa Iloilo', 764, 'FJ'),
	('PHL', 'Philippines', 'Asia', 'Southeast Asia', 300000.00, 1946, 75967000, 67.5, 65107.00, 82239.00, 'Pilipinas', 'Republic', 'Gloria Macapagal-Arroyo', 766, 'PH'),
	('FRO', 'Faroe Islands', 'Europe', 'Nordic Countries', 1399.00, NULL, 43000, 78.4, 0.00, NULL, 'FÃ¸royar', 'Part of Denmark', 'Margrethe II', 901, 'FO'),
	('GAB', 'Gabon', 'Africa', 'Central Africa', 267668.00, 1960, 1226000, 50.1, 5493.00, 5279.00, 'Le Gabon', 'Republic', 'Omar Bongo', 902, 'GA'),
	('GMB', 'Gambia', 'Africa', 'Western Africa', 11295.00, 1965, 1305000, 53.2, 320.00, 325.00, 'The Gambia', 'Republic', 'Yahya Jammeh', 904, 'GM'),
	('GEO', 'Georgia', 'Asia', 'Middle East', 69700.00, 1991, 4968000, 64.5, 6064.00, 5924.00, 'Sakartvelo', 'Republic', 'Eduard Å evardnadze', 905, 'GE'),
	('GHA', 'Ghana', 'Africa', 'Western Africa', 238533.00, 1957, 20212000, 57.4, 7137.00, 6884.00, 'Ghana', 'Republic', 'John Kufuor', 910, 'GH'),
	('GIB', 'Gibraltar', 'Europe', 'Southern Europe', 6.00, NULL, 25000, 79.0, 258.00, NULL, 'Gibraltar', 'Dependent Territory of the UK', 'Elisabeth II', 915, 'GI'),
	('GRD', 'Grenada', 'North America', 'Caribbean', 344.00, 1974, 94000, 64.5, 318.00, NULL, 'Grenada', 'Constitutional Monarchy', 'Elisabeth II', 916, 'GD'),
	('GRL', 'Greenland', 'North America', 'North America', 2166090.00, NULL, 56000, 68.1, 0.00, NULL, 'Kalaallit Nunaat/GrÃ¸nland', 'Part of Denmark', 'Margrethe II', 917, 'GL'),
	('GLP', 'Guadeloupe', 'North America', 'Caribbean', 1705.00, NULL, 456000, 77.0, 3501.00, NULL, 'Guadeloupe', 'Overseas Department of France', 'Jacques Chirac', 919, 'GP'),
	('GUM', 'Guam', 'Oceania', 'Micronesia', 549.00, NULL, 168000, 77.8, 1197.00, 1136.00, 'Guam', 'US Territory', 'George W. Bush', 921, 'GU'),
	('GTM', 'Guatemala', 'North America', 'Central America', 108889.00, 1821, 11385000, 66.2, 19008.00, 17797.00, 'Guatemala', 'Republic', 'Alfonso Portillo Cabrera', 922, 'GT'),
	('GIN', 'Guinea', 'Africa', 'Western Africa', 245857.00, 1958, 7430000, 45.6, 2352.00, 2383.00, 'GuinÃ©e', 'Republic', 'Lansana ContÃ©', 926, 'GN'),
	('GNB', 'Guinea-Bissau', 'Africa', 'Western Africa', 36125.00, 1974, 1213000, 49.0, 293.00, 272.00, 'GuinÃ©-Bissau', 'Republic', 'Kumba IalÃ¡', 927, 'GW'),
	('GUY', 'Guyana', 'South America', 'South America', 214969.00, 1966, 861000, 64.0, 722.00, 743.00, 'Guyana', 'Republic', 'Bharrat Jagdeo', 928, 'GY'),
	('HTI', 'Haiti', 'North America', 'Caribbean', 27750.00, 1804, 8222000, 49.2, 3459.00, 3107.00, 'HaÃ¯ti/Dayti', 'Republic', 'Jean-Bertrand Aristide', 929, 'HT'),
	('HND', 'Honduras', 'North America', 'Central America', 112088.00, 1838, 6485000, 69.9, 5333.00, 4697.00, 'Honduras', 'Republic', 'Carlos Roberto Flores FacussÃ©', 933, 'HN'),
	('HKG', 'Hong Kong', 'Asia', 'Eastern Asia', 1075.00, NULL, 6782000, 79.5, 166448.00, 173610.00, 'Xianggang/Hong Kong', 'Special Administrative Region of China', 'Jiang Zemin', 937, 'HK'),
	('SJM', 'Svalbard and Jan Mayen', 'Europe', 'Nordic Countries', 62422.00, NULL, 3200, NULL, 0.00, NULL, 'Svalbard og Jan Mayen', 'Dependent Territory of Norway', 'Harald V', 938, 'SJ'),
	('IDN', 'Indonesia', 'Asia', 'Southeast Asia', 1904569.00, 1945, 212107000, 68.0, 84982.00, 215002.00, 'Indonesia', 'Republic', 'Abdurrahman Wahid', 939, 'ID'),
	('IND', 'India', 'Asia', 'Southern and Central Asia', 3287263.00, 1947, 1013662000, 62.5, 447114.00, 430572.00, 'Bharat/India', 'Federal Republic', 'Kocheril Raman Narayanan', 1109, 'IN'),
	('IRQ', 'Iraq', 'Asia', 'Middle East', 438317.00, 1932, 23115000, 66.5, 11500.00, NULL, 'Al-Â´Iraq', 'Republic', 'Saddam Hussein al-Takriti', 1365, 'IQ'),
	('IRN', 'Iran', 'Asia', 'Southern and Central Asia', 1648195.00, 1906, 67702000, 69.7, 195746.00, 160151.00, 'Iran', 'Islamic Republic', 'Ali Mohammad Khatami-Ardakani', 1380, 'IR'),
	('IRL', 'Ireland', 'Europe', 'British Islands', 70273.00, 1921, 3775100, 76.8, 75921.00, 73132.00, 'Ireland/Ã‰ire', 'Republic', 'Mary McAleese', 1447, 'IE'),
	('ISL', 'Iceland', 'Europe', 'Nordic Countries', 103000.00, 1944, 279000, 79.4, 8255.00, 7474.00, 'Ãsland', 'Republic', 'Ã“lafur Ragnar GrÃ­msson', 1449, 'IS'),
	('ISR', 'Israel', 'Asia', 'Middle East', 21056.00, 1948, 6217000, 78.6, 97477.00, 98577.00, 'Yisraâ€™el/Israâ€™il', 'Republic', 'Moshe Katzav', 1450, 'IL'),
	('ITA', 'Italy', 'Europe', 'Southern Europe', 301316.00, 1861, 57680000, 79.0, 1161755.00, 1145372.00, 'Italia', 'Republic', 'Carlo Azeglio Ciampi', 1464, 'IT'),
	('TMP', 'East Timor', 'Asia', 'Southeast Asia', 14874.00, NULL, 885000, 46.0, 0.00, NULL, 'Timor Timur', 'Administrated by the UN', 'JosÃ© Alexandre GusmÃ£o', 1522, 'TP'),
	('AUT', 'Austria', 'Europe', 'Western Europe', 83859.00, 1918, 8091800, 77.7, 211860.00, 206025.00, 'Ã–sterreich', 'Federal Republic', 'Thomas Klestil', 1523, 'AT'),
	('JAM', 'Jamaica', 'North America', 'Caribbean', 10990.00, 1962, 2583000, 75.2, 6871.00, 6722.00, 'Jamaica', 'Constitutional Monarchy', 'Elisabeth II', 1530, 'JM'),
	('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.00, -660, 126714000, 80.7, 3787042.00, 4192638.00, 'Nihon/Nippon', 'Constitutional Monarchy', 'Akihito', 1532, 'JP'),
	('YEM', 'Yemen', 'Asia', 'Middle East', 527968.00, 1918, 18112000, 59.8, 6041.00, 5729.00, 'Al-Yaman', 'Republic', 'Ali Abdallah Salih', 1780, 'YE'),
	('JOR', 'Jordan', 'Asia', 'Middle East', 88946.00, 1946, 5083000, 77.4, 7526.00, 7051.00, 'Al-Urdunn', 'Constitutional Monarchy', 'Abdullah II', 1786, 'JO'),
	('CXR', 'Christmas Island', 'Oceania', 'Australia and New Zealand', 135.00, NULL, 2500, NULL, 0.00, NULL, 'Christmas Island', 'Territory of Australia', 'Elisabeth II', 1791, 'CX'),
	('YUG', 'Yugoslavia', 'Europe', 'Southern Europe', 102173.00, 1918, 10640000, 72.4, 17000.00, NULL, 'Jugoslavija', 'Federal Republic', 'Vojislav KoÅ¡tunica', 1792, 'YU'),
	('KHM', 'Cambodia', 'Asia', 'Southeast Asia', 181035.00, 1953, 11168000, 56.5, 5121.00, 5670.00, 'KÃ¢mpuchÃ©a', 'Constitutional Monarchy', 'Norodom Sihanouk', 1800, 'KH'),
	('CMR', 'Cameroon', 'Africa', 'Central Africa', 475442.00, 1960, 15085000, 54.8, 9174.00, 8596.00, 'Cameroun/Cameroon', 'Republic', 'Paul Biya', 1804, 'CM'),
	('CAN', 'Canada', 'North America', 'North America', 9970610.00, 1867, 31147000, 79.4, 598862.00, 625626.00, 'Canada', 'Constitutional Monarchy, Federation', 'Elisabeth II', 1822, 'CA'),
	('CPV', 'Cape Verde', 'Africa', 'Western Africa', 4033.00, 1975, 428000, 68.9, 435.00, 420.00, 'Cabo Verde', 'Republic', 'AntÃ³nio Mascarenhas Monteiro', 1859, 'CV'),
	('KAZ', 'Kazakstan', 'Asia', 'Southern and Central Asia', 2724900.00, 1991, 16223000, 63.2, 24375.00, 23383.00, 'Qazaqstan', 'Republic', 'Nursultan Nazarbajev', 1864, 'KZ'),
	('KEN', 'Kenya', 'Africa', 'Eastern Africa', 580367.00, 1963, 30080000, 48.0, 9217.00, 10241.00, 'Kenya', 'Republic', 'Daniel arap Moi', 1881, 'KE'),
	('CAF', 'Central African Republic', 'Africa', 'Central Africa', 622984.00, 1960, 3615000, 44.0, 1054.00, 993.00, 'Centrafrique/BÃª-AfrÃ®ka', 'Republic', 'Ange-FÃ©lix PatassÃ©', 1889, 'CF'),
	('CHN', 'China', 'Asia', 'Eastern Asia', 9572900.00, -1523, 1277558000, 71.4, 982268.00, 917719.00, 'Zhongquo', 'People\'sRepublic', 'Jiang Zemin', 1891, 'CN'),
	('KGZ', 'Kyrgyzstan', 'Asia', 'Southern and Central Asia', 199900.00, 1991, 4699000, 63.4, 1626.00, 1767.00, 'Kyrgyzstan', 'Republic', 'Askar Akajev', 2253, 'KG'),
	('KIR', 'Kiribati', 'Oceania', 'Micronesia', 726.00, 1979, 83000, 59.8, 40.70, NULL, 'Kiribati', 'Republic', 'Teburoro Tito', 2256, 'KI'),
	('COL', 'Colombia', 'South America', 'South America', 1138914.00, 1810, 42321000, 70.3, 102896.00, 105116.00, 'Colombia', 'Republic', 'AndrÃ©s Pastrana Arango', 2257, 'CO'),
	('COM', 'Comoros', 'Africa', 'Eastern Africa', 1862.00, 1975, 578000, 60.0, 4401.00, 4361.00, 'Komori/Comores', 'Republic', 'Azali Assoumani', 2295, 'KM'),
	('COG', 'Congo', 'Africa', 'Central Africa', 342000.00, 1960, 2943000, 47.4, 2108.00, 2287.00, 'Congo', 'Republic', 'Denis Sassou-Nguesso', 2296, 'CG'),
	('COD', 'Congo, The Democratic Republic of the', 'Africa', 'Central Africa', 2344858.00, 1960, 51654000, 48.8, 6964.00, 2474.00, 'RÃ©publique DÃ©mocratique du Congo', 'Republic', 'Joseph Kabila', 2298, 'CD'),
	('CCK', 'Cocos (Keeling) Islands', 'Oceania', 'Australia and New Zealand', 14.00, NULL, 600, NULL, 0.00, NULL, 'Cocos (Keeling) Islands', 'Territory of Australia', 'Elisabeth II', 2317, 'CC'),
	('PRK', 'North Korea', 'Asia', 'Eastern Asia', 120538.00, 1948, 24039000, 70.7, 5332.00, NULL, 'Choson Minjujuui InÂ´min Konghwaguk (Bukhan)', 'Socialistic Republic', 'Kim Jong-il', 2318, 'KP'),
	('KOR', 'South Korea', 'Asia', 'Eastern Asia', 99434.00, 1948, 46844000, 74.4, 320749.00, 442544.00, 'Taehan Minâ€™guk (Namhan)', 'Republic', 'Kim Dae-jung', 2331, 'KR'),
	('GRC', 'Greece', 'Europe', 'Southern Europe', 131626.00, 1830, 10545700, 78.4, 120724.00, 119946.00, 'EllÃ¡da', 'Republic', 'Kostis Stefanopoulos', 2401, 'GR'),
	('HRV', 'Croatia', 'Europe', 'Southern Europe', 56538.00, 1991, 4473000, 73.7, 20208.00, 19300.00, 'Hrvatska', 'Republic', 'Å tipe Mesic', 2409, 'HR'),
	('CUB', 'Cuba', 'North America', 'Caribbean', 110861.00, 1902, 11201000, 76.2, 17843.00, 18862.00, 'Cuba', 'Socialistic Republic', 'Fidel Castro Ruz', 2413, 'CU'),
	('KWT', 'Kuwait', 'Asia', 'Middle East', 17818.00, 1961, 1972000, 76.1, 27037.00, 30373.00, 'Al-Kuwayt', 'Constitutional Monarchy (Emirate)', 'Jabir al-Ahmad al-Jabir al-Sabah', 2429, 'KW'),
	('CYP', 'Cyprus', 'Asia', 'Middle East', 9251.00, 1960, 754700, 76.7, 9333.00, 8246.00, 'KÃ½pros/Kibris', 'Republic', 'Glafkos Klerides', 2430, 'CY'),
	('LAO', 'Laos', 'Asia', 'Southeast Asia', 236800.00, 1953, 5433000, 53.1, 1292.00, 1746.00, 'Lao', 'Republic', 'Khamtay Siphandone', 2432, 'LA'),
	('LVA', 'Latvia', 'Europe', 'Baltic Countries', 64589.00, 1991, 2424200, 68.4, 6398.00, 5639.00, 'Latvija', 'Republic', 'Vaira Vike-Freiberga', 2434, 'LV'),
	('LSO', 'Lesotho', 'Africa', 'Southern Africa', 30355.00, 1966, 2153000, 50.8, 1061.00, 1161.00, 'Lesotho', 'Constitutional Monarchy', 'Letsie III', 2437, 'LS'),
	('LBN', 'Lebanon', 'Asia', 'Middle East', 10400.00, 1941, 3282000, 71.3, 17121.00, 15129.00, 'Lubnan', 'Republic', 'Ã‰mile Lahoud', 2438, 'LB'),
	('LBR', 'Liberia', 'Africa', 'Western Africa', 111369.00, 1847, 3154000, 51.0, 2012.00, NULL, 'Liberia', 'Republic', 'Charles Taylor', 2440, 'LR'),
	('LBY', 'Libyan Arab Jamahiriya', 'Africa', 'Northern Africa', 1759540.00, 1951, 5605000, 75.5, 44806.00, 40562.00, 'Libiya', 'Socialistic State', 'Muammar al-Qadhafi', 2441, 'LY'),
	('LIE', 'Liechtenstein', 'Europe', 'Western Europe', 160.00, 1806, 32300, 78.8, 1119.00, 1084.00, 'Liechtenstein', 'Constitutional Monarchy', 'Hans-Adam II', 2446, 'LI'),
	('LTU', 'Lithuania', 'Europe', 'Baltic Countries', 65301.00, 1991, 3698500, 69.1, 10692.00, 9585.00, 'Lietuva', 'Republic', 'Valdas Adamkus', 2447, 'LT'),
	('LUX', 'Luxembourg', 'Europe', 'Western Europe', 2586.00, 1867, 435700, 77.1, 16321.00, 15519.00, 'Luxembourg/LÃ«tzebuerg', 'Constitutional Monarchy', 'Henri', 2452, 'LU'),
	('ESH', 'Western Sahara', 'Africa', 'Northern Africa', 266000.00, NULL, 293000, 49.8, 60.00, NULL, 'As-Sahrawiya', 'Occupied by Marocco', 'Mohammed Abdel Aziz', 2453, 'EH'),
	('MAC', 'Macao', 'Asia', 'Eastern Asia', 18.00, NULL, 473000, 81.6, 5749.00, 5940.00, 'Macau/Aomen', 'Special Administrative Region of China', 'Jiang Zemin', 2454, 'MO'),
	('MDG', 'Madagascar', 'Africa', 'Eastern Africa', 587041.00, 1960, 15942000, 55.0, 3750.00, 3545.00, 'Madagasikara/Madagascar', 'Federal Republic', 'Didier Ratsiraka', 2455, 'MG'),
	('MKD', 'Macedonia', 'Europe', 'Southern Europe', 25713.00, 1991, 2024000, 73.8, 1694.00, 1915.00, 'Makedonija', 'Republic', 'Boris Trajkovski', 2460, 'MK'),
	('MWI', 'Malawi', 'Africa', 'Eastern Africa', 118484.00, 1964, 10925000, 37.6, 1687.00, 2527.00, 'Malawi', 'Republic', 'Bakili Muluzi', 2462, 'MW'),
	('MDV', 'Maldives', 'Asia', 'Southern and Central Asia', 298.00, 1965, 286000, 62.2, 199.00, NULL, 'Dhivehi Raajje/Maldives', 'Republic', 'Maumoon Abdul Gayoom', 2463, 'MV'),
	('MYS', 'Malaysia', 'Asia', 'Southeast Asia', 329758.00, 1957, 22244000, 70.8, 69213.00, 97884.00, 'Malaysia', 'Constitutional Monarchy, Federation', 'Salahuddin Abdul Aziz Shah Alhaj', 2464, 'MY'),
	('MLI', 'Mali', 'Africa', 'Western Africa', 1240192.00, 1960, 11234000, 46.7, 2642.00, 2453.00, 'Mali', 'Republic', 'Alpha Oumar KonarÃ©', 2482, 'ML'),
	('MLT', 'Malta', 'Europe', 'Southern Europe', 316.00, 1964, 380200, 77.9, 3512.00, 3338.00, 'Malta', 'Republic', 'Guido de Marco', 2484, 'MT'),
	('MAR', 'Morocco', 'Africa', 'Northern Africa', 446550.00, 1956, 28351000, 69.1, 36124.00, 33514.00, 'Al-Maghrib', 'Constitutional Monarchy', 'Mohammed VI', 2486, 'MA'),
	('MHL', 'Marshall Islands', 'Oceania', 'Micronesia', 181.00, 1990, 64000, 65.5, 97.00, NULL, 'Marshall Islands/Majol', 'Republic', 'Kessai Note', 2507, 'MH'),
	('MTQ', 'Martinique', 'North America', 'Caribbean', 1102.00, NULL, 395000, 78.3, 2731.00, 2559.00, 'Martinique', 'Overseas Department of France', 'Jacques Chirac', 2508, 'MQ'),
	('MRT', 'Mauritania', 'Africa', 'Western Africa', 1025520.00, 1960, 2670000, 50.8, 998.00, 1081.00, 'Muritaniya/Mauritanie', 'Republic', 'Maaouiya Ould SidÂ´Ahmad Taya', 2509, 'MR'),
	('MUS', 'Mauritius', 'Africa', 'Eastern Africa', 2040.00, 1968, 1158000, 71.0, 4251.00, 4186.00, 'Mauritius', 'Republic', 'Cassam Uteem', 2511, 'MU'),
	('MYT', 'Mayotte', 'Africa', 'Eastern Africa', 373.00, NULL, 149000, 59.5, 0.00, NULL, 'Mayotte', 'Territorial Collectivity of France', 'Jacques Chirac', 2514, 'YT'),
	('MEX', 'Mexico', 'North America', 'Central America', 1958201.00, 1810, 98881000, 71.5, 414972.00, 401461.00, 'MÃ©xico', 'Federal Republic', 'Vicente Fox Quesada', 2515, 'MX'),
	('FSM', 'Micronesia, Federated States of', 'Oceania', 'Micronesia', 702.00, 1990, 119000, 68.6, 212.00, NULL, 'Micronesia', 'Federal Republic', 'Leo A. Falcam', 2689, 'FM'),
	('MDA', 'Moldova', 'Europe', 'Eastern Europe', 33851.00, 1991, 4380000, 64.5, 1579.00, 1872.00, 'Moldova', 'Republic', 'Vladimir Voronin', 2690, 'MD'),
	('MCO', 'Monaco', 'Europe', 'Western Europe', 1.50, 1861, 34000, 78.8, 776.00, NULL, 'Monaco', 'Constitutional Monarchy', 'Rainier III', 2695, 'MC'),
	('MNG', 'Mongolia', 'Asia', 'Eastern Asia', 1566500.00, 1921, 2662000, 67.3, 1043.00, 933.00, 'Mongol Uls', 'Republic', 'Natsagiin Bagabandi', 2696, 'MN'),
	('MSR', 'Montserrat', 'North America', 'Caribbean', 102.00, NULL, 11000, 78.0, 109.00, NULL, 'Montserrat', 'Dependent Territory of the UK', 'Elisabeth II', 2697, 'MS'),
	('MOZ', 'Mozambique', 'Africa', 'Eastern Africa', 801590.00, 1975, 19680000, 37.5, 2891.00, 2711.00, 'MoÃ§ambique', 'Republic', 'JoaquÃ­m A. Chissano', 2698, 'MZ'),
	('MMR', 'Myanmar', 'Asia', 'Southeast Asia', 676578.00, 1948, 45611000, 54.9, 180375.00, 171028.00, 'Myanma Pye', 'Republic', 'kenraali Than Shwe', 2710, 'MM'),
	('NAM', 'Namibia', 'Africa', 'Southern Africa', 824292.00, 1990, 1726000, 42.5, 3101.00, 3384.00, 'Namibia', 'Republic', 'Sam Nujoma', 2726, 'NA'),
	('NRU', 'Nauru', 'Oceania', 'Micronesia', 21.00, 1968, 12000, 60.8, 197.00, NULL, 'Naoero/Nauru', 'Republic', 'Bernard Dowiyogo', 2728, 'NR'),
	('NPL', 'Nepal', 'Asia', 'Southern and Central Asia', 147181.00, 1769, 23930000, 57.8, 4768.00, 4837.00, 'Nepal', 'Constitutional Monarchy', 'Gyanendra Bir Bikram', 2729, 'NP'),
	('NIC', 'Nicaragua', 'North America', 'Central America', 130000.00, 1838, 5074000, 68.7, 1988.00, 2023.00, 'Nicaragua', 'Republic', 'Arnoldo AlemÃ¡n Lacayo', 2734, 'NI'),
	('NER', 'Niger', 'Africa', 'Western Africa', 1267000.00, 1960, 10730000, 41.3, 1706.00, 1580.00, 'Niger', 'Republic', 'Mamadou Tandja', 2738, 'NE'),
	('NGA', 'Nigeria', 'Africa', 'Western Africa', 923768.00, 1960, 111506000, 51.6, 65707.00, 58623.00, 'Nigeria', 'Federal Republic', 'Olusegun Obasanjo', 2754, 'NG'),
	('NIU', 'Niue', 'Oceania', 'Polynesia', 260.00, NULL, 2000, NULL, 0.00, NULL, 'Niue', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 2805, 'NU'),
	('NFK', 'Norfolk Island', 'Oceania', 'Australia and New Zealand', 36.00, NULL, 2000, NULL, 0.00, NULL, 'Norfolk Island', 'Territory of Australia', 'Elisabeth II', 2806, 'NF'),
	('NOR', 'Norway', 'Europe', 'Nordic Countries', 323877.00, 1905, 4478500, 78.7, 145895.00, 153370.00, 'Norge', 'Constitutional Monarchy', 'Harald V', 2807, 'NO'),
	('CIV', 'CÃ´te dâ€™Ivoire', 'Africa', 'Western Africa', 322463.00, 1960, 14786000, 45.2, 11345.00, 10285.00, 'CÃ´te dâ€™Ivoire', 'Republic', 'Laurent Gbagbo', 2814, 'CI'),
	('OMN', 'Oman', 'Asia', 'Middle East', 309500.00, 1951, 2542000, 71.8, 16904.00, 16153.00, 'Â´Uman', 'Monarchy (Sultanate)', 'Qabus ibn SaÂ´id', 2821, 'OM'),
	('PAK', 'Pakistan', 'Asia', 'Southern and Central Asia', 796095.00, 1947, 156483000, 61.1, 61289.00, 58549.00, 'Pakistan', 'Republic', 'Mohammad Rafiq Tarar', 2831, 'PK'),
	('PLW', 'Palau', 'Oceania', 'Micronesia', 459.00, 1994, 19000, 68.6, 105.00, NULL, 'Belau/Palau', 'Republic', 'Kuniwo Nakamura', 2881, 'PW'),
	('PAN', 'Panama', 'North America', 'Central America', 75517.00, 1903, 2856000, 75.5, 9131.00, 8700.00, 'PanamÃ¡', 'Republic', 'Mireya Elisa Moscoso RodrÃ­guez', 2882, 'PA'),
	('PNG', 'Papua New Guinea', 'Oceania', 'Melanesia', 462840.00, 1975, 4807000, 63.1, 4988.00, 6328.00, 'Papua New Guinea/Papua Niugini', 'Constitutional Monarchy', 'Elisabeth II', 2884, 'PG'),
	('PRY', 'Paraguay', 'South America', 'South America', 406752.00, 1811, 5496000, 73.7, 8444.00, 9555.00, 'Paraguay', 'Republic', 'Luis Ãngel GonzÃ¡lez Macchi', 2885, 'PY'),
	('PER', 'Peru', 'South America', 'South America', 1285216.00, 1821, 25662000, 70.0, 64140.00, 65186.00, 'PerÃº/Piruw', 'Republic', 'Valentin Paniagua Corazao', 2890, 'PE'),
	('PCN', 'Pitcairn', 'Oceania', 'Polynesia', 49.00, NULL, 50, NULL, 0.00, NULL, 'Pitcairn', 'Dependent Territory of the UK', 'Elisabeth II', 2912, 'PN'),
	('MNP', 'Northern Mariana Islands', 'Oceania', 'Micronesia', 464.00, NULL, 78000, 75.5, 0.00, NULL, 'Northern Mariana Islands', 'Commonwealth of the US', 'George W. Bush', 2913, 'MP'),
	('PRT', 'Portugal', 'Europe', 'Southern Europe', 91982.00, 1143, 9997600, 75.8, 105954.00, 102133.00, 'Portugal', 'Republic', 'Jorge SampÃ£io', 2914, 'PT'),
	('PRI', 'Puerto Rico', 'North America', 'Caribbean', 8875.00, NULL, 3869000, 75.6, 34100.00, 32100.00, 'Puerto Rico', 'Commonwealth of the US', 'George W. Bush', 2919, 'PR'),
	('POL', 'Poland', 'Europe', 'Eastern Europe', 323250.00, 1918, 38653600, 73.2, 151697.00, 135636.00, 'Polska', 'Republic', 'Aleksander Kwasniewski', 2928, 'PL'),
	('GNQ', 'Equatorial Guinea', 'Africa', 'Central Africa', 28051.00, 1968, 453000, 53.6, 283.00, 542.00, 'Guinea Ecuatorial', 'Republic', 'Teodoro Obiang Nguema Mbasogo', 2972, 'GQ'),
	('QAT', 'Qatar', 'Asia', 'Middle East', 11000.00, 1971, 599000, 72.4, 9472.00, 8920.00, 'Qatar', 'Monarchy', 'Hamad ibn Khalifa al-Thani', 2973, 'QA'),
	('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 843, 59225700, 78.8, 1424285.00, 1392448.00, 'France', 'Republic', 'Jacques Chirac', 2974, 'FR'),
	('GUF', 'French Guiana', 'South America', 'South America', 90000.00, NULL, 181000, 76.1, 681.00, NULL, 'Guyane franÃ§aise', 'Overseas Department of France', 'Jacques Chirac', 3014, 'GF'),
	('PYF', 'French Polynesia', 'Oceania', 'Polynesia', 4000.00, NULL, 235000, 74.8, 818.00, 781.00, 'PolynÃ©sie franÃ§aise', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3016, 'PF'),
	('REU', 'RÃ©union', 'Africa', 'Eastern Africa', 2510.00, NULL, 699000, 72.7, 8287.00, 7988.00, 'RÃ©union', 'Overseas Department of France', 'Jacques Chirac', 3017, 'RE'),
	('ROM', 'Romania', 'Europe', 'Eastern Europe', 238391.00, 1878, 22455500, 69.9, 38158.00, 34843.00, 'RomÃ¢nia', 'Republic', 'Ion Iliescu', 3018, 'RO'),
	('RWA', 'Rwanda', 'Africa', 'Eastern Africa', 26338.00, 1962, 7733000, 39.3, 2036.00, 1863.00, 'Rwanda/Urwanda', 'Republic', 'Paul Kagame', 3047, 'RW'),
	('SWE', 'Sweden', 'Europe', 'Nordic Countries', 449964.00, 836, 8861400, 79.6, 226492.00, 227757.00, 'Sverige', 'Constitutional Monarchy', 'Carl XVI Gustaf', 3048, 'SE'),
	('SHN', 'Saint Helena', 'Africa', 'Western Africa', 314.00, NULL, 6000, 76.8, 0.00, NULL, 'Saint Helena', 'Dependent Territory of the UK', 'Elisabeth II', 3063, 'SH'),
	('KNA', 'Saint Kitts and Nevis', 'North America', 'Caribbean', 261.00, 1983, 38000, 70.7, 299.00, NULL, 'Saint Kitts and Nevis', 'Constitutional Monarchy', 'Elisabeth II', 3064, 'KN'),
	('LCA', 'Saint Lucia', 'North America', 'Caribbean', 622.00, 1979, 154000, 72.3, 571.00, NULL, 'Saint Lucia', 'Constitutional Monarchy', 'Elisabeth II', 3065, 'LC'),
	('VCT', 'Saint Vincent and the Grenadines', 'North America', 'Caribbean', 388.00, 1979, 114000, 72.3, 285.00, NULL, 'Saint Vincent and the Grenadines', 'Constitutional Monarchy', 'Elisabeth II', 3066, 'VC'),
	('SPM', 'Saint Pierre and Miquelon', 'North America', 'North America', 242.00, NULL, 7000, 77.6, 0.00, NULL, 'Saint-Pierre-et-Miquelon', 'Territorial Collectivity of France', 'Jacques Chirac', 3067, 'PM'),
	('DEU', 'Germany', 'Europe', 'Western Europe', 357022.00, 1955, 82164700, 77.4, 2133367.00, 2102826.00, 'Deutschland', 'Federal Republic', 'Johannes Rau', 3068, 'DE'),
	('SLB', 'Solomon Islands', 'Oceania', 'Melanesia', 28896.00, 1978, 444000, 71.3, 182.00, 220.00, 'Solomon Islands', 'Constitutional Monarchy', 'Elisabeth II', 3161, 'SB'),
	('ZMB', 'Zambia', 'Africa', 'Eastern Africa', 752618.00, 1964, 9169000, 37.2, 3377.00, 3922.00, 'Zambia', 'Republic', 'Frederick Chiluba', 3162, 'ZM'),
	('WSM', 'Samoa', 'Oceania', 'Polynesia', 2831.00, 1962, 180000, 69.2, 141.00, 157.00, 'Samoa', 'Parlementary Monarchy', 'Malietoa Tanumafili II', 3169, 'WS'),
	('SMR', 'San Marino', 'Europe', 'Southern Europe', 61.00, 885, 27000, 81.1, 510.00, NULL, 'San Marino', 'Republic', NULL, 3171, 'SM'),
	('STP', 'Sao Tome and Principe', 'Africa', 'Central Africa', 964.00, 1975, 147000, 65.3, 6.00, NULL, 'SÃ£o TomÃ© e PrÃ­ncipe', 'Republic', 'Miguel Trovoada', 3172, 'ST'),
	('SAU', 'Saudi Arabia', 'Asia', 'Middle East', 2149690.00, 1932, 21607000, 67.8, 137635.00, 146171.00, 'Al-Â´Arabiya as-SaÂ´udiya', 'Monarchy', 'Fahd ibn Abdul-Aziz al-SaÂ´ud', 3173, 'SA'),
	('SEN', 'Senegal', 'Africa', 'Western Africa', 196722.00, 1960, 9481000, 62.2, 4787.00, 4542.00, 'SÃ©nÃ©gal/Sounougal', 'Republic', 'Abdoulaye Wade', 3198, 'SN'),
	('SYC', 'Seychelles', 'Africa', 'Eastern Africa', 455.00, 1976, 77000, 70.4, 536.00, 539.00, 'Sesel/Seychelles', 'Republic', 'France-Albert RenÃ©', 3206, 'SC'),
	('SLE', 'Sierra Leone', 'Africa', 'Western Africa', 71740.00, 1961, 4854000, 45.3, 746.00, 858.00, 'Sierra Leone', 'Republic', 'Ahmed Tejan Kabbah', 3207, 'SL'),
	('SGP', 'Singapore', 'Asia', 'Southeast Asia', 618.00, 1965, 3567000, 80.1, 86503.00, 96318.00, 'Singapore/Singapura/Xinjiapo/Singapur', 'Republic', 'Sellapan Rama Nathan', 3208, 'SG'),
	('SVK', 'Slovakia', 'Europe', 'Eastern Europe', 49012.00, 1993, 5398700, 73.7, 20594.00, 19452.00, 'Slovensko', 'Republic', 'Rudolf Schuster', 3209, 'SK'),
	('SVN', 'Slovenia', 'Europe', 'Southern Europe', 20256.00, 1991, 1987800, 74.9, 19756.00, 18202.00, 'Slovenija', 'Republic', 'Milan Kucan', 3212, 'SI'),
	('SOM', 'Somalia', 'Africa', 'Eastern Africa', 637657.00, 1960, 10097000, 46.2, 935.00, NULL, 'Soomaaliya', 'Republic', 'Abdiqassim Salad Hassan', 3214, 'SO'),
	('LKA', 'Sri Lanka', 'Asia', 'Southern and Central Asia', 65610.00, 1948, 18827000, 71.8, 15706.00, 15091.00, 'Sri Lanka/Ilankai', 'Republic', 'Chandrika Kumaratunga', 3217, 'LK'),
	('SDN', 'Sudan', 'Africa', 'Northern Africa', 2505813.00, 1956, 29490000, 56.6, 10162.00, NULL, 'As-Sudan', 'Islamic Republic', 'Omar Hassan Ahmad al-Bashir', 3225, 'SD'),
	('FIN', 'Finland', 'Europe', 'Nordic Countries', 338145.00, 1917, 5171300, 77.4, 121914.00, 119833.00, 'Suomi', 'Republic', 'Tarja Halonen', 3236, 'FI'),
	('SUR', 'Suriname', 'South America', 'South America', 163265.00, 1975, 417000, 71.4, 870.00, 706.00, 'Suriname', 'Republic', 'Ronald Venetiaan', 3243, 'SR'),
	('SWZ', 'Swaziland', 'Africa', 'Southern Africa', 17364.00, 1968, 1008000, 40.4, 1206.00, 1312.00, 'kaNgwane', 'Monarchy', 'Mswati III', 3244, 'SZ'),
	('CHE', 'Switzerland', 'Europe', 'Western Europe', 41284.00, 1499, 7160400, 79.6, 264478.00, 256092.00, 'Schweiz/Suisse/Svizzera/Svizra', 'Federation', 'Adolf Ogi', 3248, 'CH'),
	('SYR', 'Syria', 'Asia', 'Middle East', 185180.00, 1941, 16125000, 68.5, 65984.00, 64926.00, 'Suriya', 'Republic', 'Bashar al-Assad', 3250, 'SY'),
	('TJK', 'Tajikistan', 'Asia', 'Southern and Central Asia', 143100.00, 1991, 6188000, 64.1, 1990.00, 1056.00, 'ToÃ§ikiston', 'Republic', 'Emomali Rahmonov', 3261, 'TJ'),
	('TWN', 'Taiwan', 'Asia', 'Eastern Asia', 36188.00, 1945, 22256000, 76.4, 256254.00, 263451.00, 'Tâ€™ai-wan', 'Republic', 'Chen Shui-bian', 3263, 'TW'),
	('TZA', 'Tanzania', 'Africa', 'Eastern Africa', 883749.00, 1961, 33517000, 52.3, 8005.00, 7388.00, 'Tanzania', 'Republic', 'Benjamin William Mkapa', 3306, 'TZ'),
	('DNK', 'Denmark', 'Europe', 'Nordic Countries', 43094.00, 800, 5330000, 76.5, 174099.00, 169264.00, 'Danmark', 'Constitutional Monarchy', 'Margrethe II', 3315, 'DK'),
	('THA', 'Thailand', 'Asia', 'Southeast Asia', 513115.00, 1350, 61399000, 68.6, 116416.00, 153907.00, 'Prathet Thai', 'Constitutional Monarchy', 'Bhumibol Adulyadej', 3320, 'TH'),
	('TGO', 'Togo', 'Africa', 'Western Africa', 56785.00, 1960, 4629000, 54.7, 1449.00, 1400.00, 'Togo', 'Republic', 'GnassingbÃ© EyadÃ©ma', 3332, 'TG'),
	('TKL', 'Tokelau', 'Oceania', 'Polynesia', 12.00, NULL, 2000, NULL, 0.00, NULL, 'Tokelau', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 3333, 'TK'),
	('TON', 'Tonga', 'Oceania', 'Polynesia', 650.00, 1970, 99000, 67.9, 146.00, 170.00, 'Tonga', 'Monarchy', 'Taufa\'ahau Tupou IV', 3334, 'TO'),
	('TTO', 'Trinidad and Tobago', 'North America', 'Caribbean', 5130.00, 1962, 1295000, 68.0, 6232.00, 5867.00, 'Trinidad and Tobago', 'Republic', 'Arthur N. R. Robinson', 3336, 'TT'),
	('TCD', 'Chad', 'Africa', 'Central Africa', 1284000.00, 1960, 7651000, 50.5, 1208.00, 1102.00, 'Tchad/Tshad', 'Republic', 'Idriss DÃ©by', 3337, 'TD'),
	('CZE', 'Czech Republic', 'Europe', 'Eastern Europe', 78866.00, 1993, 10278100, 74.5, 55017.00, 52037.00, 'Â¸esko', 'Republic', 'VÃ¡clav Havel', 3339, 'CZ'),
	('TUN', 'Tunisia', 'Africa', 'Northern Africa', 163610.00, 1956, 9586000, 73.7, 20026.00, 18898.00, 'Tunis/Tunisie', 'Republic', 'Zine al-Abidine Ben Ali', 3349, 'TN'),
	('TUR', 'Turkey', 'Asia', 'Middle East', 774815.00, 1923, 66591000, 71.0, 210721.00, 189122.00, 'TÃ¼rkiye', 'Republic', 'Ahmet Necdet Sezer', 3358, 'TR'),
	('TKM', 'Turkmenistan', 'Asia', 'Southern and Central Asia', 488100.00, 1991, 4459000, 60.9, 4397.00, 2000.00, 'TÃ¼rkmenostan', 'Republic', 'Saparmurad Nijazov', 3419, 'TM'),
	('TCA', 'Turks and Caicos Islands', 'North America', 'Caribbean', 430.00, NULL, 17000, 73.3, 96.00, NULL, 'The Turks and Caicos Islands', 'Dependent Territory of the UK', 'Elisabeth II', 3423, 'TC'),
	('TUV', 'Tuvalu', 'Oceania', 'Polynesia', 26.00, 1978, 12000, 66.3, 6.00, NULL, 'Tuvalu', 'Constitutional Monarchy', 'Elisabeth II', 3424, 'TV'),
	('UGA', 'Uganda', 'Africa', 'Eastern Africa', 241038.00, 1962, 21778000, 42.9, 6313.00, 6887.00, 'Uganda', 'Republic', 'Yoweri Museveni', 3425, 'UG'),
	('UKR', 'Ukraine', 'Europe', 'Eastern Europe', 603700.00, 1991, 50456000, 66.0, 42168.00, 49677.00, 'Ukrajina', 'Republic', 'Leonid KutÅ¡ma', 3426, 'UA'),
	('HUN', 'Hungary', 'Europe', 'Eastern Europe', 93030.00, 1918, 10043200, 71.4, 48267.00, 45914.00, 'MagyarorszÃ¡g', 'Republic', 'Ferenc MÃ¡dl', 3483, 'HU'),
	('URY', 'Uruguay', 'South America', 'South America', 175016.00, 1828, 3337000, 75.2, 20831.00, 19967.00, 'Uruguay', 'Republic', 'Jorge Batlle IbÃ¡Ã±ez', 3492, 'UY'),
	('NCL', 'New Caledonia', 'Oceania', 'Melanesia', 18575.00, NULL, 214000, 72.8, 3563.00, NULL, 'Nouvelle-CalÃ©donie', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3493, 'NC'),
	('NZL', 'New Zealand', 'Oceania', 'Australia and New Zealand', 270534.00, 1907, 3862000, 77.8, 54669.00, 64960.00, 'New Zealand/Aotearoa', 'Constitutional Monarchy', 'Elisabeth II', 3499, 'NZ'),
	('UZB', 'Uzbekistan', 'Asia', 'Southern and Central Asia', 447400.00, 1991, 24318000, 63.7, 14194.00, 21300.00, 'Uzbekiston', 'Republic', 'Islam Karimov', 3503, 'UZ'),
	('BLR', 'Belarus', 'Europe', 'Eastern Europe', 207600.00, 1991, 10236000, 68.0, 13714.00, NULL, 'Belarus', 'Republic', 'Aljaksandr LukaÅ¡enka', 3520, 'BY'),
	('WLF', 'Wallis and Futuna', 'Oceania', 'Polynesia', 200.00, NULL, 15000, NULL, 0.00, NULL, 'Wallis-et-Futuna', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3536, 'WF'),
	('VUT', 'Vanuatu', 'Oceania', 'Melanesia', 12189.00, 1980, 190000, 60.6, 261.00, 246.00, 'Vanuatu', 'Republic', 'John Bani', 3537, 'VU'),
	('VAT', 'Holy See (Vatican City State)', 'Europe', 'Southern Europe', 0.40, 1929, 1000, NULL, 9.00, NULL, 'Santa Sede/CittÃ  del Vaticano', 'Independent Church State', 'Johannes Paavali II', 3538, 'VA'),
	('VEN', 'Venezuela', 'South America', 'South America', 912050.00, 1811, 24170000, 73.1, 95023.00, 88434.00, 'Venezuela', 'Federal Republic', 'Hugo ChÃ¡vez FrÃ­as', 3539, 'VE'),
	('RUS', 'Russian Federation', 'Europe', 'Eastern Europe', 17075400.00, 1991, 146934000, 67.2, 276608.00, 442989.00, 'Rossija', 'Federal Republic', 'Vladimir Putin', 3580, 'RU'),
	('VNM', 'Vietnam', 'Asia', 'Southeast Asia', 331689.00, 1945, 79832000, 69.3, 21929.00, 22834.00, 'ViÃªt Nam', 'Socialistic Republic', 'TrÃ¢n Duc Luong', 3770, 'VN'),
	('EST', 'Estonia', 'Europe', 'Baltic Countries', 45227.00, 1991, 1439200, 69.5, 5328.00, 3371.00, 'Eesti', 'Republic', 'Lennart Meri', 3791, 'EE'),
	('USA', 'United States', 'North America', 'North America', 9363520.00, 1776, 278357000, 77.1, 8510700.00, 8110900.00, 'United States', 'Federal Republic', 'George W. Bush', 3813, 'US'),
	('VIR', 'Virgin Islands, U.S.', 'North America', 'Caribbean', 347.00, NULL, 93000, 78.1, 0.00, NULL, 'Virgin Islands of the United States', 'US Territory', 'George W. Bush', 4067, 'VI'),
	('ZWE', 'Zimbabwe', 'Africa', 'Eastern Africa', 390757.00, 1980, 11669000, 37.8, 5951.00, 8670.00, 'Zimbabwe', 'Republic', 'Robert G. Mugabe', 4068, 'ZW'),
	('PSE', 'Palestine', 'Asia', 'Middle East', 6257.00, NULL, 3101000, 71.4, 4173.00, NULL, 'Filastin', 'Autonomous Area', 'Yasser (Yasir) Arafat', 4074, 'PS'),
	('ATA', 'Antarctica', 'Antarctica', 'Antarctica', 13120000.00, NULL, 0, NULL, 0.00, NULL, 'â€“', 'Co-administrated', '', NULL, 'AQ'),
	('BVT', 'Bouvet Island', 'Antarctica', 'Antarctica', 59.00, NULL, 0, NULL, 0.00, NULL, 'BouvetÃ¸ya', 'Dependent Territory of Norway', 'Harald V', NULL, 'BV'),
	('IOT', 'British Indian Ocean Territory', 'Africa', 'Eastern Africa', 78.00, NULL, 0, NULL, 0.00, NULL, 'British Indian Ocean Territory', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'IO'),
	('SGS', 'South Georgia and the South Sandwich Islands', 'Antarctica', 'Antarctica', 3903.00, NULL, 0, NULL, 0.00, NULL, 'South Georgia and the South Sandwich Islands', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'GS'),
	('HMD', 'Heard Island and McDonald Islands', 'Antarctica', 'Antarctica', 359.00, NULL, 0, NULL, 0.00, NULL, 'Heard and McDonald Islands', 'Territory of Australia', 'Elisabeth II', NULL, 'HM'),
	('ATF', 'French Southern territories', 'Antarctica', 'Antarctica', 7780.00, NULL, 0, NULL, 0.00, NULL, 'Terres australes franÃ§aises', 'Nonmetropolitan Territory of France', 'Jacques Chirac', NULL, 'TF'),
	('UMI', 'United States Minor Outlying Islands', 'Oceania', 'Micronesia/Caribbean', 16.00, NULL, 0, NULL, 0.00, NULL, 'United States Minor Outlying Islands', 'Dependent Territory of the US', 'George W. Bush', NULL, 'UM');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;


-- Dumping structure for procedure hosted_emr.user_details_t_invoice_no
DROP PROCEDURE IF EXISTS `user_details_t_invoice_no`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_details_t_invoice_no`(IN `invoice_no` VARCHAR(150))
    COMMENT 'Find Customer details through invoice no'
BEGIN
	select hf.hf_id,hf.hf_facility_name,hf.hf_address,hf.hf_city,hf.hf_zip,hf.hf_state,hf.hf_country,hf.hf_email,hf.hf_phone,hf.hf_fax 
	from hosted_facilities hf,customer_invoice ci where ci.hf_id=hf.hf_id and ci.invoice_number=invoice_no;
END//
DELIMITER ;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
