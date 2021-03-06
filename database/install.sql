SET NAMES utf8mb4;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `failed_jobs`
-- ----------------------------
DROP TABLE IF EXISTS `v2_failed_jobs`;
CREATE TABLE `v2_failed_jobs` (
                               `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                               `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `v2_coupon`;
CREATE TABLE `v2_coupon` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `code` varchar(255) NOT NULL,
                             `name` varchar(255)  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
                             `type` tinyint(1) NOT NULL,
                             `value` int(11) NOT NULL,
                             `limit_use` int(11) DEFAULT NULL,
                             `limit_use_with_user` int(11) DEFAULT NULL,
                             `limit_plan_ids` varchar(255) DEFAULT NULL,
                             `started_at` int(11) NOT NULL,
                             `ended_at` int(11) NOT NULL,
                             `created_at` int(11) NOT NULL,
                             `updated_at` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_invite_code`
-- ----------------------------
DROP TABLE IF EXISTS `v2_invite_code`;
CREATE TABLE `v2_invite_code` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `user_id` int(11) NOT NULL,
                                  `code` char(32) NOT NULL,
                                  `status` tinyint(1) NOT NULL DEFAULT '0',
                                  `pv` int(11) NOT NULL DEFAULT '0',
                                  `created_at` int(11) NOT NULL,
                                  `updated_at` int(11) NOT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `user_id_status` (`user_id`,`status`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_knowledge`
-- ----------------------------
DROP TABLE IF EXISTS `v2_knowledge`;
CREATE TABLE `v2_knowledge` (
                                `id` int(11) NOT NULL AUTO_INCREMENT,
                                `language` char(5) NOT NULL COMMENT '??????',
                                `category` varchar(255) NOT NULL COMMENT '?????????',
                                `title` varchar(255) NOT NULL COMMENT '??????',
                                `body` text NOT NULL COMMENT '??????',
                                `sort` int(11) DEFAULT NULL COMMENT '??????',
                                `show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '??????',
                                `free` tinyint(1) NOT NULL DEFAULT '1' COMMENT '????????????',
                                `created_at` int(11) NOT NULL COMMENT '????????????',
                                `updated_at` int(11) NOT NULL COMMENT '????????????',
                                PRIMARY KEY (`id`),
                                KEY `language_show` (`language`,`show`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4  COMMENT='?????????';

-- ----------------------------
--  Table structure for `v2_mail_log`
-- ----------------------------
DROP TABLE IF EXISTS `v2_mail_log`;
CREATE TABLE `v2_mail_log` (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `email` varchar(64) NOT NULL,
                               `subject` varchar(255) NOT NULL,
                               `template_name` varchar(255) NOT NULL,
                               `error` text,
                               `created_at` int(11) NOT NULL,
                               `updated_at` int(11) NOT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_notice`
-- ----------------------------
DROP TABLE IF EXISTS `v2_notice`;
CREATE TABLE `v2_notice` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `title` varchar(255) NOT NULL,
                             `content` text NOT NULL,
                             `img_url` varchar(255) DEFAULT NULL,
                             `created_at` int(11) NOT NULL,
                             `updated_at` int(11) NOT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_order`
-- ----------------------------
DROP TABLE IF EXISTS `v2_order`;
CREATE TABLE `v2_order` (
                            `id` int(11) NOT NULL AUTO_INCREMENT,
                            `invite_user_id` int(11) DEFAULT '0',
                            `user_id` int(11) NOT NULL,
                            `plan_id` int(11) NOT NULL,
                            `coupon_id` int(11) DEFAULT NULL COMMENT '0',
                            `payment_id` int(11) DEFAULT '0',
                            `type` int(11) NOT NULL COMMENT '1??????2??????3??????',
                            `cycle` varchar(255) NOT NULL,
                            `trade_no` varchar(36) NOT NULL,
                            `callback_no` varchar(255) DEFAULT NULL,
                            `total_amount` int(11) NOT NULL,
                            `discount_amount` int(11) DEFAULT NULL,
                            `surplus_amount` int(11) DEFAULT NULL COMMENT '????????????',
                            `refund_amount` int(11) DEFAULT NULL COMMENT '????????????',
                            `balance_amount` int(11) DEFAULT NULL COMMENT '????????????',
                            `surplus_order_ids` text COMMENT '????????????',
                            `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0?????????1?????????2?????????3?????????4?????????',
                            `commission_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0?????????1?????????2??????3??????',
                            `commission_balance` int(11) NOT NULL DEFAULT '0',
                            `paid_at` int(11) DEFAULT NULL,
                            `created_at` int(11) NOT NULL,
                            `updated_at` int(11) NOT NULL,
                            PRIMARY KEY (`id`),
                            KEY `status` (`status`) USING BTREE,
                            KEY `invite_user_id` (`invite_user_id`) USING BTREE,
                            KEY `user_id` (`user_id`) USING BTREE,
                            KEY `created_at` (`created_at`) USING BTREE,
                            KEY `status_user_id` (`user_id`,`status`) USING BTREE,
                            KEY `created_at_status` (`status`,`created_at`) USING BTREE,
                            KEY `trade_no` (`trade_no`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_order_stat`
-- ----------------------------
DROP TABLE IF EXISTS `v2_order_stat`;
CREATE TABLE `v2_order_stat` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `order_count` int(11) NOT NULL COMMENT '????????????',
                                 `order_amount` int(11) NOT NULL COMMENT '????????????',
                                 `commission_count` int(11) NOT NULL,
                                 `commission_amount` int(11) NOT NULL COMMENT '????????????',
                                 `record_type` char(1) NOT NULL,
                                 `record_at` int(11) NOT NULL,
                                 `created_at` int(11) NOT NULL,
                                 `updated_at` int(11) NOT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `record_at` (`record_at`) USING BTREE,
                                 KEY `record_at_record_type` (`record_type`,`record_at`) USING BTREE,
                                 KEY `record_type` (`record_type`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='????????????';

-- ----------------------------
--  Table structure for `v2_payment`
-- ----------------------------
DROP TABLE IF EXISTS `v2_payment`;
CREATE TABLE `v2_payment` (
                              `id` int(11) NOT NULL AUTO_INCREMENT,
                              `uuid` char(32) NOT NULL,
                              `payment` varchar(16) NOT NULL,
                              `name` varchar(255) NOT NULL,
                              `config` text NOT NULL,
                              `enable` tinyint(1) NOT NULL DEFAULT '0',
                              `sort` int(11) DEFAULT NULL,
                              `created_at` int(11) NOT NULL,
                              `updated_at` int(11) NOT NULL,
                              PRIMARY KEY (`id`),
                              KEY `uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `v2_plan`
-- ----------------------------
DROP TABLE IF EXISTS `v2_plan`;
CREATE TABLE `v2_plan` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `group_id` int(11) NOT NULL,
                           `transfer_enable` int(11) NOT NULL,
                           `name` varchar(255) NOT NULL,
                           `show` tinyint(1) NOT NULL DEFAULT '0',
                           `sort` int(11) DEFAULT NULL,
                           `renew` tinyint(1) NOT NULL DEFAULT '1',
                           `content` text,
                           `month_price` int(11) DEFAULT NULL,
                           `quarter_price` int(11) DEFAULT NULL,
                           `half_year_price` int(11) DEFAULT NULL,
                           `year_price` int(11) DEFAULT NULL,
                           `two_year_price` int(11) DEFAULT NULL,
                           `three_year_price` int(11) DEFAULT NULL,
                           `onetime_price` int(11) DEFAULT NULL,
                           `reset_price` int(11) DEFAULT NULL,
                           `reset_traffic_method` tinyint(1) DEFAULT NULL,
                           `created_at` int(11) NOT NULL,
                           `updated_at` int(11) NOT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- ----------------------------
--  Table structure for `v2_server`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server`;
CREATE TABLE `v2_server` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `group_id` varchar(255) NOT NULL,
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `parent_id` int(11) DEFAULT '0',
                             `host` varchar(255) NOT NULL,
                             `port` int(11) NOT NULL,
                             `server_port` int(11) NOT NULL,
                             `tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                             `rate` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                             `network` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                             `tls` tinyint(4) NOT NULL DEFAULT '0',
                             `alter_id` int(11) NOT NULL DEFAULT '1',
                             `network_settings` text,
                             `tls_settings` text,
                             `rule_settings` text,
                             `dns_settings` text,
                             `show` tinyint(1) NOT NULL DEFAULT '0',
                             `sort` int(11) DEFAULT '0',
                             `created_at` int(11) NOT NULL,
                             `updated_at` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `show` (`show`) USING BTREE,
                             KEY `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_server_group`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server_group`;
CREATE TABLE `v2_server_group` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT,
                                   `name` varchar(255) NOT NULL,
                                   `created_at` int(11) NOT NULL,
                                   `updated_at` int(11) NOT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_server_log`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server_log`;
CREATE TABLE `v2_server_log` (
                                 `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                 `user_id` int(11) NOT NULL,
                                 `server_id` int(11) NOT NULL,
                                 `u` varchar(255) NOT NULL,
                                 `d` varchar(255) NOT NULL,
                                 `rate` decimal(10,2) NOT NULL,
                                 `method` varchar(255) NOT NULL,
                                 `log_at` int(11) NOT NULL,
                                 `created_at` int(11) NOT NULL,
                                 `updated_at` int(11) NOT NULL,
                                 PRIMARY KEY (`id`),
                                 KEY `log_at` (`log_at`),
                                 KEY `union` (`log_at`,`user_id`,`server_id`,`rate`,`method`) USING BTREE,
                                 KEY `user_id_creatd_at` (`user_id`,`created_at`) USING BTREE,
                                 KEY `user_id` (`user_id`),
                                 KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_server_shadowsocks`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server_shadowsocks`;
CREATE TABLE `v2_server_shadowsocks` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT,
                                         `group_id` varchar(255) NOT NULL,
                                         `parent_id` int(11) DEFAULT '0',
                                         `tags` varchar(255) DEFAULT NULL,
                                         `name` varchar(255) NOT NULL,
                                         `rate` varchar(11) NOT NULL,
                                         `host` varchar(255) NOT NULL,
                                         `port` int(11) NOT NULL,
                                         `server_port` int(11) NOT NULL,
                                         `cipher` varchar(255) NOT NULL,
                                         `show` tinyint(4) NOT NULL DEFAULT '0',
                                         `sort` int(11) DEFAULT NULL,
                                         `created_at` int(11) NOT NULL,
                                         `updated_at` int(11) NOT NULL,
                                         PRIMARY KEY (`id`),
                                         KEY `show` (`show`) USING BTREE,
                                         KEY `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `v2_server_stat`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server_stat`;
CREATE TABLE `v2_server_stat` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `server_id` int(11) NOT NULL COMMENT '??????id',
                                  `server_type` char(11) NOT NULL COMMENT '????????????',
                                  `u` varchar(255) NOT NULL,
                                  `d` varchar(255) NOT NULL,
                                  `record_type` char(1) NOT NULL COMMENT 'd day m month',
                                  `record_at` int(11) NOT NULL COMMENT '????????????',
                                  `created_at` int(11) NOT NULL,
                                  `updated_at` int(11) NOT NULL,
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `server_id_server_type_record_at` (`server_id`,`server_type`,`record_at`),
                                  KEY `record_at` (`record_at`),
                                  KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='??????????????????';

-- ----------------------------
--  Table structure for `v2_server_trojan`
-- ----------------------------
DROP TABLE IF EXISTS `v2_server_trojan`;
CREATE TABLE `v2_server_trojan` (
                                    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
                                    `group_id` varchar(255) NOT NULL COMMENT '?????????',
                                    `parent_id` int(11) DEFAULT '0' COMMENT '?????????',
                                    `tags` varchar(255) DEFAULT NULL COMMENT '????????????',
                                    `name` varchar(255) NOT NULL COMMENT '????????????',
                                    `rate` varchar(11) NOT NULL COMMENT '??????',
                                    `host` varchar(255) NOT NULL COMMENT '?????????',
                                    `port` int(11) NOT NULL COMMENT '????????????',
                                    `server_port` int(11) NOT NULL COMMENT '????????????',
                                    `allow_insecure` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?????????????????????',
                                    `server_name` varchar(255) DEFAULT NULL,
                                    `show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '????????????',
                                    `sort` int(11) DEFAULT NULL,
                                    `created_at` int(11) NOT NULL,
                                    `updated_at` int(11) NOT NULL,
                                    PRIMARY KEY (`id`),
                                    KEY `show` (`show`) USING BTREE,
                                    KEY `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='trojan????????????';

-- ----------------------------
--  Table structure for `v2_ticket`
-- ----------------------------
DROP TABLE IF EXISTS `v2_ticket`;
CREATE TABLE `v2_ticket` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `user_id` int(11) NOT NULL,
                             `last_reply_user_id` int(11) NOT NULL,
                             `subject` varchar(255) NOT NULL,
                             `level` tinyint(1) NOT NULL,
                             `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:????????? 1:?????????',
                             `created_at` int(11) NOT NULL,
                             `updated_at` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             KEY `status` (`status`) USING BTREE,
                             KEY `user_id_creatd_at` (`user_id`,`created_at`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `v2_ticket_message`
-- ----------------------------
DROP TABLE IF EXISTS `v2_ticket_message`;
CREATE TABLE `v2_ticket_message` (
                                     `id` int(11) NOT NULL AUTO_INCREMENT,
                                     `user_id` int(11) NOT NULL,
                                     `ticket_id` int(11) NOT NULL,
                                     `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `created_at` int(11) NOT NULL,
                                     `updated_at` int(11) NOT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `user_id` (`user_id`) USING BTREE,
                                     KEY `ticket_id` (`ticket_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
--  Table structure for `v2_user`
-- ----------------------------
DROP TABLE IF EXISTS `v2_user`;
CREATE TABLE `v2_user` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `invite_user_id` int(11) DEFAULT '0',
                           `telegram_id` bigint(20) DEFAULT '0',
                           `email` varchar(64) NOT NULL,
                           `password` varchar(64) NOT NULL,
                           `password_algo` char(10) DEFAULT NULL,
                           `password_salt` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                           `balance` int(11) DEFAULT '0',
                           `commission_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0: system 1: cycle 2: onetime',
                           `discount` int(11) DEFAULT NULL,
                           `commission_rate` int(11) DEFAULT NULL,
                           `commission_balance` int(11) DEFAULT '0',
                           `t` int(11) DEFAULT '0',
                           `u` bigint(20) DEFAULT '0',
                           `d` bigint(20) DEFAULT '0',
                           `transfer_enable` bigint(20) NOT NULL DEFAULT '0',
                           `last_checkin_at` int(11) NOT NULL DEFAULT '0',
                           `banned` tinyint(1) NOT NULL DEFAULT '0',
                           `is_admin` tinyint(1) DEFAULT '0',
                           `last_login_at` int(11) DEFAULT NULL,
                           `is_staff` tinyint(1) DEFAULT '0',
                           `last_login_ip` int(11) DEFAULT NULL,
                           `uuid` varchar(36) NOT NULL,
                           `group_id` int(11) DEFAULT '0',
                           `plan_id` int(11) DEFAULT '0',
                           `remind_expire` tinyint(4) DEFAULT '1',
                           `remind_traffic` tinyint(4) DEFAULT '1',
                           `token` char(32) NOT NULL,
                           `expired_at` bigint(20) DEFAULT NULL,
                           `remarks` text,
                           `created_at` int(11) NOT NULL,
                           `updated_at` int(11) NOT NULL,
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `email` (`email`),
                           KEY `expired_at` (`expired_at`) USING BTREE,
                           KEY `plan_id` (`plan_id`) USING BTREE,
                           KEY `group_id` (`group_id`) USING BTREE,
                           KEY `token` (`token`) USING BTREE,
                           KEY `password_email` (`password`,`email`) USING BTREE,
                           KEY `telegram_id` (`telegram_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
