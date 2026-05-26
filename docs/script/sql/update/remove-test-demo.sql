-- ============================================================
-- 移除演示模块相关表
-- test_demo / test_leave / test_tree 为代码生成器演示数据表
-- 对应 ruoyi-generator 模块已删除，演示表不再需要
-- ============================================================

-- 1. 删除演示表
DROP TABLE IF EXISTS test_demo;
DROP TABLE IF EXISTS test_leave;
DROP TABLE IF EXISTS test_tree;
