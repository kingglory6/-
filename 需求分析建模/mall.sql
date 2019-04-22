-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mall
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mall
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mall` DEFAULT CHARACTER SET utf8 ;
USE `mall` ;

-- -----------------------------------------------------
-- Table `mall`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`customer` ;

CREATE TABLE IF NOT EXISTS `mall`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `netname` CHAR(16) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` CHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`category` ;

CREATE TABLE IF NOT EXISTS `mall`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`brand` ;

CREATE TABLE IF NOT EXISTS `mall`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`commodity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`commodity` ;

CREATE TABLE IF NOT EXISTS `mall`.`commodity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `discount` DOUBLE NOT NULL,
  `description` VARCHAR(100) NULL,
  `shelf` TINYINT NOT NULL DEFAULT 0,
  `recommend` INT NOT NULL DEFAULT 0,
  `stock` INT NOT NULL DEFAULT 0,
  `limitstock` INT NOT NULL DEFAULT 0,
  `category_id` INT NOT NULL,
  `brand_id` INT NOT NULL,
  `activity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `commodity_fk_category_idx` (`category_id` ASC) VISIBLE,
  INDEX `commodity_fk_brand_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `commodity_fk_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `mall`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `commodity_fk_brand`
    FOREIGN KEY (`brand_id`)
    REFERENCES `mall`.`brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`Collection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`Collection` ;

CREATE TABLE IF NOT EXISTS `mall`.`Collection` (
  `uid` INT NOT NULL,
  `commodity_id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `time` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`uid`, `commodity_id`),
  INDEX `collection_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `collection_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `collection_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`address` ;

CREATE TABLE IF NOT EXISTS `mall`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `uid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `add_fk_user_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `add_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`history` ;

CREATE TABLE IF NOT EXISTS `mall`.`history` (
  `uid` INT NOT NULL,
  `commodity_id` INT NOT NULL,
  `datetime` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`uid`, `commodity_id`),
  INDEX `history_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `history_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `history_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`cart` ;

CREATE TABLE IF NOT EXISTS `mall`.`cart` (
  `uid` INT NOT NULL,
  `commodity_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `spec_id` INT NOT NULL,
  INDEX `cart_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  INDEX `cart_fk_user_idx` (`uid` ASC) VISIBLE,
  PRIMARY KEY (`uid`, `commodity_id`, `spec_id`),
  CONSTRAINT `cart_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cart_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`notice` ;

CREATE TABLE IF NOT EXISTS `mall`.`notice` (
  `email` VARCHAR(100) NOT NULL,
  `commodity_id` INT NOT NULL,
  `iNotice` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`email`, `commodity_id`),
  INDEX `notice_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `notice_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`orders` ;

CREATE TABLE IF NOT EXISTS `mall`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `time` DATETIME NOT NULL,
  `paystatus` INT NOT NULL DEFAULT 2,
  `payway` INT NULL,
  `sendstatus` INT NOT NULL DEFAULT 0,
  `hidden` INT NOT NULL DEFAULT 0,
  `total` DOUBLE NOT NULL,
  `wuliu` CHAR(13) NULL,
  PRIMARY KEY (`id`),
  INDEX `orders_fk_user_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `orders_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`item` ;

CREATE TABLE IF NOT EXISTS `mall`.`item` (
  `order_id` INT NOT NULL,
  `commodity_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `param` CHAR(45) NOT NULL,
  `remark` CHAR(45) NULL,
  PRIMARY KEY (`order_id`, `commodity_id`),
  INDEX `item_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `item_fk_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `mall`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`comment` ;

CREATE TABLE IF NOT EXISTS `mall`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commodity_id` INT NOT NULL,
  `uid` INT NOT NULL,
  `content` VARCHAR(200) NOT NULL,
  `time` DATETIME NOT NULL DEFAULT now(),
  `score` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `comment_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  INDEX `comment_fk_user_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `comment_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_fk_user`
    FOREIGN KEY (`uid`)
    REFERENCES `mall`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`activity` ;

CREATE TABLE IF NOT EXISTS `mall`.`activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commodity_id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `stock` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `type` INT NOT NULL,
  `statu` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `spike_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `spike_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`admin` ;

CREATE TABLE IF NOT EXISTS `mall`.`admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account` CHAR(10) NOT NULL,
  `password` CHAR(64) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mall`.`spec`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`spec` ;

CREATE TABLE IF NOT EXISTS `mall`.`spec` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `commodity_id` INT NOT NULL,
  `param` CHAR(45) NOT NULL,
  `img` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `parma_fk_commodity_idx` (`commodity_id` ASC) VISIBLE,
  CONSTRAINT `spec_fk_commodity`
    FOREIGN KEY (`commodity_id`)
    REFERENCES `mall`.`commodity` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mall` ;

-- -----------------------------------------------------
-- Placeholder table for view `mall`.`v_commodity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mall`.`v_commodity` (`id` INT, `title` INT, `price` INT, `discount` INT, `description` INT, `stock` INT, `category_id` INT, `brand_id` INT, `activity` INT);

-- -----------------------------------------------------
-- View `mall`.`v_commodity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mall`.`v_commodity`;
DROP VIEW IF EXISTS `mall`.`v_commodity` ;
USE `mall`;
CREATE  OR REPLACE VIEW `v_commodity` AS select id,title,price,discount,description,stock,category_id,brand_id,activity from commodity where shelf = 1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
