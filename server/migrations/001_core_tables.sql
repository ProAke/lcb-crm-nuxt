-- Migration 001: Core tables (tb_admin_user, tb_member, tb_promotion, tb_products, tb_brand, tb_category, tb_rich_menu, tb_rich_message, tb_booking, tb_booking_log, tb_manual, tb_QT)
-- Run this on fresh database to create all tables matching PHPWeb structure

-- tb_admin_user - Admin users with Argon2ID password support
CREATE TABLE IF NOT EXISTS `tb_admin_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(100) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL COMMENT 'Argon2ID hash, legacy MD5 auto-upgraded',
  `PIN` varchar(100) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `FULLNAME` varchar(255) DEFAULT NULL,
  `NICK_NAME` varchar(100) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `LINE_ID` varchar(100) DEFAULT NULL,
  `LINEKEY` varchar(255) DEFAULT NULL,
  `FACEBOOK` varchar(255) DEFAULT NULL,
  `PRIVILEGES` text DEFAULT NULL,
  `AVATAR` varchar(255) DEFAULT 'default_avatar.png',
  `TEAM` varchar(50) DEFAULT NULL,
  `GENDER` varchar(20) DEFAULT NULL,
  `LAST_LOGIN` datetime DEFAULT NULL,
  `COUNT` int(11) DEFAULT 0,
  `STATUS` int(11) DEFAULT 1,
  `LEVEL` varchar(50) DEFAULT 'user',
  `DEPARTMENT` varchar(100) DEFAULT NULL,
  `POSITION` varchar(100) DEFAULT NULL,
  `RESET_TOKEN` varchar(64) DEFAULT NULL COMMENT 'Password reset token',
  `RESET_EXPIRY` datetime DEFAULT NULL COMMENT 'Token expiry',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_member - LINE members/customers
CREATE TABLE IF NOT EXISTS `tb_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_user_id` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_promotion - Promotions/campaigns
CREATE TABLE IF NOT EXISTS `tb_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `status` enum('active','inactive','scheduled') DEFAULT 'inactive',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_products - Products/services
CREATE TABLE IF NOT EXISTS `tb_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `image` varchar(255) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brand` varchar(255) DEFAULT NULL,
  `brand_logo` varchar(255) DEFAULT NULL,
  `gallery_base_url` varchar(255) DEFAULT NULL,
  `gallery_json` text DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` text DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `blog_url` varchar(255) DEFAULT NULL,
  `brand_id` int(11) DEFAULT 0,
  `category_id` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_brand - Product brands
CREATE TABLE IF NOT EXISTS `tb_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `sort_order` int(11) DEFAULT 0,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_category - Product categories
CREATE TABLE IF NOT EXISTS `tb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `sort_order` int(11) DEFAULT 0,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_rich_menu - LINE Rich Menu management
CREATE TABLE IF NOT EXISTS `tb_rich_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rich_menu_id` varchar(100) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `template_id` varchar(50) DEFAULT 'custom',
  `name` varchar(100) NOT NULL,
  `chat_bar_text` varchar(50) NOT NULL,
  `size_width` int(11) NOT NULL DEFAULT 2500,
  `size_height` int(11) NOT NULL DEFAULT 1686,
  `selected` tinyint(1) NOT NULL DEFAULT 0,
  `areas_json` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_rich_message - LINE Rich Message management
CREATE TABLE IF NOT EXISTS `tb_rich_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `actions_json` text NOT NULL,
  `alt_text` varchar(400) DEFAULT NULL,
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_booking - Service bookings
CREATE TABLE IF NOT EXISTS `tb_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `queue_no` int(11) DEFAULT 0,
  `technician_id` int(11) DEFAULT 0,
  `line_user_id` varchar(100) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `car_plate` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `work_sheet_img` varchar(255) DEFAULT '',
  `service_note` text DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_booking_log - Booking history/log
CREATE TABLE IF NOT EXISTS `tb_booking_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_manual - Manuals/guides
CREATE TABLE IF NOT EXISTS `tb_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tb_QT - Quick quotes/quotes
CREATE TABLE IF NOT EXISTS `tb_QT` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quote_number` varchar(50) NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(50) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `car_brand` varchar(100) DEFAULT NULL,
  `car_model` varchar(100) DEFAULT NULL,
  `car_plate` varchar(50) DEFAULT NULL,
  `service_items` text DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT 0.00,
  `status` enum('draft','sent','accepted','rejected','expired') DEFAULT 'draft',
  `valid_until` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `quote_number` (`quote_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default admin user (password: admin123 -> Argon2ID hash)
-- This will be auto-upgraded on first login if using MD5
INSERT IGNORE INTO `tb_admin_user` (`USERNAME`, `PASSWORD`, `EMAIL`, `FULLNAME`, `LEVEL`, `STATUS`, `AVATAR`) VALUES
('admin', '$argon2id$v=19$m=65536,t=3,p=4$RANDOM_SALT$RANDOM_HASH', 'admin@lcb.local', 'Administrator', 'admin', 1, 'default_avatar.png');

-- Insert sample categories
INSERT IGNORE INTO `tb_category` (`name`, `description`, `status`, `sort_order`) VALUES
('ยางรถยนต์', 'ยางรถเก๋ง SUV กระบะ ทุกยี่ห้อ', 'active', 1),
('แบตเตอรี่', 'แบตเตอรี่รถยนต์ทุกขนาด', 'active', 2),
('น้ำมันเครื่อง', 'น้ำมันเครื่อง สังเคราะห์ ครึ่งสังเคราะห์', 'active', 3),
('บริการช่วยเหลือ', 'บริการช่วยเหลือฉุกเฉิน 24 ชม.', 'active', 4);

-- Insert sample brands
INSERT IGNORE INTO `tb_brand` (`name`, `description`, `status`, `sort_order`) VALUES
('BRIDGESTONE', 'ยางพรีเมียมจากญี่ปุ่น', 'active', 1),
('MICHELIN', 'ยางพรีเมียมจากฝรั่งเศส', 'active', 2),
('GOODYEAR', 'ยางจากอเมริกา', 'active', 3),
('DUNLOP', 'ยางจากอังกฤษ', 'active', 4);