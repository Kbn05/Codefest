-- MySQL Script generated by MySQL Workbench
-- Wed Oct 25 09:25:13 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema p_login
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema p_login
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `p_login` DEFAULT CHARACTER SET utf8 ;
USE `p_login` ;

-- -----------------------------------------------------
-- Table `p_login`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`users` (
  `u_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `fullname` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `rol` VARCHAR(255) NOT NULL DEFAULT 'STUDENT',
  PRIMARY KEY (`u_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p_login`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`posts` (
  `id_post` INT NOT NULL AUTO_INCREMENT,
  `p_title` VARCHAR(255) NOT NULL,
  `p_content` VARCHAR(255) NOT NULL,
  `author` INT NOT NULL,
  PRIMARY KEY (`id_post`),
  INDEX `author_idx` (`author` ASC) VISIBLE,
  CONSTRAINT `author`
    FOREIGN KEY (`author`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p_login`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`comments` (
  `id_comments` INT NOT NULL AUTO_INCREMENT,
  `c_content` VARCHAR(255) NOT NULL,
  `post_id` INT NOT NULL,
  `c_user` INT NOT NULL,
  PRIMARY KEY (`id_comments`),
  INDEX `post_id_idx` (`post_id` ASC) VISIBLE,
  INDEX `c_user_idx` (`c_user` ASC) VISIBLE,
  CONSTRAINT `post_id`
    FOREIGN KEY (`post_id`)
    REFERENCES `p_login`.`posts` (`id_post`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `c_user`
    FOREIGN KEY (`c_user`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p_login`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`likes` (
  `id_likes` INT NOT NULL AUTO_INCREMENT,
  `l_user` INT NOT NULL,
  `l_post_id` INT NOT NULL,
  PRIMARY KEY (`id_likes`),
  INDEX `l_post_idx` (`l_post_id` ASC) VISIBLE,
  INDEX `l_user_idx` (`l_user` ASC) VISIBLE,
  CONSTRAINT `l_user`
    FOREIGN KEY (`l_user`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `l_post`
    FOREIGN KEY (`l_post_id`)
    REFERENCES `p_login`.`posts` (`id_post`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p_login`.`friend_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`friend_request` (
  `id_friends` INT NOT NULL AUTO_INCREMENT,
  `f_sender` INT NOT NULL,
  `f_receiver` INT NOT NULL,
  PRIMARY KEY (`id_friends`),
  INDEX `f_sender_idx` (`f_sender` ASC) VISIBLE,
  INDEX `f_receiver_idx` (`f_receiver` ASC) VISIBLE,
  CONSTRAINT `f_sender`
    FOREIGN KEY (`f_sender`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f_receiver`
    FOREIGN KEY (`f_receiver`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p_login`.`friends`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p_login`.`friends` (
  `id_friends` INT NOT NULL AUTO_INCREMENT,
  `f_user_1` INT NOT NULL,
  `f_user_2` INT NOT NULL,
  PRIMARY KEY (`id_friends`),
  INDEX `f_user_1_idx` (`f_user_1` ASC) VISIBLE,
  INDEX `f_user_2_idx` (`f_user_2` ASC) VISIBLE,
  CONSTRAINT `f_user_1`
    FOREIGN KEY (`f_user_1`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f_user_2`
    FOREIGN KEY (`f_user_2`)
    REFERENCES `p_login`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
