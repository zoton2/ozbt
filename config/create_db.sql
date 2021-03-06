-- MySQL Script generated by MySQL Workbench
-- 04/09/16 20:57:06
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ozbt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ozbt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ozbt` DEFAULT CHARACTER SET utf8 ;
USE `ozbt` ;

-- -----------------------------------------------------
-- Table `ozbt`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`channel` (
  `Channel` VARCHAR(45) NOT NULL,
  `JoinOnAppOpen` TINYINT(1) NOT NULL DEFAULT 1,
  `BanLinks` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Channel`),
  UNIQUE INDEX `Channel_UNIQUE` (`Channel` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`subgoal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`subgoal` (
  `SubGoalId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Current` INT NULL DEFAULT 0,
  `Maximum` INT NOT NULL,
  `Channel` VARCHAR(45) NOT NULL,
  `ResubsCount` TINYINT(1) NOT NULL DEFAULT 0,
  `PublicHash` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SubGoalId`),
  UNIQUE INDEX `SubGoalId_UNIQUE` (`SubGoalId` ASC),
  INDEX `SubGoalChannel_fk_idx` (`Channel` ASC),
  CONSTRAINT `SubGoal_Channel_fk`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`customcommand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`customcommand` (
  `CustomCommandId` INT NOT NULL AUTO_INCREMENT,
  `Command` VARCHAR(45) NOT NULL,
  `OutputText` VARCHAR(255) NOT NULL,
  `Channel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomCommandId`),
  UNIQUE INDEX `CustomCommandId_UNIQUE` (`CustomCommandId` ASC),
  INDEX `CustomCommand_Channel_fk_idx` (`Channel` ASC),
  CONSTRAINT `CustomCommand_Channel_fk`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`commandpermission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`commandpermission` (
  `CommandPermissionId` INT NOT NULL AUTO_INCREMENT,
  `Command` VARCHAR(45) NOT NULL,
  `PermissionLevel` INT NOT NULL DEFAULT 0,
  `Channel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CommandPermissionId`),
  UNIQUE INDEX `Command_UNIQUE` (`Command` ASC),
  INDEX `CommandPermission_Channel_idx` (`Channel` ASC),
  CONSTRAINT `CommandPermission_Channel`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`timedcommand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`timedcommand` (
  `TimedCommandId` INT NOT NULL AUTO_INCREMENT,
  `Command` VARCHAR(45) NOT NULL,
  `Lines` INT NOT NULL DEFAULT 100,
  PRIMARY KEY (`TimedCommandId`),
  UNIQUE INDEX `TimedCommandId_UNIQUE` (`TimedCommandId` ASC),
  INDEX `TimedCommand_CustomCommand_fk_idx` (`Command` ASC),
  CONSTRAINT `TimedCommand_CustomCommand_fk`
    FOREIGN KEY (`Command`)
    REFERENCES `ozbt`.`customcommand` (`Command`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`regular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`regular` (
  `RegularId` INT NOT NULL AUTO_INCREMENT,
  `Channel` VARCHAR(45) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RegularId`),
  INDEX `Regular_Channel_fk_idx` (`Channel` ASC),
  CONSTRAINT `Regular_Channel_fk`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`supermoderator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`supermoderator` (
  `SuperModeratorId` INT NOT NULL AUTO_INCREMENT,
  `Channel` VARCHAR(45) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SuperModeratorId`),
  INDEX `SuperModerator_Channel_fk_idx` (`Channel` ASC),
  CONSTRAINT `SuperModerator_Channel_fk`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ozbt`.`greeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ozbt`.`greeting` (
  `GreetingId` INT NOT NULL AUTO_INCREMENT,
  `Type` INT NOT NULL,
  `OutputText` VARCHAR(255) NOT NULL,
  `Channel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GreetingId`),
  INDEX `Greeting_Channel_fk_idx` (`Channel` ASC),
  CONSTRAINT `Greeting_Channel_fk`
    FOREIGN KEY (`Channel`)
    REFERENCES `ozbt`.`channel` (`Channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
