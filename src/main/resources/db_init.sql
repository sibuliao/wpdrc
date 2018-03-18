CREATE DATABASE `wpdrc`;
USE `wpdrc`;

CREATE TABLE `tb_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` varchar(2) DEFAULT NULL,
  `desk_num` int(2) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `create_time` datetime,
  `status` tinyint(1) COMMENT '0进行中，1已买单，2删除，3已付款待取货，4已付款已取货',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `price` double(8,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_category_id` (`name`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除，0否，1是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_UNIQUE` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_num` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_order_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` varchar(2) DEFAULT NULL,
  `desk_num` int(2) DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `create_time` datetime,
  `status_str` varchar(10),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_order_detail_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_num` float DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_order_report_day` (
  `day` date NOT NULL,
  `sales` float DEFAULT NULL,
  `order_count` int(11) DEFAULT NULL,
  `order_count_tangshi` int(11) DEFAULT NULL,
  `order_count_dabao` int(11) DEFAULT NULL,
  PRIMARY KEY (`day`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_product_report_day` (
  `day` date NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_num` float DEFAULT NULL,
  `sales` float DEFAULT NULL,
  PRIMARY KEY (`day`,`product_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;