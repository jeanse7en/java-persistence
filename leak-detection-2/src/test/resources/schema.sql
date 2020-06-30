
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema billing_report_system
-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `billing_report_system` ;
USE `billing_report_system` ;

-- -----------------------------------------------------
-- Table `billing_report_system`.`assert_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`assert_type` (
  `assetype_key` INT(11) NOT NULL AUTO_INCREMENT,
  `assetype_id` VARCHAR(45) NOT NULL,
  `denotation` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`assetype_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
COMMENT = 'Defines the assert type. Could be ASSERT_NOT_EMPTY, ASSERT_EMPTY, ASSERT_COUNT..';


-- -----------------------------------------------------
-- Table `billing_report_system`.`data_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`data_source` (
  `datasour_key` INT(11) NOT NULL AUTO_INCREMENT,
  `datasour_id` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `driver` VARCHAR(45) NOT NULL,
  `denotation` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`datasour_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 3;


-- -----------------------------------------------------
-- Table `billing_report_system`.`execution_module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`execution_module` (
  `execmodu_key` INT(11) NOT NULL AUTO_INCREMENT,
  `execmodu_id` VARCHAR(45) NOT NULL,
  `execution_reference` VARCHAR(256) NOT NULL,
  `denotation` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`execmodu_key`),
  UNIQUE INDEX `execution_reference_UNIQUE` (`execution_reference` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
COMMENT = 'Define the class reference to run a query. Or some special business';


-- -----------------------------------------------------
-- Table `billing_report_system`.`filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`filter` (
  `filter_key` INT(11) NOT NULL AUTO_INCREMENT,
  `filter_id` VARCHAR(45) NOT NULL,
  `query` VARCHAR(2000) NULL DEFAULT NULL,
  `denotation` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `has_ended` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`filter_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
COMMENT = 'Contains the SQL query';


-- -----------------------------------------------------
-- Table `billing_report_system`.`parameter_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`parameter_type` (
  `paratype_key` INT(11) NOT NULL AUTO_INCREMENT,
  `paratype_id` VARCHAR(45) NOT NULL,
  `denotation` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`paratype_key`),
  UNIQUE INDEX `denotation_UNIQUE` (`denotation` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `billing_report_system`.`parameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`parameter` (
  `param_key` INT(11) NOT NULL,
  `filter_key` INT(11) NOT NULL,
  `paratype_key` INT(11) NOT NULL,
  `key` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`param_key`),
  UNIQUE INDEX `filter_key_UNIQUE` (`filter_key` ASC),
  UNIQUE INDEX `param_key_UNIQUE` (`key` ASC),
  INDEX `parameter__fk1_idx` (`paratype_key` ASC),
  CONSTRAINT `filter_param__fk1`
    FOREIGN KEY (`filter_key`)
    REFERENCES `billing_report_system`.`filter` (`filter_key`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `parameter__fk1`
    FOREIGN KEY (`paratype_key`)
    REFERENCES `billing_report_system`.`parameter_type` (`paratype_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billing_report_system`.`rule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`rule` (
  `rule_key` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Rule unique value',
  `rule_id` VARCHAR(45) NOT NULL COMMENT 'Unit value',
  `has_ended` INT(1) NOT NULL DEFAULT 0 COMMENT '=1 if the value is not valid',
  `creation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `denotation` VARCHAR(45) NULL DEFAULT NULL COMMENT 'The denotation rule_id',
  `description` VARCHAR(45) NULL DEFAULT NULL COMMENT 'The desciption to descible about current rule',
  PRIMARY KEY (`rule_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
COMMENT = 'Defines the rule. Enable or disable a rule by setting has_ended';


-- -----------------------------------------------------
-- Table `billing_report_system`.`rule_filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`rule_filter` (
  `rulefilt_key` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'identifier',
  `rule_key` INT(11) NOT NULL,
  `filter_key` INT(11) NOT NULL,
  `execmodu_key` INT(11) NULL DEFAULT NULL,
  `assetype_key` INT(11) NULL DEFAULT NULL,
  `assert_value` VARCHAR(200) NULL DEFAULT NULL,
  `sequence_number` INT(5) NOT NULL DEFAULT 1,
  `datasour_key` INT(11) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `has_ended` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rulefilt_key`),
  INDEX `rule_filter__fk1_idx` (`execmodu_key` ASC),
  INDEX `rule_filter__fk2_idx` (`assetype_key` ASC),
  INDEX `rule_filter__fk3_idx` (`rule_key` ASC),
  INDEX `rule_filter__fk4_idx` (`filter_key` ASC),
  INDEX `rule_filter__fk5_idx` (`datasour_key` ASC),
  CONSTRAINT `rule_filter__fk1`
    FOREIGN KEY (`execmodu_key`)
    REFERENCES `billing_report_system`.`execution_module` (`execmodu_key`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `rule_filter__fk2`
    FOREIGN KEY (`assetype_key`)
    REFERENCES `billing_report_system`.`assert_type` (`assetype_key`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `rule_filter__fk3`
    FOREIGN KEY (`rule_key`)
    REFERENCES `billing_report_system`.`rule` (`rule_key`),
  CONSTRAINT `rule_filter__fk4`
    FOREIGN KEY (`filter_key`)
    REFERENCES `billing_report_system`.`filter` (`filter_key`),
  CONSTRAINT `rule_filter__fk5`
    FOREIGN KEY (`datasour_key`)
    REFERENCES `billing_report_system`.`data_source` (`datasour_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
COMMENT = 'Contains mapping wtih a list of queries. Each mapping maps with a datasource and a execution module (Class in Java)';


-- -----------------------------------------------------
-- Table `billing_report_system`.`rule_filter_parameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`rule_filter_parameter` (
  `rulfipar_key` INT(11) NOT NULL,
  `rulefilt_key` INT(11) NOT NULL,
  `param_key` INT(11) NOT NULL,
  `value` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`rulfipar_key`),
  INDEX `rule_filter_param__fk1_idx` (`rulefilt_key` ASC),
  INDEX `rule_filter_param__fk2_idx` (`param_key` ASC),
  CONSTRAINT `rule_filter_param__fk1`
    FOREIGN KEY (`rulefilt_key`)
    REFERENCES `billing_report_system`.`rule_filter` (`rulefilt_key`),
  CONSTRAINT `rule_filter_param__fk2`
    FOREIGN KEY (`param_key`)
    REFERENCES `billing_report_system`.`parameter` (`param_key`))
ENGINE = InnoDB
COMMENT = 'This table is used to store the param of a mapping rulefilter';