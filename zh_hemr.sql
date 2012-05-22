-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.20-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4057
-- Date/time:                    2012-03-20 18:08:35
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for hosted_emr
CREATE DATABASE IF NOT EXISTS `hosted_emr` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hosted_emr`;


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
	(3, 'Paypal_intimation', '', 'Paypal is our autherized merchant to accept the payment. Please proceed with instructions to make your payment.', 1),
	(4, 'User_welcome_after_login', 'Welcome', 'Welcome to EMR user section. Please go thorugh the dashboard section to get your sections.', 1);
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


-- Dumping structure for table hosted_emr.customer_invoice
DROP TABLE IF EXISTS `customer_invoice`;
CREATE TABLE IF NOT EXISTS `customer_invoice` (
  `idcustomer_invoice` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL DEFAULT '0',
  `invoice_number` varchar(50) NOT NULL DEFAULT '0',
  `particulars` text NOT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `payment_status` int(11) NOT NULL DEFAULT '0',
  `transaction_id` varchar(50) NOT NULL DEFAULT '0',
  `status_message` text NOT NULL,
  `invoice_date` date NOT NULL,
  PRIMARY KEY (`idcustomer_invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Invoice Details of Customers';

-- Dumping data for table hosted_emr.customer_invoice: ~3 rows (approximately)
DELETE FROM `customer_invoice`;
/*!40000 ALTER TABLE `customer_invoice` DISABLE KEYS */;
INSERT INTO `customer_invoice` (`idcustomer_invoice`, `hf_id`, `invoice_number`, `particulars`, `amount`, `payment_status`, `transaction_id`, `status_message`, `invoice_date`) VALUES
	(1, 30, '1', 'Plan Activation', 25000, 0, '654213', 'authorized', '2012-03-15'),
	(2, 30, '2', 'Plan Activation', 25000, 1, '654213', 'authorized', '2012-03-15'),
	(3, 30, '3', 'Plan Activation', 25000, 0, '654212', 'authorized', '2012-03-14');
