INSERT INTO `billing_report_system`.`data_source`(`datasour_key`,`datasour_id`,`url`,`username`,`password`,`driver`,`denotation`)
VALUES(1, 'DATA_SOURCE_A', 'jdbc:h2:mem:testdb', 'sa','','org.h2.Driver','Datasource is used to check billing wrong') ;

INSERT INTO `billing_report_system`.`execution_module`(`execmodu_key`,`execmodu_id`,`execution_reference`)
VALUES (1, 'RUN_QUERY_ONLY','com.iaas.leak.detection.execution.RunQueryExecution');

INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(1, 'QUERY_FILTER','SELECT * FROM BILLING_REPORT_SYSTEM.FILTER;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(2, 'QUERY_PARAMETER','SELECT * FROM BILLING_REPORT_SYSTEM.PARAMETER;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(3, 'QUERY_EXECUTION_MODULE','SELECT COUNT(*) FROM BILLING_REPORT_SYSTEM.EXECUTION_MODULE;');

INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (1,'ASSERT_DATA_EMPTY','the result should be empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (2,'ASSERT_DATA_NOT_EMPTY','the result should be not empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (3,'ASSERT_COUNT_EMPTY','the result should be not empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (4,'ASSERT_COUNT_NOT_EMPTY','the result should be not empty');
