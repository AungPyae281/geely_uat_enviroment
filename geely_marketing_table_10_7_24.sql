-- --------------------------------------------------------
-- Host:                         therestpos.com
-- Server version:               10.6.18-MariaDB-cll-lve - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table geely_db1.event
DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT '',
  `voucher_no` varchar(150) NOT NULL DEFAULT '',
  `date` varchar(10) NOT NULL DEFAULT '',
  `done` tinyint(4) NOT NULL DEFAULT 0,
  `entry_by` varchar(150) NOT NULL DEFAULT '',
  `entry_date_time` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table geely_db1.event_detail
DROP TABLE IF EXISTS `event_detail`;
CREATE TABLE IF NOT EXISTS `event_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `target` int(11) NOT NULL DEFAULT 0,
  `actual` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for procedure geely_db1.generateTargetPages
DROP PROCEDURE IF EXISTS `generateTargetPages`;
DELIMITER //
CREATE PROCEDURE `generateTargetPages`(
	IN `dd` VARCHAR(50)
)
BEGIN
	DECLARE StartDate VARCHAR(50);
	DECLARE EndDate VARCHAR(50);
	DECLARE CurrentDate VARCHAR(50);
	
	SELECT IFNULL(concat(MAX(`month`), '-01'), '2022-12-01') INTO StartDate FROM m_target_pages;
	
	SET EndDate = dd;
	SET CurrentDate = StartDate;
	
	IF DATE_FORMAT(CurrentDate, '%Y%m') < DATE_FORMAT(EndDate, '%Y%m') THEN
		loop_label:  LOOP
			IF DATE_FORMAT(CurrentDate, '%Y%m') >= DATE_FORMAT(EndDate, '%Y%m') THEN 
			   LEAVE  loop_label;
			END  IF;
			
			IF  DATE_FORMAT(CurrentDate, '%Y%m') < DATE_FORMAT(EndDate, '%Y%m') THEN
				SET CurrentDate = DATE_ADD(CurrentDate, INTERVAL 1 MONTH);

		   	INSERT INTO m_target_pages (`page_id`, `month`, p_like, p_reach, p_engagement, p_lead, p_booking) SELECT m_pages.id AS page_id,LEFT(CurrentDate, 7), 0 as p_like, 0 as p_reach, 0 as p_engagement, 0 as p_lead, 0 as p_booking FROM m_pages;
				
			END  IF;                                                          
		END LOOP;  
	END IF;                                                         
END//
DELIMITER ;

-- Dumping structure for table geely_db1.m_category
DROP TABLE IF EXISTS `m_category`;
CREATE TABLE IF NOT EXISTS `m_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geely_db1.m_category: ~2 rows (approximately)
INSERT INTO `m_category` (`id`, `category`) VALUES
	(3, 'Marketing Material'),
	(8, 'Marketing Merchandise'),
	(9, 'Marketing');

-- Dumping structure for table geely_db1.m_item
DROP TABLE IF EXISTS `m_item`;
CREATE TABLE IF NOT EXISTS `m_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(100) NOT NULL DEFAULT '',
  `item_name` varchar(250) NOT NULL DEFAULT '',
  `capital_price` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Dumping structure for table geely_db1.m_pages
DROP TABLE IF EXISTS `m_pages`;
CREATE TABLE IF NOT EXISTS `m_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table geely_db1.m_pages: ~3 rows (approximately)
INSERT INTO `m_pages` (`id`, `name`) VALUES
	(1, 'Geely'),
	(2, 'FAW'),
	(3, 'ZEEKR');

-- Dumping structure for table geely_db1.m_stock_balance
DROP TABLE IF EXISTS `m_stock_balance`;
CREATE TABLE IF NOT EXISTS `m_stock_balance` (
  `item_id` int(11) DEFAULT NULL,
  `store` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `total_stock` int(20) NOT NULL DEFAULT 0,
  `use` int(20) NOT NULL DEFAULT 0,
  `lost` int(20) NOT NULL DEFAULT 0,
  `damage` int(20) NOT NULL DEFAULT 0,
  `expire` int(20) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table geely_db1.m_stock_in
DROP TABLE IF EXISTS `m_stock_in`;
CREATE TABLE IF NOT EXISTS `m_stock_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_in_date` varchar(25) NOT NULL DEFAULT '',
  `store` varchar(150) NOT NULL DEFAULT '',
  `item_id` varchar(50) NOT NULL DEFAULT '',
  `item_name` varchar(250) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `capital_price` int(11) NOT NULL DEFAULT 0,
  `stock_in_by` varchar(250) NOT NULL,
  `stock_in_receive_by` varchar(250) NOT NULL,
  `entry_by` varchar(100) NOT NULL DEFAULT '',
  `entry_date_time` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table geely_db1.m_stock_out
DROP TABLE IF EXISTS `m_stock_out`;
CREATE TABLE IF NOT EXISTS `m_stock_out` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `stock_out_date` varchar(20) DEFAULT NULL,
  `store` varchar(225) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_name` varchar(250) DEFAULT NULL,
  `quantity` int(20) DEFAULT NULL,
  `use` int(20) NOT NULL DEFAULT 0,
  `lost` int(20) NOT NULL DEFAULT 0,
  `damage` int(20) NOT NULL DEFAULT 0,
  `expire` int(20) NOT NULL DEFAULT 0,
  `stock_out_by` varchar(250) DEFAULT NULL,
  `stock_out_receive_by` varchar(250) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `entry_by` varchar(250) DEFAULT NULL,
  `entry_date_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table geely_db1.m_target_by_month
DROP TABLE IF EXISTS `m_target_by_month`;
CREATE TABLE IF NOT EXISTS `m_target_by_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `month_from` varchar(50) NOT NULL DEFAULT '',
  `month_to` varchar(50) NOT NULL DEFAULT '0',
  `target_like` int(25) NOT NULL DEFAULT 0,
  `target_reach` int(25) NOT NULL DEFAULT 0,
  `target_engagement` int(25) NOT NULL DEFAULT 0,
  `target_booking` int(25) NOT NULL DEFAULT 0,
  `target_lead` int(25) NOT NULL DEFAULT 0,
  `entry_by` varchar(250) NOT NULL,
  `entry_date_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;


-- Dumping structure for table geely_db1.m_target_pages
DROP TABLE IF EXISTS `m_target_pages`;
CREATE TABLE IF NOT EXISTS `m_target_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `month` varchar(50) NOT NULL DEFAULT '',
  `p_like` int(25) NOT NULL DEFAULT 0,
  `p_reach` int(25) NOT NULL DEFAULT 0,
  `p_engagement` int(25) NOT NULL DEFAULT 0,
  `p_lead` int(25) NOT NULL DEFAULT 0,
  `p_booking` int(25) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- Dumping structure for table geely_db1.m_type
DROP TABLE IF EXISTS `m_type`;
CREATE TABLE IF NOT EXISTS `m_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geely_db1.m_type: ~4 rows (approximately)
INSERT INTO `m_type` (`id`, `type`) VALUES
	(8, 'GEELY'),
	(9, 'FAW'),
	(11, 'ZEEKR');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
