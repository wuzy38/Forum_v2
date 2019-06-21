-- MySQL Script generated by MySQL Workbench
-- Sun Jun  9 21:58:59 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema forum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema forum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `forum` DEFAULT CHARACTER SET utf8 ;
USE `forum` ;

-- -----------------------------------------------------
-- Table `forum`.`plate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum`.`plate` ;

CREATE TABLE IF NOT EXISTS `forum`.`plate` (
  `plate_id` INT NOT NULL,
  `plate_name` VARCHAR(45) NULL,
  `theme_cnt` INT NULL,
  `introduction` VARCHAR(45) NULL,
  `platecol` LONGTEXT NULL,
  PRIMARY KEY (`plate_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum`.`user` ;

CREATE TABLE IF NOT EXISTS `forum`.`user` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `register_time` DATETIME NULL,
  `grade` INT NULL,
  `user_password` VARCHAR(45) NULL,
  `photo` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum`.`theme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum`.`theme` ;

CREATE TABLE IF NOT EXISTS `forum`.`theme` (
  `theme_id` INT NOT NULL,
  `theme_name` VARCHAR(45) NULL,
  `theme_time` DATETIME NULL,
  `plate_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `click_num` INT NULL,
  `newest_reply` DATETIME NULL,
  `reply_cnt` INT NULL,
  `themecol` VARCHAR(45) NULL,
  PRIMARY KEY (`theme_id`),
  INDEX `fk_theme_plate_idx` (`plate_id` ASC) ,
  INDEX `fk_theme_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_theme_plate`
    FOREIGN KEY (`plate_id`)
    REFERENCES `forum`.`plate` (`plate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_theme_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `forum`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum`.`reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum`.`reply` ;

CREATE TABLE IF NOT EXISTS `forum`.`reply` (
  `reply_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `content` TEXT NULL,
  `reply_time` DATETIME NULL,
  `theme_id` INT NOT NULL,
  PRIMARY KEY (`reply_id`),
  INDEX `fk_reply_user1_idx` (`user_id` ASC) ,
  INDEX `fk_reply_theme1_idx` (`theme_id` ASC) ,
  CONSTRAINT `fk_reply_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `forum`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_theme1`
    FOREIGN KEY (`theme_id`)
    REFERENCES `forum`.`theme` (`theme_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum`.`link`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum`.`link` ;

CREATE TABLE IF NOT EXISTS `forum`.`link` (
  `user_id` INT NOT NULL,
  `user_linked_id` INT NOT NULL,
  `connection` VARCHAR(45) NULL,
  INDEX `fk_link_user1_idx` (`user_id` ASC) ,
  INDEX `fk_link_user2_idx` (`user_linked_id` ASC) ,
  CONSTRAINT `fk_link_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `forum`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_user2`
    FOREIGN KEY (`user_linked_id`)
    REFERENCES `forum`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;