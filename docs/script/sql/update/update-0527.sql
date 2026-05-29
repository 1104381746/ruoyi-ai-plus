-- sys_tenant 增加默认租户标记字段
ALTER TABLE `sys_tenant` ADD COLUMN `is_default` char(1) DEFAULT NULL COMMENT '是否默认租户（Y是 N否）';

-- 将超管租户设为初始默认租户
UPDATE `sys_tenant` SET `is_default` = 'Y' WHERE `tenant_id` = '000000';

-- 新增多租户开关配置（默认租户 000000）
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `remark`)
SELECT 2018858143803641870, '000000', '多租户开关', 'sys.multiTenancy', 'true', 'Y', 103, 1, NOW(), '多租户开关（true开启，false关闭）'
WHERE NOT EXISTS (SELECT 1 FROM `sys_config` WHERE `config_key` = 'sys.multiTenancy' AND `tenant_id` = '000000');
