-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `numero_telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Tienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Tienda` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Tienda` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Venta` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `hora_venta` TIME NOT NULL,
  `tipo_entrega` ENUM('domicilio', 'tienda') NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `Tienda_id_tienda` INT NOT NULL,
  `Cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_Venta_Tienda1_idx` (`Tienda_id_tienda` ASC),
  INDEX `fk_Venta_Cliente1_idx` (`Cliente_id_cliente` ASC),
  CONSTRAINT `fk_Venta_Tienda1`
    FOREIGN KEY (`Tienda_id_tienda`)
    REFERENCES `pizzeria`.`Tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Cliente1`
    FOREIGN KEY (`Cliente_id_cliente`)
    REFERENCES `pizzeria`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Producto` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NULL,
  `imagen` VARCHAR(300) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Categoria` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Empleado` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `cargo` ENUM('Cocinero', 'Repartidor') NOT NULL,
  `Tienda_id_tienda` INT NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `fk_Empleado_Tienda1_idx` (`Tienda_id_tienda` ASC),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  CONSTRAINT `fk_Empleado_Tienda1`
    FOREIGN KEY (`Tienda_id_tienda`)
    REFERENCES `pizzeria`.`Tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Reparto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Reparto` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Reparto` (
  `id_reparto` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora_entrega` DATETIME NULL,
  `Venta_id_venta` INT NOT NULL,
  `Empleado_id_empleado` INT NOT NULL,
  PRIMARY KEY (`id_reparto`),
  INDEX `fk_Reparto_Venta1_idx` (`Venta_id_venta` ASC),
  UNIQUE INDEX `Venta_id_venta_UNIQUE` (`Venta_id_venta` ASC),
  INDEX `fk_Reparto_Empleado1_idx` (`Empleado_id_empleado` ASC),
  CONSTRAINT `fk_Reparto_Venta1`
    FOREIGN KEY (`Venta_id_venta`)
    REFERENCES `pizzeria`.`Venta` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reparto_Empleado1`
    FOREIGN KEY (`Empleado_id_empleado`)
    REFERENCES `pizzeria`.`Empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Pizza` (
  `Producto_id_producto` INT NOT NULL,
  `Categoria_id_categoria` INT NOT NULL,
  PRIMARY KEY (`Producto_id_producto`),
  INDEX `fk_Pizza_Categoria1_idx` (`Categoria_id_categoria` ASC),
  CONSTRAINT `fk_Pizza_Producto1`
    FOREIGN KEY (`Producto_id_producto`)
    REFERENCES `pizzeria`.`Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_Categoria1`
    FOREIGN KEY (`Categoria_id_categoria`)
    REFERENCES `pizzeria`.`Categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Detalle_Venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Detalle_Venta` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Detalle_Venta` (
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `Producto_id_producto` INT NOT NULL,
  `Venta_id_venta` INT NOT NULL,
  PRIMARY KEY (`Producto_id_producto`, `Venta_id_venta`),
  INDEX `fk_Detalle_Venta_Venta1_idx` (`Venta_id_venta` ASC),
  CONSTRAINT `fk_Detalle_Venta_Producto1`
    FOREIGN KEY (`Producto_id_producto`)
    REFERENCES `pizzeria`.`Producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Venta_Venta1`
    FOREIGN KEY (`Venta_id_venta`)
    REFERENCES `pizzeria`.`Venta` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
