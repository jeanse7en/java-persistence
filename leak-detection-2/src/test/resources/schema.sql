-- -----------------------------------------------------
-- Schema billing_report_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `billing_report_system` ;
USE `billing_report_system` ;

-- -----------------------------------------------------
-- Table `billing_report_system`.`filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`filter` (
  `filter_key` INT(11) NOT NULL AUTO_INCREMENT,
  `filter_id` VARCHAR(45) NOT NULL,
  `query` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`filter_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
COMMENT = 'Contains the SQL query';


-- -----------------------------------------------------
-- Table `billing_report_system`.`rule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_report_system`.`rule` (
  `rule_key` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Rule unique value',
  `rule_id` VARCHAR(45) NOT NULL COMMENT 'Unit value',
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
  PRIMARY KEY (`rulefilt_key`),
  INDEX `rule_filter__fk3_idx` (`rule_key` ASC),
  INDEX `rule_filter__fk4_idx` (`filter_key` ASC),
  CONSTRAINT `rule_filter__fk3`
    FOREIGN KEY (`rule_key`)
    REFERENCES `billing_report_system`.`rule` (`rule_key`),
  CONSTRAINT `rule_filter__fk4`
    FOREIGN KEY (`filter_key`)
    REFERENCES `billing_report_system`.`filter` (`filter_key`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
COMMENT = 'Contains mapping wtih a list of queries. Each mapping maps with a datasource and a execution module (Class in Java)';
