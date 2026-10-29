-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `optica` ;

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`cliente` ;

CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `id_cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `numero` VARCHAR(45) NULL DEFAULT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `puerta` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_registro` DATE NULL DEFAULT NULL,
  `id_cliente_recomendador` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_recomendador_idx` (`id_cliente_recomendador` ASC),
  CONSTRAINT `fk_cliente_recomendador`
    FOREIGN KEY (`id_cliente_recomendador`)
    REFERENCES `optica`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`proveedor` ;

CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `fax` VARCHAR(45) NULL DEFAULT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `numero` VARCHAR(45) NULL DEFAULT NULL,
  `piso` VARCHAR(45) NULL DEFAULT NULL,
  `puerta` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`marca` ;

CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `id_marca` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Proveedor_id_proveedor` INT(11) NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_Marca_Proveedor1_idx` (`Proveedor_id_proveedor` ASC),
  CONSTRAINT `fk_Marca_Proveedor1`
    FOREIGN KEY (`Proveedor_id_proveedor`)
    REFERENCES `optica`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`gafa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`gafa` ;

CREATE TABLE IF NOT EXISTS `optica`.`gafa` (
  `id_gafa` INT(11) NOT NULL AUTO_INCREMENT,
  `graduacion_izquierda` DECIMAL(45,2) NULL DEFAULT NULL,
  `graduacion_derecha` DECIMAL(45,2) NULL DEFAULT NULL,
  `tipo_montura` VARCHAR(45) NULL DEFAULT NULL,
  `color_montura` VARCHAR(45) NULL DEFAULT NULL,
  `color_izquierda` VARCHAR(45) NULL DEFAULT NULL,
  `color_derecha` VARCHAR(45) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT NULL,
  `Marca_id_marca` INT(11) NOT NULL,
  PRIMARY KEY (`id_gafa`),
  INDEX `fk_Gafa_Marca1_idx` (`Marca_id_marca` ASC),
  CONSTRAINT `fk_Gafa_Marca1`
    FOREIGN KEY (`Marca_id_marca`)
    REFERENCES `optica`.`marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`empleado` ;

CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id_empleado` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`venta` ;

CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `id_venta` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `Cliente_id_cliente` INT(11) NOT NULL,
  `Empleado_id_empleado` INT(11) NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_Venta_Cliente1_idx` (`Cliente_id_cliente` ASC),
  INDEX `fk_Venta_Empleado1_idx` (`Empleado_id_empleado` ASC),
  CONSTRAINT `fk_Venta_Cliente1`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `optica`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Empleado1`
    FOREIGN KEY (`Empleado_id_empleado`)
    REFERENCES `optica`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`detalle_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`detalle_venta` ;

CREATE TABLE IF NOT EXISTS `optica`.`detalle_venta` (
  `id_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `cantidad` INT(11) NOT NULL,
  `precio_unitario` DECIMAL(45,0) NOT NULL,
  `Venta_id_venta` INT(11) NOT NULL,
  `Gafa_id_gafa` INT(11) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  INDEX `fk_Detalle_venta_Venta1_idx` (`Venta_id_venta` ASC),
  INDEX `fk_Detalle_venta_Gafa1_idx` (`Gafa_id_gafa` ASC),
  CONSTRAINT `fk_Detalle_venta_Gafa1`
    FOREIGN KEY (`Gafa_id_gafa`)
    REFERENCES `optica`.`gafa` (`id_gafa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_venta_Venta1`
    FOREIGN KEY (`Venta_id_venta`)
    REFERENCES `optica`.`venta` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
