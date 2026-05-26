-- ============================================================
-- 移除 SnailJob 任务调度 和 Spring Boot Admin 监控 模块
-- 对应删除后端代码模块和前端管理端相关页面
-- ============================================================

-- 1. 删除角色-菜单关联
DELETE FROM sys_role_menu WHERE menu_id IN (117, 120);

-- 2. 删除菜单项
-- Admin监控菜单 (1条)
DELETE FROM sys_menu WHERE menu_id = 117;
-- 任务调度中心菜单 (1条)
DELETE FROM sys_menu WHERE menu_id = 120;

-- 3. 删除 SnailJob 表 (23张)
DROP TABLE IF EXISTS sj_distributed_lock;
DROP TABLE IF EXISTS sj_group_config;
DROP TABLE IF EXISTS sj_job;
DROP TABLE IF EXISTS sj_job_executor;
DROP TABLE IF EXISTS sj_job_log_message;
DROP TABLE IF EXISTS sj_job_summary;
DROP TABLE IF EXISTS sj_job_task;
DROP TABLE IF EXISTS sj_job_task_batch;
DROP TABLE IF EXISTS sj_namespace;
DROP TABLE IF EXISTS sj_notify_config;
DROP TABLE IF EXISTS sj_notify_recipient;
DROP TABLE IF EXISTS sj_retry;
DROP TABLE IF EXISTS sj_retry_dead_letter;
DROP TABLE IF EXISTS sj_retry_scene_config;
DROP TABLE IF EXISTS sj_retry_summary;
DROP TABLE IF EXISTS sj_retry_task;
DROP TABLE IF EXISTS sj_retry_task_log_message;
DROP TABLE IF EXISTS sj_server_node;
DROP TABLE IF EXISTS sj_system_user;
DROP TABLE IF EXISTS sj_system_user_permission;
DROP TABLE IF EXISTS sj_workflow;
DROP TABLE IF EXISTS sj_workflow_node;
DROP TABLE IF EXISTS sj_workflow_task_batch;
