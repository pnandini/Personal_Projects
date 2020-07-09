-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SJSU_Parking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SJSU_Parking` ;

-- -----------------------------------------------------
-- Schema SJSU_Parking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SJSU_Parking` DEFAULT CHARACTER SET utf8 ;
USE `SJSU_Parking` ;

-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Permit_Type_Price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Permit_Type_Price` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Permit_Type_Price` (
  `Permit_ID` INT NOT NULL AUTO_INCREMENT,
  `Permit_Name` VARCHAR(45) NOT NULL,
  `Permit_Duration` VARCHAR(45) NOT NULL,
  `Permit_Price` VARCHAR(45) NOT NULL,
  `Permit_Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Permit_ID`),
  UNIQUE INDEX `Permit_ID_UNIQUE` (`Permit_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Customers` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Customers` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `Car_Plate_Numb` VARCHAR(45) NOT NULL,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Phone_Numb` INT NULL,
  `Vehicle_Type` VARCHAR(45) NULL,
  `Permit_ID` INT NOT NULL,
  `Permit_startDate` DATE NOT NULL,
  INDEX `fk_Customers_Permit_Type_Price1_idx` (`Permit_ID` ASC) VISIBLE,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE INDEX `Customer_ID_UNIQUE` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Permit_Type_Price1`
    FOREIGN KEY (`Permit_ID`)
    REFERENCES `SJSU_Parking`.`Permit_Type_Price` (`Permit_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Parking_Lot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Parking_Lot` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Parking_Lot` (
  `Parking_Lot_ID` INT NOT NULL AUTO_INCREMENT,
  `Lot_Name` VARCHAR(45) NOT NULL,
  `Numb_Floors` INT NULL,
  `Numb_Parking_Slot` INT NOT NULL,
  `Parking_Lot_Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Parking_Lot_ID`),
  UNIQUE INDEX `Parking_Lot_ID_UNIQUE` (`Parking_Lot_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Occupancy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Occupancy` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Occupancy` (
  `Occupancy_ID` INT NOT NULL AUTO_INCREMENT,
  `Check_In_DateTime` DATETIME NULL,
  `Check_Out_DateTime` DATETIME NULL,
  `Customer_ID` INT NOT NULL,
  `Parking_Lot_ID` INT NOT NULL,
  PRIMARY KEY (`Occupancy_ID`),
  INDEX `fk_Parking_Lot_ID_idx` (`Parking_Lot_ID` ASC) VISIBLE,
  INDEX `fk_Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  UNIQUE INDEX `Occupancy_ID_UNIQUE` (`Occupancy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Parking_Lot_ID`
    FOREIGN KEY (`Parking_Lot_ID`)
    REFERENCES `SJSU_Parking`.`Parking_Lot` (`Parking_Lot_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `SJSU_Parking`.`Customers` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Citation_Penalty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Citation_Penalty` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Citation_Penalty` (
  `Penalty_ID` INT NOT NULL AUTO_INCREMENT,
  `Citation_Type` INT NOT NULL,
  `Penalty_Price` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Penalty_ID`),
  UNIQUE INDEX `Penalty_ID_UNIQUE` (`Penalty_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SJSU_Parking`.`Customer_Citation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SJSU_Parking`.`Customer_Citation` ;

CREATE TABLE IF NOT EXISTS `SJSU_Parking`.`Customer_Citation` (
  `Citation_ID` INT NOT NULL AUTO_INCREMENT,
  `Citation_DateTime` DATETIME NULL,
  `Citation_Penalty_ID` INT NOT NULL,
  `Occupancy_ID` INT NULL,
  PRIMARY KEY (`Citation_ID`),
  INDEX `fk_Customer_Citation_Citation_Penalty1_idx` (`Citation_Penalty_ID` ASC) VISIBLE,
  INDEX `fk_Occupancy_ID_idx` (`Occupancy_ID` ASC) VISIBLE,
  UNIQUE INDEX `Citation_ID_UNIQUE` (`Citation_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Citation_Penalty1`
    FOREIGN KEY (`Citation_Penalty_ID`)
    REFERENCES `SJSU_Parking`.`Citation_Penalty` (`Penalty_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Occupancy_ID`
    FOREIGN KEY (`Occupancy_ID`)
    REFERENCES `SJSU_Parking`.`Occupancy` (`Occupancy_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
