-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.8-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4058
-- Date/time:                    2012-07-17 14:36:03
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table hosted_emr.acl_acl
DROP TABLE IF EXISTS `acl_acl`;
CREATE TABLE IF NOT EXISTS `acl_acl` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(230) NOT NULL DEFAULT 'system',
  `allow` int(11) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '0',
  `return_value` text,
  `note` text,
  `updated_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acl_enabled_acl` (`enabled`),
  KEY `acl_section_value_acl` (`section_value`),
  KEY `acl_updated_date_acl` (`updated_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_acl: ~0 rows (approximately)
DELETE FROM `acl_acl`;
/*!40000 ALTER TABLE `acl_acl` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_acl` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_acl_sections
DROP TABLE IF EXISTS `acl_acl_sections`;
CREATE TABLE IF NOT EXISTS `acl_acl_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_value_acl_sections` (`value`),
  KEY `acl_hidden_acl_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_acl_sections: ~2 rows (approximately)
DELETE FROM `acl_acl_sections`;
/*!40000 ALTER TABLE `acl_acl_sections` DISABLE KEYS */;
INSERT INTO `acl_acl_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
	(1, 'system', 1, 'System', 0),
	(2, 'user', 2, 'User', 0);
/*!40000 ALTER TABLE `acl_acl_sections` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aco
DROP TABLE IF EXISTS `acl_aco`;
CREATE TABLE IF NOT EXISTS `acl_aco` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(240) NOT NULL DEFAULT '0',
  `value` varchar(240) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_section_value_value_aco` (`section_value`,`value`),
  KEY `acl_hidden_aco` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aco: ~0 rows (approximately)
DELETE FROM `acl_aco`;
/*!40000 ALTER TABLE `acl_aco` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aco` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aco_map
DROP TABLE IF EXISTS `acl_aco_map`;
CREATE TABLE IF NOT EXISTS `acl_aco_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(230) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aco_map: ~0 rows (approximately)
DELETE FROM `acl_aco_map`;
/*!40000 ALTER TABLE `acl_aco_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aco_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aco_sections
DROP TABLE IF EXISTS `acl_aco_sections`;
CREATE TABLE IF NOT EXISTS `acl_aco_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_value_aco_sections` (`value`),
  KEY `acl_hidden_aco_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aco_sections: ~0 rows (approximately)
DELETE FROM `acl_aco_sections`;
/*!40000 ALTER TABLE `acl_aco_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aco_sections` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aro
DROP TABLE IF EXISTS `acl_aro`;
CREATE TABLE IF NOT EXISTS `acl_aro` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(240) NOT NULL DEFAULT '0',
  `value` varchar(240) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_section_value_value_aro` (`section_value`,`value`),
  KEY `acl_hidden_aro` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aro: ~0 rows (approximately)
DELETE FROM `acl_aro`;
/*!40000 ALTER TABLE `acl_aro` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aro` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aro_groups
DROP TABLE IF EXISTS `acl_aro_groups`;
CREATE TABLE IF NOT EXISTS `acl_aro_groups` (
  `id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`value`),
  UNIQUE KEY `acl_value_aro_groups` (`value`),
  KEY `acl_parent_id_aro_groups` (`parent_id`),
  KEY `acl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aro_groups: ~0 rows (approximately)
DELETE FROM `acl_aro_groups`;
/*!40000 ALTER TABLE `acl_aro_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aro_groups` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aro_groups_map
DROP TABLE IF EXISTS `acl_aro_groups_map`;
CREATE TABLE IF NOT EXISTS `acl_aro_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aro_groups_map: ~0 rows (approximately)
DELETE FROM `acl_aro_groups_map`;
/*!40000 ALTER TABLE `acl_aro_groups_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aro_groups_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aro_map
DROP TABLE IF EXISTS `acl_aro_map`;
CREATE TABLE IF NOT EXISTS `acl_aro_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(230) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aro_map: ~0 rows (approximately)
DELETE FROM `acl_aro_map`;
/*!40000 ALTER TABLE `acl_aro_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aro_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_aro_sections
DROP TABLE IF EXISTS `acl_aro_sections`;
CREATE TABLE IF NOT EXISTS `acl_aro_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_value_aro_sections` (`value`),
  KEY `acl_hidden_aro_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_aro_sections: ~0 rows (approximately)
DELETE FROM `acl_aro_sections`;
/*!40000 ALTER TABLE `acl_aro_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_aro_sections` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_axo
DROP TABLE IF EXISTS `acl_axo`;
CREATE TABLE IF NOT EXISTS `acl_axo` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(240) NOT NULL DEFAULT '0',
  `value` varchar(240) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_section_value_value_axo` (`section_value`,`value`),
  KEY `acl_hidden_axo` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_axo: ~0 rows (approximately)
DELETE FROM `acl_axo`;
/*!40000 ALTER TABLE `acl_axo` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_axo` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_axo_groups
DROP TABLE IF EXISTS `acl_axo_groups`;
CREATE TABLE IF NOT EXISTS `acl_axo_groups` (
  `id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`value`),
  UNIQUE KEY `acl_value_axo_groups` (`value`),
  KEY `acl_parent_id_axo_groups` (`parent_id`),
  KEY `acl_lft_rgt_axo_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_axo_groups: ~0 rows (approximately)
DELETE FROM `acl_axo_groups`;
/*!40000 ALTER TABLE `acl_axo_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_axo_groups` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_axo_groups_map
DROP TABLE IF EXISTS `acl_axo_groups_map`;
CREATE TABLE IF NOT EXISTS `acl_axo_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_axo_groups_map: ~0 rows (approximately)
DELETE FROM `acl_axo_groups_map`;
/*!40000 ALTER TABLE `acl_axo_groups_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_axo_groups_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_axo_map
DROP TABLE IF EXISTS `acl_axo_map`;
CREATE TABLE IF NOT EXISTS `acl_axo_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(230) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_axo_map: ~0 rows (approximately)
DELETE FROM `acl_axo_map`;
/*!40000 ALTER TABLE `acl_axo_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_axo_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_axo_sections
DROP TABLE IF EXISTS `acl_axo_sections`;
CREATE TABLE IF NOT EXISTS `acl_axo_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(230) NOT NULL,
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL,
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_value_axo_sections` (`value`),
  KEY `acl_hidden_axo_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_axo_sections: ~0 rows (approximately)
DELETE FROM `acl_axo_sections`;
/*!40000 ALTER TABLE `acl_axo_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_axo_sections` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_groups_aro_map
DROP TABLE IF EXISTS `acl_groups_aro_map`;
CREATE TABLE IF NOT EXISTS `acl_groups_aro_map` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `aro_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`aro_id`),
  KEY `acl_aro_id` (`aro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_groups_aro_map: ~0 rows (approximately)
DELETE FROM `acl_groups_aro_map`;
/*!40000 ALTER TABLE `acl_groups_aro_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_groups_aro_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_groups_axo_map
DROP TABLE IF EXISTS `acl_groups_axo_map`;
CREATE TABLE IF NOT EXISTS `acl_groups_axo_map` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `axo_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`axo_id`),
  KEY `acl_axo_id` (`axo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_groups_axo_map: ~0 rows (approximately)
DELETE FROM `acl_groups_axo_map`;
/*!40000 ALTER TABLE `acl_groups_axo_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_groups_axo_map` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_phpgacl
DROP TABLE IF EXISTS `acl_phpgacl`;
CREATE TABLE IF NOT EXISTS `acl_phpgacl` (
  `name` varchar(230) NOT NULL,
  `value` varchar(230) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.acl_phpgacl: ~2 rows (approximately)
DELETE FROM `acl_phpgacl`;
/*!40000 ALTER TABLE `acl_phpgacl` DISABLE KEYS */;
INSERT INTO `acl_phpgacl` (`name`, `value`) VALUES
	('schema_version', '2.1'),
	('version', '3.3.7');
/*!40000 ALTER TABLE `acl_phpgacl` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_resources
DROP TABLE IF EXISTS `acl_resources`;
CREATE TABLE IF NOT EXISTS `acl_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `module_display_name` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `controller_display_name` varchar(255) NOT NULL,
  `action` varchar(45) NOT NULL,
  `action_display_name` varchar(45) NOT NULL,
  `modified` date NOT NULL,
  `created` date NOT NULL,
  `listing_order` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.acl_resources: 16 rows
DELETE FROM `acl_resources`;
/*!40000 ALTER TABLE `acl_resources` DISABLE KEYS */;
INSERT INTO `acl_resources` (`id`, `module`, `module_display_name`, `controller`, `controller_display_name`, `action`, `action_display_name`, `modified`, `created`, `listing_order`) VALUES
	(1, 'Admin', 'Manage Admin', 'user', 'Manage Users', 'index', 'Listing', '2012-05-11', '2012-05-10', 2),
	(2, 'Admin', 'Admin', 'PageHelp', 'Pagewise Help', 'PageHelp', 'Page Help', '2012-05-11', '2012-05-10', 2),
	(3, 'Admin', 'Admin', 'Planconfig', 'Plan Configuration', 'index', 'List', '2012-05-11', '2012-05-11', 3),
	(7, 'Admin', 'Admin', 'Plans', 'Plan Details', 'index', 'List Plans', '2012-05-14', '2012-05-14', 3),
	(8, 'Admin', 'Admin', 'Plans', 'Plan Details', 'add', 'Add New Plan', '2012-05-14', '2012-05-14', 5),
	(9, 'Admin', 'Admin', 'Plans', 'Plan Details', 'edit', 'Edit Plan', '2012-05-14', '2012-05-14', 6),
	(10, 'Admin', 'Admin', 'Plans', 'Plan Details', 'delete', 'Delete Plan', '2012-05-14', '2012-05-14', 7),
	(11, 'user', 'User', 'Profile', 'Profile Update', 'index', 'View Profile', '2012-05-17', '2012-05-17', 8),
	(12, 'user', 'User', 'Changepassword', 'Change Password', 'index', 'Update Password', '2012-05-17', '2012-05-17', 9),
	(13, 'user', 'User', 'Plan', 'Plan Details', 'index', 'List Plan Details', '2012-05-17', '2012-05-17', 10),
	(14, 'user', 'User', 'Products', 'Products', 'index', 'List Additional Products', '2012-05-18', '2012-05-17', 11),
	(15, 'user', 'User', 'Products', 'Products', 'addtocart', 'Add To Cart', '2012-05-18', '2012-05-17', 12),
	(16, 'user', 'User', 'Invoice', 'Invoice', 'paidinvoice', 'Paid Invoice Section', '2012-05-17', '2012-05-17', 13),
	(17, 'user', 'User', 'Invoice', 'Invoice', 'outstandinginvoice', 'Outstanding Invoice List', '2012-05-17', '2012-05-17', 15),
	(18, 'user', 'User', 'Invoice', 'Invoice', 'ledgerbalance', 'Details of Ledger Balance', '2012-05-18', '2012-05-17', 16),
	(19, 'user', 'User', 'Profile', 'Profile Update', 'update', 'Update Profile', '2012-05-21', '2012-05-21', 9);
/*!40000 ALTER TABLE `acl_resources` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_roleresources
DROP TABLE IF EXISTS `acl_roleresources`;
CREATE TABLE IF NOT EXISTS `acl_roleresources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `resourceId` int(11) NOT NULL,
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_idx` (`roleId`),
  KEY `resources_idx` (`resourceId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.acl_roleresources: 0 rows
DELETE FROM `acl_roleresources`;
/*!40000 ALTER TABLE `acl_roleresources` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_roleresources` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_roles
DROP TABLE IF EXISTS `acl_roles`;
CREATE TABLE IF NOT EXISTS `acl_roles` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `default_val` tinyint(1) DEFAULT NULL,
  `modified` date DEFAULT NULL,
  `created` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.acl_roles: 6 rows
DELETE FROM `acl_roles`;
/*!40000 ALTER TABLE `acl_roles` DISABLE KEYS */;
INSERT INTO `acl_roles` (`id`, `customer_id`, `name`, `default_val`, `modified`, `created`) VALUES
	(1, 1, 'Super Admin', 1, '0000-00-00', '2012-04-10'),
	(2, 1, 'Staff', 0, '0000-00-00', '2012-04-10'),
	(3, 1, 'Sales', 0, '2012-05-11', '2012-05-11'),
	(4, 1, 'Support', 0, '2012-05-11', '2012-05-11'),
	(14, 1, 'developer', 0, '2012-05-16', '2012-05-16'),
	(13, 8, 'Staff', 0, '2012-05-16', '2012-05-16');
/*!40000 ALTER TABLE `acl_roles` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.acl_user_setting
DROP TABLE IF EXISTS `acl_user_setting`;
CREATE TABLE IF NOT EXISTS `acl_user_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL DEFAULT '0',
  `acl_resource` text NOT NULL,
  `acl_action` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=latin1 COMMENT='Controller and Action Section for a user';

-- Dumping data for table hosted_emr.acl_user_setting: ~93 rows (approximately)
DELETE FROM `acl_user_setting`;
/*!40000 ALTER TABLE `acl_user_setting` DISABLE KEYS */;
INSERT INTO `acl_user_setting` (`id`, `hf_id`, `acl_resource`, `acl_action`) VALUES
	(2, 95, 'Profile,Changepassword,Plan,Products', '13,14,11,19'),
	(3, 94, 'Changepassword,Plan', '12,13'),
	(4, 105, 'Profile,Changepassword,Plan,Products,Invoice', '12,18,17,16,13,15,14,11,19'),
	(5, 108, 'Profile,Changepassword,Plan,Products,Invoice', '12,18,17,16,13,15,14,11,19'),
	(31, 145, 'Profile,Changepassword,Plan,Products,Invoice', '18,17,16,13,15,14,11,19'),
	(42, 156, 'Profile,Changepassword,Plan,Products,Invoice', '18,17,16,13,15,14,11,19'),
	(55, 169, 'Profile,Changepassword,Plan,Products,Invoice', '18,17,16,13,15,14,11,19'),
	(56, 170, 'Profile,Changepassword,Plan,Products,Invoice', '18,17,16,13,15,14,11,19'),
	(57, 171, 'Profile,Changepassword,Plan,Products,Invoice', '18,17,16,13,15,14,11,19'),
	(78, 192, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(82, 196, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(83, 197, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(84, 198, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(85, 199, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(86, 200, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(88, 202, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(89, 203, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(90, 204, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(91, 205, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(92, 206, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(93, 207, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(94, 208, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(95, 209, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(96, 210, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(97, 211, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(98, 212, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(99, 213, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(100, 214, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(101, 215, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(102, 216, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(103, 217, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(104, 218, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(105, 219, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(106, 220, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(107, 221, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(108, 222, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(109, 223, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(110, 224, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(111, 225, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(112, 226, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(113, 227, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(114, 228, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(115, 229, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(116, 230, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(117, 231, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(118, 232, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(119, 233, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(120, 234, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(121, 235, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(122, 236, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(123, 237, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(124, 238, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(125, 239, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(126, 240, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(127, 241, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(128, 242, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(129, 243, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(130, 244, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(131, 245, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(132, 246, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(133, 247, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(134, 248, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(135, 249, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(136, 250, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(137, 251, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(138, 252, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(139, 253, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(140, 254, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(141, 255, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(142, 256, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(143, 257, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(144, 258, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(145, 259, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(146, 260, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(147, 261, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(148, 262, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(149, 263, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(150, 264, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(151, 265, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(152, 266, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(153, 267, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(154, 268, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(155, 269, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(156, 270, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(157, 271, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(158, 272, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(159, 273, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(160, 274, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(161, 275, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(162, 276, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(163, 277, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(164, 278, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(165, 279, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20'),
	(166, 280, 'Profile,Changepassword,Plan,Products,Invoice,Backup', '18,17,16,13,15,14,11,19,20');
/*!40000 ALTER TABLE `acl_user_setting` ENABLE KEYS */;


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
	DECLARE category VARCHAR(50) DEFAULT "product";
	DECLARE productname VARCHAR(150) DEFAULT "Product";
	DECLARE pcost FLOAT(20) DEFAULT 0.00;
	DECLARE setupfee FLOAT(20) DEFAULT 0.00;
	DECLARE providercostnature FLOAT(20) DEFAULT 0.00;
	DECLARE providersetupnature FLOAT(20) DEFAULT 0.00;
	DECLARE totalprice FLOAT(20) DEFAULT 0.00;
	DECLARE uprice INT DEFAULT 0;
	DECLARE cdate DATE DEFAULT CURDATE();
	DECLARE cartidcount INT DEFAULT 0;
	
	SELECT category,product_name,cost,setup_fee,provider_cost_nature,provider_setup_nature INTO category,productname,pcost,setupfee,providercostnature,providersetupnature FROM products WHERE idproducts=pid;
	
	SELECT COUNT(idcart) into cartidcount FROM cart WHERE cartsession=sessionid AND product_id=pid AND hf_id=hf_id AND invoice_no is null;
	IF cartidcount = 0 THEN
		IF providercostnature = 1 THEN
			SET uprice = pcost * providerno;
		ELSE
			SET uprice = pcost;
		END IF;
		
		IF providersetupnature = 1 THEN
			SET setupfee = setupfee * providerno;
		ELSE
			SET setupfee = setupfee;
		END IF;
		
		SET totalprice = uprice + setupfee;
		
		INSERT INTO customer_products(hf_id,hp_id,idproducts,category,product_name,cost,setup_fee,product_status,additional) VALUES (hf_id,0,pid,category,productname,uprice,setupfee,1,1);
		
		INSERT INTO cart(cartsession,product_id,hf_id,description,qty,unit_price,setupfee,total,cstatus,cart_date)VALUES(sessionid,pid,hf_id,productname,providerno,uprice,setupfee,totalprice,0,cdate);
		
		
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
  `roleId` bigint(20) NOT NULL,
  `role` varchar(250) NOT NULL,
  `AdminLastLogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AdminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Administrator Login Informations';

-- Dumping data for table hosted_emr.admin_details: ~1 rows (approximately)
DELETE FROM `admin_details`;
/*!40000 ALTER TABLE `admin_details` DISABLE KEYS */;
INSERT INTO `admin_details` (`AdminId`, `customer_id`, `AdminUserId`, `AdminPassword`, `AdminFullName`, `AdminEmail`, `roleId`, `role`, `AdminLastLogin`) VALUES
	(1, 1, 'admin', 'admin', 'Administrator', 'hemr@zhservices.com', 0, '', '2012-02-23 17:25:20');
/*!40000 ALTER TABLE `admin_details` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.autonumber
DROP TABLE IF EXISTS `autonumber`;
CREATE TABLE IF NOT EXISTS `autonumber` (
  `autonumber` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Storing autonumber storage';

-- Dumping data for table hosted_emr.autonumber: ~80 rows (approximately)
DELETE FROM `autonumber`;
/*!40000 ALTER TABLE `autonumber` DISABLE KEYS */;
INSERT INTO `autonumber` (`autonumber`) VALUES
	('db8d51fc'),
	('bf3581a2'),
	('1d038fa7'),
	('c19afe3d'),
	('91e2ca3a'),
	('10ef4b28'),
	('b1772946'),
	('cd279020'),
	('d5a89503'),
	('58693bb1'),
	('62e8af2e'),
	('b6eb3881'),
	('2fd2e547'),
	('328bc137'),
	('57527af6'),
	('2b40cce4'),
	('c781acd0'),
	('8bfeb6f9'),
	('bfc591da'),
	('15df8416'),
	('753b776d'),
	('15e16cf4'),
	('9750237c'),
	('efef8004'),
	('00260846'),
	('0fec4d24'),
	('cb4057ac'),
	('16bc01fe'),
	('a898876e'),
	('d6d7a0c0'),
	('54a12662'),
	('642aa783'),
	('5cca2c4a'),
	('6c4a1567'),
	('f7863d2b'),
	('e1e4a06c'),
	('f6840eee'),
	('4f294589'),
	('88ac334a'),
	('74b0893b'),
	('3cf90cf4'),
	('dd75ac89'),
	('caa58dc0'),
	('b24d87d3'),
	('91531e63'),
	('1dc79376'),
	('74a294fa'),
	('cfca61ab'),
	('02ae2ca7'),
	('c14f7f08'),
	('ae935a4c'),
	('19107f80'),
	('44c3e6ad'),
	('34934bfa'),
	('00b2c81b'),
	('6f2d20bb'),
	('b4aa2a04'),
	('b6cb539f'),
	('7df6153e'),
	('206b91c1'),
	('26d15003'),
	('df3d2245'),
	('feb29d2c'),
	('4ddcce95'),
	('abd11409'),
	('c1cde5ab'),
	('13033a64'),
	('b25c18d1'),
	('fd4a164c'),
	('bb6139f2'),
	('65d35193'),
	('4367caa5'),
	('10f48099'),
	('88d31ea6'),
	('80597f4e'),
	('952f7cf9'),
	('5c515cc3'),
	('192b55ff'),
	('f26bf32a'),
	('6423d1eb');
/*!40000 ALTER TABLE `autonumber` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=latin1 COMMENT='Shopping Cart';

-- Dumping data for table hosted_emr.cart: ~37 rows (approximately)
DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`idcart`, `cartsession`, `plan_id`, `product_id`, `hf_id`, `description`, `qty_from`, `qty`, `unit_price`, `setupfee`, `discount`, `setupfee_discount`, `total`, `cstatus`, `cart_date`, `invoice_no`) VALUES
	(445, '8btl0b79qofupruvpa8b1n8up2', 15, 0, 248, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-02', 'ZH-2012-07-02-00030'),
	(446, '5gvgq9t0vbi1rl9gvgd1l2rl45', 15, 0, 249, 'ZH EMRRevenue Subscription', 0, 1, 285, 0, 35, 0, 250, 1, '2012-07-02', 'ZH-2012-07-02-00031'),
	(447, 'cbtrk508vih1ld5m5qam4rm033', 15, 0, 250, 'ZH EMRRevenue Subscription', 0, 2, 370, 0, 70, 0, 300, 0, '2012-07-03', 'ZH-2012-07-03-00032'),
	(450, 'cbtrk508vih1ld5m5qam4rm033', 0, 34, 250, 'Concierge Support', 0, 2, 400, 0, 0, 0, 400, 0, '2012-07-03', 'ZH-2012-07-03-00032'),
	(453, '0sg1gh9q1si403u302lbv3svh4', 15, 0, 252, 'ZH EMRRevenue Subscription', 0, 2, 370, 0, 70, 0, 300, 0, '2012-07-03', 'ZH-2012-07-03-00034'),
	(454, '0sg1gh9q1si403u302lbv3svh4', 0, 34, 252, 'Concierge Support', 0, 2, 400, 0, 0, 0, 400, 0, '2012-07-03', 'ZH-2012-07-03-00034'),
	(455, 'hst2k708icnlpm4v9j47tif5c5', 15, 0, 253, 'ZH EMRRevenue Subscription', 0, 2, 370, 0, 70, 0, 300, 1, '2012-07-03', 'ZH-2012-07-03-00036'),
	(456, 'hst2k708icnlpm4v9j47tif5c5', 0, 34, 253, 'Concierge Support', 0, 2, 400, 0, 0, 0, 400, 1, '2012-07-03', 'ZH-2012-07-03-00036'),
	(457, 'hst2k708icnlpm4v9j47tif5c5', 15, 0, 254, 'ZH EMRRevenue Subscription', 0, 2, 370, 0, 70, 0, 300, 0, '2012-07-03', 'ZH-2012-07-03-00036'),
	(459, 'hst2k708icnlpm4v9j47tif5c5', 0, 34, 254, 'Concierge Support', 0, 2, 400, 0, 0, 0, 400, 0, '2012-07-03', 'ZH-2012-07-03-00036'),
	(460, 'hst2k708icnlpm4v9j47tif5c5', 15, 0, 255, 'ZH EMRRevenue Subscription', 0, 3, 855, 0, 105, 0, 750, 0, '2012-07-03', NULL),
	(461, 'adj3jt1m2kp33r1j7ddcfdmrf2', 15, 0, 256, 'ZH EMRRevenue Subscription', 0, 3, 555, 0, 105, 0, 450, 1, '2012-07-03', 'ZH-2012-07-03-00037'),
	(462, 'adj3jt1m2kp33r1j7ddcfdmrf2', 0, 34, 256, 'Concierge Support', 0, 3, 600, 0, 0, 0, 600, 1, '2012-07-03', 'ZH-2012-07-03-00037'),
	(463, '6qlvs1gkrn3lpm7qfa61pkqvm3', 16, 0, 257, 'ZH EMRPractice Subscription', 0, 2, 670, 0, 70, 0, 600, 0, '2012-07-03', NULL),
	(464, '7naq8vr7vm4blhd9p1nrdj1gj6', 257, 0, 257, ' Subscription', 0, 2, 0, 0, 0, 0, 0, 0, '2012-07-03', NULL),
	(465, '7naq8vr7vm4blhd9p1nrdj1gj6', 257, 0, 257, ' Subscription', 0, 2, 0, 0, 0, 0, 0, 0, '2012-07-03', NULL),
	(466, '6famaon60c642jaetiill50bb1', 15, 0, 265, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-05', NULL),
	(467, '6famaon60c642jaetiill50bb1', 15, 0, 268, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-05', NULL),
	(468, '6famaon60c642jaetiill50bb1', 15, 0, 269, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-05', NULL),
	(469, '6famaon60c642jaetiill50bb1', 15, 0, 270, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-05', NULL),
	(470, '6famaon60c642jaetiill50bb1', 15, 0, 271, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-05', NULL),
	(472, '8dj585va32kbsn0leah0vjag32', 16, 0, 272, 'ZH EMRPractice Subscription', 0, 2, 670, 0, 70, 0, 600, 1, '2012-07-05', 'ZH-2012-07-05-00038'),
	(473, '3q4nitbs01jdtnb66e3e5anvq2', 16, 0, 273, 'ZH EMRPractice Subscription', 0, 3, 1005, 0, 105, 0, 900, 1, '2012-07-05', 'ZH-2012-07-05-00039'),
	(474, 'u5akgkqvnldvk3h0gdencstq36', 1, 0, 272, 'ZH EMRCapture Subscription', 0, 2, 350, 0, 14, 0, 336, 1, '2012-07-05', 'ZH-2012-07-05-00040'),
	(475, 'ruo2d1rcu5p41cuah3ldj7ioq1', 15, 0, 272, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-05', 'ZH-2012-07-05-00041'),
	(476, 'f6cr6otne1ig2b8p5sb93tdnv2', 15, 0, 272, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-05', 'ZH-2012-07-05-00042'),
	(477, '5cm1b1k37loe45vvrn44t64ra1', 15, 0, 272, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-05', 'ZH-2012-07-05-00044'),
	(478, '5cm1b1k37loe45vvrn44t64ra1', 15, 0, 272, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-05', 'ZH-2012-07-05-00044'),
	(479, 'd8bugbhiv5u5q67n3925fjv5v5', 15, 0, 274, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 0, '2012-07-12', 'ZH-2012-07-12-00045'),
	(480, 'b2blovcop4qf87nuqer03cgq76', 15, 0, 275, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-12', 'ZH-2012-07-12-00046'),
	(481, '20ik5ltu9ni37ufrmoam6rgs46', 15, 0, 276, 'ZH EMRRevenue Subscription', 0, 1, 285, 0, 35, 0, 250, 1, '2012-07-12', 'ZH-2012-07-12-00047'),
	(482, '1vgkij3ie3vqijfafop10tt167', 15, 0, 277, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-12', 'ZH-2012-07-12-00048'),
	(483, 'jd6d64frn7dghjcqg4gnkvb2l2', 15, 0, 247, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 70, 0, 500, 1, '2012-07-12', 'ZH-2012-07-12-00049'),
	(484, 'oe5nttr9uavm9rl2nfdtvvnku5', 15, 0, 278, 'ZH EMRRevenue Subscription', 0, 1, 285, 0, 35, 0, 250, 0, '2012-07-14', NULL),
	(485, '429hopgmdqdhtjqdp3tmn5cps0', 1, 0, 278, 'ZH EMRCapture Subscription', 0, 1, 175, 0, 7, 0, 168, 0, '2012-07-14', 'ZH-2012-07-14-00050'),
	(486, 'hmhlas92edqfjoadbuv07hh8p3', 16, 0, 278, 'ZH EMRPractice Subscription', 0, 2, 670, 0, 70, 0, 600, 1, '2012-07-14', 'ZH-2012-07-14-00051'),
	(487, '5uirimd4l74nubqlv769vincu0', 15, 0, 279, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 22.8, 0, 547.2, 1, '2012-07-17', 'ZH-2012-07-17-00052'),
	(488, '5uirimd4l74nubqlv769vincu0', 15, 0, 280, 'ZH EMRRevenue Subscription', 0, 2, 570, 0, 22.8, 0, 547.2, 0, '2012-07-17', NULL);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;


-- Dumping structure for procedure hosted_emr.cart_products
DROP PROCEDURE IF EXISTS `cart_products`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `cart_products`(IN `hf_idvar` BIGINT, IN `cusid` BIGINT)
BEGIN
     SELECT idproducts,category,product_name,product_feature,cost,setup_fee FROM products WHERE 
customer_id=cusid AND product_status='1'  AND idproducts NOT IN(SELECT idproducts FROM customer_products WHERE 
hf_id=hf_idvar) ORDER BY category,product_sort_order;
   
    END//
DELIMITER ;


-- Dumping structure for table hosted_emr.cms
DROP TABLE IF EXISTS `cms`;
CREATE TABLE IF NOT EXISTS `cms` (
  `cms_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `cms_sec` varchar(50) NOT NULL,
  `cms_title` varchar(50) NOT NULL,
  `cms_details` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.cms: ~17 rows (approximately)
DELETE FROM `cms`;
/*!40000 ALTER TABLE `cms` DISABLE KEYS */;
INSERT INTO `cms` (`cms_id`, `customer_id`, `cms_sec`, `cms_title`, `cms_details`, `status`) VALUES
	(1, 1, 'homepage', ' ', '<table align="center" border="0" cellpadding="1" cellspacing="1" style="width: 657px; height: 83px;">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<em>No</em> software to install or hardware to maintain</td>\r\n			<td>\r\n				Adaptable to your practice workflow</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<em>No</em> vendor &quot;lock-in&quot; - based on OpenEMR</td>\r\n			<td>\r\n				100% HIPAA compliant and secure</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<em><u>Low Cost</u></em> monthly fee with no set-up fees</td>\r\n			<td>\r\n				ONCHIT Certified for Meaningful Use</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', 1),
	(2, 1, 'Confirm Invoice', 'Registration Confirmation', '<p>\r\n	You have completed the registration process.&nbsp; Please confirm your invoice and proceed to payment</p>\r\n', 1),
	(3, 1, 'Paypal_intimation', 'Paypal', '	Paypal is our authorized merchant to accept the payment. Please proceed with instructions to make your payment.\r\n', 1),
	(4, 1, 'User_welcome_after_login', '', '<p>\r\n	Welcome to ZH Healthcare! It is our goal to enable you with the information you need to be successful with ZH OpenEMR.</p>\r\n<p>\r\n	Here you may: &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Update your profile</li>\r\n	<li>\r\n		Manage your ZH OpenEMR plan</li>\r\n	<li>\r\n		Review payment information&nbsp;</li>\r\n	<li>\r\n		View status of your support tickets</li>\r\n	<li>\r\n		View messages with important updates regarding improvements and enhancements of your products</li>\r\n	<li>\r\n		Access recommended training for you and your staff</li>\r\n</ul>\r\n', 1),
	(5, 1, 'Plan List Page', '', '', 1),
	(6, 1, 'Compare Plans', 'Compare Plans', '<p>\r\n	<strong>Still not sure which plan is best for your practice? (EMR Assistant)</strong></p>\r\n', 1),
	(7, 1, 'Register User', 'Registration', '', 1),
	(8, 1, 'Cart', 'Review Your Plan Selection', '<p>\r\n	<strong>Please review your plan selection.&nbsp; You may also customize your plan with additional ZH Healthcare products and services.</strong></p>\r\n', 1),
	(10, 1, 'ZHOpen EMR Support Scope', 'ZH OpenEMR Support Scope', '<table border="0" cellpadding="2" cellspacing="2" id="supportplans" width="100%">\r\n	<tbody>\r\n		<tr>\r\n			<th>\r\n				<h2>\r\n					ZH OpenEMR Support Levels and Benefits</h2>\r\n			</th>\r\n			<th>\r\n				Essential</th>\r\n			<th>\r\n				<h2>\r\n					<strong>Preferred</strong></h2>\r\n			</th>\r\n			<th>\r\n				Concierge</th>\r\n		</tr>\r\n		<tr>\r\n			<th>\r\n				Basics</th>\r\n			<td align="center" colspan="3" rowspan="1">\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<strong>Pricing (Monthly / Per Provider)</strong></td>\r\n			<td align="center">\r\n				<strong>$0.00</strong></td>\r\n			<td align="center">\r\n				<strong>$100.00</strong></td>\r\n			<td align="center">\r\n				<strong>$200.00</strong></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Included Support Requests (Incidents)</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Named Contacts</td>\r\n			<td align="center">\r\n				1</td>\r\n			<td align="center">\r\n				1</td>\r\n			<td align="center">\r\n				3</td>\r\n		</tr>\r\n		<tr>\r\n			<th>\r\n				Supported Software</th>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Resolution for ZH -owned software issues</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				ZH OpenEMR</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				ZH Advanced Billing Module</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				ZH eRx</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				ZH Lab Interface</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Clearing house Integration</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<th>\r\n				Problem Resolution Support</th>\r\n			<td align="center" colspan="3" rowspan="1">\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Included Cases (Incidents)</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n			<td align="center">\r\n				unlimited</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Local business hours</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Initial Response Time</td>\r\n			<td align="center">\r\n				48 Hours</td>\r\n			<td align="center">\r\n				12 Hours</td>\r\n			<td align="center">\r\n				1 Hour</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Web Case Management</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Email Support</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				One-on-one online support</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				One-on-one phone support</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Remote Troubleshooting</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Direct access to Customer Care Manager</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<th>\r\n				<strong>Consultative Support </strong></th>\r\n			<td align="center">\r\n				&nbsp;</td>\r\n			<td align="center">\r\n				&nbsp;</td>\r\n			<td align="center">\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Best practice guidance</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Go-Live Assistance</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Scheduled Upgrade Assistance</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Configuration Review</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Usage Review</td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="No" src="http://www.hostedopenemr.com/images/no.png" title="No" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<th>\r\n				<strong>Self Help Support </strong></th>\r\n			<td align="center" colspan="3" rowspan="1">\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Account Portal</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Access to online videos</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Access to community forums</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				Knowledge Base</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				User Forums</td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n			<td align="center">\r\n				<img alt="Yes" src="http://www.hostedopenemr.com/images/ok.png" title="Yes" /></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', 1),
	(11, 1, 'Privacy Policy', '', '<p>\r\n	<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<div class="rc">\r\n	<p>\r\n		It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n</div>\r\n<p>\r\n	&nbsp;Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of &quot;de Finibus Bonorum et Malorum&quot; (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, &quot;Lorem ipsum dolor sit amet..&quot;, comes from a line in section 1.10.32.</p>\r\n<div class="lc">\r\n	<p>\r\n		The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from &quot;de Finibus Bonorum et Malorum&quot; by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n', 1),
	(12, 1, 'Terms of Use', '', '<p>\r\n	<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<div class="rc">\r\n	<p>\r\n		It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n</div>\r\n<p>\r\n	&nbsp;Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of &quot;de Finibus Bonorum et Malorum&quot; (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, &quot;Lorem ipsum dolor sit amet..&quot;, comes from a line in section 1.10.32.</p>\r\n<div class="lc">\r\n	<p>\r\n		The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from &quot;de Finibus Bonorum et Malorum&quot; by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n', 1),
	(13, 1, 'Legal Documentation ', '', '<p>\r\n	<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<div class="rc">\r\n	<p>\r\n		It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n</div>\r\n<p>\r\n	&nbsp;Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of &quot;de Finibus Bonorum et Malorum&quot; (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, &quot;Lorem ipsum dolor sit amet..&quot;, comes from a line in section 1.10.32.</p>\r\n<div class="lc">\r\n	<p>\r\n		The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from &quot;de Finibus Bonorum et Malorum&quot; by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n', 1),
	(14, 1, 'Payment Success', 'Thank you for your payment!', '<p>\r\n	Update Content From CMS: Return to dashboard: www.hostedopenemr.com</p>\r\n', 1),
	(15, 1, 'Payment Fail', 'Sorry!!', '<p>\r\n	We were unable to verify your credit card.&nbsp;&nbsp; Please return to the payment screen to&nbsp; verify your credit card number or call us at &lt;need number&gt; and we will be happy to help you with the registration process.</p>\r\n', 1),
	(16, 1, 'Forgot Password', 'We will help you !!!', '<p>\r\n	Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words.</p>\r\n', 1),
	(17, 1, 'Cart Additional Product Intro', '', 'Would you like to change your support plan? . When you do so your current support plan will be replaced by the one that you have selected.  ', 1),
	(18, 1, 'Payment Confirmation', '', '<font face="Verdana, Geneva, sans-serif" color="#223E6A" size="2">\r\n<p>Hi Name,</p>\r\n<p><br />\r\n  Thanks for making the payment. Your Transaction is completed  successfully and the <strong>Transaction Id is : 23423423</strong>. Please this transaction ID  for future reference.</p>\r\n<p><br />\r\n  Your Plan set up is initiated and will set up in 12 Hours.  Once the plan is configured you will be notified by mail. If you not received  any update in 12 Hours, Contact us on <a href="mailto:support@zhservices.com">support@zhservices.com</a> with your Transaction ID as reference.</p>\r\n<p><br />\r\n  Welcome to ZH OpenEMR.</p>\r\n  </font>', 1);
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
	('ALB', 'Albania', 'Europe', 'Southern Europe', 28748.00, 1912, 3401200, 71.6, 3205.00, 2500.00, 'ShqipÃƒÂ«ria', 'Republic', 'Rexhep Mejdani', 34, 'AL'),
	('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.00, 1962, 31471000, 69.7, 49982.00, 46966.00, 'Al-JazaÃ¢â‚¬â„¢ir/AlgÃƒÂ©rie', 'Republic', 'Abdelaziz Bouteflika', 35, 'DZ'),
	('ASM', 'American Samoa', 'Oceania', 'Polynesia', 199.00, NULL, 68000, 75.1, 334.00, NULL, 'Amerika Samoa', 'US Territory', 'George W. Bush', 54, 'AS'),
	('AND', 'Andorra', 'Europe', 'Southern Europe', 468.00, 1278, 78000, 83.5, 1630.00, NULL, 'Andorra', 'Parliamentary Coprincipality', '', 55, 'AD'),
	('AGO', 'Angola', 'Africa', 'Central Africa', 1246700.00, 1975, 12878000, 38.3, 6648.00, 7984.00, 'Angola', 'Republic', 'JosÃƒÂ© Eduardo dos Santos', 56, 'AO'),
	('AIA', 'Anguilla', 'North America', 'Caribbean', 96.00, NULL, 8000, 76.1, 63.20, NULL, 'Anguilla', 'Dependent Territory of the UK', 'Elisabeth II', 62, 'AI'),
	('ATG', 'Antigua and Barbuda', 'North America', 'Caribbean', 442.00, 1981, 68000, 70.5, 612.00, 584.00, 'Antigua and Barbuda', 'Constitutional Monarchy', 'Elisabeth II', 63, 'AG'),
	('ARE', 'United Arab Emirates', 'Asia', 'Middle East', 83600.00, 1971, 2441000, 74.1, 37966.00, 36846.00, 'Al-Imarat al-Ã‚Â´Arabiya al-Muttahida', 'Emirate Federation', 'Zayid bin Sultan al-Nahayan', 65, 'AE'),
	('ARG', 'Argentina', 'South America', 'South America', 2780400.00, 1816, 37032000, 75.1, 340238.00, 323310.00, 'Argentina', 'Federal Republic', 'Fernando de la RÃƒÂºa', 69, 'AR'),
	('ARM', 'Armenia', 'Asia', 'Middle East', 29800.00, 1991, 3520000, 66.4, 1813.00, 1627.00, 'Hajastan', 'Republic', 'Robert KotÃ…Â¡arjan', 126, 'AM'),
	('ABW', 'Aruba', 'North America', 'Caribbean', 193.00, NULL, 103000, 78.4, 828.00, 793.00, 'Aruba', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', 129, 'AW'),
	('AUS', 'Australia', 'Oceania', 'Australia and New Zealand', 7741220.00, 1901, 18886000, 79.8, 351182.00, 392911.00, 'Australia', 'Constitutional Monarchy, Federation', 'Elisabeth II', 135, 'AU'),
	('AZE', 'Azerbaijan', 'Asia', 'Middle East', 86600.00, 1991, 7734000, 62.9, 4127.00, 4100.00, 'AzÃƒÂ¤rbaycan', 'Federal Republic', 'HeydÃƒÂ¤r Ãƒâ€žliyev', 144, 'AZ'),
	('BHS', 'Bahamas', 'North America', 'Caribbean', 13878.00, 1973, 307000, 71.1, 3527.00, 3347.00, 'The Bahamas', 'Constitutional Monarchy', 'Elisabeth II', 148, 'BS'),
	('BHR', 'Bahrain', 'Asia', 'Middle East', 694.00, 1971, 617000, 73.0, 6366.00, 6097.00, 'Al-Bahrayn', 'Monarchy (Emirate)', 'Hamad ibn Isa al-Khalifa', 149, 'BH'),
	('BGD', 'Bangladesh', 'Asia', 'Southern and Central Asia', 143998.00, 1971, 129155000, 60.2, 32852.00, 31966.00, 'Bangladesh', 'Republic', 'Shahabuddin Ahmad', 150, 'BD'),
	('BRB', 'Barbados', 'North America', 'Caribbean', 430.00, 1966, 270000, 73.0, 2223.00, 2186.00, 'Barbados', 'Constitutional Monarchy', 'Elisabeth II', 174, 'BB'),
	('BEL', 'Belgium', 'Europe', 'Western Europe', 30518.00, 1830, 10239000, 77.8, 249704.00, 243948.00, 'BelgiÃƒÂ«/Belgique', 'Constitutional Monarchy, Federation', 'Albert II', 179, 'BE'),
	('BLZ', 'Belize', 'North America', 'Central America', 22696.00, 1981, 241000, 70.9, 630.00, 616.00, 'Belize', 'Constitutional Monarchy', 'Elisabeth II', 185, 'BZ'),
	('BEN', 'Benin', 'Africa', 'Western Africa', 112622.00, 1960, 6097000, 50.2, 2357.00, 2141.00, 'BÃƒÂ©nin', 'Republic', 'Mathieu KÃƒÂ©rÃƒÂ©kou', 187, 'BJ'),
	('BMU', 'Bermuda', 'North America', 'North America', 53.00, NULL, 65000, 76.9, 2328.00, 2190.00, 'Bermuda', 'Dependent Territory of the UK', 'Elisabeth II', 191, 'BM'),
	('BTN', 'Bhutan', 'Asia', 'Southern and Central Asia', 47000.00, 1910, 2124000, 52.4, 372.00, 383.00, 'Druk-Yul', 'Monarchy', 'Jigme Singye Wangchuk', 192, 'BT'),
	('BOL', 'Bolivia', 'South America', 'South America', 1098581.00, 1825, 8329000, 63.7, 8571.00, 7967.00, 'Bolivia', 'Republic', 'Hugo BÃƒÂ¡nzer SuÃƒÂ¡rez', 194, 'BO'),
	('BIH', 'Bosnia and Herzegovina', 'Europe', 'Southern Europe', 51197.00, 1992, 3972000, 71.5, 2841.00, NULL, 'Bosna i Hercegovina', 'Federal Republic', 'Ante Jelavic', 201, 'BA'),
	('BWA', 'Botswana', 'Africa', 'Southern Africa', 581730.00, 1966, 1622000, 39.3, 4834.00, 4935.00, 'Botswana', 'Republic', 'Festus G. Mogae', 204, 'BW'),
	('BRA', 'Brazil', 'South America', 'South America', 8547403.00, 1822, 170115000, 62.9, 776739.00, 804108.00, 'Brasil', 'Federal Republic', 'Fernando Henrique Cardoso', 211, 'BR'),
	('GBR', 'United Kingdom', 'Europe', 'British Islands', 242900.00, 1066, 59623400, 77.7, 1378330.00, 1296830.00, 'United Kingdom', 'Constitutional Monarchy', 'Elisabeth II', 456, 'GB'),
	('VGB', 'Virgin Islands, British', 'North America', 'Caribbean', 151.00, NULL, 21000, 75.4, 612.00, 573.00, 'British Virgin Islands', 'Dependent Territory of the UK', 'Elisabeth II', 537, 'VG'),
	('BRN', 'Brunei', 'Asia', 'Southeast Asia', 5765.00, 1984, 328000, 73.6, 11705.00, 12460.00, 'Brunei Darussalam', 'Monarchy (Sultanate)', 'Haji Hassan al-Bolkiah', 538, 'BN'),
	('BGR', 'Bulgaria', 'Europe', 'Eastern Europe', 110994.00, 1908, 8190900, 70.9, 12178.00, 10169.00, 'Balgarija', 'Republic', 'Petar Stojanov', 539, 'BG'),
	('BFA', 'Burkina Faso', 'Africa', 'Western Africa', 274000.00, 1960, 11937000, 46.7, 2425.00, 2201.00, 'Burkina Faso', 'Republic', 'Blaise CompaorÃƒÂ©', 549, 'BF'),
	('BDI', 'Burundi', 'Africa', 'Eastern Africa', 27834.00, 1962, 6695000, 46.2, 903.00, 982.00, 'Burundi/Uburundi', 'Republic', 'Pierre Buyoya', 552, 'BI'),
	('CYM', 'Cayman Islands', 'North America', 'Caribbean', 264.00, NULL, 38000, 78.9, 1263.00, 1186.00, 'Cayman Islands', 'Dependent Territory of the UK', 'Elisabeth II', 553, 'KY'),
	('CHL', 'Chile', 'South America', 'South America', 756626.00, 1810, 15211000, 75.7, 72949.00, 75780.00, 'Chile', 'Republic', 'Ricardo Lagos Escobar', 554, 'CL'),
	('COK', 'Cook Islands', 'Oceania', 'Polynesia', 236.00, NULL, 20000, 71.1, 100.00, NULL, 'The Cook Islands', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 583, 'CK'),
	('CRI', 'Costa Rica', 'North America', 'Central America', 51100.00, 1821, 4023000, 75.8, 10226.00, 9757.00, 'Costa Rica', 'Republic', 'Miguel ÃƒÂngel RodrÃƒÂ­guez EcheverrÃƒÂ­a', 584, 'CR'),
	('DJI', 'Djibouti', 'Africa', 'Eastern Africa', 23200.00, 1977, 638000, 50.8, 382.00, 373.00, 'Djibouti/Jibuti', 'Republic', 'Ismail Omar Guelleh', 585, 'DJ'),
	('DMA', 'Dominica', 'North America', 'Caribbean', 751.00, 1978, 71000, 73.4, 256.00, 243.00, 'Dominica', 'Republic', 'Vernon Shaw', 586, 'DM'),
	('DOM', 'Dominican Republic', 'North America', 'Caribbean', 48511.00, 1844, 8495000, 73.2, 15846.00, 15076.00, 'RepÃƒÂºblica Dominicana', 'Republic', 'HipÃƒÂ³lito MejÃƒÂ­a DomÃƒÂ­nguez', 587, 'DO'),
	('ECU', 'Ecuador', 'South America', 'South America', 283561.00, 1822, 12646000, 71.1, 19770.00, 19769.00, 'Ecuador', 'Republic', 'Gustavo Noboa Bejarano', 594, 'EC'),
	('EGY', 'Egypt', 'Africa', 'Northern Africa', 1001449.00, 1922, 68470000, 63.3, 82710.00, 75617.00, 'Misr', 'Republic', 'Hosni Mubarak', 608, 'EG'),
	('SLV', 'El Salvador', 'North America', 'Central America', 21041.00, 1841, 6276000, 69.7, 11863.00, 11203.00, 'El Salvador', 'Republic', 'Francisco Guillermo Flores PÃƒÂ©rez', 645, 'SV'),
	('ERI', 'Eritrea', 'Africa', 'Eastern Africa', 117600.00, 1993, 3850000, 55.8, 650.00, 755.00, 'Ertra', 'Republic', 'Isayas Afewerki [Isaias Afwerki]', 652, 'ER'),
	('ESP', 'Spain', 'Europe', 'Southern Europe', 505992.00, 1492, 39441700, 78.8, 553233.00, 532031.00, 'EspaÃƒÂ±a', 'Constitutional Monarchy', 'Juan Carlos I', 653, 'ES'),
	('ZAF', 'South Africa', 'Africa', 'Southern Africa', 1221037.00, 1910, 40377000, 51.1, 116729.00, 129092.00, 'South Africa', 'Republic', 'Thabo Mbeki', 716, 'ZA'),
	('ETH', 'Ethiopia', 'Africa', 'Eastern Africa', 1104300.00, -1000, 62565000, 45.2, 6353.00, 6180.00, 'YeItyopÃ‚Â´iya', 'Republic', 'Negasso Gidada', 756, 'ET'),
	('FLK', 'Falkland Islands', 'South America', 'South America', 12173.00, NULL, 2000, NULL, 0.00, NULL, 'Falkland Islands', 'Dependent Territory of the UK', 'Elisabeth II', 763, 'FK'),
	('FJI', 'Fiji Islands', 'Oceania', 'Melanesia', 18274.00, 1970, 817000, 67.9, 1536.00, 2149.00, 'Fiji Islands', 'Republic', 'Josefa Iloilo', 764, 'FJ'),
	('PHL', 'Philippines', 'Asia', 'Southeast Asia', 300000.00, 1946, 75967000, 67.5, 65107.00, 82239.00, 'Pilipinas', 'Republic', 'Gloria Macapagal-Arroyo', 766, 'PH'),
	('FRO', 'Faroe Islands', 'Europe', 'Nordic Countries', 1399.00, NULL, 43000, 78.4, 0.00, NULL, 'FÃƒÂ¸royar', 'Part of Denmark', 'Margrethe II', 901, 'FO'),
	('GAB', 'Gabon', 'Africa', 'Central Africa', 267668.00, 1960, 1226000, 50.1, 5493.00, 5279.00, 'Le Gabon', 'Republic', 'Omar Bongo', 902, 'GA'),
	('GMB', 'Gambia', 'Africa', 'Western Africa', 11295.00, 1965, 1305000, 53.2, 320.00, 325.00, 'The Gambia', 'Republic', 'Yahya Jammeh', 904, 'GM'),
	('GEO', 'Georgia', 'Asia', 'Middle East', 69700.00, 1991, 4968000, 64.5, 6064.00, 5924.00, 'Sakartvelo', 'Republic', 'Eduard Ã…Â evardnadze', 905, 'GE'),
	('GHA', 'Ghana', 'Africa', 'Western Africa', 238533.00, 1957, 20212000, 57.4, 7137.00, 6884.00, 'Ghana', 'Republic', 'John Kufuor', 910, 'GH'),
	('GIB', 'Gibraltar', 'Europe', 'Southern Europe', 6.00, NULL, 25000, 79.0, 258.00, NULL, 'Gibraltar', 'Dependent Territory of the UK', 'Elisabeth II', 915, 'GI'),
	('GRD', 'Grenada', 'North America', 'Caribbean', 344.00, 1974, 94000, 64.5, 318.00, NULL, 'Grenada', 'Constitutional Monarchy', 'Elisabeth II', 916, 'GD'),
	('GRL', 'Greenland', 'North America', 'North America', 2166090.00, NULL, 56000, 68.1, 0.00, NULL, 'Kalaallit Nunaat/GrÃƒÂ¸nland', 'Part of Denmark', 'Margrethe II', 917, 'GL'),
	('GLP', 'Guadeloupe', 'North America', 'Caribbean', 1705.00, NULL, 456000, 77.0, 3501.00, NULL, 'Guadeloupe', 'Overseas Department of France', 'Jacques Chirac', 919, 'GP'),
	('GUM', 'Guam', 'Oceania', 'Micronesia', 549.00, NULL, 168000, 77.8, 1197.00, 1136.00, 'Guam', 'US Territory', 'George W. Bush', 921, 'GU'),
	('GTM', 'Guatemala', 'North America', 'Central America', 108889.00, 1821, 11385000, 66.2, 19008.00, 17797.00, 'Guatemala', 'Republic', 'Alfonso Portillo Cabrera', 922, 'GT'),
	('GIN', 'Guinea', 'Africa', 'Western Africa', 245857.00, 1958, 7430000, 45.6, 2352.00, 2383.00, 'GuinÃƒÂ©e', 'Republic', 'Lansana ContÃƒÂ©', 926, 'GN'),
	('GNB', 'Guinea-Bissau', 'Africa', 'Western Africa', 36125.00, 1974, 1213000, 49.0, 293.00, 272.00, 'GuinÃƒÂ©-Bissau', 'Republic', 'Kumba IalÃƒÂ¡', 927, 'GW'),
	('GUY', 'Guyana', 'South America', 'South America', 214969.00, 1966, 861000, 64.0, 722.00, 743.00, 'Guyana', 'Republic', 'Bharrat Jagdeo', 928, 'GY'),
	('HTI', 'Haiti', 'North America', 'Caribbean', 27750.00, 1804, 8222000, 49.2, 3459.00, 3107.00, 'HaÃƒÂ¯ti/Dayti', 'Republic', 'Jean-Bertrand Aristide', 929, 'HT'),
	('HND', 'Honduras', 'North America', 'Central America', 112088.00, 1838, 6485000, 69.9, 5333.00, 4697.00, 'Honduras', 'Republic', 'Carlos Roberto Flores FacussÃƒÂ©', 933, 'HN'),
	('HKG', 'Hong Kong', 'Asia', 'Eastern Asia', 1075.00, NULL, 6782000, 79.5, 166448.00, 173610.00, 'Xianggang/Hong Kong', 'Special Administrative Region of China', 'Jiang Zemin', 937, 'HK'),
	('SJM', 'Svalbard and Jan Mayen', 'Europe', 'Nordic Countries', 62422.00, NULL, 3200, NULL, 0.00, NULL, 'Svalbard og Jan Mayen', 'Dependent Territory of Norway', 'Harald V', 938, 'SJ'),
	('IDN', 'Indonesia', 'Asia', 'Southeast Asia', 1904569.00, 1945, 212107000, 68.0, 84982.00, 215002.00, 'Indonesia', 'Republic', 'Abdurrahman Wahid', 939, 'ID'),
	('IND', 'India', 'Asia', 'Southern and Central Asia', 3287263.00, 1947, 1013662000, 62.5, 447114.00, 430572.00, 'Bharat/India', 'Federal Republic', 'Kocheril Raman Narayanan', 1109, 'IN'),
	('IRQ', 'Iraq', 'Asia', 'Middle East', 438317.00, 1932, 23115000, 66.5, 11500.00, NULL, 'Al-Ã‚Â´Iraq', 'Republic', 'Saddam Hussein al-Takriti', 1365, 'IQ'),
	('IRN', 'Iran', 'Asia', 'Southern and Central Asia', 1648195.00, 1906, 67702000, 69.7, 195746.00, 160151.00, 'Iran', 'Islamic Republic', 'Ali Mohammad Khatami-Ardakani', 1380, 'IR'),
	('IRL', 'Ireland', 'Europe', 'British Islands', 70273.00, 1921, 3775100, 76.8, 75921.00, 73132.00, 'Ireland/Ãƒâ€°ire', 'Republic', 'Mary McAleese', 1447, 'IE'),
	('ISL', 'Iceland', 'Europe', 'Nordic Countries', 103000.00, 1944, 279000, 79.4, 8255.00, 7474.00, 'ÃƒÂsland', 'Republic', 'Ãƒâ€œlafur Ragnar GrÃƒÂ­msson', 1449, 'IS'),
	('ISR', 'Israel', 'Asia', 'Middle East', 21056.00, 1948, 6217000, 78.6, 97477.00, 98577.00, 'YisraÃ¢â‚¬â„¢el/IsraÃ¢â‚¬â„¢il', 'Republic', 'Moshe Katzav', 1450, 'IL'),
	('ITA', 'Italy', 'Europe', 'Southern Europe', 301316.00, 1861, 57680000, 79.0, 1161755.00, 1145372.00, 'Italia', 'Republic', 'Carlo Azeglio Ciampi', 1464, 'IT'),
	('TMP', 'East Timor', 'Asia', 'Southeast Asia', 14874.00, NULL, 885000, 46.0, 0.00, NULL, 'Timor Timur', 'Administrated by the UN', 'JosÃƒÂ© Alexandre GusmÃƒÂ£o', 1522, 'TP'),
	('AUT', 'Austria', 'Europe', 'Western Europe', 83859.00, 1918, 8091800, 77.7, 211860.00, 206025.00, 'Ãƒâ€“sterreich', 'Federal Republic', 'Thomas Klestil', 1523, 'AT'),
	('JAM', 'Jamaica', 'North America', 'Caribbean', 10990.00, 1962, 2583000, 75.2, 6871.00, 6722.00, 'Jamaica', 'Constitutional Monarchy', 'Elisabeth II', 1530, 'JM'),
	('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.00, -660, 126714000, 80.7, 3787042.00, 4192638.00, 'Nihon/Nippon', 'Constitutional Monarchy', 'Akihito', 1532, 'JP'),
	('YEM', 'Yemen', 'Asia', 'Middle East', 527968.00, 1918, 18112000, 59.8, 6041.00, 5729.00, 'Al-Yaman', 'Republic', 'Ali Abdallah Salih', 1780, 'YE'),
	('JOR', 'Jordan', 'Asia', 'Middle East', 88946.00, 1946, 5083000, 77.4, 7526.00, 7051.00, 'Al-Urdunn', 'Constitutional Monarchy', 'Abdullah II', 1786, 'JO'),
	('CXR', 'Christmas Island', 'Oceania', 'Australia and New Zealand', 135.00, NULL, 2500, NULL, 0.00, NULL, 'Christmas Island', 'Territory of Australia', 'Elisabeth II', 1791, 'CX'),
	('YUG', 'Yugoslavia', 'Europe', 'Southern Europe', 102173.00, 1918, 10640000, 72.4, 17000.00, NULL, 'Jugoslavija', 'Federal Republic', 'Vojislav KoÃ…Â¡tunica', 1792, 'YU'),
	('KHM', 'Cambodia', 'Asia', 'Southeast Asia', 181035.00, 1953, 11168000, 56.5, 5121.00, 5670.00, 'KÃƒÂ¢mpuchÃƒÂ©a', 'Constitutional Monarchy', 'Norodom Sihanouk', 1800, 'KH'),
	('CMR', 'Cameroon', 'Africa', 'Central Africa', 475442.00, 1960, 15085000, 54.8, 9174.00, 8596.00, 'Cameroun/Cameroon', 'Republic', 'Paul Biya', 1804, 'CM'),
	('CAN', 'Canada', 'North America', 'North America', 9970610.00, 1867, 31147000, 79.4, 598862.00, 625626.00, 'Canada', 'Constitutional Monarchy, Federation', 'Elisabeth II', 1822, 'CA'),
	('CPV', 'Cape Verde', 'Africa', 'Western Africa', 4033.00, 1975, 428000, 68.9, 435.00, 420.00, 'Cabo Verde', 'Republic', 'AntÃƒÂ³nio Mascarenhas Monteiro', 1859, 'CV'),
	('KAZ', 'Kazakstan', 'Asia', 'Southern and Central Asia', 2724900.00, 1991, 16223000, 63.2, 24375.00, 23383.00, 'Qazaqstan', 'Republic', 'Nursultan Nazarbajev', 1864, 'KZ'),
	('KEN', 'Kenya', 'Africa', 'Eastern Africa', 580367.00, 1963, 30080000, 48.0, 9217.00, 10241.00, 'Kenya', 'Republic', 'Daniel arap Moi', 1881, 'KE'),
	('CAF', 'Central African Republic', 'Africa', 'Central Africa', 622984.00, 1960, 3615000, 44.0, 1054.00, 993.00, 'Centrafrique/BÃƒÂª-AfrÃƒÂ®ka', 'Republic', 'Ange-FÃƒÂ©lix PatassÃƒÂ©', 1889, 'CF'),
	('CHN', 'China', 'Asia', 'Eastern Asia', 9572900.00, -1523, 1277558000, 71.4, 982268.00, 917719.00, 'Zhongquo', 'People\'sRepublic', 'Jiang Zemin', 1891, 'CN'),
	('KGZ', 'Kyrgyzstan', 'Asia', 'Southern and Central Asia', 199900.00, 1991, 4699000, 63.4, 1626.00, 1767.00, 'Kyrgyzstan', 'Republic', 'Askar Akajev', 2253, 'KG'),
	('KIR', 'Kiribati', 'Oceania', 'Micronesia', 726.00, 1979, 83000, 59.8, 40.70, NULL, 'Kiribati', 'Republic', 'Teburoro Tito', 2256, 'KI'),
	('COL', 'Colombia', 'South America', 'South America', 1138914.00, 1810, 42321000, 70.3, 102896.00, 105116.00, 'Colombia', 'Republic', 'AndrÃƒÂ©s Pastrana Arango', 2257, 'CO'),
	('COM', 'Comoros', 'Africa', 'Eastern Africa', 1862.00, 1975, 578000, 60.0, 4401.00, 4361.00, 'Komori/Comores', 'Republic', 'Azali Assoumani', 2295, 'KM'),
	('COG', 'Congo', 'Africa', 'Central Africa', 342000.00, 1960, 2943000, 47.4, 2108.00, 2287.00, 'Congo', 'Republic', 'Denis Sassou-Nguesso', 2296, 'CG'),
	('COD', 'Congo, The Democratic Republic of the', 'Africa', 'Central Africa', 2344858.00, 1960, 51654000, 48.8, 6964.00, 2474.00, 'RÃƒÂ©publique DÃƒÂ©mocratique du Congo', 'Republic', 'Joseph Kabila', 2298, 'CD'),
	('CCK', 'Cocos (Keeling) Islands', 'Oceania', 'Australia and New Zealand', 14.00, NULL, 600, NULL, 0.00, NULL, 'Cocos (Keeling) Islands', 'Territory of Australia', 'Elisabeth II', 2317, 'CC'),
	('PRK', 'North Korea', 'Asia', 'Eastern Asia', 120538.00, 1948, 24039000, 70.7, 5332.00, NULL, 'Choson Minjujuui InÃ‚Â´min Konghwaguk (Bukhan', 'Socialistic Republic', 'Kim Jong-il', 2318, 'KP'),
	('KOR', 'South Korea', 'Asia', 'Eastern Asia', 99434.00, 1948, 46844000, 74.4, 320749.00, 442544.00, 'Taehan MinÃ¢â‚¬â„¢guk (Namhan)', 'Republic', 'Kim Dae-jung', 2331, 'KR'),
	('GRC', 'Greece', 'Europe', 'Southern Europe', 131626.00, 1830, 10545700, 78.4, 120724.00, 119946.00, 'EllÃƒÂ¡da', 'Republic', 'Kostis Stefanopoulos', 2401, 'GR'),
	('HRV', 'Croatia', 'Europe', 'Southern Europe', 56538.00, 1991, 4473000, 73.7, 20208.00, 19300.00, 'Hrvatska', 'Republic', 'Ã…Â tipe Mesic', 2409, 'HR'),
	('CUB', 'Cuba', 'North America', 'Caribbean', 110861.00, 1902, 11201000, 76.2, 17843.00, 18862.00, 'Cuba', 'Socialistic Republic', 'Fidel Castro Ruz', 2413, 'CU'),
	('KWT', 'Kuwait', 'Asia', 'Middle East', 17818.00, 1961, 1972000, 76.1, 27037.00, 30373.00, 'Al-Kuwayt', 'Constitutional Monarchy (Emirate)', 'Jabir al-Ahmad al-Jabir al-Sabah', 2429, 'KW'),
	('CYP', 'Cyprus', 'Asia', 'Middle East', 9251.00, 1960, 754700, 76.7, 9333.00, 8246.00, 'KÃƒÂ½pros/Kibris', 'Republic', 'Glafkos Klerides', 2430, 'CY'),
	('LAO', 'Laos', 'Asia', 'Southeast Asia', 236800.00, 1953, 5433000, 53.1, 1292.00, 1746.00, 'Lao', 'Republic', 'Khamtay Siphandone', 2432, 'LA'),
	('LVA', 'Latvia', 'Europe', 'Baltic Countries', 64589.00, 1991, 2424200, 68.4, 6398.00, 5639.00, 'Latvija', 'Republic', 'Vaira Vike-Freiberga', 2434, 'LV'),
	('LSO', 'Lesotho', 'Africa', 'Southern Africa', 30355.00, 1966, 2153000, 50.8, 1061.00, 1161.00, 'Lesotho', 'Constitutional Monarchy', 'Letsie III', 2437, 'LS'),
	('LBN', 'Lebanon', 'Asia', 'Middle East', 10400.00, 1941, 3282000, 71.3, 17121.00, 15129.00, 'Lubnan', 'Republic', 'Ãƒâ€°mile Lahoud', 2438, 'LB'),
	('LBR', 'Liberia', 'Africa', 'Western Africa', 111369.00, 1847, 3154000, 51.0, 2012.00, NULL, 'Liberia', 'Republic', 'Charles Taylor', 2440, 'LR'),
	('LBY', 'Libyan Arab Jamahiriya', 'Africa', 'Northern Africa', 1759540.00, 1951, 5605000, 75.5, 44806.00, 40562.00, 'Libiya', 'Socialistic State', 'Muammar al-Qadhafi', 2441, 'LY'),
	('LIE', 'Liechtenstein', 'Europe', 'Western Europe', 160.00, 1806, 32300, 78.8, 1119.00, 1084.00, 'Liechtenstein', 'Constitutional Monarchy', 'Hans-Adam II', 2446, 'LI'),
	('LTU', 'Lithuania', 'Europe', 'Baltic Countries', 65301.00, 1991, 3698500, 69.1, 10692.00, 9585.00, 'Lietuva', 'Republic', 'Valdas Adamkus', 2447, 'LT'),
	('LUX', 'Luxembourg', 'Europe', 'Western Europe', 2586.00, 1867, 435700, 77.1, 16321.00, 15519.00, 'Luxembourg/LÃƒÂ«tzebuerg', 'Constitutional Monarchy', 'Henri', 2452, 'LU'),
	('ESH', 'Western Sahara', 'Africa', 'Northern Africa', 266000.00, NULL, 293000, 49.8, 60.00, NULL, 'As-Sahrawiya', 'Occupied by Marocco', 'Mohammed Abdel Aziz', 2453, 'EH'),
	('MAC', 'Macao', 'Asia', 'Eastern Asia', 18.00, NULL, 473000, 81.6, 5749.00, 5940.00, 'Macau/Aomen', 'Special Administrative Region of China', 'Jiang Zemin', 2454, 'MO'),
	('MDG', 'Madagascar', 'Africa', 'Eastern Africa', 587041.00, 1960, 15942000, 55.0, 3750.00, 3545.00, 'Madagasikara/Madagascar', 'Federal Republic', 'Didier Ratsiraka', 2455, 'MG'),
	('MKD', 'Macedonia', 'Europe', 'Southern Europe', 25713.00, 1991, 2024000, 73.8, 1694.00, 1915.00, 'Makedonija', 'Republic', 'Boris Trajkovski', 2460, 'MK'),
	('MWI', 'Malawi', 'Africa', 'Eastern Africa', 118484.00, 1964, 10925000, 37.6, 1687.00, 2527.00, 'Malawi', 'Republic', 'Bakili Muluzi', 2462, 'MW'),
	('MDV', 'Maldives', 'Asia', 'Southern and Central Asia', 298.00, 1965, 286000, 62.2, 199.00, NULL, 'Dhivehi Raajje/Maldives', 'Republic', 'Maumoon Abdul Gayoom', 2463, 'MV'),
	('MYS', 'Malaysia', 'Asia', 'Southeast Asia', 329758.00, 1957, 22244000, 70.8, 69213.00, 97884.00, 'Malaysia', 'Constitutional Monarchy, Federation', 'Salahuddin Abdul Aziz Shah Alhaj', 2464, 'MY'),
	('MLI', 'Mali', 'Africa', 'Western Africa', 1240192.00, 1960, 11234000, 46.7, 2642.00, 2453.00, 'Mali', 'Republic', 'Alpha Oumar KonarÃƒÂ©', 2482, 'ML'),
	('MLT', 'Malta', 'Europe', 'Southern Europe', 316.00, 1964, 380200, 77.9, 3512.00, 3338.00, 'Malta', 'Republic', 'Guido de Marco', 2484, 'MT'),
	('MAR', 'Morocco', 'Africa', 'Northern Africa', 446550.00, 1956, 28351000, 69.1, 36124.00, 33514.00, 'Al-Maghrib', 'Constitutional Monarchy', 'Mohammed VI', 2486, 'MA'),
	('MHL', 'Marshall Islands', 'Oceania', 'Micronesia', 181.00, 1990, 64000, 65.5, 97.00, NULL, 'Marshall Islands/Majol', 'Republic', 'Kessai Note', 2507, 'MH'),
	('MTQ', 'Martinique', 'North America', 'Caribbean', 1102.00, NULL, 395000, 78.3, 2731.00, 2559.00, 'Martinique', 'Overseas Department of France', 'Jacques Chirac', 2508, 'MQ'),
	('MRT', 'Mauritania', 'Africa', 'Western Africa', 1025520.00, 1960, 2670000, 50.8, 998.00, 1081.00, 'Muritaniya/Mauritanie', 'Republic', 'Maaouiya Ould SidÃ‚Â´Ahmad Taya', 2509, 'MR'),
	('MUS', 'Mauritius', 'Africa', 'Eastern Africa', 2040.00, 1968, 1158000, 71.0, 4251.00, 4186.00, 'Mauritius', 'Republic', 'Cassam Uteem', 2511, 'MU'),
	('MYT', 'Mayotte', 'Africa', 'Eastern Africa', 373.00, NULL, 149000, 59.5, 0.00, NULL, 'Mayotte', 'Territorial Collectivity of France', 'Jacques Chirac', 2514, 'YT'),
	('MEX', 'Mexico', 'North America', 'Central America', 1958201.00, 1810, 98881000, 71.5, 414972.00, 401461.00, 'MÃƒÂ©xico', 'Federal Republic', 'Vicente Fox Quesada', 2515, 'MX'),
	('FSM', 'Micronesia, Federated States of', 'Oceania', 'Micronesia', 702.00, 1990, 119000, 68.6, 212.00, NULL, 'Micronesia', 'Federal Republic', 'Leo A. Falcam', 2689, 'FM'),
	('MDA', 'Moldova', 'Europe', 'Eastern Europe', 33851.00, 1991, 4380000, 64.5, 1579.00, 1872.00, 'Moldova', 'Republic', 'Vladimir Voronin', 2690, 'MD'),
	('MCO', 'Monaco', 'Europe', 'Western Europe', 1.50, 1861, 34000, 78.8, 776.00, NULL, 'Monaco', 'Constitutional Monarchy', 'Rainier III', 2695, 'MC'),
	('MNG', 'Mongolia', 'Asia', 'Eastern Asia', 1566500.00, 1921, 2662000, 67.3, 1043.00, 933.00, 'Mongol Uls', 'Republic', 'Natsagiin Bagabandi', 2696, 'MN'),
	('MSR', 'Montserrat', 'North America', 'Caribbean', 102.00, NULL, 11000, 78.0, 109.00, NULL, 'Montserrat', 'Dependent Territory of the UK', 'Elisabeth II', 2697, 'MS'),
	('MOZ', 'Mozambique', 'Africa', 'Eastern Africa', 801590.00, 1975, 19680000, 37.5, 2891.00, 2711.00, 'MoÃƒÂ§ambique', 'Republic', 'JoaquÃƒÂ­m A. Chissano', 2698, 'MZ'),
	('MMR', 'Myanmar', 'Asia', 'Southeast Asia', 676578.00, 1948, 45611000, 54.9, 180375.00, 171028.00, 'Myanma Pye', 'Republic', 'kenraali Than Shwe', 2710, 'MM'),
	('NAM', 'Namibia', 'Africa', 'Southern Africa', 824292.00, 1990, 1726000, 42.5, 3101.00, 3384.00, 'Namibia', 'Republic', 'Sam Nujoma', 2726, 'NA'),
	('NRU', 'Nauru', 'Oceania', 'Micronesia', 21.00, 1968, 12000, 60.8, 197.00, NULL, 'Naoero/Nauru', 'Republic', 'Bernard Dowiyogo', 2728, 'NR'),
	('NPL', 'Nepal', 'Asia', 'Southern and Central Asia', 147181.00, 1769, 23930000, 57.8, 4768.00, 4837.00, 'Nepal', 'Constitutional Monarchy', 'Gyanendra Bir Bikram', 2729, 'NP'),
	('NIC', 'Nicaragua', 'North America', 'Central America', 130000.00, 1838, 5074000, 68.7, 1988.00, 2023.00, 'Nicaragua', 'Republic', 'Arnoldo AlemÃƒÂ¡n Lacayo', 2734, 'NI'),
	('NER', 'Niger', 'Africa', 'Western Africa', 1267000.00, 1960, 10730000, 41.3, 1706.00, 1580.00, 'Niger', 'Republic', 'Mamadou Tandja', 2738, 'NE'),
	('NGA', 'Nigeria', 'Africa', 'Western Africa', 923768.00, 1960, 111506000, 51.6, 65707.00, 58623.00, 'Nigeria', 'Federal Republic', 'Olusegun Obasanjo', 2754, 'NG'),
	('NIU', 'Niue', 'Oceania', 'Polynesia', 260.00, NULL, 2000, NULL, 0.00, NULL, 'Niue', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 2805, 'NU'),
	('NFK', 'Norfolk Island', 'Oceania', 'Australia and New Zealand', 36.00, NULL, 2000, NULL, 0.00, NULL, 'Norfolk Island', 'Territory of Australia', 'Elisabeth II', 2806, 'NF'),
	('NOR', 'Norway', 'Europe', 'Nordic Countries', 323877.00, 1905, 4478500, 78.7, 145895.00, 153370.00, 'Norge', 'Constitutional Monarchy', 'Harald V', 2807, 'NO'),
	('CIV', 'CÃƒÂ´te dÃ¢â‚¬â„¢Ivoire', 'Africa', 'Western Africa', 322463.00, 1960, 14786000, 45.2, 11345.00, 10285.00, 'CÃƒÂ´te dÃ¢â‚¬â„¢Ivoire', 'Republic', 'Laurent Gbagbo', 2814, 'CI'),
	('OMN', 'Oman', 'Asia', 'Middle East', 309500.00, 1951, 2542000, 71.8, 16904.00, 16153.00, 'Ã‚Â´Uman', 'Monarchy (Sultanate)', 'Qabus ibn SaÃ‚Â´id', 2821, 'OM'),
	('PAK', 'Pakistan', 'Asia', 'Southern and Central Asia', 796095.00, 1947, 156483000, 61.1, 61289.00, 58549.00, 'Pakistan', 'Republic', 'Mohammad Rafiq Tarar', 2831, 'PK'),
	('PLW', 'Palau', 'Oceania', 'Micronesia', 459.00, 1994, 19000, 68.6, 105.00, NULL, 'Belau/Palau', 'Republic', 'Kuniwo Nakamura', 2881, 'PW'),
	('PAN', 'Panama', 'North America', 'Central America', 75517.00, 1903, 2856000, 75.5, 9131.00, 8700.00, 'PanamÃƒÂ¡', 'Republic', 'Mireya Elisa Moscoso RodrÃƒÂ­guez', 2882, 'PA'),
	('PNG', 'Papua New Guinea', 'Oceania', 'Melanesia', 462840.00, 1975, 4807000, 63.1, 4988.00, 6328.00, 'Papua New Guinea/Papua Niugini', 'Constitutional Monarchy', 'Elisabeth II', 2884, 'PG'),
	('PRY', 'Paraguay', 'South America', 'South America', 406752.00, 1811, 5496000, 73.7, 8444.00, 9555.00, 'Paraguay', 'Republic', 'Luis ÃƒÂngel GonzÃƒÂ¡lez Macchi', 2885, 'PY'),
	('PER', 'Peru', 'South America', 'South America', 1285216.00, 1821, 25662000, 70.0, 64140.00, 65186.00, 'PerÃƒÂº/Piruw', 'Republic', 'Valentin Paniagua Corazao', 2890, 'PE'),
	('PCN', 'Pitcairn', 'Oceania', 'Polynesia', 49.00, NULL, 50, NULL, 0.00, NULL, 'Pitcairn', 'Dependent Territory of the UK', 'Elisabeth II', 2912, 'PN'),
	('MNP', 'Northern Mariana Islands', 'Oceania', 'Micronesia', 464.00, NULL, 78000, 75.5, 0.00, NULL, 'Northern Mariana Islands', 'Commonwealth of the US', 'George W. Bush', 2913, 'MP'),
	('PRT', 'Portugal', 'Europe', 'Southern Europe', 91982.00, 1143, 9997600, 75.8, 105954.00, 102133.00, 'Portugal', 'Republic', 'Jorge SampÃƒÂ£io', 2914, 'PT'),
	('PRI', 'Puerto Rico', 'North America', 'Caribbean', 8875.00, NULL, 3869000, 75.6, 34100.00, 32100.00, 'Puerto Rico', 'Commonwealth of the US', 'George W. Bush', 2919, 'PR'),
	('POL', 'Poland', 'Europe', 'Eastern Europe', 323250.00, 1918, 38653600, 73.2, 151697.00, 135636.00, 'Polska', 'Republic', 'Aleksander Kwasniewski', 2928, 'PL'),
	('GNQ', 'Equatorial Guinea', 'Africa', 'Central Africa', 28051.00, 1968, 453000, 53.6, 283.00, 542.00, 'Guinea Ecuatorial', 'Republic', 'Teodoro Obiang Nguema Mbasogo', 2972, 'GQ'),
	('QAT', 'Qatar', 'Asia', 'Middle East', 11000.00, 1971, 599000, 72.4, 9472.00, 8920.00, 'Qatar', 'Monarchy', 'Hamad ibn Khalifa al-Thani', 2973, 'QA'),
	('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 843, 59225700, 78.8, 1424285.00, 1392448.00, 'France', 'Republic', 'Jacques Chirac', 2974, 'FR'),
	('GUF', 'French Guiana', 'South America', 'South America', 90000.00, NULL, 181000, 76.1, 681.00, NULL, 'Guyane franÃƒÂ§aise', 'Overseas Department of France', 'Jacques Chirac', 3014, 'GF'),
	('PYF', 'French Polynesia', 'Oceania', 'Polynesia', 4000.00, NULL, 235000, 74.8, 818.00, 781.00, 'PolynÃƒÂ©sie franÃƒÂ§aise', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3016, 'PF'),
	('REU', 'RÃƒÂ©union', 'Africa', 'Eastern Africa', 2510.00, NULL, 699000, 72.7, 8287.00, 7988.00, 'RÃƒÂ©union', 'Overseas Department of France', 'Jacques Chirac', 3017, 'RE'),
	('ROM', 'Romania', 'Europe', 'Eastern Europe', 238391.00, 1878, 22455500, 69.9, 38158.00, 34843.00, 'RomÃƒÂ¢nia', 'Republic', 'Ion Iliescu', 3018, 'RO'),
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
	('STP', 'Sao Tome and Principe', 'Africa', 'Central Africa', 964.00, 1975, 147000, 65.3, 6.00, NULL, 'SÃƒÂ£o TomÃƒÂ© e PrÃƒÂ­ncipe', 'Republic', 'Miguel Trovoada', 3172, 'ST'),
	('SAU', 'Saudi Arabia', 'Asia', 'Middle East', 2149690.00, 1932, 21607000, 67.8, 137635.00, 146171.00, 'Al-Ã‚Â´Arabiya as-SaÃ‚Â´udiya', 'Monarchy', 'Fahd ibn Abdul-Aziz al-SaÃ‚Â´ud', 3173, 'SA'),
	('SEN', 'Senegal', 'Africa', 'Western Africa', 196722.00, 1960, 9481000, 62.2, 4787.00, 4542.00, 'SÃƒÂ©nÃƒÂ©gal/Sounougal', 'Republic', 'Abdoulaye Wade', 3198, 'SN'),
	('SYC', 'Seychelles', 'Africa', 'Eastern Africa', 455.00, 1976, 77000, 70.4, 536.00, 539.00, 'Sesel/Seychelles', 'Republic', 'France-Albert RenÃƒÂ©', 3206, 'SC'),
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
	('TJK', 'Tajikistan', 'Asia', 'Southern and Central Asia', 143100.00, 1991, 6188000, 64.1, 1990.00, 1056.00, 'ToÃƒÂ§ikiston', 'Republic', 'Emomali Rahmonov', 3261, 'TJ'),
	('TWN', 'Taiwan', 'Asia', 'Eastern Asia', 36188.00, 1945, 22256000, 76.4, 256254.00, 263451.00, 'TÃ¢â‚¬â„¢ai-wan', 'Republic', 'Chen Shui-bian', 3263, 'TW'),
	('TZA', 'Tanzania', 'Africa', 'Eastern Africa', 883749.00, 1961, 33517000, 52.3, 8005.00, 7388.00, 'Tanzania', 'Republic', 'Benjamin William Mkapa', 3306, 'TZ'),
	('DNK', 'Denmark', 'Europe', 'Nordic Countries', 43094.00, 800, 5330000, 76.5, 174099.00, 169264.00, 'Danmark', 'Constitutional Monarchy', 'Margrethe II', 3315, 'DK'),
	('THA', 'Thailand', 'Asia', 'Southeast Asia', 513115.00, 1350, 61399000, 68.6, 116416.00, 153907.00, 'Prathet Thai', 'Constitutional Monarchy', 'Bhumibol Adulyadej', 3320, 'TH'),
	('TGO', 'Togo', 'Africa', 'Western Africa', 56785.00, 1960, 4629000, 54.7, 1449.00, 1400.00, 'Togo', 'Republic', 'GnassingbÃƒÂ© EyadÃƒÂ©ma', 3332, 'TG'),
	('TKL', 'Tokelau', 'Oceania', 'Polynesia', 12.00, NULL, 2000, NULL, 0.00, NULL, 'Tokelau', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 3333, 'TK'),
	('TON', 'Tonga', 'Oceania', 'Polynesia', 650.00, 1970, 99000, 67.9, 146.00, 170.00, 'Tonga', 'Monarchy', 'Taufa\'ahau Tupou IV', 3334, 'TO'),
	('TTO', 'Trinidad and Tobago', 'North America', 'Caribbean', 5130.00, 1962, 1295000, 68.0, 6232.00, 5867.00, 'Trinidad and Tobago', 'Republic', 'Arthur N. R. Robinson', 3336, 'TT'),
	('TCD', 'Chad', 'Africa', 'Central Africa', 1284000.00, 1960, 7651000, 50.5, 1208.00, 1102.00, 'Tchad/Tshad', 'Republic', 'Idriss DÃƒÂ©by', 3337, 'TD'),
	('CZE', 'Czech Republic', 'Europe', 'Eastern Europe', 78866.00, 1993, 10278100, 74.5, 55017.00, 52037.00, 'Ã‚Â¸esko', 'Republic', 'VÃƒÂ¡clav Havel', 3339, 'CZ'),
	('TUN', 'Tunisia', 'Africa', 'Northern Africa', 163610.00, 1956, 9586000, 73.7, 20026.00, 18898.00, 'Tunis/Tunisie', 'Republic', 'Zine al-Abidine Ben Ali', 3349, 'TN'),
	('TUR', 'Turkey', 'Asia', 'Middle East', 774815.00, 1923, 66591000, 71.0, 210721.00, 189122.00, 'TÃƒÂ¼rkiye', 'Republic', 'Ahmet Necdet Sezer', 3358, 'TR'),
	('TKM', 'Turkmenistan', 'Asia', 'Southern and Central Asia', 488100.00, 1991, 4459000, 60.9, 4397.00, 2000.00, 'TÃƒÂ¼rkmenostan', 'Republic', 'Saparmurad Nijazov', 3419, 'TM'),
	('TCA', 'Turks and Caicos Islands', 'North America', 'Caribbean', 430.00, NULL, 17000, 73.3, 96.00, NULL, 'The Turks and Caicos Islands', 'Dependent Territory of the UK', 'Elisabeth II', 3423, 'TC'),
	('TUV', 'Tuvalu', 'Oceania', 'Polynesia', 26.00, 1978, 12000, 66.3, 6.00, NULL, 'Tuvalu', 'Constitutional Monarchy', 'Elisabeth II', 3424, 'TV'),
	('UGA', 'Uganda', 'Africa', 'Eastern Africa', 241038.00, 1962, 21778000, 42.9, 6313.00, 6887.00, 'Uganda', 'Republic', 'Yoweri Museveni', 3425, 'UG'),
	('UKR', 'Ukraine', 'Europe', 'Eastern Europe', 603700.00, 1991, 50456000, 66.0, 42168.00, 49677.00, 'Ukrajina', 'Republic', 'Leonid KutÃ…Â¡ma', 3426, 'UA'),
	('HUN', 'Hungary', 'Europe', 'Eastern Europe', 93030.00, 1918, 10043200, 71.4, 48267.00, 45914.00, 'MagyarorszÃƒÂ¡g', 'Republic', 'Ferenc MÃƒÂ¡dl', 3483, 'HU'),
	('URY', 'Uruguay', 'South America', 'South America', 175016.00, 1828, 3337000, 75.2, 20831.00, 19967.00, 'Uruguay', 'Republic', 'Jorge Batlle IbÃƒÂ¡ÃƒÂ±ez', 3492, 'UY'),
	('NCL', 'New Caledonia', 'Oceania', 'Melanesia', 18575.00, NULL, 214000, 72.8, 3563.00, NULL, 'Nouvelle-CalÃƒÂ©donie', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3493, 'NC'),
	('NZL', 'New Zealand', 'Oceania', 'Australia and New Zealand', 270534.00, 1907, 3862000, 77.8, 54669.00, 64960.00, 'New Zealand/Aotearoa', 'Constitutional Monarchy', 'Elisabeth II', 3499, 'NZ'),
	('UZB', 'Uzbekistan', 'Asia', 'Southern and Central Asia', 447400.00, 1991, 24318000, 63.7, 14194.00, 21300.00, 'Uzbekiston', 'Republic', 'Islam Karimov', 3503, 'UZ'),
	('BLR', 'Belarus', 'Europe', 'Eastern Europe', 207600.00, 1991, 10236000, 68.0, 13714.00, NULL, 'Belarus', 'Republic', 'Aljaksandr LukaÃ…Â¡enka', 3520, 'BY'),
	('WLF', 'Wallis and Futuna', 'Oceania', 'Polynesia', 200.00, NULL, 15000, NULL, 0.00, NULL, 'Wallis-et-Futuna', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3536, 'WF'),
	('VUT', 'Vanuatu', 'Oceania', 'Melanesia', 12189.00, 1980, 190000, 60.6, 261.00, 246.00, 'Vanuatu', 'Republic', 'John Bani', 3537, 'VU'),
	('VAT', 'Holy See (Vatican City State)', 'Europe', 'Southern Europe', 0.40, 1929, 1000, NULL, 9.00, NULL, 'Santa Sede/CittÃƒÂ  del Vaticano', 'Independent Church State', 'Johannes Paavali II', 3538, 'VA'),
	('VEN', 'Venezuela', 'South America', 'South America', 912050.00, 1811, 24170000, 73.1, 95023.00, 88434.00, 'Venezuela', 'Federal Republic', 'Hugo ChÃƒÂ¡vez FrÃƒÂ­as', 3539, 'VE'),
	('RUS', 'Russian Federation', 'Europe', 'Eastern Europe', 17075400.00, 1991, 146934000, 67.2, 276608.00, 442989.00, 'Rossija', 'Federal Republic', 'Vladimir Putin', 3580, 'RU'),
	('VNM', 'Vietnam', 'Asia', 'Southeast Asia', 331689.00, 1945, 79832000, 69.3, 21929.00, 22834.00, 'ViÃƒÂªt Nam', 'Socialistic Republic', 'TrÃƒÂ¢n Duc Luong', 3770, 'VN'),
	('EST', 'Estonia', 'Europe', 'Baltic Countries', 45227.00, 1991, 1439200, 69.5, 5328.00, 3371.00, 'Eesti', 'Republic', 'Lennart Meri', 3791, 'EE'),
	('USA', 'United States', 'North America', 'North America', 9363520.00, 1776, 278357000, 77.1, 8510700.00, 8110900.00, 'United States', 'Federal Republic', 'George W. Bush', 3813, 'US'),
	('VIR', 'Virgin Islands, U.S.', 'North America', 'Caribbean', 347.00, NULL, 93000, 78.1, 0.00, NULL, 'Virgin Islands of the United States', 'US Territory', 'George W. Bush', 4067, 'VI'),
	('ZWE', 'Zimbabwe', 'Africa', 'Eastern Africa', 390757.00, 1980, 11669000, 37.8, 5951.00, 8670.00, 'Zimbabwe', 'Republic', 'Robert G. Mugabe', 4068, 'ZW'),
	('PSE', 'Palestine', 'Asia', 'Middle East', 6257.00, NULL, 3101000, 71.4, 4173.00, NULL, 'Filastin', 'Autonomous Area', 'Yasser (Yasir) Arafat', 4074, 'PS'),
	('ATA', 'Antarctica', 'Antarctica', 'Antarctica', 13120000.00, NULL, 0, NULL, 0.00, NULL, 'Ã¢â‚¬â€œ', 'Co-administrated', '', NULL, 'AQ'),
	('BVT', 'Bouvet Island', 'Antarctica', 'Antarctica', 59.00, NULL, 0, NULL, 0.00, NULL, 'BouvetÃƒÂ¸ya', 'Dependent Territory of Norway', 'Harald V', NULL, 'BV'),
	('IOT', 'British Indian Ocean Territory', 'Africa', 'Eastern Africa', 78.00, NULL, 0, NULL, 0.00, NULL, 'British Indian Ocean Territory', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'IO'),
	('SGS', 'South Georgia and the South Sandwich Islands', 'Antarctica', 'Antarctica', 3903.00, NULL, 0, NULL, 0.00, NULL, 'South Georgia and the South Sandwich Islands', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'GS'),
	('HMD', 'Heard Island and McDonald Islands', 'Antarctica', 'Antarctica', 359.00, NULL, 0, NULL, 0.00, NULL, 'Heard and McDonald Islands', 'Territory of Australia', 'Elisabeth II', NULL, 'HM'),
	('ATF', 'French Southern territories', 'Antarctica', 'Antarctica', 7780.00, NULL, 0, NULL, 0.00, NULL, 'Terres australes franÃƒÂ§aises', 'Nonmetropolitan Territory of France', 'Jacques Chirac', NULL, 'TF'),
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
  `activation_status` tinyint(4) DEFAULT '0',
  `activation_message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idcustomer_invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 COMMENT='Invoice Details of Customers';

-- Dumping data for table hosted_emr.customer_invoice: ~9 rows (approximately)
DELETE FROM `customer_invoice`;
/*!40000 ALTER TABLE `customer_invoice` DISABLE KEYS */;
INSERT INTO `customer_invoice` (`idcustomer_invoice`, `plan_id`, `hf_id`, `invoice_number`, `cartsessionid`, `particulars`, `amount`, `setupfee`, `payment_date`, `payment_status`, `transaction_id`, `status_message`, `invoice_date`, `paypal_string`, `subscription_amount`, `subscr_id`, `discount_percentage`, `discount_amount`, `activation_status`, `activation_message`) VALUES
	(39, 16, 273, 'ZH-2012-07-05-00039', '3q4nitbs01jdtnb66e3e5anvq2', 'ZH EMRPractice Subscription', 900, 0, '2012-07-05', 'COMPLETED', '97C79617AN379241L', 'Pending', '2012-07-05', '{"PROFILEID":"I-91VJF23G0GT5","TRANSACTIONID":"97C79617AN379241L","TIMESTAMP":"2012-07-05T10:06:09Z","CORRELATIONID":"4b596f4a6655d","ACK":"Success","VERSION":"51.0","BUILD":"3231178"}', 900, 'I-91VJF23G0GT5', 0, 105, 0, NULL),
	(44, 15, 272, 'ZH-2012-07-05-00044', '5cm1b1k37loe45vvrn44t64ra1', 'ZH EMRRevenue Subscription', 500, 0, '2012-07-05', 'COMPLETED', '1CW69341BW188931D', 'Pending', '2012-07-05', '{"PROFILEID":"I-25G5JBTXN6MT","TRANSACTIONID":"1CW69341BW188931D","TIMESTAMP":"2012-07-05T13:05:01Z","CORRELATIONID":"4a252b1642caf","ACK":"Success","VERSION":"51.0","BUILD":"3231178"}', 500, 'I-25G5JBTXN6MT', 0, 70, 0, NULL),
	(45, 15, 274, 'ZH-2012-07-12-00045', 'd8bugbhiv5u5q67n3925fjv5v5', 'ZH EMRRevenue Subscription', 500, 0, NULL, 'Pending', '0', 'Pending', '2012-07-12', NULL, 500, NULL, 0, 70, 0, NULL),
	(46, 15, 275, 'ZH-2012-07-12-00046', 'b2blovcop4qf87nuqer03cgq76', 'ZH EMRRevenue Subscription', 500, 0, '2012-07-12', 'COMPLETED', '2SN70036RY732524Y', 'Pending', '2012-07-12', '{"PROFILEID":"I-L3S4W295R3FJ","TRANSACTIONID":"2SN70036RY732524Y","TIMESTAMP":"2012-07-12T07:08:10Z","CORRELATIONID":"1ad57d5b48eb8","ACK":"Success","VERSION":"51.0","BUILD":"3255948"}', 500, 'I-L3S4W295R3FJ', 0, 70, 0, NULL),
	(47, 15, 276, 'ZH-2012-07-12-00047', '20ik5ltu9ni37ufrmoam6rgs46', 'ZH EMRRevenue Subscription', 250, 0, '2012-07-12', 'COMPLETED', '14T1553635708761B', 'Pending', '2012-07-12', '{"PROFILEID":"I-DCYGVEERCAY9","TRANSACTIONID":"14T1553635708761B","TIMESTAMP":"2012-07-12T07:10:49Z","CORRELATIONID":"af9aaf2a18987","ACK":"Success","VERSION":"51.0","BUILD":"3255948"}', 250, 'I-DCYGVEERCAY9', 0, 35, 0, NULL),
	(48, 15, 277, 'ZH-2012-07-12-00048', '1vgkij3ie3vqijfafop10tt167', 'ZH EMRRevenue Subscription', 500, 0, '2012-07-12', 'COMPLETED', '80W6290993940322S', 'Pending', '2012-07-12', '{"PROFILEID":"I-R6LSRMX0DHNX","PROFILESTATUS":"PendingProfile","TRANSACTIONID":"80W6290993940322S","TIMESTAMP":"2012-07-12T10:10:10Z","CORRELATIONID":"68ef1b7dde36b","ACK":"Success","VERSION":"56.0","BUILD":"3255948"}', 500, 'I-R6LSRMX0DHNX', 0, 70, 0, NULL),
	(49, 15, 247, 'ZH-2012-07-12-00049', 'jd6d64frn7dghjcqg4gnkvb2l2', 'ZH EMRRevenue Subscription', 500, 0, '2012-07-12', 'COMPLETED', '0JX25056B2584353A', 'Pending', '2012-07-12', '{"PROFILEID":"I-GGATLNXE6E4X","PROFILESTATUS":"PendingProfile","TRANSACTIONID":"0JX25056B2584353A","TIMESTAMP":"2012-07-12T11:57:42Z","CORRELATIONID":"938ff254f1273","ACK":"Success","VERSION":"56.0","BUILD":"3255948"}', 500, 'I-GGATLNXE6E4X', 0, 70, 0, NULL),
	(51, 16, 278, 'ZH-2012-07-14-00051', 'hmhlas92edqfjoadbuv07hh8p3', 'ZH EMRPractice Subscription', 600, 0, '2012-07-14', 'COMPLETED', '7S430629R2275380T', 'Pending', '2012-07-14', '{"PROFILEID":"I-PE74FYKWTN0R","PROFILESTATUS":"PendingProfile","TRANSACTIONID":"7S430629R2275380T","TIMESTAMP":"2012-07-14T08:03:51Z","CORRELATIONID":"2cde79a82d61","ACK":"Success","VERSION":"56.0","BUILD":"3255948"}', 600, 'I-PE74FYKWTN0R', 0, 70, 0, NULL),
	(52, 15, 279, 'ZH-2012-07-17-00052', '5uirimd4l74nubqlv769vincu0', 'ZH EMRRevenue Subscription', 547.2, 0, '2012-07-17', 'COMPLETED', '73Y82449R89910203', 'Pending', '2012-07-17', '{"PROFILEID":"I-6E4VGSGMRDSF","PROFILESTATUS":"PendingProfile","TRANSACTIONID":"73Y82449R89910203","TIMESTAMP":"2012-07-17T06:58:06Z","CORRELATIONID":"e95bfb8315351","ACK":"Success","VERSION":"56.0","BUILD":"3255948"}', 547.2, 'I-6E4VGSGMRDSF', 0, 22.8, 0, NULL);
/*!40000 ALTER TABLE `customer_invoice` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.customer_products
DROP TABLE IF EXISTS `customer_products`;
CREATE TABLE IF NOT EXISTS `customer_products` (
  `idcustomer_products` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL,
  `hp_id` bigint(20) NOT NULL,
  `idproducts` bigint(20) NOT NULL,
  `category` varchar(50) NOT NULL,
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
  `Column 16` tinyint(4) DEFAULT NULL,
  `actual_cost` float DEFAULT NULL,
  `actual_setupfee` float DEFAULT NULL,
  `discount_provided_by` varchar(50) DEFAULT NULL,
  `discount_given_date` varchar(50) DEFAULT NULL,
  `ProductType` tinyint(4) NOT NULL,
  `provider_cost_nature` int(11) NOT NULL DEFAULT '0',
  `provider_setup_nature` int(11) NOT NULL DEFAULT '0',
  `emrfeature` varchar(10) NOT NULL,
  `additional` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcustomer_products`)
) ENGINE=InnoDB AUTO_INCREMENT=973 DEFAULT CHARSET=latin1 COMMENT='Products Master Table';

-- Dumping data for table hosted_emr.customer_products: ~43 rows (approximately)
DELETE FROM `customer_products`;
/*!40000 ALTER TABLE `customer_products` DISABLE KEYS */;
INSERT INTO `customer_products` (`idcustomer_products`, `hf_id`, `hp_id`, `idproducts`, `category`, `product_name`, `customer_id`, `product_feature`, `user_from`, `user_to`, `cost`, `setup_fee`, `payment_term`, `product_sort_order`, `product_status`, `Column 16`, `actual_cost`, `actual_setupfee`, `discount_provided_by`, `discount_given_date`, `ProductType`, `provider_cost_nature`, `provider_setup_nature`, `emrfeature`, `additional`) VALUES
	(895, 273, 16, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(896, 273, 16, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(897, 273, 16, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(898, 273, 16, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(899, 273, 16, 31, 'product', 'ZH Lab Interface', '1', '<p>\r\n	Improves management of of ordering, tracking, storing of results data providing improved workflow for the investative process to determine treatment plans for your patients.</p>\r\n<ul>\r\n	<li>\r\n		Seamlessly order and receive tests</li>\r\n	<li>\r\n		Stores results within EMR</li>\r\n	<li>\r\n		Results easily viewable by physcian</li>\r\n	<li>\r\n		Tracks previous investigations for comparisons of results</li>\r\n</ul>\r\n<p>\r\n	&nbsp;</p>\r\n', NULL, NULL, 50, 0, NULL, 5, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(900, 273, 16, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(919, 272, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(920, 272, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(921, 272, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(922, 272, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(923, 272, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(924, 274, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(925, 274, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(926, 274, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(927, 274, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(928, 274, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(929, 275, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(930, 275, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(931, 275, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(932, 275, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(933, 275, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(934, 276, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(935, 276, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(936, 276, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(937, 276, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(938, 276, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(939, 277, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(940, 277, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(941, 277, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(942, 277, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(943, 277, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(944, 247, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(945, 247, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(946, 247, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(947, 247, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(948, 247, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(957, 278, 16, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(958, 278, 16, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(959, 278, 16, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(960, 278, 16, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(961, 278, 16, 31, 'product', 'ZH Lab Interface', '1', '<p>\r\n	Improves management of of ordering, tracking, storing of results data providing improved workflow for the investative process to determine treatment plans for your patients.</p>\r\n<ul>\r\n	<li>\r\n		Seamlessly order and receive tests</li>\r\n	<li>\r\n		Stores results within EMR</li>\r\n	<li>\r\n		Results easily viewable by physcian</li>\r\n	<li>\r\n		Tracks previous investigations for comparisons of results</li>\r\n</ul>\r\n<p>\r\n	&nbsp;</p>\r\n', NULL, NULL, 50, 0, NULL, 5, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(962, 278, 16, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(963, 279, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(964, 279, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(965, 279, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(966, 279, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(967, 279, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(968, 280, 15, 1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(969, 280, 15, 36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', NULL, NULL, 0, 0, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, '', 0),
	(970, 280, 15, 29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', NULL, NULL, 75, 0, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(971, 280, 15, 30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', NULL, NULL, 35, 0, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0),
	(972, 280, 15, 33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', NULL, NULL, 100, 0, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=latin1 COMMENT='Customer Selected Plan and its Features';

-- Dumping data for table hosted_emr.customer_selected_plan: ~10 rows (approximately)
DELETE FROM `customer_selected_plan`;
/*!40000 ALTER TABLE `customer_selected_plan` DISABLE KEYS */;
INSERT INTO `customer_selected_plan` (`idcustomer_selected_plan`, `plan_id`, `plan_name`, `provider_no`, `hf_id`, `dashboard_userid`, `created_date`, `one_time_payment`, `monthly_payment`, `setupfee`, `discount_percentage`, `discount_amount`, `total_payment`, `payment_status`, `payment_date`, `payment_error_message`, `plan_status`, `plan_activated_date`, `plan_disabled_date`, `plan_expired_date`, `plan_deleted_date`, `emr_path`, `mac_ip`, `facility`, `npi`, `license`) VALUES
	(216, 271, NULL, 2, NULL, 'bbc@bb.com', '2012-07-05', 0, 0, 0, NULL, 0, 0, '0', NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(218, 16, 'ZH EMRPractice', 3, 273, 'aac@aac.com', '2012-07-05', 0, 900, 0, 35, 105, 900, 'COMPLETED', '2012-07-05', '', 1, '2012-07-05', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(223, 15, 'ZH EMRRevenue', 2, 272, 'ddc@dd.com', '2012-07-05', 0, 500, 0, 35, 70, 500, 'COMPLETED', '2012-07-05', '', 1, '2012-07-05', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(224, 15, 'ZH EMRRevenue', 2, 274, 'hj@hj.com', '2012-07-12', 0, 500, 0, 35, 70, 500, '0', NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(225, 15, 'ZH EMRRevenue', 2, 275, 'cd@cd.com', '2012-07-12', 0, 500, 0, 35, 70, 500, 'COMPLETED', '2012-07-12', '', 1, '2012-07-12', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(226, 15, 'ZH EMRRevenue', 1, 276, 'xs@xs.com', '2012-07-12', 0, 250, 0, 35, 35, 250, 'COMPLETED', '2012-07-12', '', 1, '2012-07-12', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(227, 15, 'ZH EMRRevenue', 2, 277, 'bg@bg.com', '2012-07-12', 0, 500, 0, 35, 70, 500, 'COMPLETED', '2012-07-12', '', 1, '2012-07-12', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(228, 15, 'ZH EMRRevenue', 2, 247, 'pradeep@zhservices.com', '2012-07-12', 0, 500, 0, 35, 70, 500, 'COMPLETED', '2012-07-12', '', 1, '2012-07-12', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(231, 16, 'ZH EMRPractice', 2, 278, 'jj@jj.com', '2012-07-14', 0, 600, 0, 35, 70, 600, 'COMPLETED', '2012-07-14', '', 1, '2012-07-14', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(232, 15, 'ZH EMRRevenue', 2, 279, 'hj@hgj.com', '2012-07-17', 0, 547.2, 0, 4, 22.8, 547.2, 'COMPLETED', '2012-07-17', '', 1, '2012-07-17', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
	(233, 15, 'ZH EMRRevenue', 2, 280, 'ddff@ddff.com', '2012-07-17', 0, 547.2, 0, 4, 22.8, 547.2, '0', NULL, 'Not Proceed to Payment Gateway', 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0);
/*!40000 ALTER TABLE `customer_selected_plan` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.email_template
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE IF NOT EXISTS `email_template` (
  `template_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `template_sec` varchar(50) DEFAULT NULL,
  `Subject` text,
  `content` text,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Email Template System';

-- Dumping data for table hosted_emr.email_template: ~4 rows (approximately)
DELETE FROM `email_template`;
/*!40000 ALTER TABLE `email_template` DISABLE KEYS */;
INSERT INTO `email_template` (`template_id`, `template_sec`, `Subject`, `content`) VALUES
	(1, 'new_user_register', 'Welcome To ZH Healthcare!', '<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Hi __name__,<br />\r\n	Welcome to HZ Healthcare nmnmnm. Your registration with ZH completed successfully. Please note your access details for future reference<br />\r\n	User ID : __email__<br />\r\n	Password : __userpwd__<br />\r\n	If your invoice is not successful, you can login to your account area and in pending invoice section, you can find the Invoice and can proceed to payment. Only after the successful payment, your plan will setup and access details will mail to you.<br />\r\n	<br />\r\n	<strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n'),
	(3, 'invoice_details', 'Invoice __invoiceno__', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;__name__,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; __invoiceno__. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n'),
	(4, 'forgot_password', 'Reset Password ZH OEMR', '<p>\r\n	<font color="#104D96">Hi __name__,</font></p>\r\n<p>\r\n	<font color="#104D96">As per your password request, here we are providing an temporary password to reset your account.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Your Temporary Password is : __temppassword__</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Click on the below url to reset your password</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">__resetlink__</font></p>\r\n<p>\r\n	<font color="#104D96">Regards,<br />\r\n	ZH Healthcare Support Team.</font></p>\r\n'),
	(5, 'plan_configuration_success', 'Plan Activated', 'asdf');
/*!40000 ALTER TABLE `email_template` ENABLE KEYS */;


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


-- Dumping structure for table hosted_emr.emr_modules
DROP TABLE IF EXISTS `emr_modules`;
CREATE TABLE IF NOT EXISTS `emr_modules` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(100) DEFAULT NULL,
  `short_tag` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Core EMR Modules';

-- Dumping data for table hosted_emr.emr_modules: ~5 rows (approximately)
DELETE FROM `emr_modules`;
/*!40000 ALTER TABLE `emr_modules` DISABLE KEYS */;
INSERT INTO `emr_modules` (`id`, `module_name`, `short_tag`) VALUES
	(1, 'eRx', 'ex'),
	(2, 'Lab', 'lb'),
	(3, 'Advance Billing Module', 'ab'),
	(4, 'Patient Portal', 'pp'),
	(5, 'ZH OpenEMR', 'zh');
/*!40000 ALTER TABLE `emr_modules` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.faq
DROP TABLE IF EXISTS `faq`;
CREATE TABLE IF NOT EXISTS `faq` (
  `faqid` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` tinytext,
  `listing_order` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`faqid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='FAQ Section';

-- Dumping data for table hosted_emr.faq: ~2 rows (approximately)
DELETE FROM `faq`;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` (`faqid`, `customer_id`, `category`, `question`, `answer`, `listing_order`, `status`) VALUES
	(1, 1, 0, 'Who is a customer', '<p>\r\n	Customer means in EMR is the Identifier</p>\r\n', 1, 1),
	(3, 1, 0, 'Is my subscription automatically renewed?', '<p>\r\n	Yes it is.&nbsp; If you do not want your subscription to renew you must cancel your account. &nbsp; You always have the option of canceling or changing your plan at any time.&nbsp;&nbsp; You&nbsp; have complete control to change your subscription wi', 2, 1);
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.files
DROP TABLE IF EXISTS `files`;
CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ACL Section';

-- Dumping data for table hosted_emr.files: ~0 rows (approximately)
DELETE FROM `files`;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;


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
	(2, 'UserRegistrtion', 'FacilityIdentifier', 'Please choose a unique short name to identify your organization.  This will become a part of your login credentials for ZH OpenEMR.   eg: practice01.  This name should not have any space in it.  '),
	(3, 'UserRegistrtion', 'name', 'Enter the formal name of your facility or organization'),
	(4, 'UserRegistrtion', 'Speciality', 'Select your medical practice specialty or focus. (e.g. plastic surgery)'),
	(5, 'UserRegistrtion', 'DashboardUserId', 'Enter Your Log in Id to this system. Your User Id should be alphanumeric and can enter maximum 25 characters'),
	(6, 'UserRegistrtion', 'Dashboardpassword', 'Password should be alphanumeric and of maximum 15 Character length.'),
	(7, 'UserRegistrtion', 'ConfirmDashboardPassword', 'Please re-enter your password to confirm'),
	(8, 'UserRegistrtion', 'EmailAddress', 'Please enter your preferred email address.  This email address will become the login to your Account Dashboard and receive communication and notifications from us.'),
	(9, 'UserRegistrtion', 'StreetAddress', 'Street Address'),
	(10, 'UserRegistrtion', 'PhoneNumber', '(000) 000-0000 format'),
	(11, 'UserRegistrtion', 'Fax', '(000) 000-0000 Format'),
	(12, 'UserRegistrtion', 'TaxID', 'Tax ID'),
	(13, 'UserRegistrtion', 'NPI', 'NPI');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.hosted_facilities
DROP TABLE IF EXISTS `hosted_facilities`;
CREATE TABLE IF NOT EXISTS `hosted_facilities` (
  `hf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '1',
  `hf_organization` varchar(255) NOT NULL,
  `hf_facility_identifier` varchar(150) DEFAULT NULL,
  `hf_facility_suffix` varchar(15) DEFAULT NULL,
  `hf_facility_name` varchar(150) DEFAULT NULL,
  `hf_facility_lname` varchar(150) DEFAULT NULL,
  `hf_speciality` varchar(255) DEFAULT NULL,
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
  `hosted_server` varchar(255) DEFAULT NULL,
  `db_server` varchar(255) NOT NULL,
  `backup_db_server` varchar(255) NOT NULL DEFAULT 'backup.hostedopenemr',
  `hf_backup_password` varchar(20) NOT NULL DEFAULT 'backup.hostedopenemr',
  `temp_password` varchar(255) NOT NULL,
  `temp_password_date` date NOT NULL,
  PRIMARY KEY (`hf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_facilities: ~23 rows (approximately)
DELETE FROM `hosted_facilities`;
/*!40000 ALTER TABLE `hosted_facilities` DISABLE KEYS */;
INSERT INTO `hosted_facilities` (`hf_id`, `customer_id`, `hf_organization`, `hf_facility_identifier`, `hf_facility_suffix`, `hf_facility_name`, `hf_facility_lname`, `hf_speciality`, `dashboard_password`, `hf_email`, `hf_phone`, `hf_address`, `hf_fax`, `hf_city`, `hf_zip`, `hf_state`, `hf_tax_id`, `hf_country`, `hf_npi`, `reg_date`, `user_status`, `hosted_server`, `db_server`, `backup_db_server`, `hf_backup_password`, `temp_password`, `temp_password_date`) VALUES
	(246, 1, 'df', 'df', 'Dr.', 'df', 'df', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'df@df.com', '564', 'asdf', '0', 'asdf', '654', 'Alabama', '0', 'USA', '0', '2012-07-02', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(247, 1, 'admix', 'admix', 'Dr.', 'Pradeep', 'T P', 'Paediatric cardiology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'pradeep@zhservices.com', '546', 'asdf', '0', 'asdf', '546', 'Alabama', '0', 'USA', '0', '2012-07-02', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(248, 1, 'dfg', 'dfg', 'Dr.', 'dfg', 'dfg', 'Child and adolescent psychiatry and psychotherapy', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'dfg@dfg.com', '546', 'asdf', '0', 'asdf', '456', 'Alabama', '0', 'USA', '0', '2012-07-02', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(249, 1, 'test', 'ttt', 'Dr.', 'ttt', 'ttt', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'ttt@ttt.com', '123', 'ttt', '0', 'ttt', '123', 'Alabama', '0', 'USA', '0', '2012-07-02', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(250, 1, 'xz', 'xz', 'Dr.', 'xz', 'xz', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'xz@xz.com', '546', 'asdf', '0', 'asdf', '654', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(251, 1, 'cv', 'cv', 'Dr.', 'cv', 'cv', 'Paediatric cardiology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'cv@cv.com', '56', 'asdf', '0', 'asdf', '564', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(252, 1, 'as', 'as', 'Dr.', 'as', 'as', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'as@as.com', '123', 'asdf', '0', 'asdf', '123', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(253, 1, 'bv', 'bv', 'Dr.', 'bv', 'bv', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'bv@bv.com', '564', 'sadf', '0', 'asd', '546', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(254, 1, 'nb', 'nb', 'Dr.', 'nb', 'nb', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'nb@nb.com', '234', 'sadf', '0', 'adsf', '234', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(255, 1, 'mn', 'mn', 'Dr.', 'mn', 'mn', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'mn@mn.com', '234', 'asdf', '0', 'sdf', '234', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(256, 1, 'km', 'km', 'Dr.', 'km', 'km', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'km@km.com', '654', 'sadf', '0', 'dsf', '546', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(257, 1, 'nipi', 'nipi', 'Dr.', 'nipi', 'n', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'nipi@nipi.com', '54', 'asdf', '0', 'sadf', '546', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(258, 1, 'ddf', 'ddf', 'Dr.', 'ddf', 'ddf', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'ddf@ddf.com', '564', 'asdf', '0', 'asdf', '546', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(259, 1, 'chikku', 'chikku', 'Dr.', 'chikku', 'chikku', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'chikku@chikku.com', '546', 'asdf', '0', 'asdf', '465', 'Alabama', '0', 'USA', '0', '2012-07-03', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(271, 1, 'bbc', 'bbc', 'Dr.', 'bbc', 'bbc', 'Child and adolescent psychiatry and psychotherapy', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'bbc@bb.com', '654', 'asdf', '0', 'asdf', '546', 'Alabama', '0', 'USA', '0', '2012-07-05', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(272, 1, 'ddc', 'ddc', 'Dr.', 'ddc', 'ddc', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'ddc@dd.com', '546', 'sadf', '0', 'asdf', '546', 'Alabama', '0', 'USA', '0', '2012-07-05', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(273, 1, 'aac', 'aac', 'Dr.', 'aac', 'aac', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'aac@aac.com', '7', 'asdf', '0', 'sadf', '87', 'Alabama', '0', 'USA', '0', '2012-07-05', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(274, 1, 'hj', 'hj', 'Dr.', 'hj', 'hj', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'hj@hj.com', '564', 'sdaf', '0', 'sadf', '546', 'Alabama', '0', 'USA', '0', '2012-07-12', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(275, 1, 'cd', 'cd', 'Dr.', 'cd', 'cd', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'cd@cd.com', '234', 'asdf', '0', 'asdf', '234', 'Alabama', '0', 'USA', '0', '2012-07-12', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(276, 1, 'xs', 'xs', 'Dr.', 'xs', 'xs', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'xs@xs.com', '564', 'asdf', '0', 'asdf', '456', 'Alabama', '0', 'USA', '0', '2012-07-12', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(277, 1, 'bgg', 'bg', 'Dr.', 'bgg', 'bgg', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'bg@bg.com', '546', 'asdf', '23423', 'sadf', '654', 'Alabama', '0', 'hf_country', '0', '2012-07-12', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(278, 1, 'jj', 'jj', 'Dr.', 'jj', 'jj', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'jj@jj.com', '654', 'adsf', '0', 'sadf', '654', 'Alabama', '0', 'USA', '0', '2012-07-14', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(279, 1, 'hj', 'hj', 'Dr.', 'hj', 'hj', 'Allergy and Immunology', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'hj@hgj.com', '234', 'sad', '0', 'asdf', '234', 'Alabama', '0', 'USA', '0', '2012-07-17', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00'),
	(280, 1, 'ddff', 'ddff', 'Dr.', 'ddff', 'ddff', 'test', '82b37cf1fbcaa4e6b1e7b5134f62be1c7383e3c1', 'ddff@ddff.com', '234', 'asdf', '0', 'adsf', '234', 'Alabama', '0', 'USA', '0', '2012-07-17', 1, NULL, '', 'backup.hostedopenemr', 'backup.hostedopenemr', '', '0000-00-00');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table hosted_emr.hosted_plans: ~3 rows (approximately)
DELETE FROM `hosted_plans`;
/*!40000 ALTER TABLE `hosted_plans` DISABLE KEYS */;
INSERT INTO `hosted_plans` (`hp_id`, `customer_id`, `hp_name`, `hp_caption`, `hp_sortorder`, `hp_status`, `bundle_discount_type`, `bundle_discount_per_cost`, `bundle_discount_per_setup`, `bundle_cost`, `bundle_setup_cost`, `discount`, `discount_start_date`, `discount_end_date`, `Imagename`) VALUES
	(1, 1, 'ZH EMRCapture', 'ZH EMRCapture', 1, 1, 1, 4, 0, 168, 0, NULL, NULL, NULL, '1.png'),
	(15, 1, 'ZH EMRRevenue', 'ZH EMRRevenue', 2, 1, 1, 4, 0, 274, 0, 0, NULL, NULL, '15.png'),
	(16, 1, 'ZH EMRPractice', 'ZH EMRPractice', 3, 1, 2, 35, 0, 300, 0, NULL, NULL, NULL, '16.png');
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


-- Dumping structure for procedure hosted_emr.listprice
DROP PROCEDURE IF EXISTS `listprice`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `listprice`(IN `idplan` BIGINT)
    COMMENT 'retrive the list price of a plan'
BEGIN
	select sum(cost) from products,plan_products where products.idproducts=plan_products.idproducts and plan_products.idplan=idplan;
END//
DELIMITER ;


-- Dumping structure for table hosted_emr.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hf_id` bigint(20) NOT NULL,
  `pk_id` bigint(20) NOT NULL,
  `Subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT '0-new, 1-Read, 2,reply,3,forwarded',
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 COMMENT='Internam Message Section';

-- Dumping data for table hosted_emr.messages: ~67 rows (approximately)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `hf_id`, `pk_id`, `Subject`, `message`, `status`, `date`) VALUES
	(1, 191, 0, 'Invoice ZH-2012-06-14-00106', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi,</strong></font><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Thanks for making the payment for Invoice No : ZH-2012-06-14-00106. The payment is Successful and your Plan will be activated within 12 Hours.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">For your information, All the payment is on advance mode, so if your plan contains any monthly payment section, the amount will deduct advance on each month and will rise invoice for your reference. If your payment is not successful after three attempt, your plan will be deactivated. Please let us know if any changes in your Paypal authorization details.<br />\r\n	<br />\r\n	<strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-14'),
	(2, 194, 0, 'Invoice ZH-2012-06-14-00109', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi,</strong></font><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Thanks for making the payment for Invoice No : ZH-2012-06-14-00109. The payment is Successful and your Plan will be activated within 12 Hours.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">For your information, All the payment is on advance mode, so if your plan contains any monthly payment section, the amount will deduct advance on each month and will rise invoice for your reference. If your payment is not successful after three attempt, your plan will be deactivated. Please let us know if any changes in your Paypal authorization details.<br />\r\n	<br />\r\n	<strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-14'),
	(3, 195, 0, 'Invoice ZH-2012-06-15-00110', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi,</strong></font><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Thanks for making the payment for Invoice No : ZH-2012-06-15-00110. The payment is Successful and your Plan will be activated within 12 Hours.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">For your information, All the payment is on advance mode, so if your plan contains any monthly payment section, the amount will deduct advance on each month and will rise invoice for your reference. If your payment is not successful after three attempt, your plan will be deactivated. Please let us know if any changes in your Paypal authorization details.<br />\r\n	<br />\r\n	<strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-15'),
	(4, 196, 0, 'Invoice ZH-2012-06-15-00111', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi _name_,</strong></font><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration to HostedOpenEMR and the corresponding payment for the plan you selected is successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-15-00111. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to login to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your plan, invoices, ledger so on and so forth.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-15'),
	(5, 197, 0, 'Invoice ZH-2012-06-15-00112', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;__name__,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-15-00112. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-15'),
	(6, 198, 0, 'Invoice ZH-2012-06-18-00113', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;__name__,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-18-00113. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-18'),
	(7, 199, 0, 'Invoice ZH-2012-06-18-00114', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;bb&nbspbb,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-18-00114. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-18'),
	(8, 170, 0, 'Reset Password ZH OEMR', '<p>Hi Dr. pradeep T P,</p>\r\n<p>As per your password request, here we are providing an temporary password to reset your account. </p>\r\n<p><br />\r\n  Your Temporary Password is : zWLTG8qZ </p>\r\n<p><br />\r\n  Click on the below url to reset your password</p>\r\n<p><br />\r\nhttp://hostedopenemr.com/Resetpassword/uid/MTcw</p>\r\n<p>Regards,<br />\r\nZH Healthcare Support Team.</p><p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-19'),
	(9, 170, 0, 'Reset Password ZH OEMR', '<p>\r\n	<font color="#104D96">Hi Dr. pradeep T P,</font></p>\r\n<p>\r\n	<font color="#104D96">As per your password request, here we are providing an temporary password to reset your account.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Your Temporary Password is : zWLTG8qZ</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Click on the below url to reset your password</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">http://hostedopenemr.com/Resetpassword/uid/MTcw</font></p>\r\n<p>\r\n	<font color="#104D96">Regards,<br />\r\n	ZH Healthcare Support Team.</font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-19'),
	(10, 170, 0, 'Reset Password ZH OEMR', '<p>\r\n	<font color="#104D96">Hi Dr. pradeep T P,</font></p>\r\n<p>\r\n	<font color="#104D96">As per your password request, here we are providing an temporary password to reset your account.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Your Temporary Password is : zWLTG8qZ</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Click on the below url to reset your password</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">http://hostedopenemr.com/Resetpassword/index/uid/MTcw</font></p>\r\n<p>\r\n	<font color="#104D96">Regards,<br />\r\n	ZH Healthcare Support Team.</font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-19'),
	(11, 202, 0, 'Invoice ZH-2012-06-20-00117', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Debra&nbspMendes,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-20-00117. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-20'),
	(12, 170, 0, 'Reset Password ZH OEMR', '<p>\r\n	<font color="#104D96">Hi Dr. pradeep T P,</font></p>\r\n<p>\r\n	<font color="#104D96">As per your password request, here we are providing an temporary password to reset your account.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Your Temporary Password is : VSeY63w5</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Click on the below url to reset your password</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">http://hostedopenemr.com/Resetpassword/index/uid/MTcw</font></p>\r\n<p>\r\n	<font color="#104D96">Regards,<br />\r\n	ZH Healthcare Support Team.</font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-20'),
	(13, 170, 0, 'Reset Password ZH OEMR', '<p>\r\n	<font color="#104D96">Hi Dr. pradeep T P,</font></p>\r\n<p>\r\n	<font color="#104D96">As per your password request, here we are providing an temporary password to reset your account.</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Your Temporary Password is : VSeY63w5</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">Click on the below url to reset your password</font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96">http://hostedopenemr.com/Resetpassword/index/uid/MTcw</font></p>\r\n<p>\r\n	<font color="#104D96">Regards,<br />\r\n	ZH Healthcare Support Team.</font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-20'),
	(14, 224, 0, 'Invoice ZH-2012-06-26-00004', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep&nbspTP,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00004. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(15, 224, 0, 'Invoice ZH-2012-06-26-00004', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep&nbspTP,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00004. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(16, 225, 0, 'Invoice ZH-2012-06-26-00007', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;vf&nbspvf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00007. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(17, 226, 0, 'Invoice ZH-2012-06-26-00008', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;hg&nbsphg,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00008. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(18, 227, 0, 'Invoice ZH-2012-06-26-00009', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ajil&nbspa,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00009. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(19, 228, 0, 'Invoice ZH-2012-06-26-00010', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;teny&nbspk,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-26-00010. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-26'),
	(20, 235, 0, 'Invoice ZH-2012-06-27-00018', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep&nbspT+P,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-27-00018. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-27'),
	(21, 235, 0, 'Invoice ZH-2012-06-28-00019', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep&nbspT+P,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-28-00019. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-28'),
	(22, 235, 0, 'Invoice ZH-2012-06-28-00020', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep&nbspT+P,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-28-00020. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-28'),
	(23, 235, 0, 'Invoice ZH-2012-06-28-00022', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep T+P,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-28-00022. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-28'),
	(24, 236, 0, 'Invoice ZH-2012-06-29-00023', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;bhg bhg,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-29-00023. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-29'),
	(25, 238, 0, 'Invoice ZH-2012-06-30-00024', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-30-00024. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-30'),
	(26, 238, 0, 'Invoice ZH-2012-06-30-00024', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-06-30-00024. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-30'),
	(27, 238, 0, 'test', '<p>\r\n	test mess</p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-30'),
	(28, 238, 0, 'asdf', '<p>\r\n	asdf</p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-06-30'),
	(29, 239, 0, 'Invoice ZH-2012-07-02-00025', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ccv ccv,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00025. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(30, 239, 0, 'Invoice ZH-2012-07-02-00025', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ccv ccv,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00025. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(31, 239, 0, 'Invoice ZH-2012-07-02-00025', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ccv ccv,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00025. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(32, 240, 0, 'Invoice ZH-2012-07-02-00026', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00026. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(33, 240, 0, 'Invoice ZH-2012-07-02-00026', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00026. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(34, 240, 0, 'Invoice ZH-2012-07-02-00026', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00026. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(35, 240, 0, 'Invoice ZH-2012-07-02-00026', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddf ddf,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00026. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(36, 241, 0, 'Invoice ZH-2012-07-02-00027', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;sd sd,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00027. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(37, 242, 0, 'Invoice ZH-2012-07-02-00028', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;rt rt,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00028. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(38, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(39, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(40, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(41, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(42, 243, 0, 'Invoice ZH-2012-07-02-00029', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ajil a,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00029. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(43, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(44, 242, 0, 'Plan Activated', 'asdf<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(45, 248, 0, 'Invoice ZH-2012-07-02-00030', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;dfg dfg,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00030. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(46, 249, 0, 'Invoice ZH-2012-07-02-00031', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ttt ttt,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-02-00031. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-02'),
	(47, 254, 0, 'Invoice ZH-2012-07-03-00035', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;nb nb,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-03-00035. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-03'),
	(48, 256, 0, 'Invoice ZH-2012-07-03-00037', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;km km,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-03-00037. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-03'),
	(49, 272, 0, 'Invoice ZH-2012-07-05-00038', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00038. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(50, 273, 0, 'Invoice ZH-2012-07-05-00039', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;aac aac,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00039. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(51, 272, 0, 'Invoice ZH-2012-07-05-00040', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00040. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(52, 272, 0, 'Invoice ZH-2012-07-05-00041', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00041. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(53, 272, 0, 'Invoice ZH-2012-07-05-00042', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00042. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(54, 272, 0, 'Invoice ZH-2012-07-05-00043', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00043. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(55, 272, 0, 'Invoice ZH-2012-07-05-00044', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;ddc ddc,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-05-00044. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-05'),
	(56, 275, 0, 'Invoice ZH-2012-07-12-00046', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;cd cd,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-12-00046. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-12'),
	(57, 276, 0, 'Invoice ZH-2012-07-12-00047', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;xs xs,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-12-00047. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-12'),
	(58, 277, 0, 'Invoice ZH-2012-07-12-00048', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;bg bg,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-12-00048. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-12'),
	(59, 247, 0, 'Invoice ZH-2012-07-12-00049', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;Pradeep T+P,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-12-00049. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-12'),
	(60, 278, 0, 'Invoice ZH-2012-07-14-00051', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;jj jj,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-14-00051. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-14'),
	(61, 278, 0, 'Invoice ZH-2012-07-14-00051', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;jj jj,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-14-00051. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-14'),
	(62, 279, 0, 'Invoice ZH-2012-07-17-00052', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;hj hj,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-17-00052. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-17'),
	(63, 279, 0, 'Invoice ZH-2012-07-17-00052', '<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Hi&nbsp;</strong></font><strong><span style="color: rgb(16, 77, 150); font-family: Verdana, Geneva, sans-serif; font-size: small; ">&nbsp;hj hj,</span></strong><br />\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Your registration with HostedOpenEMR and the corresponding payment for the plan you selected was successful.&nbsp; Your invoice number is&nbsp; ZH-2012-07-17-00052. </font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">Within the next 12 hours your database will be setup and an email will follow with the credentials for you to log in to your ZHOpenEMR.</font></p>\r\n<p>\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2">You can log in to your account from www.hostedopenemr.com.&nbsp; Select the &quot;My Account&quot; tab and log in to view your account details.&nbsp; You can also purchase additional products and services from the portal. </font></p>\r\n<p>\r\n	<br />\r\n	<font color="#104D96" face="Verdana, Geneva, sans-serif" size="2"><strong>Regards,<br />\r\n	ZH Healthcare Support Team</strong></font></p>\r\n<p><font face="Verdana, Geneva, sans-serif" size="1" color="#666666">DO NOT read, copy or disseminate this communication unless you are the intended addressee. This e-mail communication may contain confidential and/or privileged information intended only for the addressee. If you are not the intended recipient, please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by return e-mail, and delete it from your computer.</font></p>', 1, '2012-07-17');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.modules
DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `module_id` int(10) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL DEFAULT '0',
  `module_controller` varchar(50) NOT NULL DEFAULT '0',
  `module_display_name` varchar(50) NOT NULL DEFAULT '0',
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='Main Module Table (ACL)';

-- Dumping data for table hosted_emr.modules: ~11 rows (approximately)
DELETE FROM `modules`;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`module_id`, `module_name`, `module_controller`, `module_display_name`, `customer_id`) VALUES
	(1, 'Admin', 'Plans', 'Plans', 1),
	(2, 'Admin', 'Products', 'Products', 1),
	(3, 'Admin', 'Help', 'Help (Tips)', 1),
	(4, 'Admin', 'PageHelp', 'Page Wise Help', 1),
	(5, 'Admin', 'Users', 'Registered Customers', 1),
	(6, 'Admin', 'Acl', 'Acl Module', 1),
	(7, 'Admin', 'Cms', 'Cms', 1),
	(8, 'Admin', 'EmailTemplate', 'Email Templates', 1),
	(9, 'Admin', 'Speciality', 'Speciality', 1),
	(10, 'Admin', 'Faq', ' F A Q', 1),
	(11, 'Admin', 'Paypal', 'Paypal Setting', 1);
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


-- Dumping structure for table hosted_emr.paypal_setting
DROP TABLE IF EXISTS `paypal_setting`;
CREATE TABLE IF NOT EXISTS `paypal_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `signature` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'sandbox',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Setting of Paypal';

-- Dumping data for table hosted_emr.paypal_setting: ~2 rows (approximately)
DELETE FROM `paypal_setting`;
/*!40000 ALTER TABLE `paypal_setting` DISABLE KEYS */;
INSERT INTO `paypal_setting` (`id`, `username`, `password`, `signature`, `version`, `type`, `status`) VALUES
	(1, 'pradee_1339587675_biz_api1.zhservices.com', 'MTMzOTU4NzcxMw==', 'AkLZIuO-LKkA1TSAeoEBD3dkzIc4AKb3.ebscal3VYeJ4-cZbEqd8TXY', '56.0', 'sandbox', 1),
	(2, 'pradee_1339587675_biz_api1.zhservices.com', 'MTMzOTU4NzcxMw==', 'AkLZIuO-LKkA1TSAeoEBD3dkzIc4AKb3.ebscal3VYeJ4-cZbEqd8TXY', '56.0', 'live', 0);
/*!40000 ALTER TABLE `paypal_setting` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=latin1;

-- Dumping data for table hosted_emr.plan_products: ~14 rows (approximately)
DELETE FROM `plan_products`;
/*!40000 ALTER TABLE `plan_products` DISABLE KEYS */;
INSERT INTO `plan_products` (`idplanproducts`, `idplan`, `idproducts`, `added_date`, `compulsory`) VALUES
	(248, 1, 1, '2012-06-07', 0),
	(249, 1, 36, '2012-06-07', 0),
	(250, 1, 33, '2012-06-07', 0),
	(251, 15, 1, '2012-06-07', 0),
	(252, 15, 36, '2012-06-07', 0),
	(253, 15, 29, '2012-06-07', 0),
	(254, 15, 30, '2012-06-07', 0),
	(255, 15, 33, '2012-06-07', 0),
	(256, 16, 1, '2012-06-07', 0),
	(257, 16, 36, '2012-06-07', 0),
	(258, 16, 29, '2012-06-07', 0),
	(259, 16, 30, '2012-06-07', 0),
	(260, 16, 31, '2012-06-07', 0),
	(261, 16, 33, '2012-06-07', 0);
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
  `category` varchar(50) NOT NULL DEFAULT '0',
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
  `emrfeature` varchar(10) NOT NULL DEFAULT '0' COMMENT '0:not increment with provider number ; 1: increment with provider number',
  PRIMARY KEY (`idproducts`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 COMMENT='Products Master Table';

-- Dumping data for table hosted_emr.products: ~13 rows (approximately)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`idproducts`, `category`, `product_name`, `customer_id`, `product_feature`, `cost`, `setup_fee`, `payment_term`, `product_sort_order`, `product_status`, `added_date`, `ProductType`, `provider_cost_nature`, `provider_setup_nature`, `emrfeature`) VALUES
	(1, 'product', 'ZH OpenEMR', '1', '<p>\r\n	Scheduling</p>\r\n<ul>\r\n	<li>\r\n		Supports multiple physicians and facilities</li>\r\n	<li>\r\n		Easy to manage appointment calendar</li>\r\n	<li>\r\n		Ability to assign olors to easily identify appointment types or facilities</li>\r\n	<li>\r\n		Supports repeating appointments and restricting appointments</li>\r\n	<li>\r\n		Supports patient reminders and notifications</li>\r\n	<li>\r\n		Physcian Reminders</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient Demographics</p>\r\n<ul>\r\n	<li>\r\n		Manage Patient Demographics</li>\r\n	<li>\r\n		Comprehensive patient identification profile information, including full name, date of birth, sex, identification, language, ethinicity, marital status</li>\r\n	<li>\r\n		Contact information for patient</li>\r\n	<li>\r\n		Emergency Contact information</li>\r\n	<li>\r\n		Employment Information</li>\r\n	<li>\r\n		Insurance Coverage</li>\r\n	<li>\r\n		Primary Provider</li>\r\n	<li>\r\n		HIPAA Information</li>\r\n	<li>\r\n		Fully Customizable to easily extend out of the box demographic profile</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Patient History</p>\r\n<ul>\r\n	<li>\r\n		Medical Issues</li>\r\n	<li>\r\n		Medications</li>\r\n	<li>\r\n		Immunizations</li>\r\n	<li>\r\n		Vitals</li>\r\n	<li>\r\n		Labs</li>\r\n	<li>\r\n		Procedures</li>\r\n	<li>\r\n		Clinical Decision Rules to check/monitor/alert clinical information (such as vitals, history information, medications, procedures, labs, etc.) in real time</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Scan, link, and manage any document or picture</li>\r\n	<li>\r\n		Insurance Eligibility</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Encounters and Charting</p>\r\n<ul>\r\n	<li>\r\n		Fully customizable, template driven forms</li>\r\n	<li>\r\n		Comprehensive chart, visit summary, patient history views for quick updates</li>\r\n	<li>\r\n		Voice recognition ready</li>\r\n	<li>\r\n		Graphical Charting</li>\r\n	<li>\r\n		Easy to use Patient Notes with time savings features allowing saving of frequently used notes for reuse</li>\r\n	<li>\r\n		Diagnosis and procedure coding (CPT/ICD-9)</li>\r\n	<li>\r\n		Communications ready to create letters for insurance providers, referring physicians, or patients</li>\r\n	<li>\r\n		Electronic Syndrome Surveillance reporting</li>\r\n	<li>\r\n		Clinical Measures Calculations</li>\r\n	<li>\r\n		Clinical Quality Measure Calculations</li>\r\n	<li>\r\n		Automated Measure Calculations (AMC) and Tracking</li>\r\n	<li>\r\n		Hardcopy and eRX ready</li>\r\n	<li>\r\n		Paper Chart Tracking</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Billing and Receivables</p>\r\n<ul>\r\n	<li>\r\n		Flexible system of coding including CPT, HCPCS and ICD codes and the ability to add others</li>\r\n	<li>\r\n		Support for electronic billing to clearing houses such as Medavant/Capario and ZirMED using ANSI X12</li>\r\n	<li>\r\n		Support for paper claims</li>\r\n	<li>\r\n		Insurance Eligibility Queries</li>\r\n	<li>\r\n		Insurance Tracking Interface</li>\r\n	<li>\r\n		Accounts Receivable Interface</li>\r\n	<li>\r\n		Medical claim management interface</li>\r\n	<li>\r\n		EOB Entry Interface</li>\r\n	<li>\r\n		Customizable to work with a clearing house for automated 835 or ERA entry</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Additional Features</p>\r\n<ul>\r\n	<li>\r\n		Fully Customizable and Flexible to modify to how you work</li>\r\n	<li>\r\n		Supports use of multiple languages within the same clinic</li>\r\n	<li>\r\n		Robust reporting features with ability to create, enhance, and extend</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	Certifications</p>\r\n<ul>\r\n	<li>\r\n		ONC Complete Ambulatory EHR Certified</li>\r\n</ul>\r\n<p>\r\n	<br />\r\n	<br />\r\n	Security</p>\r\n<ul>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ability to Encrypt Patient Documents</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supports fine-grained per-user access controls</li>\r\n	<li>\r\n		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remotely accessible from any modern web browser with a suitable security certificate installed</li>\r\n</ul>\r\n', 75, 0, 1, 1, 1, '2012-04-01', 1, 1, 0, 'ab'),
	(29, 'product', 'ZH Advanced Billing', '1', '<p>\r\n	The Advanced Billing module is focused on providing capabilities to manage and improve your revenue cycle by decreasing staff time needed to enter billing, process and manage insurance claims, record payments; improve the accuracy of coding of encounters; provide quick access to patient accounts for responding to inquiries and resolving status of claims.</p>\r\n<p>\r\n	<strong>Enhanced Billing and Claims Processing</strong></p>\r\n<p>\r\n	Smart Fee Sheet</p>\r\n<ul>\r\n	<li>\r\n		Easy to use template that looks like the paper superbill you are used to</li>\r\n	<li>\r\n		Store CPT, ICD valid codes for easy and correct entry</li>\r\n	<li>\r\n		Allows for multiple fee sheets for a single factility</li>\r\n	<li>\r\n		Allows advanced capaility to lock encounters that are not ready for billing</li>\r\n	<li>\r\n		Time saving ability to enter miscellaneous options without leaving the fee sheet</li>\r\n</ul>\r\n<p>\r\n	Batch Charge Entry to Support Larger Facilities</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter multiple claims from a single screen</li>\r\n	<li>\r\n		Allows for entry of new patients from the same screen</li>\r\n</ul>\r\n<p>\r\n	Real Time Eligibility Verification for Insurance</p>\r\n<p>\r\n	Billing Management</p>\r\n<ul>\r\n	<li>\r\n		Work on all claims from a single screen</li>\r\n	<li>\r\n		Advanced filters to see only the claims you are interested in working</li>\r\n	<li>\r\n		Allows to view fee sheet and demographics ledger</li>\r\n	<li>\r\n		Ability to fix all errors before submittal increasing First Pass Rate</li>\r\n	<li>\r\n		Data entry uses quality control verifying codes as you type and automatically applies relevant data (patient, provider, payer) from system database</li>\r\n	<li>\r\n		Generate HCFA, PDF, TXT, or Electronic Claims files</li>\r\n	<li>\r\n		Automatically generate and upload claims to clearing house</li>\r\n	<li>\r\n		Option to direct claims to 3rd party billing systems</li>\r\n	<li>\r\n		Supports multiple insurance company networks</li>\r\n	<li>\r\n		Ability to process secondary insurance claims</li>\r\n	<li>\r\n		Ability to write off balances</li>\r\n	<li>\r\n		Allows for moving balances to patient accounts</li>\r\n	<li>\r\n		Ability to send more than 4 diagnosis with claim</li>\r\n</ul>\r\n<p>\r\n	Clearing House Integration</p>\r\n<ul>\r\n	<li>\r\n		Seamless integration avoiding steps to generate and upload files separately</li>\r\n	<li>\r\n		Advanced import facility will import NPI and Tax ID numbers needed for posting payment from ERA</li>\r\n	<li>\r\n		Enhanced file summary of uploaded claimes to clearing house includes current status of the claims and response from the payer allowing ability to update the EMR database automatically</li>\r\n</ul>\r\n<p>\r\n	Rejected Claim Management</p>\r\n<ul>\r\n	<li>\r\n		Enhanced query ability to enable quick review to remedy errors and refile claims from a sign screen</li>\r\n	<li>\r\n		Stores history relating to why the claims were denied</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Payment Receipt Processing</strong></p>\r\n<p>\r\n	Payments</p>\r\n<ul>\r\n	<li>\r\n		Easy entry of payments and adjustments</li>\r\n	<li>\r\n		Single screen to receive any payment method including cash, check, credit card</li>\r\n	<li>\r\n		Advanced search and filtering to view only the payments you wish to review</li>\r\n	<li>\r\n		Allows receipt from any type of payment source including advance payment, group payment, capitation payment, insurance payment</li>\r\n	<li>\r\n		Easily allocate payment or EOBs to specific encounters</li>\r\n	<li>\r\n		Easily allocate payment to specific CPTs within a claim and track unpaid CPTs within a claim</li>\r\n	<li>\r\n		Ability to enter payments to specific &quot;post to&quot; dates</li>\r\n	<li>\r\n		Easily enter data from EOBs and apply insurance company responses to patient accounts</li>\r\n	<li>\r\n		View and print original EOBs and other payment documents</li>\r\n</ul>\r\n<p>\r\n	ERA&nbsp; Posting</p>\r\n<ul>\r\n	<li>\r\n		Post individual ERA and automatically update to patient accounts</li>\r\n	<li>\r\n		Advanced ability to batch process ERA files from multiple insurance companies greatly reducing process time for larger facilities</li>\r\n</ul>\r\n<p>\r\n	Capitation Payments</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter and track capitation payments</li>\r\n	<li>\r\n		Analysis reporting for profitability of capitated patient encounters</li>\r\n</ul>\r\n<p>\r\n	<strong>Accounts Receivable Management</strong></p>\r\n<ul>\r\n	<li>\r\n		Full featured claims and action tracking allowing to monitor and report on claim status, alert for followups, and identify payer denied claims</li>\r\n	<li>\r\n		Supports claims appeal process to determine reason for denial, collection of needed additional information and resubmission of claim</li>\r\n	<li>\r\n		Maintains call log of followup actions</li>\r\n</ul>\r\n<p>\r\n	<strong>Patient Accounts</strong></p>\r\n<p>\r\n	Pre-Authorization Management</p>\r\n<ul>\r\n	<li>\r\n		Ability to enter pre-autorization and plan details greatly reducing staff time needed to manage the variations of authorized treatment</li>\r\n	<li>\r\n		Track encounters based on number of visits, hours, specific CPTs</li>\r\n	<li>\r\n		Flag encounters where pre-autorization is not covered or reaches allowed coverage</li>\r\n</ul>\r\n<p>\r\n	Patient Ledger</p>\r\n<ul>\r\n	<li>\r\n		Elaborate patient ledger displaying total charges, amounts pending for each insurance, payments received, balance details detailing insurance versus patient portion</li>\r\n	<li>\r\n		Color coded line items to easily distingish services, patient payments, insurance payments, and adjustments</li>\r\n	<li>\r\n		One click viewing of underlying fee sheet or payment</li>\r\n	<li>\r\n		Quick printing directly from ledger of individual patient statement and patient ledger</li>\r\n</ul>\r\n<p>\r\n	Patient Statements</p>\r\n<ul>\r\n	<li>\r\n		Batch or individual printing of billing statements</li>\r\n	<li>\r\n		Quick access to billing statement and payment history from patient profile</li>\r\n	<li>\r\n		Easy billing lookup for responding to patient billing inquiries</li>\r\n</ul>\r\n<p>\r\n	<strong>Advanced Reporting</strong></p>\r\n<ul>\r\n	<li>\r\n		Library of reports to track accounts receivable, patients, and other financial information</li>\r\n	<li>\r\n		Ability to customize reports to needs</li>\r\n	<li>\r\n		Reporting memory option allowing specific filter and reporting queries to be saved for repeated use</li>\r\n	<li>\r\n		Export reports to PDF, Excel or CSV formats</li>\r\n</ul>\r\n', 75, 0, 1, 3, 1, '2012-04-27', 3, 1, 0, 'ab'),
	(30, 'product', 'ZH eRx', '1', '<p>\r\n	ZHOpenEMR&rsquo;s electronic prescription or e-Prescription module enables your practice to facilitate faster delivery of medicines, refills, with accuracy. &nbsp;</p>\r\n<ul>\r\n	<li>\r\n		Submit electronic presriptions to any pharmacy</li>\r\n	<li>\r\n		Supports refill requests</li>\r\n	<li>\r\n		Includes drug-drug and drug-allergy interactions</li>\r\n	<li>\r\n		Allows ability to also print presriptions</li>\r\n	<li>\r\n		Available as a standalone product</li>\r\n</ul>\r\n', 35, 0, 1, 4, 1, '2012-04-27', 3, 1, 0, 'ex'),
	(31, 'product', 'ZH Lab Interface', '1', '<p>\r\n	Improves management of of ordering, tracking, storing of results data providing improved workflow for the investative process to determine treatment plans for your patients.</p>\r\n<ul>\r\n	<li>\r\n		Seamlessly order and receive tests</li>\r\n	<li>\r\n		Stores results within EMR</li>\r\n	<li>\r\n		Results easily viewable by physcian</li>\r\n	<li>\r\n		Tracks previous investigations for comparisons of results</li>\r\n</ul>\r\n<p>\r\n	&nbsp;</p>\r\n', 50, 0, 1, 5, 1, '2012-04-27', 3, 1, 0, 'lb'),
	(32, 'support', 'Essential Support', '1', '<p>\r\n	Our Essential Support services are for those who want to ensure their system is &quot;always on&quot; and secure, but do not need personal assistance and guidance in best usage of our ZH OpenEMR software.</p>\r\n<p>\r\n	Support Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		No Monthly Fee</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contacts &nbsp;&nbsp; &nbsp;1</li>\r\n	<li>\r\n		Resolution for ZH -owned issues &nbsp;&nbsp;</li>\r\n	<li>\r\n		Support during local business hours</li>\r\n	<li>\r\n		48 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		Acces to self-help support including:\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums<br />\r\n				&nbsp;</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', 0, 0, 1, 6, 1, '2012-05-25', 2, 1, 0, '0'),
	(33, 'support', ' Preferred Support', '1', '<p>\r\n	Our most popular plan provides you with your reliable, always on, always up to date system as well as access to our customer care experts for addressing your technical and ZH OpenEMR software usage questions.</p>\r\n<p>\r\n	Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$100 per month per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		1 Named Contact&nbsp;&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Resolution for ZH -owned issues</li>\r\n	<li>\r\n		Support during Local business hours</li>\r\n	<li>\r\n		12 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting&nbsp; &nbsp;&nbsp;</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Self Help Support including:&nbsp; &nbsp; &nbsp;&nbsp;\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online tutorial videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', 100, 0, 1, 7, 1, '2012-05-25', 3, 1, 0, '0'),
	(34, 'support', 'Concierge Support', '1', '<p>\r\n	Our Concierge support service provides all the benefits of our preferred support plus provides you with your personal customer care expert to provide the individual attention your facility requires.</p>\r\n<p>\r\n	Support Plan Details:</p>\r\n<ul>\r\n	<li>\r\n		$200 monthly per provider</li>\r\n	<li>\r\n		Unlimited Support Requests (Incidents)</li>\r\n	<li>\r\n		3 Named Contacts</li>\r\n	<li>\r\n		Resolution for ZH -owned software issues</li>\r\n	<li>\r\n		Support durig local business hours</li>\r\n	<li>\r\n		1 hour Initial Response Time</li>\r\n	<li>\r\n		Web Case Management</li>\r\n	<li>\r\n		Email Support</li>\r\n	<li>\r\n		One-on-one online support</li>\r\n	<li>\r\n		One-on-one phone support</li>\r\n	<li>\r\n		Remote Troubleshooting</li>\r\n	<li>\r\n		Direct access to Customer Care Account Manager</li>\r\n	<li>\r\n		Best practice guidance</li>\r\n	<li>\r\n		Go-Live Assistance</li>\r\n	<li>\r\n		Scheduled Upgrade Assistance</li>\r\n	<li>\r\n		Complimentary Configuration Review</li>\r\n	<li>\r\n		Complimentary Usage Review</li>\r\n	<li>\r\n		Self Help Support including:\r\n		<ul>\r\n			<li>\r\n				Account Portal</li>\r\n			<li>\r\n				Access to User Manuals</li>\r\n			<li>\r\n				Access to online videos</li>\r\n			<li>\r\n				Best Practice Knowledge Base</li>\r\n			<li>\r\n				User Forums</li>\r\n		</ul>\r\n	</li>\r\n</ul>\r\n', 200, 0, 1, 8, 1, '2012-05-25', 2, 1, 0, '0'),
	(35, 'service', 'Data Conversion', '1', '<p>\r\n	Data conversion from your Legacy EMR/Billing Software</p>\r\n', 0, 2000, 1, 9, 1, '2012-05-30', 2, 0, 0, '0'),
	(36, 'product', 'ZH Patient Portal', '1', '<p>\r\n	ZH Patient Portal gives a direct online link between the provider and the patient to allow for easy resolution of questions, make it easier to complete required forms and overall provide a better service to your patients.</p>\r\n<ul>\r\n	<li>\r\n		Flexible and easily configurable to needs of each practice</li>\r\n	<li>\r\n		New patient can register online and complete pre-visit documents</li>\r\n	<li>\r\n		Patient can browse and make appointment online</li>\r\n	<li>\r\n		View and update patient profile inforamtion including demographic and insurance infomation</li>\r\n	<li>\r\n		Make payments online</li>\r\n	<li>\r\n		View medical records including lab results and presriptions</li>\r\n	<li>\r\n		View billing account and statements</li>\r\n	<li>\r\n		Communicate easily through a secure mailbox to request refills, referrals, or other information</li>\r\n</ul>\r\n', 0, 0, 1, 2, 1, '2012-06-01', 3, 1, 1, 'pp'),
	(37, 'service', 'Go-Live Assistance', '1', '<p>\r\n	Provides personalized setup assistance to help your practice be successful with ZH OpenEMR.&nbsp; This includes</p>\r\n<p>\r\n	1.&nbsp; Get Started Guide</p>\r\n<p>\r\n	2.&nbsp; Setup and configuration for your facility</p>\r\n<p>\r\n	3.&nbsp; Workflow Review and recommendations for best usage of ZH OpenEMR</p>\r\n<p>\r\n	4.&nbsp; Assistance to customize (and how to training) for one of your specialized forms</p>\r\n<p>\r\n	5.&nbsp; Customized &quot;How To&quot; training that will most benefit your practice</p>\r\n<p>\r\n	&nbsp;</p>\r\n', 0, 2000, NULL, 8, 1, '2012-06-08', 2, 0, 1, '0');
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
	select cost,setup_fee,provider_cost_nature,provider_setup_nature  from products where idproducts=pid and product_status=1;
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


-- Dumping structure for table hosted_emr.reseller_details
DROP TABLE IF EXISTS `reseller_details`;
CREATE TABLE IF NOT EXISTS `reseller_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='Reseller Master Table';

-- Dumping data for table hosted_emr.reseller_details: ~2 rows (approximately)
DELETE FROM `reseller_details`;
/*!40000 ALTER TABLE `reseller_details` DISABLE KEYS */;
INSERT INTO `reseller_details` (`id`, `Name`) VALUES
	(1, 'ZH Healthcare'),
	(8, 'Hp');
/*!40000 ALTER TABLE `reseller_details` ENABLE KEYS */;


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


-- Dumping structure for table hosted_emr.speciality
DROP TABLE IF EXISTS `speciality`;
CREATE TABLE IF NOT EXISTS `speciality` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(150) DEFAULT NULL,
  `listing_order` bigint(20) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1 COMMENT='Speciality Table Master (For Listing in Registration)';

-- Dumping data for table hosted_emr.speciality: ~51 rows (approximately)
DELETE FROM `speciality`;
/*!40000 ALTER TABLE `speciality` DISABLE KEYS */;
INSERT INTO `speciality` (`id`, `sp_name`, `listing_order`, `status`) VALUES
	(1, 'Allergy and Immunology', 1, 1),
	(2, 'Anaesthetics', 2, 1),
	(3, 'Pathology', 3, 1),
	(4, 'Cardiology', 4, 1),
	(5, 'Paediatric cardiology', 5, 1),
	(6, 'Cardiothoracic surgery', 6, 1),
	(7, 'Child and adolescent psychiatry and psychotherapy', 7, 1),
	(8, 'Clinical neurophysiology', 8, 1),
	(9, 'Dermato-Venereology', 9, 1),
	(10, 'Endocrinology', 10, 1),
	(11, 'Gastroenterology', 11, 1),
	(12, 'Geriatrics', 12, 1),
	(13, 'Gynaecology and obstetrics', 13, 1),
	(14, 'Health Informatics', 14, 1),
	(15, 'Infectious diseases', 15, 1),
	(16, 'Internal Medicine', 16, 1),
	(17, 'Interventional Radiology', 17, 1),
	(18, 'Vascular medicine', 18, 1),
	(19, 'Microbiology', 19, 1),
	(20, 'Nephrology', 20, 1),
	(21, 'Neurology', 21, 1),
	(22, 'Neurosurgery', 22, 1),
	(23, 'Nuclear medicine', 23, 1),
	(24, 'Occupational medicine', 24, 1),
	(25, 'Ophthalmology', 25, 1),
	(26, 'Orthopaedics', 26, 1),
	(27, 'Oro-Maxillo-Facial Surgery', 27, 1),
	(28, 'Otorhinolaryngology', 28, 1),
	(29, 'Paediatrics', 29, 1),
	(30, 'Paediatric allergology', 30, 1),
	(31, 'Paediatric endocrinology and diabetes', 31, 1),
	(32, 'Paediatric gastroenterology, hepatology and nutrition', 32, 1),
	(33, 'Paediatric haematology and oncology', 33, 1),
	(34, 'Paediatric infectious diseases', 34, 1),
	(35, 'Neonatology', 35, 1),
	(36, 'Paediatric Nephrology', 36, 1),
	(37, 'Paediatric respiratory medicine', 37, 1),
	(38, 'Paediatric rheumatology', 38, 1),
	(39, 'Paediatric surgery', 39, 1),
	(40, 'Physical and Rehabilitation Medicine', 40, 1),
	(41, 'Plastic, Reconstructive and Aesthetic Surgery', 41, 1),
	(42, 'Pneumology', 42, 1),
	(43, 'Psychiatry', 43, 1),
	(44, 'Public Health', 44, 1),
	(45, 'Radiology', 45, 1),
	(46, 'Neuroradiology', 46, 1),
	(47, 'Radiotherapy', 47, 1),
	(48, 'General surgery', 48, 1),
	(49, 'Urology', 49, 1),
	(50, 'Vascular surgery', 50, 1),
	(52, 'Family Practice', 11, 1),
	(53, 'test', 51, 1);
/*!40000 ALTER TABLE `speciality` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.state
DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `state_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Country_Code` varchar(3) NOT NULL,
  `State_name` varchar(255) NOT NULL,
  `listing_order` bigint(20) NOT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 COMMENT='State List';

-- Dumping data for table hosted_emr.state: ~50 rows (approximately)
DELETE FROM `state`;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` (`state_id`, `Country_Code`, `State_name`, `listing_order`) VALUES
	(1, 'USA', 'Alabama', 1),
	(2, 'USA', 'Alaska', 2),
	(3, 'USA', 'Arizona', 3),
	(4, 'USA', 'Arkansas', 4),
	(5, 'USA', 'California', 5),
	(6, 'USA', 'Colorado', 6),
	(7, 'USA', 'Connecticut', 7),
	(8, 'USA', 'Delaware', 8),
	(9, 'USA', 'Florida', 9),
	(10, 'USA', 'Georgia', 10),
	(11, 'USA', 'Hawaii', 11),
	(12, 'USA', 'Idaho', 12),
	(13, 'USA', 'Illinois', 13),
	(14, 'USA', 'Indiana', 14),
	(15, 'USA', 'Iowa', 15),
	(16, 'USA', 'Kansas', 16),
	(17, 'USA', 'Kentucky', 17),
	(18, 'USA', 'Louisiana', 18),
	(19, 'USA', 'Maine', 19),
	(20, 'USA', 'Maryland', 20),
	(21, 'USA', 'Massachusetts', 21),
	(22, 'USA', 'Michigan', 22),
	(23, 'USA', 'Minnesota', 23),
	(24, 'USA', 'Mississippi', 24),
	(25, 'USA', 'Missouri', 25),
	(26, 'USA', 'Montana', 26),
	(27, 'USA', 'Nebraska', 27),
	(28, 'USA', 'Nevada', 28),
	(29, 'USA', 'New Hampshire', 29),
	(30, 'USA', 'New Jersey', 30),
	(31, 'USA', 'New Mexico', 31),
	(32, 'USA', 'New York', 32),
	(33, 'USA', 'North Carolina', 33),
	(34, 'USA', 'North Dakota', 34),
	(35, 'USA', 'Ohio', 35),
	(36, 'USA', 'Oklahoma', 36),
	(37, 'USA', 'Oregon', 37),
	(38, 'USA', 'Pennsylvania', 38),
	(39, 'USA', 'Rhode Island', 39),
	(40, 'USA', 'South Carolina', 40),
	(41, 'USA', 'South Dakota', 41),
	(42, 'USA', 'Tennessee', 42),
	(43, 'USA', 'Texas', 43),
	(44, 'USA', 'Utah', 44),
	(45, 'USA', 'Vermont', 45),
	(46, 'USA', 'Virginia', 46),
	(47, 'USA', 'Washington', 47),
	(48, 'USA', 'West Virginia', 48),
	(49, 'USA', 'Wisconsin', 49),
	(50, 'USA', ' Wyoming', 50);
/*!40000 ALTER TABLE `state` ENABLE KEYS */;


-- Dumping structure for table hosted_emr.sub_product_list
DROP TABLE IF EXISTS `sub_product_list`;
CREATE TABLE IF NOT EXISTS `sub_product_list` (
  `sub_product_listId` bigint(20) NOT NULL AUTO_INCREMENT,
  `idproducts` bigint(20) NOT NULL DEFAULT '0',
  `sub_idproducts` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sub_product_listId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Link products wth a master product for compulsory inserting';

-- Dumping data for table hosted_emr.sub_product_list: ~2 rows (approximately)
DELETE FROM `sub_product_list`;
/*!40000 ALTER TABLE `sub_product_list` DISABLE KEYS */;
INSERT INTO `sub_product_list` (`sub_product_listId`, `idproducts`, `sub_idproducts`) VALUES
	(2, 34, 29),
	(3, 34, 30);
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
	('ALB', 'Albania', 'Europe', 'Southern Europe', 28748.00, 1912, 3401200, 71.6, 3205.00, 2500.00, 'ShqipÃƒÂ«ria', 'Republic', 'Rexhep Mejdani', 34, 'AL'),
	('DZA', 'Algeria', 'Africa', 'Northern Africa', 2381741.00, 1962, 31471000, 69.7, 49982.00, 46966.00, 'Al-JazaÃ¢â‚¬â„¢ir/AlgÃƒÂ©rie', 'Republic', 'Abdelaziz Bouteflika', 35, 'DZ'),
	('ASM', 'American Samoa', 'Oceania', 'Polynesia', 199.00, NULL, 68000, 75.1, 334.00, NULL, 'Amerika Samoa', 'US Territory', 'George W. Bush', 54, 'AS'),
	('AND', 'Andorra', 'Europe', 'Southern Europe', 468.00, 1278, 78000, 83.5, 1630.00, NULL, 'Andorra', 'Parliamentary Coprincipality', '', 55, 'AD'),
	('AGO', 'Angola', 'Africa', 'Central Africa', 1246700.00, 1975, 12878000, 38.3, 6648.00, 7984.00, 'Angola', 'Republic', 'JosÃƒÂ© Eduardo dos Santos', 56, 'AO'),
	('AIA', 'Anguilla', 'North America', 'Caribbean', 96.00, NULL, 8000, 76.1, 63.20, NULL, 'Anguilla', 'Dependent Territory of the UK', 'Elisabeth II', 62, 'AI'),
	('ATG', 'Antigua and Barbuda', 'North America', 'Caribbean', 442.00, 1981, 68000, 70.5, 612.00, 584.00, 'Antigua and Barbuda', 'Constitutional Monarchy', 'Elisabeth II', 63, 'AG'),
	('ARE', 'United Arab Emirates', 'Asia', 'Middle East', 83600.00, 1971, 2441000, 74.1, 37966.00, 36846.00, 'Al-Imarat al-Ã‚Â´Arabiya al-Muttahida', 'Emirate Federation', 'Zayid bin Sultan al-Nahayan', 65, 'AE'),
	('ARG', 'Argentina', 'South America', 'South America', 2780400.00, 1816, 37032000, 75.1, 340238.00, 323310.00, 'Argentina', 'Federal Republic', 'Fernando de la RÃƒÂºa', 69, 'AR'),
	('ARM', 'Armenia', 'Asia', 'Middle East', 29800.00, 1991, 3520000, 66.4, 1813.00, 1627.00, 'Hajastan', 'Republic', 'Robert KotÃ…Â¡arjan', 126, 'AM'),
	('ABW', 'Aruba', 'North America', 'Caribbean', 193.00, NULL, 103000, 78.4, 828.00, 793.00, 'Aruba', 'Nonmetropolitan Territory of The Netherlands', 'Beatrix', 129, 'AW'),
	('AUS', 'Australia', 'Oceania', 'Australia and New Zealand', 7741220.00, 1901, 18886000, 79.8, 351182.00, 392911.00, 'Australia', 'Constitutional Monarchy, Federation', 'Elisabeth II', 135, 'AU'),
	('AZE', 'Azerbaijan', 'Asia', 'Middle East', 86600.00, 1991, 7734000, 62.9, 4127.00, 4100.00, 'AzÃƒÂ¤rbaycan', 'Federal Republic', 'HeydÃƒÂ¤r Ãƒâ€žliyev', 144, 'AZ'),
	('BHS', 'Bahamas', 'North America', 'Caribbean', 13878.00, 1973, 307000, 71.1, 3527.00, 3347.00, 'The Bahamas', 'Constitutional Monarchy', 'Elisabeth II', 148, 'BS'),
	('BHR', 'Bahrain', 'Asia', 'Middle East', 694.00, 1971, 617000, 73.0, 6366.00, 6097.00, 'Al-Bahrayn', 'Monarchy (Emirate)', 'Hamad ibn Isa al-Khalifa', 149, 'BH'),
	('BGD', 'Bangladesh', 'Asia', 'Southern and Central Asia', 143998.00, 1971, 129155000, 60.2, 32852.00, 31966.00, 'Bangladesh', 'Republic', 'Shahabuddin Ahmad', 150, 'BD'),
	('BRB', 'Barbados', 'North America', 'Caribbean', 430.00, 1966, 270000, 73.0, 2223.00, 2186.00, 'Barbados', 'Constitutional Monarchy', 'Elisabeth II', 174, 'BB'),
	('BEL', 'Belgium', 'Europe', 'Western Europe', 30518.00, 1830, 10239000, 77.8, 249704.00, 243948.00, 'BelgiÃƒÂ«/Belgique', 'Constitutional Monarchy, Federation', 'Albert II', 179, 'BE'),
	('BLZ', 'Belize', 'North America', 'Central America', 22696.00, 1981, 241000, 70.9, 630.00, 616.00, 'Belize', 'Constitutional Monarchy', 'Elisabeth II', 185, 'BZ'),
	('BEN', 'Benin', 'Africa', 'Western Africa', 112622.00, 1960, 6097000, 50.2, 2357.00, 2141.00, 'BÃƒÂ©nin', 'Republic', 'Mathieu KÃƒÂ©rÃƒÂ©kou', 187, 'BJ'),
	('BMU', 'Bermuda', 'North America', 'North America', 53.00, NULL, 65000, 76.9, 2328.00, 2190.00, 'Bermuda', 'Dependent Territory of the UK', 'Elisabeth II', 191, 'BM'),
	('BTN', 'Bhutan', 'Asia', 'Southern and Central Asia', 47000.00, 1910, 2124000, 52.4, 372.00, 383.00, 'Druk-Yul', 'Monarchy', 'Jigme Singye Wangchuk', 192, 'BT'),
	('BOL', 'Bolivia', 'South America', 'South America', 1098581.00, 1825, 8329000, 63.7, 8571.00, 7967.00, 'Bolivia', 'Republic', 'Hugo BÃƒÂ¡nzer SuÃƒÂ¡rez', 194, 'BO'),
	('BIH', 'Bosnia and Herzegovina', 'Europe', 'Southern Europe', 51197.00, 1992, 3972000, 71.5, 2841.00, NULL, 'Bosna i Hercegovina', 'Federal Republic', 'Ante Jelavic', 201, 'BA'),
	('BWA', 'Botswana', 'Africa', 'Southern Africa', 581730.00, 1966, 1622000, 39.3, 4834.00, 4935.00, 'Botswana', 'Republic', 'Festus G. Mogae', 204, 'BW'),
	('BRA', 'Brazil', 'South America', 'South America', 8547403.00, 1822, 170115000, 62.9, 776739.00, 804108.00, 'Brasil', 'Federal Republic', 'Fernando Henrique Cardoso', 211, 'BR'),
	('GBR', 'United Kingdom', 'Europe', 'British Islands', 242900.00, 1066, 59623400, 77.7, 1378330.00, 1296830.00, 'United Kingdom', 'Constitutional Monarchy', 'Elisabeth II', 456, 'GB'),
	('VGB', 'Virgin Islands, British', 'North America', 'Caribbean', 151.00, NULL, 21000, 75.4, 612.00, 573.00, 'British Virgin Islands', 'Dependent Territory of the UK', 'Elisabeth II', 537, 'VG'),
	('BRN', 'Brunei', 'Asia', 'Southeast Asia', 5765.00, 1984, 328000, 73.6, 11705.00, 12460.00, 'Brunei Darussalam', 'Monarchy (Sultanate)', 'Haji Hassan al-Bolkiah', 538, 'BN'),
	('BGR', 'Bulgaria', 'Europe', 'Eastern Europe', 110994.00, 1908, 8190900, 70.9, 12178.00, 10169.00, 'Balgarija', 'Republic', 'Petar Stojanov', 539, 'BG'),
	('BFA', 'Burkina Faso', 'Africa', 'Western Africa', 274000.00, 1960, 11937000, 46.7, 2425.00, 2201.00, 'Burkina Faso', 'Republic', 'Blaise CompaorÃƒÂ©', 549, 'BF'),
	('BDI', 'Burundi', 'Africa', 'Eastern Africa', 27834.00, 1962, 6695000, 46.2, 903.00, 982.00, 'Burundi/Uburundi', 'Republic', 'Pierre Buyoya', 552, 'BI'),
	('CYM', 'Cayman Islands', 'North America', 'Caribbean', 264.00, NULL, 38000, 78.9, 1263.00, 1186.00, 'Cayman Islands', 'Dependent Territory of the UK', 'Elisabeth II', 553, 'KY'),
	('CHL', 'Chile', 'South America', 'South America', 756626.00, 1810, 15211000, 75.7, 72949.00, 75780.00, 'Chile', 'Republic', 'Ricardo Lagos Escobar', 554, 'CL'),
	('COK', 'Cook Islands', 'Oceania', 'Polynesia', 236.00, NULL, 20000, 71.1, 100.00, NULL, 'The Cook Islands', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 583, 'CK'),
	('CRI', 'Costa Rica', 'North America', 'Central America', 51100.00, 1821, 4023000, 75.8, 10226.00, 9757.00, 'Costa Rica', 'Republic', 'Miguel ÃƒÂngel RodrÃƒÂ­guez EcheverrÃƒÂ­a', 584, 'CR'),
	('DJI', 'Djibouti', 'Africa', 'Eastern Africa', 23200.00, 1977, 638000, 50.8, 382.00, 373.00, 'Djibouti/Jibuti', 'Republic', 'Ismail Omar Guelleh', 585, 'DJ'),
	('DMA', 'Dominica', 'North America', 'Caribbean', 751.00, 1978, 71000, 73.4, 256.00, 243.00, 'Dominica', 'Republic', 'Vernon Shaw', 586, 'DM'),
	('DOM', 'Dominican Republic', 'North America', 'Caribbean', 48511.00, 1844, 8495000, 73.2, 15846.00, 15076.00, 'RepÃƒÂºblica Dominicana', 'Republic', 'HipÃƒÂ³lito MejÃƒÂ­a DomÃƒÂ­nguez', 587, 'DO'),
	('ECU', 'Ecuador', 'South America', 'South America', 283561.00, 1822, 12646000, 71.1, 19770.00, 19769.00, 'Ecuador', 'Republic', 'Gustavo Noboa Bejarano', 594, 'EC'),
	('EGY', 'Egypt', 'Africa', 'Northern Africa', 1001449.00, 1922, 68470000, 63.3, 82710.00, 75617.00, 'Misr', 'Republic', 'Hosni Mubarak', 608, 'EG'),
	('SLV', 'El Salvador', 'North America', 'Central America', 21041.00, 1841, 6276000, 69.7, 11863.00, 11203.00, 'El Salvador', 'Republic', 'Francisco Guillermo Flores PÃƒÂ©rez', 645, 'SV'),
	('ERI', 'Eritrea', 'Africa', 'Eastern Africa', 117600.00, 1993, 3850000, 55.8, 650.00, 755.00, 'Ertra', 'Republic', 'Isayas Afewerki [Isaias Afwerki]', 652, 'ER'),
	('ESP', 'Spain', 'Europe', 'Southern Europe', 505992.00, 1492, 39441700, 78.8, 553233.00, 532031.00, 'EspaÃƒÂ±a', 'Constitutional Monarchy', 'Juan Carlos I', 653, 'ES'),
	('ZAF', 'South Africa', 'Africa', 'Southern Africa', 1221037.00, 1910, 40377000, 51.1, 116729.00, 129092.00, 'South Africa', 'Republic', 'Thabo Mbeki', 716, 'ZA'),
	('ETH', 'Ethiopia', 'Africa', 'Eastern Africa', 1104300.00, -1000, 62565000, 45.2, 6353.00, 6180.00, 'YeItyopÃ‚Â´iya', 'Republic', 'Negasso Gidada', 756, 'ET'),
	('FLK', 'Falkland Islands', 'South America', 'South America', 12173.00, NULL, 2000, NULL, 0.00, NULL, 'Falkland Islands', 'Dependent Territory of the UK', 'Elisabeth II', 763, 'FK'),
	('FJI', 'Fiji Islands', 'Oceania', 'Melanesia', 18274.00, 1970, 817000, 67.9, 1536.00, 2149.00, 'Fiji Islands', 'Republic', 'Josefa Iloilo', 764, 'FJ'),
	('PHL', 'Philippines', 'Asia', 'Southeast Asia', 300000.00, 1946, 75967000, 67.5, 65107.00, 82239.00, 'Pilipinas', 'Republic', 'Gloria Macapagal-Arroyo', 766, 'PH'),
	('FRO', 'Faroe Islands', 'Europe', 'Nordic Countries', 1399.00, NULL, 43000, 78.4, 0.00, NULL, 'FÃƒÂ¸royar', 'Part of Denmark', 'Margrethe II', 901, 'FO'),
	('GAB', 'Gabon', 'Africa', 'Central Africa', 267668.00, 1960, 1226000, 50.1, 5493.00, 5279.00, 'Le Gabon', 'Republic', 'Omar Bongo', 902, 'GA'),
	('GMB', 'Gambia', 'Africa', 'Western Africa', 11295.00, 1965, 1305000, 53.2, 320.00, 325.00, 'The Gambia', 'Republic', 'Yahya Jammeh', 904, 'GM'),
	('GEO', 'Georgia', 'Asia', 'Middle East', 69700.00, 1991, 4968000, 64.5, 6064.00, 5924.00, 'Sakartvelo', 'Republic', 'Eduard Ã…Â evardnadze', 905, 'GE'),
	('GHA', 'Ghana', 'Africa', 'Western Africa', 238533.00, 1957, 20212000, 57.4, 7137.00, 6884.00, 'Ghana', 'Republic', 'John Kufuor', 910, 'GH'),
	('GIB', 'Gibraltar', 'Europe', 'Southern Europe', 6.00, NULL, 25000, 79.0, 258.00, NULL, 'Gibraltar', 'Dependent Territory of the UK', 'Elisabeth II', 915, 'GI'),
	('GRD', 'Grenada', 'North America', 'Caribbean', 344.00, 1974, 94000, 64.5, 318.00, NULL, 'Grenada', 'Constitutional Monarchy', 'Elisabeth II', 916, 'GD'),
	('GRL', 'Greenland', 'North America', 'North America', 2166090.00, NULL, 56000, 68.1, 0.00, NULL, 'Kalaallit Nunaat/GrÃƒÂ¸nland', 'Part of Denmark', 'Margrethe II', 917, 'GL'),
	('GLP', 'Guadeloupe', 'North America', 'Caribbean', 1705.00, NULL, 456000, 77.0, 3501.00, NULL, 'Guadeloupe', 'Overseas Department of France', 'Jacques Chirac', 919, 'GP'),
	('GUM', 'Guam', 'Oceania', 'Micronesia', 549.00, NULL, 168000, 77.8, 1197.00, 1136.00, 'Guam', 'US Territory', 'George W. Bush', 921, 'GU'),
	('GTM', 'Guatemala', 'North America', 'Central America', 108889.00, 1821, 11385000, 66.2, 19008.00, 17797.00, 'Guatemala', 'Republic', 'Alfonso Portillo Cabrera', 922, 'GT'),
	('GIN', 'Guinea', 'Africa', 'Western Africa', 245857.00, 1958, 7430000, 45.6, 2352.00, 2383.00, 'GuinÃƒÂ©e', 'Republic', 'Lansana ContÃƒÂ©', 926, 'GN'),
	('GNB', 'Guinea-Bissau', 'Africa', 'Western Africa', 36125.00, 1974, 1213000, 49.0, 293.00, 272.00, 'GuinÃƒÂ©-Bissau', 'Republic', 'Kumba IalÃƒÂ¡', 927, 'GW'),
	('GUY', 'Guyana', 'South America', 'South America', 214969.00, 1966, 861000, 64.0, 722.00, 743.00, 'Guyana', 'Republic', 'Bharrat Jagdeo', 928, 'GY'),
	('HTI', 'Haiti', 'North America', 'Caribbean', 27750.00, 1804, 8222000, 49.2, 3459.00, 3107.00, 'HaÃƒÂ¯ti/Dayti', 'Republic', 'Jean-Bertrand Aristide', 929, 'HT'),
	('HND', 'Honduras', 'North America', 'Central America', 112088.00, 1838, 6485000, 69.9, 5333.00, 4697.00, 'Honduras', 'Republic', 'Carlos Roberto Flores FacussÃƒÂ©', 933, 'HN'),
	('HKG', 'Hong Kong', 'Asia', 'Eastern Asia', 1075.00, NULL, 6782000, 79.5, 166448.00, 173610.00, 'Xianggang/Hong Kong', 'Special Administrative Region of China', 'Jiang Zemin', 937, 'HK'),
	('SJM', 'Svalbard and Jan Mayen', 'Europe', 'Nordic Countries', 62422.00, NULL, 3200, NULL, 0.00, NULL, 'Svalbard og Jan Mayen', 'Dependent Territory of Norway', 'Harald V', 938, 'SJ'),
	('IDN', 'Indonesia', 'Asia', 'Southeast Asia', 1904569.00, 1945, 212107000, 68.0, 84982.00, 215002.00, 'Indonesia', 'Republic', 'Abdurrahman Wahid', 939, 'ID'),
	('IND', 'India', 'Asia', 'Southern and Central Asia', 3287263.00, 1947, 1013662000, 62.5, 447114.00, 430572.00, 'Bharat/India', 'Federal Republic', 'Kocheril Raman Narayanan', 1109, 'IN'),
	('IRQ', 'Iraq', 'Asia', 'Middle East', 438317.00, 1932, 23115000, 66.5, 11500.00, NULL, 'Al-Ã‚Â´Iraq', 'Republic', 'Saddam Hussein al-Takriti', 1365, 'IQ'),
	('IRN', 'Iran', 'Asia', 'Southern and Central Asia', 1648195.00, 1906, 67702000, 69.7, 195746.00, 160151.00, 'Iran', 'Islamic Republic', 'Ali Mohammad Khatami-Ardakani', 1380, 'IR'),
	('IRL', 'Ireland', 'Europe', 'British Islands', 70273.00, 1921, 3775100, 76.8, 75921.00, 73132.00, 'Ireland/Ãƒâ€°ire', 'Republic', 'Mary McAleese', 1447, 'IE'),
	('ISL', 'Iceland', 'Europe', 'Nordic Countries', 103000.00, 1944, 279000, 79.4, 8255.00, 7474.00, 'ÃƒÂsland', 'Republic', 'Ãƒâ€œlafur Ragnar GrÃƒÂ­msson', 1449, 'IS'),
	('ISR', 'Israel', 'Asia', 'Middle East', 21056.00, 1948, 6217000, 78.6, 97477.00, 98577.00, 'YisraÃ¢â‚¬â„¢el/IsraÃ¢â‚¬â„¢il', 'Republic', 'Moshe Katzav', 1450, 'IL'),
	('ITA', 'Italy', 'Europe', 'Southern Europe', 301316.00, 1861, 57680000, 79.0, 1161755.00, 1145372.00, 'Italia', 'Republic', 'Carlo Azeglio Ciampi', 1464, 'IT'),
	('TMP', 'East Timor', 'Asia', 'Southeast Asia', 14874.00, NULL, 885000, 46.0, 0.00, NULL, 'Timor Timur', 'Administrated by the UN', 'JosÃƒÂ© Alexandre GusmÃƒÂ£o', 1522, 'TP'),
	('AUT', 'Austria', 'Europe', 'Western Europe', 83859.00, 1918, 8091800, 77.7, 211860.00, 206025.00, 'Ãƒâ€“sterreich', 'Federal Republic', 'Thomas Klestil', 1523, 'AT'),
	('JAM', 'Jamaica', 'North America', 'Caribbean', 10990.00, 1962, 2583000, 75.2, 6871.00, 6722.00, 'Jamaica', 'Constitutional Monarchy', 'Elisabeth II', 1530, 'JM'),
	('JPN', 'Japan', 'Asia', 'Eastern Asia', 377829.00, -660, 126714000, 80.7, 3787042.00, 4192638.00, 'Nihon/Nippon', 'Constitutional Monarchy', 'Akihito', 1532, 'JP'),
	('YEM', 'Yemen', 'Asia', 'Middle East', 527968.00, 1918, 18112000, 59.8, 6041.00, 5729.00, 'Al-Yaman', 'Republic', 'Ali Abdallah Salih', 1780, 'YE'),
	('JOR', 'Jordan', 'Asia', 'Middle East', 88946.00, 1946, 5083000, 77.4, 7526.00, 7051.00, 'Al-Urdunn', 'Constitutional Monarchy', 'Abdullah II', 1786, 'JO'),
	('CXR', 'Christmas Island', 'Oceania', 'Australia and New Zealand', 135.00, NULL, 2500, NULL, 0.00, NULL, 'Christmas Island', 'Territory of Australia', 'Elisabeth II', 1791, 'CX'),
	('YUG', 'Yugoslavia', 'Europe', 'Southern Europe', 102173.00, 1918, 10640000, 72.4, 17000.00, NULL, 'Jugoslavija', 'Federal Republic', 'Vojislav KoÃ…Â¡tunica', 1792, 'YU'),
	('KHM', 'Cambodia', 'Asia', 'Southeast Asia', 181035.00, 1953, 11168000, 56.5, 5121.00, 5670.00, 'KÃƒÂ¢mpuchÃƒÂ©a', 'Constitutional Monarchy', 'Norodom Sihanouk', 1800, 'KH'),
	('CMR', 'Cameroon', 'Africa', 'Central Africa', 475442.00, 1960, 15085000, 54.8, 9174.00, 8596.00, 'Cameroun/Cameroon', 'Republic', 'Paul Biya', 1804, 'CM'),
	('CAN', 'Canada', 'North America', 'North America', 9970610.00, 1867, 31147000, 79.4, 598862.00, 625626.00, 'Canada', 'Constitutional Monarchy, Federation', 'Elisabeth II', 1822, 'CA'),
	('CPV', 'Cape Verde', 'Africa', 'Western Africa', 4033.00, 1975, 428000, 68.9, 435.00, 420.00, 'Cabo Verde', 'Republic', 'AntÃƒÂ³nio Mascarenhas Monteiro', 1859, 'CV'),
	('KAZ', 'Kazakstan', 'Asia', 'Southern and Central Asia', 2724900.00, 1991, 16223000, 63.2, 24375.00, 23383.00, 'Qazaqstan', 'Republic', 'Nursultan Nazarbajev', 1864, 'KZ'),
	('KEN', 'Kenya', 'Africa', 'Eastern Africa', 580367.00, 1963, 30080000, 48.0, 9217.00, 10241.00, 'Kenya', 'Republic', 'Daniel arap Moi', 1881, 'KE'),
	('CAF', 'Central African Republic', 'Africa', 'Central Africa', 622984.00, 1960, 3615000, 44.0, 1054.00, 993.00, 'Centrafrique/BÃƒÂª-AfrÃƒÂ®ka', 'Republic', 'Ange-FÃƒÂ©lix PatassÃƒÂ©', 1889, 'CF'),
	('CHN', 'China', 'Asia', 'Eastern Asia', 9572900.00, -1523, 1277558000, 71.4, 982268.00, 917719.00, 'Zhongquo', 'People\'sRepublic', 'Jiang Zemin', 1891, 'CN'),
	('KGZ', 'Kyrgyzstan', 'Asia', 'Southern and Central Asia', 199900.00, 1991, 4699000, 63.4, 1626.00, 1767.00, 'Kyrgyzstan', 'Republic', 'Askar Akajev', 2253, 'KG'),
	('KIR', 'Kiribati', 'Oceania', 'Micronesia', 726.00, 1979, 83000, 59.8, 40.70, NULL, 'Kiribati', 'Republic', 'Teburoro Tito', 2256, 'KI'),
	('COL', 'Colombia', 'South America', 'South America', 1138914.00, 1810, 42321000, 70.3, 102896.00, 105116.00, 'Colombia', 'Republic', 'AndrÃƒÂ©s Pastrana Arango', 2257, 'CO'),
	('COM', 'Comoros', 'Africa', 'Eastern Africa', 1862.00, 1975, 578000, 60.0, 4401.00, 4361.00, 'Komori/Comores', 'Republic', 'Azali Assoumani', 2295, 'KM'),
	('COG', 'Congo', 'Africa', 'Central Africa', 342000.00, 1960, 2943000, 47.4, 2108.00, 2287.00, 'Congo', 'Republic', 'Denis Sassou-Nguesso', 2296, 'CG'),
	('COD', 'Congo, The Democratic Republic of the', 'Africa', 'Central Africa', 2344858.00, 1960, 51654000, 48.8, 6964.00, 2474.00, 'RÃƒÂ©publique DÃƒÂ©mocratique du Congo', 'Republic', 'Joseph Kabila', 2298, 'CD'),
	('CCK', 'Cocos (Keeling) Islands', 'Oceania', 'Australia and New Zealand', 14.00, NULL, 600, NULL, 0.00, NULL, 'Cocos (Keeling) Islands', 'Territory of Australia', 'Elisabeth II', 2317, 'CC'),
	('PRK', 'North Korea', 'Asia', 'Eastern Asia', 120538.00, 1948, 24039000, 70.7, 5332.00, NULL, 'Choson Minjujuui InÃ‚Â´min Konghwaguk (Bukhan', 'Socialistic Republic', 'Kim Jong-il', 2318, 'KP'),
	('KOR', 'South Korea', 'Asia', 'Eastern Asia', 99434.00, 1948, 46844000, 74.4, 320749.00, 442544.00, 'Taehan MinÃ¢â‚¬â„¢guk (Namhan)', 'Republic', 'Kim Dae-jung', 2331, 'KR'),
	('GRC', 'Greece', 'Europe', 'Southern Europe', 131626.00, 1830, 10545700, 78.4, 120724.00, 119946.00, 'EllÃƒÂ¡da', 'Republic', 'Kostis Stefanopoulos', 2401, 'GR'),
	('HRV', 'Croatia', 'Europe', 'Southern Europe', 56538.00, 1991, 4473000, 73.7, 20208.00, 19300.00, 'Hrvatska', 'Republic', 'Ã…Â tipe Mesic', 2409, 'HR'),
	('CUB', 'Cuba', 'North America', 'Caribbean', 110861.00, 1902, 11201000, 76.2, 17843.00, 18862.00, 'Cuba', 'Socialistic Republic', 'Fidel Castro Ruz', 2413, 'CU'),
	('KWT', 'Kuwait', 'Asia', 'Middle East', 17818.00, 1961, 1972000, 76.1, 27037.00, 30373.00, 'Al-Kuwayt', 'Constitutional Monarchy (Emirate)', 'Jabir al-Ahmad al-Jabir al-Sabah', 2429, 'KW'),
	('CYP', 'Cyprus', 'Asia', 'Middle East', 9251.00, 1960, 754700, 76.7, 9333.00, 8246.00, 'KÃƒÂ½pros/Kibris', 'Republic', 'Glafkos Klerides', 2430, 'CY'),
	('LAO', 'Laos', 'Asia', 'Southeast Asia', 236800.00, 1953, 5433000, 53.1, 1292.00, 1746.00, 'Lao', 'Republic', 'Khamtay Siphandone', 2432, 'LA'),
	('LVA', 'Latvia', 'Europe', 'Baltic Countries', 64589.00, 1991, 2424200, 68.4, 6398.00, 5639.00, 'Latvija', 'Republic', 'Vaira Vike-Freiberga', 2434, 'LV'),
	('LSO', 'Lesotho', 'Africa', 'Southern Africa', 30355.00, 1966, 2153000, 50.8, 1061.00, 1161.00, 'Lesotho', 'Constitutional Monarchy', 'Letsie III', 2437, 'LS'),
	('LBN', 'Lebanon', 'Asia', 'Middle East', 10400.00, 1941, 3282000, 71.3, 17121.00, 15129.00, 'Lubnan', 'Republic', 'Ãƒâ€°mile Lahoud', 2438, 'LB'),
	('LBR', 'Liberia', 'Africa', 'Western Africa', 111369.00, 1847, 3154000, 51.0, 2012.00, NULL, 'Liberia', 'Republic', 'Charles Taylor', 2440, 'LR'),
	('LBY', 'Libyan Arab Jamahiriya', 'Africa', 'Northern Africa', 1759540.00, 1951, 5605000, 75.5, 44806.00, 40562.00, 'Libiya', 'Socialistic State', 'Muammar al-Qadhafi', 2441, 'LY'),
	('LIE', 'Liechtenstein', 'Europe', 'Western Europe', 160.00, 1806, 32300, 78.8, 1119.00, 1084.00, 'Liechtenstein', 'Constitutional Monarchy', 'Hans-Adam II', 2446, 'LI'),
	('LTU', 'Lithuania', 'Europe', 'Baltic Countries', 65301.00, 1991, 3698500, 69.1, 10692.00, 9585.00, 'Lietuva', 'Republic', 'Valdas Adamkus', 2447, 'LT'),
	('LUX', 'Luxembourg', 'Europe', 'Western Europe', 2586.00, 1867, 435700, 77.1, 16321.00, 15519.00, 'Luxembourg/LÃƒÂ«tzebuerg', 'Constitutional Monarchy', 'Henri', 2452, 'LU'),
	('ESH', 'Western Sahara', 'Africa', 'Northern Africa', 266000.00, NULL, 293000, 49.8, 60.00, NULL, 'As-Sahrawiya', 'Occupied by Marocco', 'Mohammed Abdel Aziz', 2453, 'EH'),
	('MAC', 'Macao', 'Asia', 'Eastern Asia', 18.00, NULL, 473000, 81.6, 5749.00, 5940.00, 'Macau/Aomen', 'Special Administrative Region of China', 'Jiang Zemin', 2454, 'MO'),
	('MDG', 'Madagascar', 'Africa', 'Eastern Africa', 587041.00, 1960, 15942000, 55.0, 3750.00, 3545.00, 'Madagasikara/Madagascar', 'Federal Republic', 'Didier Ratsiraka', 2455, 'MG'),
	('MKD', 'Macedonia', 'Europe', 'Southern Europe', 25713.00, 1991, 2024000, 73.8, 1694.00, 1915.00, 'Makedonija', 'Republic', 'Boris Trajkovski', 2460, 'MK'),
	('MWI', 'Malawi', 'Africa', 'Eastern Africa', 118484.00, 1964, 10925000, 37.6, 1687.00, 2527.00, 'Malawi', 'Republic', 'Bakili Muluzi', 2462, 'MW'),
	('MDV', 'Maldives', 'Asia', 'Southern and Central Asia', 298.00, 1965, 286000, 62.2, 199.00, NULL, 'Dhivehi Raajje/Maldives', 'Republic', 'Maumoon Abdul Gayoom', 2463, 'MV'),
	('MYS', 'Malaysia', 'Asia', 'Southeast Asia', 329758.00, 1957, 22244000, 70.8, 69213.00, 97884.00, 'Malaysia', 'Constitutional Monarchy, Federation', 'Salahuddin Abdul Aziz Shah Alhaj', 2464, 'MY'),
	('MLI', 'Mali', 'Africa', 'Western Africa', 1240192.00, 1960, 11234000, 46.7, 2642.00, 2453.00, 'Mali', 'Republic', 'Alpha Oumar KonarÃƒÂ©', 2482, 'ML'),
	('MLT', 'Malta', 'Europe', 'Southern Europe', 316.00, 1964, 380200, 77.9, 3512.00, 3338.00, 'Malta', 'Republic', 'Guido de Marco', 2484, 'MT'),
	('MAR', 'Morocco', 'Africa', 'Northern Africa', 446550.00, 1956, 28351000, 69.1, 36124.00, 33514.00, 'Al-Maghrib', 'Constitutional Monarchy', 'Mohammed VI', 2486, 'MA'),
	('MHL', 'Marshall Islands', 'Oceania', 'Micronesia', 181.00, 1990, 64000, 65.5, 97.00, NULL, 'Marshall Islands/Majol', 'Republic', 'Kessai Note', 2507, 'MH'),
	('MTQ', 'Martinique', 'North America', 'Caribbean', 1102.00, NULL, 395000, 78.3, 2731.00, 2559.00, 'Martinique', 'Overseas Department of France', 'Jacques Chirac', 2508, 'MQ'),
	('MRT', 'Mauritania', 'Africa', 'Western Africa', 1025520.00, 1960, 2670000, 50.8, 998.00, 1081.00, 'Muritaniya/Mauritanie', 'Republic', 'Maaouiya Ould SidÃ‚Â´Ahmad Taya', 2509, 'MR'),
	('MUS', 'Mauritius', 'Africa', 'Eastern Africa', 2040.00, 1968, 1158000, 71.0, 4251.00, 4186.00, 'Mauritius', 'Republic', 'Cassam Uteem', 2511, 'MU'),
	('MYT', 'Mayotte', 'Africa', 'Eastern Africa', 373.00, NULL, 149000, 59.5, 0.00, NULL, 'Mayotte', 'Territorial Collectivity of France', 'Jacques Chirac', 2514, 'YT'),
	('MEX', 'Mexico', 'North America', 'Central America', 1958201.00, 1810, 98881000, 71.5, 414972.00, 401461.00, 'MÃƒÂ©xico', 'Federal Republic', 'Vicente Fox Quesada', 2515, 'MX'),
	('FSM', 'Micronesia, Federated States of', 'Oceania', 'Micronesia', 702.00, 1990, 119000, 68.6, 212.00, NULL, 'Micronesia', 'Federal Republic', 'Leo A. Falcam', 2689, 'FM'),
	('MDA', 'Moldova', 'Europe', 'Eastern Europe', 33851.00, 1991, 4380000, 64.5, 1579.00, 1872.00, 'Moldova', 'Republic', 'Vladimir Voronin', 2690, 'MD'),
	('MCO', 'Monaco', 'Europe', 'Western Europe', 1.50, 1861, 34000, 78.8, 776.00, NULL, 'Monaco', 'Constitutional Monarchy', 'Rainier III', 2695, 'MC'),
	('MNG', 'Mongolia', 'Asia', 'Eastern Asia', 1566500.00, 1921, 2662000, 67.3, 1043.00, 933.00, 'Mongol Uls', 'Republic', 'Natsagiin Bagabandi', 2696, 'MN'),
	('MSR', 'Montserrat', 'North America', 'Caribbean', 102.00, NULL, 11000, 78.0, 109.00, NULL, 'Montserrat', 'Dependent Territory of the UK', 'Elisabeth II', 2697, 'MS'),
	('MOZ', 'Mozambique', 'Africa', 'Eastern Africa', 801590.00, 1975, 19680000, 37.5, 2891.00, 2711.00, 'MoÃƒÂ§ambique', 'Republic', 'JoaquÃƒÂ­m A. Chissano', 2698, 'MZ'),
	('MMR', 'Myanmar', 'Asia', 'Southeast Asia', 676578.00, 1948, 45611000, 54.9, 180375.00, 171028.00, 'Myanma Pye', 'Republic', 'kenraali Than Shwe', 2710, 'MM'),
	('NAM', 'Namibia', 'Africa', 'Southern Africa', 824292.00, 1990, 1726000, 42.5, 3101.00, 3384.00, 'Namibia', 'Republic', 'Sam Nujoma', 2726, 'NA'),
	('NRU', 'Nauru', 'Oceania', 'Micronesia', 21.00, 1968, 12000, 60.8, 197.00, NULL, 'Naoero/Nauru', 'Republic', 'Bernard Dowiyogo', 2728, 'NR'),
	('NPL', 'Nepal', 'Asia', 'Southern and Central Asia', 147181.00, 1769, 23930000, 57.8, 4768.00, 4837.00, 'Nepal', 'Constitutional Monarchy', 'Gyanendra Bir Bikram', 2729, 'NP'),
	('NIC', 'Nicaragua', 'North America', 'Central America', 130000.00, 1838, 5074000, 68.7, 1988.00, 2023.00, 'Nicaragua', 'Republic', 'Arnoldo AlemÃƒÂ¡n Lacayo', 2734, 'NI'),
	('NER', 'Niger', 'Africa', 'Western Africa', 1267000.00, 1960, 10730000, 41.3, 1706.00, 1580.00, 'Niger', 'Republic', 'Mamadou Tandja', 2738, 'NE'),
	('NGA', 'Nigeria', 'Africa', 'Western Africa', 923768.00, 1960, 111506000, 51.6, 65707.00, 58623.00, 'Nigeria', 'Federal Republic', 'Olusegun Obasanjo', 2754, 'NG'),
	('NIU', 'Niue', 'Oceania', 'Polynesia', 260.00, NULL, 2000, NULL, 0.00, NULL, 'Niue', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 2805, 'NU'),
	('NFK', 'Norfolk Island', 'Oceania', 'Australia and New Zealand', 36.00, NULL, 2000, NULL, 0.00, NULL, 'Norfolk Island', 'Territory of Australia', 'Elisabeth II', 2806, 'NF'),
	('NOR', 'Norway', 'Europe', 'Nordic Countries', 323877.00, 1905, 4478500, 78.7, 145895.00, 153370.00, 'Norge', 'Constitutional Monarchy', 'Harald V', 2807, 'NO'),
	('CIV', 'CÃƒÂ´te dÃ¢â‚¬â„¢Ivoire', 'Africa', 'Western Africa', 322463.00, 1960, 14786000, 45.2, 11345.00, 10285.00, 'CÃƒÂ´te dÃ¢â‚¬â„¢Ivoire', 'Republic', 'Laurent Gbagbo', 2814, 'CI'),
	('OMN', 'Oman', 'Asia', 'Middle East', 309500.00, 1951, 2542000, 71.8, 16904.00, 16153.00, 'Ã‚Â´Uman', 'Monarchy (Sultanate)', 'Qabus ibn SaÃ‚Â´id', 2821, 'OM'),
	('PAK', 'Pakistan', 'Asia', 'Southern and Central Asia', 796095.00, 1947, 156483000, 61.1, 61289.00, 58549.00, 'Pakistan', 'Republic', 'Mohammad Rafiq Tarar', 2831, 'PK'),
	('PLW', 'Palau', 'Oceania', 'Micronesia', 459.00, 1994, 19000, 68.6, 105.00, NULL, 'Belau/Palau', 'Republic', 'Kuniwo Nakamura', 2881, 'PW'),
	('PAN', 'Panama', 'North America', 'Central America', 75517.00, 1903, 2856000, 75.5, 9131.00, 8700.00, 'PanamÃƒÂ¡', 'Republic', 'Mireya Elisa Moscoso RodrÃƒÂ­guez', 2882, 'PA'),
	('PNG', 'Papua New Guinea', 'Oceania', 'Melanesia', 462840.00, 1975, 4807000, 63.1, 4988.00, 6328.00, 'Papua New Guinea/Papua Niugini', 'Constitutional Monarchy', 'Elisabeth II', 2884, 'PG'),
	('PRY', 'Paraguay', 'South America', 'South America', 406752.00, 1811, 5496000, 73.7, 8444.00, 9555.00, 'Paraguay', 'Republic', 'Luis ÃƒÂngel GonzÃƒÂ¡lez Macchi', 2885, 'PY'),
	('PER', 'Peru', 'South America', 'South America', 1285216.00, 1821, 25662000, 70.0, 64140.00, 65186.00, 'PerÃƒÂº/Piruw', 'Republic', 'Valentin Paniagua Corazao', 2890, 'PE'),
	('PCN', 'Pitcairn', 'Oceania', 'Polynesia', 49.00, NULL, 50, NULL, 0.00, NULL, 'Pitcairn', 'Dependent Territory of the UK', 'Elisabeth II', 2912, 'PN'),
	('MNP', 'Northern Mariana Islands', 'Oceania', 'Micronesia', 464.00, NULL, 78000, 75.5, 0.00, NULL, 'Northern Mariana Islands', 'Commonwealth of the US', 'George W. Bush', 2913, 'MP'),
	('PRT', 'Portugal', 'Europe', 'Southern Europe', 91982.00, 1143, 9997600, 75.8, 105954.00, 102133.00, 'Portugal', 'Republic', 'Jorge SampÃƒÂ£io', 2914, 'PT'),
	('PRI', 'Puerto Rico', 'North America', 'Caribbean', 8875.00, NULL, 3869000, 75.6, 34100.00, 32100.00, 'Puerto Rico', 'Commonwealth of the US', 'George W. Bush', 2919, 'PR'),
	('POL', 'Poland', 'Europe', 'Eastern Europe', 323250.00, 1918, 38653600, 73.2, 151697.00, 135636.00, 'Polska', 'Republic', 'Aleksander Kwasniewski', 2928, 'PL'),
	('GNQ', 'Equatorial Guinea', 'Africa', 'Central Africa', 28051.00, 1968, 453000, 53.6, 283.00, 542.00, 'Guinea Ecuatorial', 'Republic', 'Teodoro Obiang Nguema Mbasogo', 2972, 'GQ'),
	('QAT', 'Qatar', 'Asia', 'Middle East', 11000.00, 1971, 599000, 72.4, 9472.00, 8920.00, 'Qatar', 'Monarchy', 'Hamad ibn Khalifa al-Thani', 2973, 'QA'),
	('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 843, 59225700, 78.8, 1424285.00, 1392448.00, 'France', 'Republic', 'Jacques Chirac', 2974, 'FR'),
	('GUF', 'French Guiana', 'South America', 'South America', 90000.00, NULL, 181000, 76.1, 681.00, NULL, 'Guyane franÃƒÂ§aise', 'Overseas Department of France', 'Jacques Chirac', 3014, 'GF'),
	('PYF', 'French Polynesia', 'Oceania', 'Polynesia', 4000.00, NULL, 235000, 74.8, 818.00, 781.00, 'PolynÃƒÂ©sie franÃƒÂ§aise', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3016, 'PF'),
	('REU', 'RÃƒÂ©union', 'Africa', 'Eastern Africa', 2510.00, NULL, 699000, 72.7, 8287.00, 7988.00, 'RÃƒÂ©union', 'Overseas Department of France', 'Jacques Chirac', 3017, 'RE'),
	('ROM', 'Romania', 'Europe', 'Eastern Europe', 238391.00, 1878, 22455500, 69.9, 38158.00, 34843.00, 'RomÃƒÂ¢nia', 'Republic', 'Ion Iliescu', 3018, 'RO'),
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
	('STP', 'Sao Tome and Principe', 'Africa', 'Central Africa', 964.00, 1975, 147000, 65.3, 6.00, NULL, 'SÃƒÂ£o TomÃƒÂ© e PrÃƒÂ­ncipe', 'Republic', 'Miguel Trovoada', 3172, 'ST'),
	('SAU', 'Saudi Arabia', 'Asia', 'Middle East', 2149690.00, 1932, 21607000, 67.8, 137635.00, 146171.00, 'Al-Ã‚Â´Arabiya as-SaÃ‚Â´udiya', 'Monarchy', 'Fahd ibn Abdul-Aziz al-SaÃ‚Â´ud', 3173, 'SA'),
	('SEN', 'Senegal', 'Africa', 'Western Africa', 196722.00, 1960, 9481000, 62.2, 4787.00, 4542.00, 'SÃƒÂ©nÃƒÂ©gal/Sounougal', 'Republic', 'Abdoulaye Wade', 3198, 'SN'),
	('SYC', 'Seychelles', 'Africa', 'Eastern Africa', 455.00, 1976, 77000, 70.4, 536.00, 539.00, 'Sesel/Seychelles', 'Republic', 'France-Albert RenÃƒÂ©', 3206, 'SC'),
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
	('TJK', 'Tajikistan', 'Asia', 'Southern and Central Asia', 143100.00, 1991, 6188000, 64.1, 1990.00, 1056.00, 'ToÃƒÂ§ikiston', 'Republic', 'Emomali Rahmonov', 3261, 'TJ'),
	('TWN', 'Taiwan', 'Asia', 'Eastern Asia', 36188.00, 1945, 22256000, 76.4, 256254.00, 263451.00, 'TÃ¢â‚¬â„¢ai-wan', 'Republic', 'Chen Shui-bian', 3263, 'TW'),
	('TZA', 'Tanzania', 'Africa', 'Eastern Africa', 883749.00, 1961, 33517000, 52.3, 8005.00, 7388.00, 'Tanzania', 'Republic', 'Benjamin William Mkapa', 3306, 'TZ'),
	('DNK', 'Denmark', 'Europe', 'Nordic Countries', 43094.00, 800, 5330000, 76.5, 174099.00, 169264.00, 'Danmark', 'Constitutional Monarchy', 'Margrethe II', 3315, 'DK'),
	('THA', 'Thailand', 'Asia', 'Southeast Asia', 513115.00, 1350, 61399000, 68.6, 116416.00, 153907.00, 'Prathet Thai', 'Constitutional Monarchy', 'Bhumibol Adulyadej', 3320, 'TH'),
	('TGO', 'Togo', 'Africa', 'Western Africa', 56785.00, 1960, 4629000, 54.7, 1449.00, 1400.00, 'Togo', 'Republic', 'GnassingbÃƒÂ© EyadÃƒÂ©ma', 3332, 'TG'),
	('TKL', 'Tokelau', 'Oceania', 'Polynesia', 12.00, NULL, 2000, NULL, 0.00, NULL, 'Tokelau', 'Nonmetropolitan Territory of New Zealand', 'Elisabeth II', 3333, 'TK'),
	('TON', 'Tonga', 'Oceania', 'Polynesia', 650.00, 1970, 99000, 67.9, 146.00, 170.00, 'Tonga', 'Monarchy', 'Taufa\'ahau Tupou IV', 3334, 'TO'),
	('TTO', 'Trinidad and Tobago', 'North America', 'Caribbean', 5130.00, 1962, 1295000, 68.0, 6232.00, 5867.00, 'Trinidad and Tobago', 'Republic', 'Arthur N. R. Robinson', 3336, 'TT'),
	('TCD', 'Chad', 'Africa', 'Central Africa', 1284000.00, 1960, 7651000, 50.5, 1208.00, 1102.00, 'Tchad/Tshad', 'Republic', 'Idriss DÃƒÂ©by', 3337, 'TD'),
	('CZE', 'Czech Republic', 'Europe', 'Eastern Europe', 78866.00, 1993, 10278100, 74.5, 55017.00, 52037.00, 'Ã‚Â¸esko', 'Republic', 'VÃƒÂ¡clav Havel', 3339, 'CZ'),
	('TUN', 'Tunisia', 'Africa', 'Northern Africa', 163610.00, 1956, 9586000, 73.7, 20026.00, 18898.00, 'Tunis/Tunisie', 'Republic', 'Zine al-Abidine Ben Ali', 3349, 'TN'),
	('TUR', 'Turkey', 'Asia', 'Middle East', 774815.00, 1923, 66591000, 71.0, 210721.00, 189122.00, 'TÃƒÂ¼rkiye', 'Republic', 'Ahmet Necdet Sezer', 3358, 'TR'),
	('TKM', 'Turkmenistan', 'Asia', 'Southern and Central Asia', 488100.00, 1991, 4459000, 60.9, 4397.00, 2000.00, 'TÃƒÂ¼rkmenostan', 'Republic', 'Saparmurad Nijazov', 3419, 'TM'),
	('TCA', 'Turks and Caicos Islands', 'North America', 'Caribbean', 430.00, NULL, 17000, 73.3, 96.00, NULL, 'The Turks and Caicos Islands', 'Dependent Territory of the UK', 'Elisabeth II', 3423, 'TC'),
	('TUV', 'Tuvalu', 'Oceania', 'Polynesia', 26.00, 1978, 12000, 66.3, 6.00, NULL, 'Tuvalu', 'Constitutional Monarchy', 'Elisabeth II', 3424, 'TV'),
	('UGA', 'Uganda', 'Africa', 'Eastern Africa', 241038.00, 1962, 21778000, 42.9, 6313.00, 6887.00, 'Uganda', 'Republic', 'Yoweri Museveni', 3425, 'UG'),
	('UKR', 'Ukraine', 'Europe', 'Eastern Europe', 603700.00, 1991, 50456000, 66.0, 42168.00, 49677.00, 'Ukrajina', 'Republic', 'Leonid KutÃ…Â¡ma', 3426, 'UA'),
	('HUN', 'Hungary', 'Europe', 'Eastern Europe', 93030.00, 1918, 10043200, 71.4, 48267.00, 45914.00, 'MagyarorszÃƒÂ¡g', 'Republic', 'Ferenc MÃƒÂ¡dl', 3483, 'HU'),
	('URY', 'Uruguay', 'South America', 'South America', 175016.00, 1828, 3337000, 75.2, 20831.00, 19967.00, 'Uruguay', 'Republic', 'Jorge Batlle IbÃƒÂ¡ÃƒÂ±ez', 3492, 'UY'),
	('NCL', 'New Caledonia', 'Oceania', 'Melanesia', 18575.00, NULL, 214000, 72.8, 3563.00, NULL, 'Nouvelle-CalÃƒÂ©donie', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3493, 'NC'),
	('NZL', 'New Zealand', 'Oceania', 'Australia and New Zealand', 270534.00, 1907, 3862000, 77.8, 54669.00, 64960.00, 'New Zealand/Aotearoa', 'Constitutional Monarchy', 'Elisabeth II', 3499, 'NZ'),
	('UZB', 'Uzbekistan', 'Asia', 'Southern and Central Asia', 447400.00, 1991, 24318000, 63.7, 14194.00, 21300.00, 'Uzbekiston', 'Republic', 'Islam Karimov', 3503, 'UZ'),
	('BLR', 'Belarus', 'Europe', 'Eastern Europe', 207600.00, 1991, 10236000, 68.0, 13714.00, NULL, 'Belarus', 'Republic', 'Aljaksandr LukaÃ…Â¡enka', 3520, 'BY'),
	('WLF', 'Wallis and Futuna', 'Oceania', 'Polynesia', 200.00, NULL, 15000, NULL, 0.00, NULL, 'Wallis-et-Futuna', 'Nonmetropolitan Territory of France', 'Jacques Chirac', 3536, 'WF'),
	('VUT', 'Vanuatu', 'Oceania', 'Melanesia', 12189.00, 1980, 190000, 60.6, 261.00, 246.00, 'Vanuatu', 'Republic', 'John Bani', 3537, 'VU'),
	('VAT', 'Holy See (Vatican City State)', 'Europe', 'Southern Europe', 0.40, 1929, 1000, NULL, 9.00, NULL, 'Santa Sede/CittÃƒÂ  del Vaticano', 'Independent Church State', 'Johannes Paavali II', 3538, 'VA'),
	('VEN', 'Venezuela', 'South America', 'South America', 912050.00, 1811, 24170000, 73.1, 95023.00, 88434.00, 'Venezuela', 'Federal Republic', 'Hugo ChÃƒÂ¡vez FrÃƒÂ­as', 3539, 'VE'),
	('RUS', 'Russian Federation', 'Europe', 'Eastern Europe', 17075400.00, 1991, 146934000, 67.2, 276608.00, 442989.00, 'Rossija', 'Federal Republic', 'Vladimir Putin', 3580, 'RU'),
	('VNM', 'Vietnam', 'Asia', 'Southeast Asia', 331689.00, 1945, 79832000, 69.3, 21929.00, 22834.00, 'ViÃƒÂªt Nam', 'Socialistic Republic', 'TrÃƒÂ¢n Duc Luong', 3770, 'VN'),
	('EST', 'Estonia', 'Europe', 'Baltic Countries', 45227.00, 1991, 1439200, 69.5, 5328.00, 3371.00, 'Eesti', 'Republic', 'Lennart Meri', 3791, 'EE'),
	('USA', 'United States', 'North America', 'North America', 9363520.00, 1776, 278357000, 77.1, 8510700.00, 8110900.00, 'United States', 'Federal Republic', 'George W. Bush', 3813, 'US'),
	('VIR', 'Virgin Islands, U.S.', 'North America', 'Caribbean', 347.00, NULL, 93000, 78.1, 0.00, NULL, 'Virgin Islands of the United States', 'US Territory', 'George W. Bush', 4067, 'VI'),
	('ZWE', 'Zimbabwe', 'Africa', 'Eastern Africa', 390757.00, 1980, 11669000, 37.8, 5951.00, 8670.00, 'Zimbabwe', 'Republic', 'Robert G. Mugabe', 4068, 'ZW'),
	('PSE', 'Palestine', 'Asia', 'Middle East', 6257.00, NULL, 3101000, 71.4, 4173.00, NULL, 'Filastin', 'Autonomous Area', 'Yasser (Yasir) Arafat', 4074, 'PS'),
	('ATA', 'Antarctica', 'Antarctica', 'Antarctica', 13120000.00, NULL, 0, NULL, 0.00, NULL, 'Ã¢â‚¬â€œ', 'Co-administrated', '', NULL, 'AQ'),
	('BVT', 'Bouvet Island', 'Antarctica', 'Antarctica', 59.00, NULL, 0, NULL, 0.00, NULL, 'BouvetÃƒÂ¸ya', 'Dependent Territory of Norway', 'Harald V', NULL, 'BV'),
	('IOT', 'British Indian Ocean Territory', 'Africa', 'Eastern Africa', 78.00, NULL, 0, NULL, 0.00, NULL, 'British Indian Ocean Territory', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'IO'),
	('SGS', 'South Georgia and the South Sandwich Islands', 'Antarctica', 'Antarctica', 3903.00, NULL, 0, NULL, 0.00, NULL, 'South Georgia and the South Sandwich Islands', 'Dependent Territory of the UK', 'Elisabeth II', NULL, 'GS'),
	('HMD', 'Heard Island and McDonald Islands', 'Antarctica', 'Antarctica', 359.00, NULL, 0, NULL, 0.00, NULL, 'Heard and McDonald Islands', 'Territory of Australia', 'Elisabeth II', NULL, 'HM'),
	('ATF', 'French Southern territories', 'Antarctica', 'Antarctica', 7780.00, NULL, 0, NULL, 0.00, NULL, 'Terres australes franÃƒÂ§aises', 'Nonmetropolitan Territory of France', 'Jacques Chirac', NULL, 'TF'),
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
