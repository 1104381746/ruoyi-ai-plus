-- ============================================================
-- 移除 ruoyi-generator 和 ruoyi-workflow 模块
-- 对应删除后端代码模块和前端管理端相关页面
-- ============================================================

-- 1. 删除角色-菜单关联
DELETE FROM sys_role_menu WHERE menu_id IN (115, 116, 1055, 1056, 1057, 1058, 1059, 1060);
DELETE FROM sys_role_menu WHERE menu_id IN (11616, 11618, 11619, 11620, 11621, 11622, 11623, 11624, 11625, 11626, 11627, 11629, 11630, 11631, 11632, 11633, 11700, 11701, 11801, 11802, 11803, 11804, 11805, 11806);

-- 2. 删除菜单项
-- 代码生成器菜单 (8条)
DELETE FROM sys_menu WHERE menu_id IN (115, 116, 1055, 1056, 1057, 1058, 1059, 1060);
-- 工作流菜单 (24条)
DELETE FROM sys_menu WHERE menu_id IN (11616, 11618, 11619, 11620, 11621, 11622, 11623, 11624, 11625, 11626, 11627, 11629, 11630, 11631, 11632, 11633, 11700, 11701, 11801, 11802, 11803, 11804, 11805, 11806);

-- 3. 删除代码生成器表 (2张)
DROP TABLE IF EXISTS gen_table;
DROP TABLE IF EXISTS gen_table_column;

-- 4. 删除工作流表 (10张)
DROP TABLE IF EXISTS flow_category;
DROP TABLE IF EXISTS flow_definition;
DROP TABLE IF EXISTS flow_his_task;
DROP TABLE IF EXISTS flow_instance;
DROP TABLE IF EXISTS flow_instance_biz_ext;
DROP TABLE IF EXISTS flow_node;
DROP TABLE IF EXISTS flow_skip;
DROP TABLE IF EXISTS flow_spel;
DROP TABLE IF EXISTS flow_task;
DROP TABLE IF EXISTS flow_user;