/*!40000 ALTER TABLE `customer_invoice` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_selected_plan
DROP TABLE IF EXISTS `customer_selected_plan`;
CREATE TABLE IF NOT EXISTS `customer_selected_plan` (
  `idcustomer_selected_plan` bigint(20) NOT NULL AUTO_INCREMENT,
  `plan_id` bigint(20) DEFAULT NULL,
  `plan_name` varchar(45) DEFAULT NULL,
  `hf_id` bigint(20) DEFAULT NULL,
  `dashboard_userid` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `one_time_payment` float DEFAULT '0',
  `monthly_payment` float DEFAULT '0',
  `discount_percentage` float DEFAULT '0',
  `discount_amount` float DEFAULT '0',
  `total_payment` float DEFAULT '0',
  `payment_status` int(11) DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `payment_error_message` text,
  `plan_status` int(11) DEFAULT '0' COMMENT '0: Not Active, 1: Active, 2: Disabled, 3: Expired, 4:deleted',
  `plan_activated_date` date DEFAULT NULL,
  `plan_disabled_date` date DEFAULT NULL,
  `plan_expired_date` date DEFAULT NULL,
  `plan_deleted_date` date DEFAULT NULL,
  PRIMARY KEY (`idcustomer_selected_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='Customer Selected Plan and its Features';

-- Dumping data for table hosted_emr.customer_selected_plan: ~5 rows (approximately)
DELETE FROM `customer_selected_plan`;
/*!40000 ALTER TABLE `customer_selected_plan` DISABLE KEYS */;
INSERT INTO `customer_selected_plan` (`idcustomer_selected_plan`, `plan_id`, `plan_name`, `hf_id`, `dashboard_userid`, `created_date`, `one_time_payment`, `monthly_payment`, `discount_percentage`, `discount_amount`, `total_payment`, `payment_status`, `payment_date`, `payment_error_message`, `plan_status`, `plan_activated_date`, `plan_disabled_date`, `plan_expired_date`, `plan_deleted_date`) VALUES
	(12, 15, 'ZhOpenEMR', 30, 'demo', '2012-03-14', 10, 7, 2, 0.34, 16.66, 0, NULL, 'Not Proceed to Payment Gateway', 1, '2012-03-13', '2012-03-13', '2012-03-13', NULL),
	(13, 16, 'Billing', 31, 'test', '2012-03-14', 2000, 1035, 2, 60.7, 2974.3, 0, NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL),
	(14, 16, 'Billing', 32, 'asdf', '2012-03-14', 2000, 1035, 2, 60.7, 2974.3, 0, NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL),
	(15, 16, 'Billing', 33, 'dfhg', '2012-03-14', 2000, 1035, 2, 60.7, 2974.3, 0, NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL),
	(16, 16, 'Billing', 34, 'tgtg', '2012-03-14', 2000, 1035, 2, 60.7, 2974.3, 0, NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `customer_selected_plan` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_selected_plan_features
DROP TABLE IF EXISTS `customer_selected_plan_features`;
CREATE TABLE IF NOT EXISTS `customer_selected_plan_features` (
  `idcustomer_selected_plan_features` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) DEFAULT NULL,
  `idcustomer_selected_plan` bigint(20) DEFAULT NULL,
  `hpcm_type_id` bigint(20) DEFAULT NULL,
  `hsc_value` varchar(50) DEFAULT NULL,
  `hp_id` bigint(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idcustomer_selected_plan_features`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=latin1 COMMENT='In this table all features of customer selected plan will in';

-- Dumping data for table hosted_emr.customer_selected_plan_features: ~237 rows (approximately)
DELETE FROM `customer_selected_plan_features`;
/*!40000 ALTER TABLE `customer_selected_plan_features` DISABLE KEYS */;
INSERT INTO `customer_selected_plan_features` (`idcustomer_selected_plan_features`, `hf_id`, `idcustomer_selected_plan`, `hpcm_type_id`, `hsc_value`, `hp_id`, `payment_term`) VALUES
	(59, 30, 15, 2, '2500', 15, 0),
	(60, 30, 15, 3, '1000', 15, 0),
	(61, 30, 15, 4, '20', 15, 0),
	(62, 30, 15, 5, '50', 15, 0),
	(63, 30, 15, 6, '6% of Total Bill', 15, 1),
	(64, 30, 15, 7, 'Yes', 15, 0),
	(65, 30, 15, 8, 'Yes', 15, 0),
	(66, 30, 15, 9, 'Yes', 15, 0),
	(67, 30, 15, 10, 'Yes', 15, 0),
	(68, 30, 15, 11, 'Yes', 15, 0),
	(69, 30, 15, 12, 'Yes', 15, 0),
	(70, 30, 15, 13, 'Yes', 15, 0),
	(71, 30, 15, 14, 'Yes', 15, 0),
	(72, 30, 15, 15, 'No', 15, 0),
	(73, 30, 15, 16, 'No', 15, 0),
	(74, 30, 15, 17, 'Yes', 15, 0),
	(75, 30, 15, 18, 'Yes', 15, 0),
	(76, 30, 15, 19, 'Yes', 15, 0),
	(77, 30, 15, 20, 'Yes', 15, 0),
	(78, 30, 15, 21, 'Yes', 15, 0),
	(79, 30, 15, 22, 'Yes', 15, 0),
	(80, 30, 15, 23, 'Yes', 15, 0),
	(81, 30, 15, 24, 'Yes', 15, 0),
	(82, 30, 15, 25, 'Yes', 15, 0),
	(83, 30, 15, 26, 'Yes', 15, 0),
	(84, 30, 15, 27, 'Yes', 15, 0),
	(85, 30, 15, 28, 'Yes', 15, 0),
	(86, 30, 15, 29, 'Yes', 15, 0),
	(87, 30, 15, 30, 'Yes', 15, 0),
	(88, 30, 15, 31, 'Yes', 15, 0),
	(89, 30, 15, 32, 'Yes', 15, 0),
	(90, 30, 15, 33, 'Yes', 15, 0),
	(91, 30, 15, 34, 'Yes', 15, 0),
	(92, 30, 15, 35, '100', 15, 0),
	(93, 30, 15, 36, 'Yes', 15, 0),
	(94, 30, 15, 37, 'Yes', 15, 0),
	(95, 30, 15, 38, 'Yes', 15, 0),
	(96, 30, 15, 39, 'Yes', 15, 0),
	(97, 30, 15, 40, 'Yes', 15, 0),
	(98, 30, 15, 41, 'Yes', 15, 0),
	(99, 30, 15, 42, 'Yes', 15, 0),
	(100, 30, 15, 43, 'Yes', 15, 0),
	(101, 30, 15, 44, 'Yes', 15, 0),
	(102, 30, 15, 45, 'Yes', 15, 0),
	(103, 30, 15, 46, 'Yes', 15, 0),
	(104, 30, 15, 47, 'Yes', 15, 0),
	(105, 30, 15, 48, 'Yes', 15, 0),
	(106, 30, 15, 49, 'Yes', 15, 0),
	(107, 30, 15, 50, '1 GB', 15, 0),
	(108, 30, 15, 51, 'Yes', 15, 0),
	(109, 30, 15, 52, '25', 15, 0),
	(110, 30, 15, 53, '10', 15, 0),
	(111, 30, 15, 54, '500', 15, 0),
	(112, 30, 15, 55, 'Yes', 15, 0),
	(113, 30, 15, 56, '50', 15, 0),
	(114, 30, 15, 57, 'No', 15, 0),
	(115, 30, 15, 58, 'Quote', 15, 0),
	(116, 31, 16, 2, '2000', 16, 1),
	(117, 31, 16, 3, '200', 16, 1),
	(118, 31, 16, 4, '100', 16, 1),
	(119, 31, 16, 5, '50', 16, 1),
	(120, 31, 16, 6, '7% of Total Bill', 16, 0),
	(121, 31, 16, 7, 'Yes', 16, 0),
	(122, 31, 16, 8, 'Yes', 16, 0),
	(123, 31, 16, 9, 'Yes', 16, 0),
	(124, 31, 16, 10, 'Yes', 16, 0),
	(125, 31, 16, 11, 'Yes', 16, 0),
	(126, 31, 16, 12, 'Yes', 16, 0),
	(127, 31, 16, 13, 'Yes', 16, 0),
	(128, 31, 16, 14, 'Yes', 16, 1),
	(129, 31, 16, 15, 'Yes', 16, 1),
	(130, 31, 16, 16, 'No', 16, 0),
	(131, 31, 16, 17, 'Yes', 16, 0),
	(132, 31, 16, 18, 'No', 16, 0),
	(133, 31, 16, 19, 'No', 16, 0),
	(134, 31, 16, 20, 'No', 16, 0),
	(135, 31, 16, 21, 'No', 16, 0),
	(136, 31, 16, 22, 'No', 16, 0),
	(137, 31, 16, 23, 'No', 16, 0),
	(138, 31, 16, 24, 'No', 16, 0),
	(139, 31, 16, 25, 'No', 16, 0),
	(140, 31, 16, 26, 'Yes', 16, 0),
	(141, 31, 16, 27, 'No', 16, 0),
	(142, 31, 16, 28, 'No', 16, 0),
	(143, 31, 16, 29, 'No', 16, 0),
	(144, 31, 16, 30, 'Yes', 16, 0),
	(145, 31, 16, 31, 'No', 16, 0),
	(146, 31, 16, 32, 'No', 16, 0),
	(147, 31, 16, 33, 'No', 16, 0),
	(148, 31, 16, 34, 'No', 16, 0),
	(149, 31, 16, 35, '100', 16, 1),
	(150, 31, 16, 36, 'No', 16, 0),
	(151, 31, 16, 37, 'No', 16, 0),
	(152, 31, 16, 38, 'No', 16, 0),
	(153, 31, 16, 39, 'No', 16, 0),
	(154, 31, 16, 40, 'No', 16, 0),
	(155, 31, 16, 41, 'No', 16, 0),
	(156, 31, 16, 42, 'No', 16, 0),
	(157, 31, 16, 43, 'Yes', 16, 0),
	(158, 31, 16, 44, 'No', 16, 0),
	(159, 31, 16, 45, 'No', 16, 0),
	(160, 31, 16, 46, 'No', 16, 0),
	(161, 31, 16, 47, 'Yes', 16, 0),
	(162, 31, 16, 48, 'Yes', 16, 0),
	(163, 31, 16, 49, 'No', 16, 0),
	(164, 31, 16, 50, '1 GB', 16, 0),
	(165, 31, 16, 51, 'No', 16, 0),
	(166, 31, 16, 52, '25', 16, 1),
	(167, 31, 16, 53, '10', 16, 1),
	(168, 31, 16, 54, '500', 16, 1),
	(169, 31, 16, 55, 'No', 16, 0),
	(170, 31, 16, 56, '50', 16, 1),
	(171, 31, 16, 57, 'No', 16, 0),
	(172, 31, 16, 58, 'Quote', 16, 0),
	(173, 32, 16, 2, '2000', 16, 0),
	(174, 32, 16, 3, '200', 16, 1),
	(175, 32, 16, 4, '100', 16, 1),
	(176, 32, 16, 5, '50', 16, 1),
	(177, 32, 16, 6, '7% of Total Bill', 16, 0),
	(178, 32, 16, 7, 'Yes', 16, 0),
	(179, 32, 16, 8, 'Yes', 16, 0),
	(180, 32, 16, 9, 'Yes', 16, 0),
	(181, 32, 16, 10, 'Yes', 16, 0),
	(182, 32, 16, 11, 'Yes', 16, 0),
	(183, 32, 16, 12, 'Yes', 16, 0),
	(184, 32, 16, 13, 'Yes', 16, 0),
	(185, 32, 16, 14, 'Yes', 16, 1),
	(186, 32, 16, 15, 'Yes', 16, 1),
	(187, 32, 16, 16, 'No', 16, 0),
	(188, 32, 16, 17, 'Yes', 16, 0),
	(189, 32, 16, 18, 'No', 16, 0),
	(190, 32, 16, 19, 'No', 16, 0),
	(191, 32, 16, 20, 'No', 16, 0),
	(192, 32, 16, 21, 'No', 16, 0),
	(193, 32, 16, 22, 'No', 16, 0),
	(194, 32, 16, 23, 'No', 16, 0),
	(195, 32, 16, 24, 'No', 16, 0),
	(196, 32, 16, 25, 'No', 16, 0),
	(197, 32, 16, 26, 'Yes', 16, 0),
	(198, 32, 16, 27, 'No', 16, 0),
	(199, 32, 16, 28, 'No', 16, 0),
	(200, 32, 16, 29, 'No', 16, 0),
	(201, 32, 16, 30, 'Yes', 16, 0),
	(202, 32, 16, 31, 'No', 16, 0),
	(203, 32, 16, 32, 'No', 16, 0),
	(204, 32, 16, 33, 'No', 16, 0),
	(205, 32, 16, 34, 'No', 16, 0),
	(206, 32, 16, 35, '100', 16, 1),
	(207, 32, 16, 36, 'No', 16, 0),
	(208, 32, 16, 37, 'No', 16, 0),
	(209, 32, 16, 38, 'No', 16, 0),
	(210, 32, 16, 39, 'No', 16, 0),
	(211, 32, 16, 40, 'No', 16, 0),
	(212, 32, 16, 41, 'No', 16, 0),
	(213, 32, 16, 42, 'No', 16, 0),
	(214, 32, 16, 43, 'Yes', 16, 0),
	(215, 32, 16, 44, 'No', 16, 0),
	(216, 32, 16, 45, 'No', 16, 0),
	(217, 32, 16, 46, 'No', 16, 0),
	(218, 32, 16, 47, 'Yes', 16, 0),
	(219, 32, 16, 48, 'Yes', 16, 0),
	(220, 32, 16, 49, 'No', 16, 0),
	(221, 32, 16, 50, '1 GB', 16, 0),
	(222, 32, 16, 51, 'No', 16, 0),
	(223, 32, 16, 52, '25', 16, 1),
	(224, 32, 16, 53, '10', 16, 1),
	(225, 32, 16, 54, '500', 16, 1),
	(226, 32, 16, 55, 'No', 16, 0),
	(227, 32, 16, 56, '50', 16, 1),
	(228, 32, 16, 57, 'No', 16, 0),
	(229, 32, 16, 58, 'Quote', 16, 0),
	(230, 33, 16, 2, '2000', 16, 0),
	(231, 33, 16, 3, '200', 16, 1),
	(232, 33, 16, 4, '100', 16, 1),
	(233, 33, 16, 5, '50', 16, 1),
	(234, 33, 16, 6, '7% of Total Bill', 16, 0),
	(235, 33, 16, 7, 'Yes', 16, 0),
	(236, 33, 16, 8, 'Yes', 16, 0),
	(237, 33, 16, 9, 'Yes', 16, 0),
	(238, 33, 16, 10, 'Yes', 16, 0),
	(239, 33, 16, 11, 'Yes', 16, 0),
	(240, 33, 16, 12, 'Yes', 16, 0),
	(241, 33, 16, 13, 'Yes', 16, 0),
	(242, 33, 16, 14, 'Yes', 16, 1),
	(243, 33, 16, 15, 'Yes', 16, 1),
	(244, 33, 16, 16, 'No', 16, 0),
	(245, 33, 16, 17, 'Yes', 16, 0),
	(246, 33, 16, 18, 'No', 16, 0),
	(247, 33, 16, 19, 'No', 16, 0),
	(248, 33, 16, 20, 'No', 16, 0),
	(249, 33, 16, 21, 'No', 16, 0),
	(250, 33, 16, 22, 'No', 16, 0),
	(251, 33, 16, 23, 'No', 16, 0),
	(252, 33, 16, 24, 'No', 16, 0),
	(253, 33, 16, 25, 'No', 16, 0),
	(254, 33, 16, 26, 'Yes', 16, 0),
	(255, 33, 16, 27, 'No', 16, 0),
	(256, 33, 16, 28, 'No', 16, 0),
	(257, 33, 16, 29, 'No', 16, 0),
	(258, 33, 16, 30, 'Yes', 16, 0),
	(259, 33, 16, 31, 'No', 16, 0),
	(260, 33, 16, 32, 'No', 16, 0),
	(261, 33, 16, 33, 'No', 16, 0),
	(262, 33, 16, 34, 'No', 16, 0),
	(263, 33, 16, 35, '100', 16, 1),
	(264, 33, 16, 36, 'No', 16, 0),
	(265, 33, 16, 37, 'No', 16, 0),
	(266, 33, 16, 38, 'No', 16, 0),
	(267, 33, 16, 39, 'No', 16, 0),
	(268, 33, 16, 40, 'No', 16, 0),
	(269, 33, 16, 41, 'No', 16, 0),
	(270, 33, 16, 42, 'No', 16, 0),
	(271, 33, 16, 43, 'Yes', 16, 0),
	(272, 33, 16, 44, 'No', 16, 0),
	(273, 33, 16, 45, 'No', 16, 0),
	(274, 33, 16, 46, 'No', 16, 0),
	(275, 33, 16, 47, 'Yes', 16, 0),
	(276, 33, 16, 48, 'Yes', 16, 0),
	(277, 33, 16, 49, 'No', 16, 0),
	(278, 33, 16, 50, '1 GB', 16, 0),
	(279, 33, 16, 51, 'No', 16, 0),
	(280, 33, 16, 52, '25', 16, 1),
	(281, 33, 16, 53, '10', 16, 1),
	(282, 33, 16, 54, '500', 16, 1),
	(283, 33, 16, 55, 'No', 16, 0),
	(284, 33, 16, 56, '50', 16, 1),
	(285, 33, 16, 57, 'No', 16, 0),
	(286, 33, 16, 58, 'Quote', 16, 0),
	(287, 34, 16, 2, '2000', 16, 0),
	(288, 34, 16, 3, '200', 16, 1),
	(289, 34, 16, 4, '100', 16, 1),
	(290, 34, 16, 5, '50', 16, 1),
	(291, 34, 16, 6, '7% of Total Bill', 16, 0),
	(292, 34, 16, 7, 'Yes', 16, 0),
	(293, 34, 16, 8, 'Yes', 16, 0),
	(294, 34, 16, 9, 'Yes', 16, 0),
	(295, 34, 16, 10, 'Yes', 16, 0),
	(296, 34, 16, 11, 'Yes', 16, 0),
	(297, 34, 16, 12, 'Yes', 16, 0),
	(298, 34, 16, 13, 'Yes', 16, 0),
	(299, 34, 16, 14, 'Yes', 16, 1),
	(300, 34, 16, 15, 'Yes', 16, 1),
	(301, 34, 16, 16, 'No', 16, 0),
	(302, 34, 16, 17, 'Yes', 16, 0),
	(303, 34, 16, 18, 'No', 16, 0),
	(304, 34, 16, 19, 'No', 16, 0),
	(305, 34, 16, 20, 'No', 16, 0),
	(306, 34, 16, 21, 'No', 16, 0),
	(307, 34, 16, 22, 'No', 16, 0),
	(308, 34, 16, 23, 'No', 16, 0),
	(309, 34, 16, 24, 'No', 16, 0),
	(310, 34, 16, 25, 'No', 16, 0),
	(311, 34, 16, 26, 'Yes', 16, 0),
	(312, 34, 16, 27, 'No', 16, 0),
	(313, 34, 16, 28, 'No', 16, 0),
	(314, 34, 16, 29, 'No', 16, 0),
	(315, 34, 16, 30, 'Yes', 16, 0),
	(316, 34, 16, 31, 'No', 16, 0),
	(317, 34, 16, 32, 'No', 16, 0),
	(318, 34, 16, 33, 'No', 16, 0),
	(319, 34, 16, 34, 'No', 16, 0),
	(320, 34, 16, 35, '100', 16, 1),
	(321, 34, 16, 36, 'No', 16, 0),
	(322, 34, 16, 37, 'No', 16, 0),
	(323, 34, 16, 38, 'No', 16, 0),
	(324, 34, 16, 39, 'No', 16, 0),
	(325, 34, 16, 40, 'No', 16, 0),
	(326, 34, 16, 41, 'No', 16, 0),
	(327, 34, 16, 42, 'No', 16, 0),
	(328, 34, 16, 43, 'Yes', 16, 0),
	(329, 34, 16, 44, 'No', 16, 0),
	(330, 34, 16, 45, 'No', 16, 0),
	(331, 34, 16, 46, 'No', 16, 0),
	(332, 34, 16, 47, 'Yes', 16, 0),
	(333, 34, 16, 48, 'Yes', 16, 0),
	(334, 34, 16, 49, 'No', 16, 0),
	(335, 34, 16, 50, '1 GB', 16, 0),
	(336, 34, 16, 51, 'No', 16, 0),
	(337, 34, 16, 52, '25', 16, 1),
	(338, 34, 16, 53, '10', 16, 1),
	(339, 34, 16, 54, '500', 16, 1),
	(340, 34, 16, 55, 'No', 16, 0),
	(341, 34, 16, 56, '50', 16, 1),
	(342, 34, 16, 57, 'No', 16, 0),
	(343, 34, 16, 58, 'Quote', 16, 0);
/*!40000 ALTER TABLE `customer_selected_plan_features` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.help
DROP TABLE IF EXISTS `help`;
CREATE TABLE IF NOT EXISTS `help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `module` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COMMENT='This Table Contains the details of help data for entire site';

-- Dumping data for table hosted_emr.help: ~12 rows (approximately)
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
	(13, 'UserRegistrtion', 'NPI', 'NPI');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_facilities
DROP TABLE IF EXISTS `hosted_facilities`;
CREATE TABLE IF NOT EXISTS `hosted_facilities` (
  `hf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `hf_facility_identifier` varchar(150) DEFAULT NULL,
  `hf_facility_name` varchar(150) DEFAULT NULL,
  `hf_speciality` varchar(150) DEFAULT NULL,
  `dashboard_userid` varchar(150) DEFAULT NULL,
  `dashboard_password` varchar(150) DEFAULT NULL,
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
  PRIMARY KEY (`hf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_facilities: ~5 rows (approximately)
DELETE FROM `hosted_facilities`;
/*!40000 ALTER TABLE `hosted_facilities` DISABLE KEYS */;
INSERT INTO `hosted_facilities` (`hf_id`, `customer_id`, `hf_facility_identifier`, `hf_facility_name`, `hf_speciality`, `dashboard_userid`, `dashboard_password`, `hf_email`, `hf_phone`, `hf_address`, `hf_fax`, `hf_city`, `hf_zip`, `hf_state`, `hf_tax_id`, `hf_country`, `hf_npi`) VALUES
	(30, 0, 'AIIMS', 'Pradeep', 'General', 'demo', '121212', 'pradeep@zhservices.com', '5468876', 'A-4, Dhyansadhana CHS, Kharghar', '5648796', 'Kharghar', '410210', 'New Mumbai', '546', 'India', '564'),
	(31, 0, 'Test', 'test', 'test', 'test', '121212', 'test@test.com', '234', 'asasdf asdf asdf', '234', 'asdfasdf asdf', '234234', 'dfasdf', '234', '234', '234'),
	(32, 0, 'asdf', 'asdf', 'asdf', 'asdf', '12', 'ad@ad.com', '234', 'asd asdf ', '234', 'dsfasd', 'asdf', ' asdf', '234', ' asdf', '234'),
	(33, 0, 'dfhg', 'dfhg', 'dfhg', 'dfhg', '121212', 'dk@dk.com', '234', 'asdgfsa df a', '234', 'dfgsdfg sdfg', '234234', 'sdfgsdf', '234', '2342', '234'),
	(34, 0, 'tgtg', 'tgtg', 'tgtg', 'tgtg', 'tgtg', 'tgtg@tg.com', '3425', 'sadf asdf asdf ', '234', 'asdf', 'asdf', 'asdf', '234', 'asdf', '234');
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
  `discount` float DEFAULT '0',
  `discount_start_date` date DEFAULT NULL,
  `discount_end_date` date DEFAULT NULL,
  PRIMARY KEY (`hp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_plans: ~3 rows (approximately)
DELETE FROM `hosted_plans`;
/*!40000 ALTER TABLE `hosted_plans` DISABLE KEYS */;
INSERT INTO `hosted_plans` (`hp_id`, `customer_id`, `hp_name`, `hp_caption`, `hp_sortorder`, `hp_status`, `discount`, `discount_start_date`, `discount_end_date`) VALUES
	(1, 1, 'Free General Release', 'EMR - No Addons', 1, 1, 0, NULL, NULL),
	(15, 1, 'ZhOpenEMR', 'ZhOpenEMR', 2, 1, 2, '2012-02-01', '2012-06-06'),
	(16, 1, 'Billing', 'ZF-OPENEMRBILLING', 3, 1, 2, '2012-02-01', '2012-06-06');
/*!40000 ALTER TABLE `hosted_plans` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_plan_content_mapping
DROP TABLE IF EXISTS `hosted_plan_content_mapping`;
CREATE TABLE IF NOT EXISTS `hosted_plan_content_mapping` (
  `hpcm_type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `hpcm_type_name` varchar(150) DEFAULT NULL,
  `hpcm_order` int(10) DEFAULT NULL,
  `hpcm_level` int(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT 'if zero then one time, if one then montyly',
  PRIMARY KEY (`hpcm_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='This table storing the Main Features of Plan (master collection)';

-- Dumping data for table hosted_emr.hosted_plan_content_mapping: ~57 rows (approximately)
DELETE FROM `hosted_plan_content_mapping`;
/*!40000 ALTER TABLE `hosted_plan_content_mapping` DISABLE KEYS */;
INSERT INTO `hosted_plan_content_mapping` (`hpcm_type_id`, `customer_id`, `hpcm_type_name`, `hpcm_order`, `hpcm_level`, `status`) VALUES
	(2, 1, 'One time Setup Fee : First Provider', 1, 1, 1),
	(3, 1, 'One time Setup Fee: Additional Providers', 2, 1, 1),
	(4, 1, 'Monthly Fee : First provider', 3, 1, 1),
	(5, 1, 'Monthly Fee: Additional Provider', 4, 1, 1),
	(6, 1, 'Monthly Billing Fees', 5, 1, 1),
	(7, 1, 'EMR hosted on our server', 6, 1, 1),
	(8, 1, 'Key Features', 7, 1, 1),
	(9, 1, 'Patient Portal', 8, 1, 1),
	(10, 1, 'Scheduling', 9, 1, 1),
	(11, 1, 'Patient Records', 10, 1, 1),
	(12, 1, 'Charting', 11, 1, 1),
	(13, 1, 'Document Management', 12, 1, 1),
	(14, 1, 'Billing', 13, 1, 1),
	(15, 1, 'Collections', 14, 1, 1),
	(16, 1, 'Hundreds of templates', 15, 1, 1),
	(17, 1, 'Reports', 16, 1, 1),
	(18, 1, 'Specialty Modules', 17, 1, 1),
	(19, 1, 'Advanced Billing Module', 18, 1, 1),
	(20, 1, 'Template based Fee sheets', 19, 1, 1),
	(21, 1, 'Contract Management', 20, 1, 1),
	(22, 1, 'Capitation Billing', 21, 1, 1),
	(23, 1, 'Pre-authorizations', 22, 1, 1),
	(24, 1, 'Clearing house integration*', 23, 1, 1),
	(25, 1, 'AR Management', 24, 1, 1),
	(26, 1, 'Patient Ledgers', 25, 1, 1),
	(27, 1, 'Advanced Reporting', 26, 1, 1),
	(28, 1, 'Customizable reports', 27, 1, 1),
	(29, 1, 'e-Prescription Ready', 28, 1, 1),
	(30, 1, 'Lab Exchange Ready', 29, 1, 1),
	(31, 1, 'Integrated e-Prescription', 30, 1, 1),
	(32, 1, 'Integrated Lab Exchange', 31, 1, 1),
	(33, 1, 'Private Branding one time @$1000 and $50 per month', 32, 1, 1),
	(34, 1, 'Go-live support', 33, 1, 1),
	(35, 1, 'Staff training', 34, 1, 1),
	(36, 1, 'Auto appt reminder calls (@ $0.10 per call)', 35, 1, 1),
	(37, 1, 'Automatic updates', 36, 1, 1),
	(38, 1, 'Monthly maintenance', 37, 1, 1),
	(39, 1, 'Monthly hosting and support', 38, 1, 1),
	(40, 1, 'Medical Billing Services - We bill for you', 39, 1, 1),
	(41, 1, 'Insurance Billing', 40, 1, 1),
	(42, 1, 'Patient Billing', 41, 1, 1),
	(43, 1, 'Verification of benefits', 42, 1, 1),
	(44, 1, 'Pre-Auth services', 43, 1, 1),
	(45, 1, 'Credentialing', 44, 1, 1),
	(46, 1, 'Claims submission', 45, 1, 1),
	(47, 1, 'EOB Posting', 46, 1, 1),
	(48, 1, 'Receivables', 47, 1, 1),
	(49, 1, 'EFT', 48, 1, 1),
	(50, 1, 'Storage Space', 49, 1, 1),
	(51, 1, 'Additional Space per GB per year', 50, 1, 1),
	(52, 1, 'Onsite Services Hourly Rate', 51, 1, 1),
	(53, 1, 'Remote Services Hourly Rate', 52, 1, 1),
	(54, 1, 'Data Conversion from your system', 53, 1, 1),
	(55, 1, 'Medisoft', 54, 1, 1),
	(56, 1, 'TotalMD', 55, 1, 1),
	(57, 1, 'Lytec', 56, 1, 1),
	(58, 1, 'Others', 57, 1, 1);
/*!40000 ALTER TABLE `hosted_plan_content_mapping` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_site_content
DROP TABLE IF EXISTS `hosted_site_content`;
CREATE TABLE IF NOT EXISTS `hosted_site_content` (
  `hpcm_type_id` bigint(20) NOT NULL,
  `hsc_value` varchar(50) DEFAULT NULL,
  `value_type` varchar(50) DEFAULT NULL,
  `hp_id` bigint(20) NOT NULL,
  `payment_term` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-one time, 1 monthly',
  KEY `FK_hosted_site_content_hosted_plan_content_mapping` (`hpcm_type_id`),
  KEY `FK_hosted_site_content_hosted_plans` (`hp_id`),
  CONSTRAINT `FK_hosted_site_content_hosted_plans` FOREIGN KEY (`hp_id`) REFERENCES `hosted_plans` (`hp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_site_content: ~171 rows (approximately)
DELETE FROM `hosted_site_content`;
/*!40000 ALTER TABLE `hosted_site_content` DISABLE KEYS */;
INSERT INTO `hosted_site_content` (`hpcm_type_id`, `hsc_value`, `value_type`, `hp_id`, `payment_term`) VALUES
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
/*!40000 ALTER TABLE `hosted_site_content` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_specialty
DROP TABLE IF EXISTS `hosted_specialty`;
CREATE TABLE IF NOT EXISTS `hosted_specialty` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `specialty_id` varchar(150) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_specialty: ~0 rows (approximately)
DELETE FROM `hosted_specialty`;
/*!40000 ALTER TABLE `hosted_specialty` DISABLE KEYS */;
/*!40000 ALTER TABLE `hosted_specialty` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='Main Module Table (ACL)';

-- Dumping data for table hosted_emr.modules: ~3 rows (approximately)
DELETE FROM `modules`;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`module_id`, `module_name`, `module_controller`, `module_display_name`, `customer_id`) VALUES
	(4, 'Admin', 'Planfeatures', 'Plan Features', 1),
	(5, 'Admin', 'Plans', 'Plans', 1),
	(6, 'Admin', 'Help', 'Help', 1);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;


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
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
