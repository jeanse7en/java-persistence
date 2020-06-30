DELETE FROM billing_report_system.rule_filter;
DELETE FROM billing_report_system.assert_type;
DELETE FROM billing_report_system.rule;
DELETE FROM billing_report_system.filter;
DELETE FROM billing_report_system.data_source;
DELETE FROM billing_report_system.execution_module;

INSERT INTO `billing_report_system`.`data_source`(`datasour_key`,`datasour_id`,`url`,`username`,`password`,`driver`,`description`)
VALUES(1, 'DATA_SOURCE_A', 'jdbc:mysql://127.0.0.1:3307/', 'root','abc123','com.mysql.cj.jdbc.Driver','Datasource is used to check billing wrong') ;
INSERT INTO `billing_report_system`.`data_source`(`datasour_key`,`datasour_id`,`url`,`username`,`password`,`driver`,`description`)
VALUES(2, 'DATA_SOURCE_B', 'jdbc:mysql://127.0.0.1:3308/', 'root','abc123','com.mysql.cj.jdbc.Driver','Datasource is used to check billing wrong') ;

INSERT INTO `billing_report_system`.`execution_module`(`execmodu_key`,`execmodu_id`,`execution_reference`)
VALUES (1, 'RUN_QUERY_ONLY','com.iaas.leak.detection.execution.RunQueryExecution');
INSERT INTO `billing_report_system`.`execution_module`(`execmodu_key`,`execmodu_id`,`execution_reference`)
VALUES (2, 'RUN_SPECIAL_BUSINESS','com.iaas.leak.detection.execution.WrongBillingExecution');

INSERT INTO `billing_report_system`.`parameter_type`(`paratype_key`,`paratype_id`,`description`)
VALUES (1, 'FIELD_IN', 'input field for query');
INSERT INTO `billing_report_system`.`parameter_type`(`paratype_key`,`paratype_id`,`description`)
VALUES (2, 'FIELD_OUT', 'out field for query');

INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (1,'ASSERT_DATA_EMPTY','the result should be empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (2,'ASSERT_DATA_NOT_EMPTY','the result should be not empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (3,'ASSERT_COUNT_EMPTY','the result should be not empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (4,'ASSERT_COUNT_NOT_EMPTY','the result should be not empty');
INSERT INTO `billing_report_system`.`assert_type`(`assetype_key`,`assetype_id`,`denotation`)
VALUES (5,'IGNORE','not check validation');


INSERT INTO `billing_report_system`.`rule`(`rule_key`, `rule_id`,`has_ended`)
VALUES (1, 'BILLING_CHECK_1','1');
INSERT INTO `billing_report_system`.`rule`(`rule_key`, `rule_id`,`has_ended`)
VALUES (2, 'BILLING_CHECK_2','0');
INSERT INTO `billing_report_system`.`rule`(`rule_key`, `rule_id`,`has_ended`)
VALUES (3, 'BILLING_CHECK_3','0');


INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(1, 'QUERY_FILTER','SELECT * FROM BILLING_REPORT_SYSTEM.FILTER;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(2, 'QUERY_PARAMETER','SELECT * FROM BILLING_REPORT_SYSTEM.PARAMETER;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`, `filter_id`,`query`)
VALUES(3, 'QUERY_EXECUTION_MODULE','SELECT COUNT(*) FROM BILLING_REPORT_SYSTEM.EXECUTION_MODULE;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`,`filter_id`,`query`)
VALUES(4, 'QUERY_RULE','SELECT * FROM BILLING_REPORT_SYSTEM.RULE WHERE RULE_ID = &in1;');
INSERT INTO `billing_report_system`.`filter`(`filter_key`,`filter_id`,`query`)
VALUES(5, 'QUERY_RULE_FILTER','SELECT * FROM BILLING_REPORT_SYSTEM.RULE_FILTER WHERE RULE_KEY = %in2;');

INSERT INTO `billing_report_system`.`rule_filter`(`rulefilt_key`,`rule_key`,`filter_key`,`execmodu_key`,`assetype_key`,`datasour_key`)
VALUES(1,1,1,1,1,1);
INSERT INTO `billing_report_system`.`rule_filter`(`rulefilt_key`,`rule_key`,`filter_key`,`execmodu_key`,`assetype_key`,`datasour_key`)
VALUES(2,2,2,1,2,1);
INSERT INTO `billing_report_system`.`rule_filter`(`rulefilt_key`,`rule_key`,`filter_key`,`execmodu_key`,`assetype_key`,`datasour_key`)
VALUES(3,2,3,1,2,1);
INSERT INTO `billing_report_system`.`rule_filter`(`rulefilt_key`,`rule_key`,`filter_key`,`execmodu_key`,`assetype_key`,`datasour_key`)
VALUES(4,3,3,1,2,2);



INSERT INTO `billing_report_system`.`parameter`(`param_key`,`rulefilt_key`,`paratype_key`,`key`, `value`)
VALUES(1, 4, 1, '&in1', 'BILLING_CHECK_1');
INSERT INTO `billing_report_system`.`parameter`(`param_key`,`rulefilt_key`,`param_key`,`paratype_key`,`key`, `value`)
VALUES(2, 4, 2, '&out1', 'rule_key');
INSERT INTO `billing_report_system`.`parameter`(`param_key`,`rulefilt_key`,`param_key`,`paratype_key`,`key`, `value`)
VALUES(3, 4, 2, '&in2', '&out1');


SELECT rufi.*
FROM billing_report_system.rule_filter rufi 
WHERE EXISTS (SELECT 1 FROM billing_report_system.rule rule
				WHERE rufi.rule_key = rule.rule_key
                AND rule.has_ended = 0);

SELECT rule.rule_id, rule.creation_date, filt.filter_id, filt.query, dso.datasour_id, exmo.execution_reference, asse.assetype_id
FROM billing_report_system.rule rule
LEFT JOIN billing_report_system.rule_filter rufi on rule.rule_key = rufi.rule_key
LEFT JOIN billing_report_system.execution_module exmo on rufi.execmodu_key = exmo.execmodu_key
LEFT JOIN billing_report_system.filter filt on filt.filter_key = rufi.filter_key
LEFT JOIN billing_report_system.data_source dso on dso.datasour_key = rufi.datasour_key
LEFT JOIN billing_report_system.assert_type asse on asse.assetype_key = rufi.assetype_key
WHERE 1= 1
-- rule.has_ended = 0
;
-- 0
-- WHERE EXISTS (SELECT 1 FROM billing_report_system.rule rule
-- 				WHERE rufi.rule_key = rule.rule_key
--                 AND rule.has_ended = 0);

