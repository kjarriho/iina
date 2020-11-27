-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VillagepeopleDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VillagepeopleDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VillagepeopleDB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
USE `VillagepeopleDB` ;

-- -----------------------------------------------------
-- Table `VillagepeopleDB`.`asiakas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VillagepeopleDB`.`asiakas` (
  `asiakas_id` INT NOT NULL AUTO_INCREMENT,
  `etunimi` VARCHAR(45) NOT NULL,
  `sukunimi` VARCHAR(45) NOT NULL,
  `lahiosoite` VARCHAR(45) NULL,
  `postitoimipaikka` VARCHAR(45) NULL,
  `postinro` CHAR(5) NULL,
  `email` VARCHAR(50) NULL,
  `puhelinnro` VARCHAR(15) NULL,
  `laskutustapa` BIT(0) NULL,
  PRIMARY KEY (`asiakas_id`, `etunimi`, `sukunimi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VillagepeopleDB`.`toimipiste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VillagepeopleDB`.`toimipiste` (
  `toimipiste_id` INT NOT NULL AUTO_INCREMENT,
  `nimi` VARCHAR(45) NULL,
  `lahiosoite` VARCHAR(45) NULL,
  `postitoimipaikka` VARCHAR(45) NULL,
  `postinro` VARCHAR(45) NULL,
  `email` VARCHAR(5) NULL,
  `puhelinnro` VARCHAR(15) NULL,
  PRIMARY KEY (`toimipiste_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VillagepeopleDB`.`varaus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VillagepeopleDB`.`varaus` (
  `varaus_id` INT NOT NULL AUTO_INCREMENT,
  `varattu_pvm` VARCHAR(45) NULL,
  `vahvistus_pvm` VARCHAR(45) NULL,
  `varattu_alkupvm` VARCHAR(45) NULL,
  `asiakas_asiakas_id` INT NOT NULL,
  `asiakas_etunimi` VARCHAR(45) NOT NULL,
  `asiakas_sukunimi` VARCHAR(45) NOT NULL,
  `toimipiste_toimipiste_id` INT NOT NULL,
  PRIMARY KEY (`varaus_id`, `asiakas_asiakas_id`, `asiakas_etunimi`, `asiakas_sukunimi`, `toimipiste_toimipiste_id`),
  INDEX `fk_varaus_asiakas1_idx` (`asiakas_asiakas_id` ASC, `asiakas_etunimi` ASC, `asiakas_sukunimi` ASC) VISIBLE,
  INDEX `fk_varaus_toimipiste1_idx` (`toimipiste_toimipiste_id` ASC) VISIBLE,
  CONSTRAINT `fk_varaus_asiakas1`
    FOREIGN KEY (`asiakas_asiakas_id` , `asiakas_etunimi` , `asiakas_sukunimi`)
    REFERENCES `VillagepeopleDB`.`asiakas` (`asiakas_id` , `etunimi` , `sukunimi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_varaus_toimipiste1`
    FOREIGN KEY (`toimipiste_toimipiste_id`)
    REFERENCES `VillagepeopleDB`.`toimipiste` (`toimipiste_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VillagepeopleDB`.`lasku`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VillagepeopleDB`.`lasku` (
  `lasku_id` INT NOT NULL AUTO_INCREMENT,
  `summa` DECIMAL(8,2) NOT NULL,
  `alv` DECIMAL(8,2) NOT NULL,
  `laskutettu` BIT(1) NULL,
  `asiakas_asiakas_id` INT NOT NULL,
  `asiakas_etunimi` VARCHAR(45) NOT NULL,
  `asiakas_sukunimi` VARCHAR(45) NOT NULL,
  `varaus_varaus_id` INT NOT NULL,
  `varaus_asiakas_asiakas_id` INT NOT NULL,
  `varaus_asiakas_etunimi` VARCHAR(45) NOT NULL,
  `varaus_asiakas_sukunimi` VARCHAR(45) NOT NULL,
  `varaus_toimipiste_toimipiste_id` INT NOT NULL,
  PRIMARY KEY (`lasku_id`, `asiakas_asiakas_id`, `asiakas_etunimi`, `asiakas_sukunimi`, `varaus_varaus_id`, `varaus_asiakas_asiakas_id`, `varaus_asiakas_etunimi`, `varaus_asiakas_sukunimi`, `varaus_toimipiste_toimipiste_id`),
  INDEX `fk_lasku_asiakas1_idx` (`asiakas_asiakas_id` ASC, `asiakas_etunimi` ASC, `asiakas_sukunimi` ASC) VISIBLE,
  INDEX `fk_lasku_varaus1_idx` (`varaus_varaus_id` ASC, `varaus_asiakas_asiakas_id` ASC, `varaus_asiakas_etunimi` ASC, `varaus_asiakas_sukunimi` ASC, `varaus_toimipiste_toimipiste_id` ASC) VISIBLE,
  CONSTRAINT `fk_lasku_asiakas1`
    FOREIGN KEY (`asiakas_asiakas_id` , `asiakas_etunimi` , `asiakas_sukunimi`)
    REFERENCES `VillagepeopleDB`.`asiakas` (`asiakas_id` , `etunimi` , `sukunimi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lasku_varaus1`
    FOREIGN KEY (`varaus_varaus_id` , `varaus_asiakas_asiakas_id` , `varaus_asiakas_etunimi` , `varaus_asiakas_sukunimi` , `varaus_toimipiste_toimipiste_id`)
    REFERENCES `VillagepeopleDB`.`varaus` (`varaus_id` , `asiakas_asiakas_id` , `asiakas_etunimi` , `asiakas_sukunimi` , `toimipiste_toimipiste_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VillagepeopleDB`.`varauksen palvelut`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VillagepeopleDB`.`varauksen palvelut` (
  `varauksen_palvelut_id` INT NULL,
  `Siivous` VARCHAR(45) NULL,
  `varauksen palvelutcol` VARCHAR(45) NULL,
  PRIMARY KEY (`varauksen_palvelut_id`),
  CONSTRAINT `varaus_id`
    FOREIGN KEY (`varauksen_palvelut_id`)
    REFERENCES `VillagepeopleDB`.`varaus` (`varaus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
