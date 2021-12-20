ALTER TABLE `v2_user`
    ADD `commission_type` tinyint NOT NULL DEFAULT ''0'' COMMENT ''0: system 1: cycle 2: onetime'' AFTER `discount`;

ALTER TABLE `v2_order`
    ADD `paid_at` int(11) NULL AFTER `commission_balance`;

ALTER TABLE `v2_server_log`
    ADD INDEX `user_id` (`user_id`),
ADD INDEX `server_id` (`server_id`);

ALTER TABLE `v2_ticket_message`
    CHANGE `message` `message` text COLLATE '' utf8mb4_general_ci '' NOT NULL AFTER `ticket_id`;

ALTER TABLE `v2_order`
    ADD `paid_at` int(11) NULL AFTER `commission_balance`;

ALTER TABLE `v2_server_log`
    ADD INDEX `user_id` (`user_id`),
ADD INDEX `server_id` (`server_id`);

ALTER TABLE `v2_ticket_message`
    CHANGE `message` `message` text COLLATE 'utf8mb4_general_ci' NOT NULL AFTER `ticket_id`;

ALTER TABLE `v2_coupon`
    ADD `limit_use_with_user` int(11) NULL AFTER `limit_use`;

ALTER TABLE `v2_user`
    ADD `password_salt` char(10) COLLATE 'utf8_general_ci' NULL AFTER `password_algo`;

ALTER TABLE `v2_user`
    ADD `last_checkin_at` int(11) NOT NULL DEFAULT '0' AFTER `transfer_enable`

ALTER TABLE `v2_plan`
    ADD `reset_traffic_method` tinyint(1) NULL AFTER `reset_price`;

ALTER TABLE `v2_knowledge` ADD COLUMN `free` tinyint(1) NOT NULL DEFAULT 1  COMMENT '是否免费' AFTER `show`;
