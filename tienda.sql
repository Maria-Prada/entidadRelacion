-- MySQL Script generated by MySQL Workbench
-- Fri Sep 10 17:09:24 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `tipoDocumento` VARCHAR(45) NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `rolUsuario` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `estadoCivil` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  UNIQUE INDEX `idUsuarios_UNIQUE` (`idUsuarios` ASC) VISIBLE,
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendedores` (
  `idVendedores` INT NOT NULL AUTO_INCREMENT,
  `idUsurioVendedor` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `idVendedores_UNIQUE` (`idVendedores` ASC) VISIBLE,
  PRIMARY KEY (`idVendedores`),
  INDEX `UsuarioVendedor_idx` (`idUsurioVendedor` ASC) VISIBLE,
  CONSTRAINT `UsuarioVendedor`
    FOREIGN KEY (`idUsurioVendedor`)
    REFERENCES `mydb`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `cantidad` INT NOT NULL,
  `valorUnitarioCompra` DOUBLE NOT NULL,
  `valorUnitarioVenta` DOUBLE NULL,
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ingresos` (
  `idIngresos` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `cantidadIngresoProducto` DOUBLE NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  `costoUnitario` DOUBLE NOT NULL,
  `idUsuarios` INT NOT NULL,
  PRIMARY KEY (`idIngresos`),
  UNIQUE INDEX `idIngresos_UNIQUE` (`idIngresos` ASC) VISIBLE,
  INDEX `IngresosProductos_idx` (`idProducto` ASC) VISIBLE,
  INDEX `ProveedorIngresos_idx` (`idUsuarios` ASC) VISIBLE,
  CONSTRAINT `IngresosProductos`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProveedorIngresos`
    FOREIGN KEY (`idUsuarios`)
    REFERENCES `mydb`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Egresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Egresos` (
  `idEgresos` INT NOT NULL AUTO_INCREMENT,
  `fechaVenta` DATE NOT NULL,
  `total` DOUBLE NOT NULL,
  `idVendedor` INT NOT NULL,
  UNIQUE INDEX `idEgresos_UNIQUE` (`idEgresos` ASC) VISIBLE,
  PRIMARY KEY (`idEgresos`),
  INDEX `VendedoresEgresos_idx` (`idVendedor` ASC) VISIBLE,
  CONSTRAINT `VendedoresEgresos`
    FOREIGN KEY (`idVendedor`)
    REFERENCES `mydb`.`Vendedores` (`idVendedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EgresoProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EgresoProductos` (
  `idEgresoProductos` INT NOT NULL AUTO_INCREMENT,
  `idProductos` INT NOT NULL,
  `idEgresos` INT NOT NULL,
  `cantidadVendida` DOUBLE NOT NULL,
  `precioCompra` DOUBLE NOT NULL,
  `precioVenta` DOUBLE NOT NULL,
  PRIMARY KEY (`idEgresoProductos`),
  UNIQUE INDEX `idEgresoProductos_UNIQUE` (`idEgresoProductos` ASC) VISIBLE,
  INDEX `EgresoProductos_idx` (`idProductos` ASC) VISIBLE,
  INDEX `ProductosEgreso_idx` (`idEgresos` ASC) VISIBLE,
  CONSTRAINT `EgresoProductos`
    FOREIGN KEY (`idProductos`)
    REFERENCES `mydb`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProductosEgreso`
    FOREIGN KEY (`idEgresos`)
    REFERENCES `mydb`.`Egresos` (`idEgresos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;