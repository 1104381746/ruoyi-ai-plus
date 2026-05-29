SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET sql_mode = '';


-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
                                 `id` bigint NOT NULL COMMENT '主键',
                                 `session_id` bigint NULL DEFAULT NULL COMMENT '会话id',
                                 `user_id` bigint NOT NULL COMMENT '用户id',
                                 `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '消息内容',
                                 `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对话角色',
                                 `total_tokens` int NULL DEFAULT 0 COMMENT '累计 Tokens',
                                 `model_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型名称',
                                 `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                 `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                 `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                 `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                 `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '聊天消息表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for chat_model
-- ----------------------------
DROP TABLE IF EXISTS `chat_model`;
CREATE TABLE `chat_model`  (
                               `id` bigint NOT NULL COMMENT '主键',
                               `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型分类',
                               `model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型名称',
                               `provider_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型供应商',
                               `model_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型描述',
                               `model_dimension` int NULL DEFAULT NULL COMMENT '模型维度',
                               `model_show` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否显示',
                               `api_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求地址',
                               `api_key` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密钥',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                               `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '模型管理' ROW_FORMAT = DYNAMIC;

INSERT INTO `chat_model` VALUES (2000585866022060033, 'chat', 'zai-org/glm-5', 'ppio', 'zai-org/glm-5', NULL, 'Y', 'https://api.ppio.com/openai', 'sk_xx', 103, 1, '2025-12-15 23:16:54', 1, '2026-03-15 19:18:48', 'DeepSeek-V3.2 是一款在高效推理、复杂推理能力与智能体场景中表现突出的领先模型。其基于 DeepSeek Sparse Attention（DSA）稀疏注意力机制，在显著降低计算开销的同时优化长上下文性能；通过可扩展强化学习框架，整体能力达到 GPT-5 同级，高算力版本 V3.2-Speciale 更在推理表现上接近 Gemini-3.0-Pro；同时，模型依托大型智能体任务合成管线，具备更强的工具调用与多步骤决策能力，并在 2025 年 IMO 与 IOI 中取得金牌级表现。作为 MaaS 平台，我们已对 DeepSeek-V3.2 完成深度适配，通过动态调度、批处理加速、低延迟推理与企业级 SLA 保障，进一步增强其在企业生产环境中的稳定性、性价比与可控性，适用于搜索、问答、智能体、代码、数据处理等多类高价值场景。', 0);
INSERT INTO `chat_model` VALUES (2007528268536287233, 'vector', 'baai/bge-m3', 'ppio', 'bge-m3', 1024, 'N', 'https://api.ppio.com/openai', 'sk_xx', 103, 1, '2026-01-04 03:03:32', 1, '2026-03-15 19:18:51', 'BGE-M3 是一款具备多维度能力的文本嵌入模型，可同时实现密集检索、多向量检索和稀疏检索三大核心功能。该模型设计上兼容超过100种语言，并支持从短句到长达8192词元的长文本等多种输入形式。在跨语言检索任务中，BGE-M3展现出显著优势，其性能在MIRACL、MKQA等国际基准测试中位居前列。此外，针对长文档检索场景，该模型在MLDR、NarritiveQA等数据集上的表现同样达到行业领先水平。', 0);
INSERT INTO `chat_model` VALUES (2045735140488847361, 'chat', 'deepseek-chat', 'custom_api', 'deepseek-chat', NULL, NULL, 'https://api.deepseek.com', 'sk_xx', 103, 1, '2026-04-19 13:24:00', 1, '2026-04-19 13:24:00', 'deepseek对话模型', 0);


-- ----------------------------
-- Table structure for chat_provider
-- ----------------------------
DROP TABLE IF EXISTS `chat_provider`;
CREATE TABLE `chat_provider`  (
                                  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `provider_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂商名称',
                                  `provider_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂商编码',
                                  `provider_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '厂商图标',
                                  `provider_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '厂商描述',
                                  `api_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'API地址',
                                  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
                                  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
                                  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                  `version` int NULL DEFAULT NULL COMMENT '版本',
                                  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
                                  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新IP',
                                  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `unique_provider_code`(`provider_code` ASC, `tenant_id` ASC, `del_flag` ASC) USING BTREE,
                                  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2045727230803255298 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '厂商管理表' ROW_FORMAT = DYNAMIC;

INSERT INTO `chat_provider` VALUES (1, 'OpenAI', 'openai', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/02/25/01091be272334383a1efd9bc22b73ee6.png', 'OpenAI官方API服务商', 'https://api.openai.com', '0', 1, 103, '2025-12-14 21:48:11', '1', '1', '2026-02-25 20:46:59', 'OpenAI厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (11, '深度求索', 'deepseek', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/04/19/5ba8c30f153246898a4d7dc7b846de8d.png', 'DeepSeek官方API', 'https://api.deepseek.com', '0', 0, 103, '2026-04-19 12:52:34', '1', '1', '2026-04-19 13:13:25', 'DeepSeek官方API', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (12, '智谱AI', 'zhipu', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/04/19/da071783c9284fdd9ed1ce1b57b3c75c.png', '智谱AI大模型服务', 'https://open.bigmodel.cn', '0', 4, 103, '2025-12-14 21:48:11', '1', '1', '2026-04-19 13:14:00', '智谱AI厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (13, '小米MIMO', 'xiaomi', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/04/19/18dd39365ce244e3ae5e030da036760e.png', '小米官方API', 'https://api.xiaomimimo.com/anthropic/v1/messages', '0', 3, 103, '2026-04-19 12:48:24', '1', '1', '2026-04-19 13:14:22', '小米官方API', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (14, '阿里云百炼', 'qianwen', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/02/25/de2aa7e649de44f3ba5c6380ac6acd04.png', '阿里云百炼大模型服务', 'https://dashscope.aliyuncs.com', '0', 2, 103, '2025-12-14 21:48:11', '1', '1', '2026-02-25 20:49:13', '阿里云厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (15, 'PPIO', 'ppio', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/02/25/049bb6a507174f73bba4b8d8b9e55b8a.png', 'api聚合厂商', 'https://api.ppinfra.com/openai', '0', 5, 103, '2025-12-15 23:13:42', '1', '1', '2026-02-25 20:49:01', 'api聚合厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (16, 'MiniMax', 'minimax', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/04/19/fdc712e90e0e4d78b05862ad230884e5.png', 'MiniMax大模型服务，支持M2.7、M2.5等模型', 'https://api.minimax.io/v1', '0', 6, 103, '2026-04-19 12:50:12', '1', '1', '2026-04-19 13:14:59', 'MiniMax厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (17, 'ollama', 'ollama', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/02/25/afecabebc8014d80b0f06b4796a74c5d.png', 'ollama大模型', 'http://127.0.0.1:11434', '0', 7, 103, '2025-12-14 21:48:11', '1', '1', '2026-02-25 20:48:48', 'ollama厂商', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` VALUES (18, '自定义厂商', 'custom_api', 'https://ruoyiai-1254149996.cos.ap-guangzhou.myqcloud.com/2026/04/19/c1a8e122510f4e2f90deb36958af710b.png', 'OPENAI兼容格式', '自定义', '0', 8, 103, '2026-04-19 12:35:57', '1', '1', '2026-04-19 13:17:20', 'OPENAI兼容格式', NULL, '0', NULL, 0);
INSERT INTO `chat_provider` (provider_name, provider_code, provider_icon, provider_desc, api_host, status, sort_order, create_dept, create_time, create_by, update_by, update_time, remark, version, del_flag, update_ip, tenant_id) VALUES('火山引擎', 'volcengine', '', '即梦视频生成', 'https://visual.volcengineapi.com', '0', 9, 103, '2026-05-22 09:32:52', '1', '1', '2026-05-22 09:32:52', '火山引擎即梦视频生成', NULL, '0', NULL, 0);

-- ----------------------------
-- Table structure for chat_session
-- ----------------------------
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session`  (
                                 `id` bigint NOT NULL COMMENT '主键',
                                 `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
                                 `session_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话标题',
                                 `session_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '会话内容',
                                 `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门',
                                 `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                 `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                 `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                 `conversation_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话ID',
                                 `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                 `type` varchar(10) DEFAULT 'chat' COMMENT '会话类型: chat/image/video',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会话管理' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for knowledge_attach
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_attach`;
CREATE TABLE `knowledge_attach`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                     `knowledge_id` bigint NOT NULL COMMENT '知识库ID',
                                     `oss_id` bigint NULL DEFAULT NULL COMMENT '对象存储ID',
                                     `doc_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文档ID',
                                     `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件名称',
                                     `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '附件类型',
                                     `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门',
                                     `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
                                     `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                     `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                     `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                     `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                     `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                     `status` TINYINT DEFAULT 0 COMMENT '解析状态: 0待解析, 1解析中, 2已解析, 3解析失败',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `idx_kname`(`knowledge_id` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2033199209203183619 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库附件' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for knowledge_fragment
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_fragment`;
CREATE TABLE `knowledge_fragment`  (
                                       `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                       `idx` int NOT NULL COMMENT '片段索引下标',
                                       `doc_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文档ID',
                                       `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档内容',
                                       `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门',
                                       `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
                                       `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                       `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                       `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                       `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                       `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                       `knowledge_id` bigint COMMENT '知识库ID',
                                       FULLTEXT INDEX `ft_content` (`content`) WITH PARSER ngram,
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2033199209131880451 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识片段' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for knowledge_info
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_info`;
CREATE TABLE `knowledge_info`  (
                                   `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
                                   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '知识库名称',
                                   `share` tinyint NULL DEFAULT NULL COMMENT '是否公开知识库（0 否 1是）',
                                   `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '知识库描述',
                                   `separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '知识分隔符',
                                   `overlap_char` int NULL DEFAULT NULL COMMENT '重叠字符数',
                                   `retrieve_limit` int NULL DEFAULT NULL COMMENT '知识库中检索的条数',
                                   `text_block_size` int NULL DEFAULT NULL COMMENT '文本块大小',
                                   `vector_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '向量库',
                                   `embedding_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '向量模型',
                                   `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门',
                                   `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
                                   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                   `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                   `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                   `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                   `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
                                   `enable_rerank` tinyint DEFAULT 0 NULL COMMENT '是否启用重排序（0否 1是）',
                                   `rerank_score_threshold` double NULL COMMENT '重排序相关性分数阈值',
                                   `rerank_top_n` int NULL COMMENT '重排序后返回的文档数量',
                                   `rerank_model` varchar(100) NULL COMMENT '重排序模型名称',
                                   `similarity_threshold` DOUBLE DEFAULT 0.5 COMMENT '相似度阈值',
                                   `enable_hybrid` tinyint(1) DEFAULT 0 COMMENT '是否启用混合检索',
                                   `hybrid_alpha` double DEFAULT 0.5 COMMENT '混合检索权重比例 (0.0=纯向量, 1.0=纯关键词)',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2033198818050781187 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for mcp_market_info
-- ----------------------------
DROP TABLE IF EXISTS `mcp_market_info`;
CREATE TABLE `mcp_market_info`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '市场ID',
                                    `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '市场名称',
                                    `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '市场URL',
                                    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '市场描述',
                                    `auth_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '认证配置（JSON格式）',
                                    `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED-启用, DISABLED-禁用',
                                    `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                    `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                    `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                    `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                    `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `idx_name`(`name` ASC) USING BTREE,
                                    INDEX `idx_status`(`status` ASC) USING BTREE,
                                    INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'MCP市场表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for mcp_market_tool
-- ----------------------------
DROP TABLE IF EXISTS `mcp_market_tool`;
CREATE TABLE `mcp_market_tool`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                    `market_id` bigint NOT NULL COMMENT '市场ID',
                                    `tool_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工具名称',
                                    `tool_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '工具描述',
                                    `tool_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '工具版本',
                                    `tool_metadata` json NULL COMMENT '工具元数据（JSON格式）',
                                    `is_loaded` tinyint(1) NULL DEFAULT 0 COMMENT '是否已加载到本地',
                                    `local_tool_id` bigint NULL DEFAULT NULL COMMENT '关联的本地工具ID',
                                    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `idx_market_id`(`market_id` ASC) USING BTREE,
                                    INDEX `idx_tool_name`(`tool_name` ASC) USING BTREE,
                                    INDEX `idx_is_loaded`(`is_loaded` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'MCP市场工具关联表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for mcp_tool_info
-- ----------------------------
DROP TABLE IF EXISTS `mcp_tool_info`;
CREATE TABLE `mcp_tool_info`  (
                                  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '工具ID',
                                  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工具名称',
                                  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '工具描述',
                                  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'LOCAL' COMMENT '工具类型：LOCAL-本地, REMOTE-远程, BUILTIN-内置',
                                  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED-启用, DISABLED-禁用',
                                  `config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '配置信息（JSON格式）',
                                  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `idx_name`(`name` ASC) USING BTREE,
                                  INDEX `idx_type`(`type` ASC) USING BTREE,
                                  INDEX `idx_status`(`status` ASC) USING BTREE,
                                  INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'MCP工具表' ROW_FORMAT = Dynamic;

INSERT INTO `mcp_tool_info` VALUES (1, 'edit_file', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-02-24 20:19:41', -1, '2026-03-10 21:21:09', '0');
INSERT INTO `mcp_tool_info` VALUES (2, 'list_directory', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-02-24 20:19:41', -1, '2026-03-10 21:21:09', '0');
INSERT INTO `mcp_tool_info` VALUES (3, 'read_file', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-02-24 20:19:41', -1, '2026-03-10 21:21:09', '0');
INSERT INTO `mcp_tool_info` VALUES (4, 'query_all_tables', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-03-10 21:21:09', -1, '2026-03-10 21:21:09', '0');
INSERT INTO `mcp_tool_info` VALUES (5, 'execute_sql_query', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-03-10 21:21:09', -1, '2026-03-10 21:21:09', '0');
INSERT INTO `mcp_tool_info` VALUES (6, 'query_table_schema', '', 'BUILTIN', 'ENABLED', NULL, '000000', -1, -1, '2026-03-10 21:21:09', -1, '2026-03-10 21:21:09', '0');


-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE `sys_client`  (
                               `id` bigint NOT NULL COMMENT 'id',
                               `client_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端id',
                               `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端key',
                               `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
                               `grant_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授权类型',
                               `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备类型',
                               `active_timeout` int NULL DEFAULT 1800 COMMENT 'token活跃超时时间',
                               `timeout` int NULL DEFAULT 604800 COMMENT 'token固定超时',
                               `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                               `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统授权表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_client` VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2026-02-03 05:14:53', 1, '2026-02-03 05:14:53');
INSERT INTO `sys_client` VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', '0', 103, 1, '2026-02-03 05:14:53', 1, '2026-02-03 05:14:53');
INSERT INTO `sys_client` VALUES (2033738530356912129, '0d4c873ff6146ecd7f38e2e45526ab1b', 'web', 'web123', 'sms,email,password', 'pc', 1800, 604800, '0', '0', 103, 1, '2026-03-17 10:53:45', 1, '2026-03-17 10:59:16');


-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
                               `config_id` bigint NOT NULL COMMENT '参数主键',
                               `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                               `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
                               `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
                               `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
                               `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_config` VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, 'true:开启, false:关闭');
INSERT INTO `sys_config` VALUES (2018858143803641858, '154726', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2018858143803641859, '154726', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '初始化密码 123456');
INSERT INTO `sys_config` VALUES (2018858143803641860, '154726', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (2018858143803641861, '154726', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (2018858143803641862, '154726', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', 'true:开启, false:关闭');
INSERT INTO `sys_config` VALUES (2018858143803641870, '000000', '多租户开关', 'sys.multiTenancy', 'true', 'Y', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '多租户开关（true开启，false关闭）');


-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                             `dept_id` bigint NOT NULL COMMENT '部门id',
                             `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                             `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
                             `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
                             `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
                             `dept_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门类别编码',
                             `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
                             `leader` bigint NULL DEFAULT NULL COMMENT '负责人',
                             `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
                             `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                             `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                             `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', '熊猫科技', NULL, 0, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:38', 1, '2026-02-06 00:38:24');
INSERT INTO `sys_dept` VALUES (101, '000000', 100, '0,100', '总公司', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:38', NULL, NULL);
INSERT INTO `sys_dept` VALUES (102, '000000', 100, '0,100', '分公司', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:38', NULL, NULL);
INSERT INTO `sys_dept` VALUES (103, '000000', 101, '0,100,101', '研发部门', NULL, 1, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (104, '000000', 101, '0,100,101', '市场部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (105, '000000', 101, '0,100,101', '测试部门', NULL, 3, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (106, '000000', 101, '0,100,101', '财务部门', NULL, 4, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (107, '000000', 101, '0,100,101', '运维部门', NULL, 5, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (108, '000000', 102, '0,100,102', '市场部门', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (109, '000000', 102, '0,100,102', '财务部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (2018858143262576642, '154726', 0, '0', '测试', NULL, 0, 2018858143623286785, NULL, NULL, '0', '0', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25');


-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
                                  `dict_code` bigint NOT NULL COMMENT '字典编码',
                                  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
                                  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
                                  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
                                  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
                                  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
                                  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '密码认证');
INSERT INTO `sys_dict_data` VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '短信认证');
INSERT INTO `sys_dict_data` VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '邮件认证');
INSERT INTO `sys_dict_data` VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '小程序认证');
INSERT INTO `sys_dict_data` VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, '三方登录认证');
INSERT INTO `sys_dict_data` VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-03 05:14:51', NULL, NULL, 'PC');
INSERT INTO `sys_dict_data` VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '安卓');
INSERT INTO `sys_dict_data` VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-03 05:14:52', NULL, NULL, 'iOS');
INSERT INTO `sys_dict_data` VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '小程序');
INSERT INTO `sys_dict_data` VALUES (2018858143749115906, '154726', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '性别男');
INSERT INTO `sys_dict_data` VALUES (2018858143749115907, '154726', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '性别女');
INSERT INTO `sys_dict_data` VALUES (2018858143749115908, '154726', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '性别未知');
INSERT INTO `sys_dict_data` VALUES (2018858143749115909, '154726', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '显示菜单');
INSERT INTO `sys_dict_data` VALUES (2018858143749115910, '154726', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (2018858143749115911, '154726', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '正常状态');
INSERT INTO `sys_dict_data` VALUES (2018858143749115912, '154726', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '停用状态');
INSERT INTO `sys_dict_data` VALUES (2018858143749115913, '154726', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '系统默认是');
INSERT INTO `sys_dict_data` VALUES (2018858143753310209, '154726', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '系统默认否');
INSERT INTO `sys_dict_data` VALUES (2018858143753310210, '154726', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '通知');
INSERT INTO `sys_dict_data` VALUES (2018858143753310211, '154726', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '公告');
INSERT INTO `sys_dict_data` VALUES (2018858143753310212, '154726', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '正常状态');
INSERT INTO `sys_dict_data` VALUES (2018858143753310213, '154726', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '关闭状态');
INSERT INTO `sys_dict_data` VALUES (2018858143753310214, '154726', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '新增操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310215, '154726', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '修改操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310216, '154726', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '删除操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310217, '154726', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '授权操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310218, '154726', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '导出操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310219, '154726', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '导入操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310220, '154726', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '强退操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310221, '154726', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '生成操作');
INSERT INTO `sys_dict_data` VALUES (2018858143753310222, '154726', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '清空操作');
INSERT INTO `sys_dict_data` VALUES (2018858143757504514, '154726', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '正常状态');
INSERT INTO `sys_dict_data` VALUES (2018858143757504515, '154726', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '停用状态');
INSERT INTO `sys_dict_data` VALUES (2018858143757504516, '154726', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '其他操作');
INSERT INTO `sys_dict_data` VALUES (2018858143757504517, '154726', 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '密码认证');
INSERT INTO `sys_dict_data` VALUES (2018858143757504518, '154726', 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '短信认证');
INSERT INTO `sys_dict_data` VALUES (2018858143757504519, '154726', 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '邮件认证');
INSERT INTO `sys_dict_data` VALUES (2018858143757504520, '154726', 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '小程序认证');
INSERT INTO `sys_dict_data` VALUES (2018858143757504521, '154726', 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '三方登录认证');
INSERT INTO `sys_dict_data` VALUES (2018858143757504522, '154726', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', 'PC');
INSERT INTO `sys_dict_data` VALUES (2018858143761698817, '154726', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '安卓');
INSERT INTO `sys_dict_data` VALUES (2018858143761698818, '154726', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', 'iOS');
INSERT INTO `sys_dict_data` VALUES (2018858143761698819, '154726', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '小程序');
INSERT INTO `sys_dict_data` VALUES (2026642472673288194, '000000', 0, '对话', 'chat', 'chat_model_category', NULL, 'cyan', 'N', 103, 1, '2026-02-25 20:56:33', 1, '2026-02-25 21:01:42', NULL);
INSERT INTO `sys_dict_data` VALUES (2026642525081116674, '000000', 1, '图像', 'image', 'chat_model_category', NULL, 'success', 'N', 103, 1, '2026-02-25 20:56:46', 1, '2026-02-25 21:01:37', NULL);
INSERT INTO `sys_dict_data` VALUES (2026643983713247233, '000000', 1, '次数计费', '1', 'sys_model_billing', NULL, 'green', 'N', 103, 1, '2026-02-25 21:02:34', 1, '2026-02-25 21:02:56', NULL);
INSERT INTO `sys_dict_data` VALUES (2026644058522853378, '000000', 2, 'token计费', '2', 'sys_model_billing', NULL, 'primary', 'N', 103, 1, '2026-02-25 21:02:51', 1, '2026-02-25 21:02:51', NULL);
INSERT INTO `sys_dict_data` VALUES (2027261114955931650, '000000', 2, '向量', 'vector', 'chat_model_category', NULL, 'default', 'N', 103, 1, '2026-02-27 13:54:49', 1, '2026-02-27 13:54:54', NULL);


-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
                                  `dict_id` bigint NOT NULL COMMENT '字典主键',
                                  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
                                  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
                                  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                  PRIMARY KEY (`dict_id`) USING BTREE,
                                  UNIQUE INDEX `tenant_id`(`tenant_id` ASC, `dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '认证授权类型');
INSERT INTO `sys_dict_type` VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2026-02-03 05:14:50', NULL, NULL, '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES (2018858143719755777, '154726', '用户性别', 'sys_user_sex', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2018858143719755778, '154726', '菜单状态', 'sys_show_hide', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950081, '154726', '系统开关', 'sys_normal_disable', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950082, '154726', '系统是否', 'sys_yes_no', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950083, '154726', '通知类型', 'sys_notice_type', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950084, '154726', '通知状态', 'sys_notice_status', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950085, '154726', '操作类型', 'sys_oper_type', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950086, '154726', '系统状态', 'sys_common_status', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (2018858143723950087, '154726', '授权类型', 'sys_grant_type', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '认证授权类型');
INSERT INTO `sys_dict_type` VALUES (2018858143723950088, '154726', '设备类型', 'sys_device_type', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES (2026642112982360066, '000000', '模型分类', 'chat_model_category', 103, 1, '2026-02-25 20:55:08', 1, '2026-02-25 20:55:08', '模型分类');
INSERT INTO `sys_dict_type` VALUES (2026642183606050817, '000000', '计费方式', 'sys_model_billing', 103, 1, '2026-02-25 20:55:24', 1, '2026-02-25 20:55:24', '计费方式');


-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
                                   `info_id` bigint NOT NULL COMMENT '访问ID',
                                   `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                   `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
                                   `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '客户端',
                                   `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备类型',
                                   `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
                                   `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
                                   `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
                                   `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
                                   `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                   `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
                                   `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
                                   PRIMARY KEY (`info_id`) USING BTREE,
                                   INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
                                   INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;



-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `menu_id` bigint NOT NULL COMMENT '菜单ID',
                             `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
                             `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
                             `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
                             `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
                             `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
                             `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
                             `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
                             `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
                             `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                             `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
                             `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                             `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
                             `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
                             `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                             `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
                             PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1, '系统管理', 0, 3, 'system', '', '', 1, 0, 'M', '0', '0', '', 'eos-icons:system-group', 103, 1, '2025-12-14 16:11:49', 1, '2026-01-01 19:06:19', '系统管理目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2, '系统监控', 0, 3, 'monitor', '', '', 1, 0, 'M', '0', '0', '', 'solar:monitor-camera-outline', 103, 1, '2025-12-14 16:11:49', 1, '2025-12-14 17:56:44', '系统监控目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(6, '租户管理', 0, 8, 'tenant', '', '', 1, 0, 'M', '0', '0', '', 'ph:users-light', 103, 1, '2025-12-14 16:11:49', 1, '2026-02-25 20:42:14', '租户管理目录');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'ant-design:user-outlined', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '用户管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'eos-icons:role-binding-outlined', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '角色管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'ic:sharp-menu', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '菜单管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'mingcute:department-line', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '部门管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'icon-park-outline:appointment', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '岗位管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'fluent-mdl2:dictionary', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '字典管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'ant-design:setting-outlined', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '参数设置菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'fe:notice-push', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '通知公告菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'material-symbols:logo-dev-outline', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '日志管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'material-symbols:generating-tokens-outline', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '在线用户菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'devicon:redis-wordmark', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '缓存监控菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'solar:folder-with-files-outline', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '文件管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', '', 1, 0, 'C', '0', '0', 'system:tenant:list', 'ph:user-list', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '租户管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', 1, 0, 'C', '0', '0', 'system:tenantPackage:list', 'bx:package', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '租户套餐管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(123, '客户端管理', 1, 11, 'client', 'system/client/index', '', 1, 0, 'C', '0', '0', 'system:client:list', 'solar:monitor-smartphone-outline', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '客户端管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(132, '字典数据', 1, 6, 'dict-data/index/:dictId', 'system/dict/data', '', 1, 1, 'C', '1', '0', 'system:dict:list', '#', 103, 1, '2025-12-14 16:11:49', 1, '2026-05-26 21:32:46', '/system/dict');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(133, '文件配置管理', 1, 10, 'oss-config/index', 'system/oss/config', '', 1, 1, 'C', '0', '0', 'system:ossConfig:list', 'ant-design:setting-outlined', 103, 1, '2025-12-14 16:11:49', 1, '2026-05-26 21:30:01', '/system/oss');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'arcticons:one-hand-operation', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '操作日志菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'streamline:interface-login-dial-pad-finger-password-dial-pad-dot-finger', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '登录日志菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1061, '客户端管理查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1062, '客户端管理新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1063, '客户端管理修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1064, '客户端管理删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1065, '客户端管理导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1600, '文件查询', 118, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1601, '文件上传', 118, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1602, '文件下载', 118, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:download', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1603, '文件删除', 118, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1606, '租户查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1607, '租户新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1608, '租户修改', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1609, '租户删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1610, '租户导出', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1611, '租户套餐查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:query', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1612, '租户套餐新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1613, '租户套餐修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1614, '租户套餐删除', 122, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1615, '租户套餐导出', 122, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:export', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1620, '配置列表', 118, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:list', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1621, '配置添加', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:add', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1622, '配置编辑', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:edit', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(1623, '配置删除', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, '2025-12-14 16:11:49', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000, 'MCP管理', 0, 2, 'mcp', '', '', 1, 0, 'M', '0', '0', '', 'mdi:robot-industrial', 103, 1, '2026-02-24 20:02:47', 1, '2026-02-25 20:41:54', 'MCP模块管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2001, 'MCP工具管理', 2000, 1, 'tool', 'mcp/tool/index', '', 1, 0, 'C', '0', '0', 'mcp:tool:list', 'octicon:tools-24', 103, 1, '2026-02-24 20:02:47', 1, '2026-02-25 20:41:27', 'MCP工具管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2002, 'MCP工具查询', 2001, 1, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:query', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2003, 'MCP工具新增', 2001, 2, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:add', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2004, 'MCP工具修改', 2001, 3, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:edit', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2005, 'MCP工具删除', 2001, 4, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:remove', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006, 'MCP工具测试', 2001, 5, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:test', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2007, 'MCP工具导出', 2001, 6, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:tool:export', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2010, 'MCP市场管理', 2000, 2, 'market', 'mcp/market/index', '', 1, 0, 'C', '0', '0', 'mcp:market:list', 'mdi:storefront-outline', 103, 1, '2026-02-24 20:02:47', NULL, NULL, 'MCP市场管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2011, 'MCP市场查询', 2010, 1, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:query', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2012, 'MCP市场新增', 2010, 2, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:add', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2013, 'MCP市场修改', 2010, 3, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:edit', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2014, 'MCP市场删除', 2010, 4, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:remove', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2015, 'MCP市场刷新', 2010, 5, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:refresh', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2016, 'MCP工具加载', 2010, 6, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:load', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2017, 'MCP市场导出', 2010, 7, '#', '', '', 1, 0, 'F', '0', '0', 'mcp:market:export', '#', 103, 1, '2026-02-24 20:02:47', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000209300188356609, '对话管理', 0, 0, 'chat', '', NULL, 1, 0, 'M', '0', '0', NULL, 'material-symbols:chat-outline', 103, 1, '2025-12-14 22:20:34', 1, '2025-12-14 22:21:24', '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892738, '厂商管理', 2000209300188356609, 1, 'provider', 'chat/provider/index', NULL, 1, 0, 'C', '0', '0', 'system:provider:list', 'tabler:cube-spark', 103, 1, '2025-12-14 22:28:05', 1, '2025-12-14 23:42:55', '厂商管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892739, '厂商管理查询', 2000210913451892738, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:provider:query', '#', 103, 1, '2025-12-14 22:28:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892740, '厂商管理新增', 2000210913451892738, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:provider:add', '#', 103, 1, '2025-12-14 22:28:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892741, '厂商管理修改', 2000210913451892738, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:provider:edit', '#', 103, 1, '2025-12-14 22:28:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892742, '厂商管理删除', 2000210913451892738, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:provider:remove', '#', 103, 1, '2025-12-14 22:28:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913451892743, '厂商管理导出', 2000210913451892738, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:provider:export', '#', 103, 1, '2025-12-14 22:28:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157314, '模型管理', 2000209300188356609, 1, 'model', 'chat/model/index', NULL, 1, 0, 'C', '0', '0', 'system:model:list', 'carbon:model-alt', 103, 1, '2025-12-14 22:27:59', 1, '2025-12-15 00:51:01', '模型管理菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157315, '模型管理查询', 2000210913846157314, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:query', '#', 103, 1, '2025-12-14 22:27:59', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157316, '模型管理新增', 2000210913846157314, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:add', '#', 103, 1, '2025-12-14 22:27:59', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157317, '模型管理修改', 2000210913846157314, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:edit', '#', 103, 1, '2025-12-14 22:27:59', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157318, '模型管理删除', 2000210913846157314, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:remove', '#', 103, 1, '2025-12-14 22:27:59', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210913846157319, '模型管理导出', 2000210913846157314, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:export', '#', 103, 1, '2025-12-14 22:28:00', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823809, '聊天消息', 2000209300188356609, 1, 'message', 'chat/message/index', NULL, 1, 0, 'C', '0', '0', 'system:message:list', 'system-uicons:message', 103, 1, '2025-12-14 22:27:54', 1, '2025-12-15 00:53:47', '聊天消息菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823810, '聊天消息查询', 2000210914680823809, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:query', '#', 103, 1, '2025-12-14 22:27:54', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823811, '聊天消息新增', 2000210914680823809, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:add', '#', 103, 1, '2025-12-14 22:27:54', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823812, '聊天消息修改', 2000210914680823809, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:edit', '#', 103, 1, '2025-12-14 22:27:54', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823813, '聊天消息删除', 2000210914680823809, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:remove', '#', 103, 1, '2025-12-14 22:27:54', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2000210914680823814, '聊天消息导出', 2000210914680823809, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:export', '#', 103, 1, '2025-12-14 22:27:54', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813441, '知识管理', 2000209300188356609, 1, 'info', 'knowledge/info/index', NULL, 1, 0, 'C', '0', '0', 'knowledge:info:list', 'solar:book-line-duotone', 103, 1, '2026-01-01 18:59:05', 1, '2026-03-15 21:07:50', '知识库菜单');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813442, '知识库查询', 2006681261898813441, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:info:query', '#', 103, 1, '2026-01-01 18:59:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813443, '知识库新增', 2006681261898813441, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:info:add', '#', 103, 1, '2026-01-01 18:59:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813444, '知识库修改', 2006681261898813441, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:info:edit', '#', 103, 1, '2026-01-01 18:59:05', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813445, '知识库删除', 2006681261898813441, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:info:remove', '#', 103, 1, '2026-01-01 18:59:06', NULL, NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, `path`, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark) VALUES(2006681261898813446, '知识库导出', 2006681261898813441, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:info:export', '#', 103, 1, '2026-01-01 18:59:06', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
                               `notice_id` bigint NOT NULL COMMENT '公告ID',
                               `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                               `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
                               `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
                               `notice_content` longblob NULL COMMENT '公告内容',
                               `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_notice` VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 103, 1, '2026-02-03 05:14:52', NULL, NULL, '管理员');


-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
                                 `oper_id` bigint NOT NULL COMMENT '日志主键',
                                 `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                 `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
                                 `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                 `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
                                 `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
                                 `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                 `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
                                 `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
                                 `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
                                 `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
                                 `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
                                 `oper_param` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
                                 `json_result` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
                                 `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
                                 `error_msg` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
                                 `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
                                 `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
                                 PRIMARY KEY (`oper_id`) USING BTREE,
                                 INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
                                 INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
                                 INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
                            `oss_id` bigint NOT NULL COMMENT '对象存储主键',
                            `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                            `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
                            `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '原名',
                            `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
                            `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'URL地址',
                            `ext1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扩展字段',
                            `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                            `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                            `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
                            `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                            `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
                            `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
                            PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
                                   `oss_config_id` bigint NOT NULL COMMENT '主键',
                                   `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                   `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置key',
                                   `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'accessKey',
                                   `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '秘钥',
                                   `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '桶名称',
                                   `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前缀',
                                   `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '访问站点',
                                   `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自定义域名',
                                   `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
                                   `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '域',
                                   `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
                                   `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
                                   `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
                                   `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                   `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                   `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                   `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                   `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                   PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对象存储配置表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_oss_config` VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2026-02-03 05:14:52', 1, '2026-02-25 15:44:13', NULL);
INSERT INTO `sys_oss_config` VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-02-03 05:14:52', 1, '2026-02-03 05:14:52', NULL);
INSERT INTO `sys_oss_config` VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-02-03 05:14:52', 1, '2026-02-03 05:14:52', NULL);
INSERT INTO `sys_oss_config` VALUES (4, '000000', 'qcloud', 'xx', 'xx', 'ruoyiai-1254149996', '', 'cos.ap-guangzhou.myqcloud.com', '', 'Y', 'ap-guangzhou', '1', '0', '', 103, 1, '2026-02-03 05:14:52', 1, '2026-03-15 17:56:06', '');
INSERT INTO `sys_oss_config` VALUES (5, '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2026-02-03 05:14:53', 1, '2026-02-03 05:14:53', NULL);


-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
                             `post_id` bigint NOT NULL COMMENT '岗位ID',
                             `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                             `dept_id` bigint NOT NULL COMMENT '部门id',
                             `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
                             `post_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '岗位类别编码',
                             `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
                             `post_sort` int NOT NULL COMMENT '显示顺序',
                             `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
                             `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                             `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_post` VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');


-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `role_id` bigint NOT NULL COMMENT '角色ID',
                             `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                             `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
                             `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
                             `role_sort` int NOT NULL COMMENT '显示顺序',
                             `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
                             `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
                             `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
                             `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                             `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                             `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_role` VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (3, '000000', '本部门及以下', 'test1', 3, '4', 1, 1, '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');
INSERT INTO `sys_role` VALUES (4, '000000', '仅本人', 'test2', 4, '5', 1, 1, '0', '0', 103, 1, '2026-02-03 05:14:39', NULL, NULL, '');
INSERT INTO `sys_role` VALUES (2018858143199662082, '154726', '管理员', 'admin', 1, '1', 1, 1, '0', '0', 103, 1, '2026-02-04 09:24:25', 1, '2026-02-04 09:24:25', NULL);


-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  `dept_id` bigint NOT NULL COMMENT '部门ID',
                                  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_role_dept` VALUES (2018858143199662082, 2018858143262576642);


-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  `menu_id` bigint NOT NULL COMMENT '菜单ID',
                                  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (4, 5);
INSERT INTO `sys_role_menu` VALUES (2018858143199662082, 1);


-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS `sys_social`;
CREATE TABLE `sys_social`  (
                               `id` bigint NOT NULL COMMENT '主键',
                               `user_id` bigint NOT NULL COMMENT '用户ID',
                               `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户id',
                               `auth_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台+平台唯一id',
                               `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户来源',
                               `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台编号唯一id',
                               `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
                               `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户昵称',
                               `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
                               `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
                               `access_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户的授权令牌',
                               `expire_in` int NULL DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
                               `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
                               `access_code` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
                               `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的 unionid',
                               `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
                               `token_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
                               `id_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'id token，部分平台可能没有',
                               `mac_algorithm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
                               `mac_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
                               `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
                               `oauth_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
                               `oauth_token_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '社会化关系表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
                               `id` bigint NOT NULL COMMENT 'id',
                               `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户编号',
                               `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
                               `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
                               `company_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业名称',
                               `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
                               `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
                               `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业简介',
                               `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '域名',
                               `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                               `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
                               `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
                               `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
                               `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
                               `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否默认租户（Y是 N否）',
                               `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                               `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                               `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_tenant` VALUES (1, '000000', '管理组', '15888888888', '熊猫科技有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, 2018611998196109314, NULL, -1, '0', 'Y', '0', 103, 1, '2026-02-03 05:14:38', NULL, NULL);


-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
                                       `package_id` bigint NOT NULL COMMENT '租户套餐id',
                                       `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐名称',
                                       `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联菜单id',
                                       `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                                       `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
                                       `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                       `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                                       `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                                       `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                                       `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                       `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                                       `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                       PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户套餐表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_tenant_package` VALUES (2018611998196109314, '测试套餐', '1,100,101,102,103,104,105,106,107,108,109,115,118,123,2,3,500,501,1001,1002,1003,1004,1005,1006,1007,131,1008,1009,1010,1011,1012,130,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,132,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1050,1600,1601,1602,1603,1620,1621,1622,1623,133,1061,1062,1063,1064,1065,1046,1047,1048,113,117,120,1055,1056,1058,1057,1059,1060,116', '测试套餐', 1, '0', '0', 103, 1, '2026-02-03 17:06:19', 1, '2026-02-06 00:37:44');


-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `user_id` bigint NOT NULL COMMENT '用户ID',
                             `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                             `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
                             `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
                             `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
                             `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
                             `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
                             `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
                             `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                             `avatar` bigint NULL DEFAULT NULL COMMENT '头像地址',
                             `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
                             `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
                             `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
                             `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
                             `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
                             `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
                             `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信用户标识',
                             `user_balance` double(20, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
                             PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_user` VALUES (1, '000000', 103, 'admin', 'admin', 'sys_user', 'ageerle@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-15 23:55:23', 103, 1, '2026-02-05 09:22:12', -1, '2026-03-15 23:55:23', '管理员', NULL, 0.00);
INSERT INTO `sys_user` VALUES (3, '000000', 108, 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2026-02-05 09:22:12', 103, 1, '2026-02-05 09:22:12', 3, '2026-02-05 09:22:12', NULL, NULL, 0.00);
INSERT INTO `sys_user` VALUES (4, '000000', 102, 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2026-02-05 09:22:12', 103, 1, '2026-02-05 09:22:12', 4, '2026-02-05 09:22:12', NULL, NULL, 0.00);


-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
                                  `user_id` bigint NOT NULL COMMENT '用户ID',
                                  `post_id` bigint NOT NULL COMMENT '岗位ID',
                                  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_user_post` VALUES (1, 1);


-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                  `user_id` bigint NOT NULL COMMENT '用户ID',
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (4, 4);
INSERT INTO `sys_user_role` VALUES (2018858143623286785, 2018858143199662082);


-- ----------------------------
-- Table structure for t_workflow
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow`;
CREATE TABLE `t_workflow`  (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'uuid',
                               `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '标题',
                               `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
                               `is_public` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否公开',
                               `is_enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
                               `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 默认0不删除',
                               `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流定义（用户定义的工作流）| Workflow Definition' ROW_FORMAT = DYNAMIC;

INSERT INTO `t_workflow` VALUES (119, '7c95c7892dd544788d90e49ce2fad966', '测试工作流', 1, 1, 1, '2025-11-07 16:44:41', '2025-11-07 16:44:41', '测试工作流', 0, '000000');


-- ----------------------------
-- Table structure for t_workflow_component
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow_component`;
CREATE TABLE `t_workflow_component`  (
                                         `id` bigint NOT NULL AUTO_INCREMENT,
                                         `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
                                         `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
                                         `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
                                         `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                                         `display_order` int NOT NULL DEFAULT 0,
                                         `is_enable` tinyint(1) NOT NULL DEFAULT 0,
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
                                         `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                         PRIMARY KEY (`id`) USING BTREE,
                                         INDEX `idx_display_order`(`display_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流组件库 | Workflow Component' ROW_FORMAT = DYNAMIC;

INSERT INTO `t_workflow_component` VALUES (17, '5cd68dccbbb411f0bb7840c2ba9a7fbc', 'Start', '开始', '流程由此开始', 0, 1, '2025-11-07 16:32:49', '2025-11-07 16:32:49', 0, '000000');
INSERT INTO `t_workflow_component` VALUES (18, '5cd6ac69bbb411f0bb7840c2ba9a7fbc', 'End', '结束', '流程由此结束', 0, 1, '2025-11-07 16:32:49', '2025-11-07 16:32:49', 0, '000000');
INSERT INTO `t_workflow_component` VALUES (19, '5cd6c8eabbb411f0bb7840c2ba9a7fbc', 'Answer', '生成回答', '调用大语言模型回答问题', 0, 1, '2025-11-07 16:32:49', '2025-11-07 16:32:49', 0, '000000');
INSERT INTO `t_workflow_component` VALUES (25, '0b4369bb60dc46d6bd84ceb4e36184dc', 'KeywordExtractor', '关键词提取', '从文本中提取关键词', 0, 1, '2025-12-26 16:30:05', '2025-12-26 16:30:05', 0, '000000');
INSERT INTO `t_workflow_component` VALUES (26, 'bb00fc2f52c74fec82ee3f99725b56bb', 'Switcher', '条件分支', '根据条件执行不同分支', 0, 1, '2025-12-26 16:30:46', '2025-12-26 16:30:46', 0, '000000');
INSERT INTO `t_workflow_component` VALUES (36, 'f37dbcb8f0d5464d90fbb22774490a56', 'HumanFeedback', '人类', '人机沟通', 0, 1, '2025-12-30 17:37:14', '2025-12-30 17:37:14', 0, '000000');


-- ----------------------------
-- Table structure for t_workflow_edge
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow_edge`;
CREATE TABLE `t_workflow_edge`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                    `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '边唯一标识',
                                    `workflow_id` bigint NOT NULL DEFAULT 0 COMMENT '所属工作流定义 id',
                                    `source_node_uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '起始节点 uuid',
                                    `source_handle` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '起始锚点标识',
                                    `target_node_uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '目标节点 uuid',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：0 正常，1 已删',
                                    `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `idx_workflow_edge_workflow_id`(`workflow_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 201 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流定义的边 | Edge of Workflow Definition' ROW_FORMAT = DYNAMIC;

INSERT INTO `t_workflow_edge` VALUES (199, '6eddc13ea3e44baebaaca5bbc7f5ba8f', 119, 'f4660cebe26b439f8264ad0111b56c85', '', '1b9c6f83822546b9af497e48108cea71', '2026-02-02 18:21:18', '2026-02-02 18:21:18', 0, '000000');
INSERT INTO `t_workflow_edge` VALUES (200, '9f500dce66354be99f14f53a7dbaa6c7', 119, '1b9c6f83822546b9af497e48108cea71', '', 'b3a95e6a16104598909269ed8cb3bb04', '2026-02-02 18:21:18', '2026-02-02 18:21:18', 0, '000000');


-- ----------------------------
-- Table structure for t_workflow_node
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow_node`;
CREATE TABLE `t_workflow_node`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                    `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '节点唯一标识',
                                    `workflow_id` bigint NOT NULL DEFAULT 0 COMMENT '所属工作流定义 id',
                                    `workflow_component_id` bigint NOT NULL DEFAULT 0 COMMENT '引用的组件 id',
                                    `user_id` bigint NOT NULL DEFAULT 0 COMMENT '创建人',
                                    `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '节点标题',
                                    `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '节点备注',
                                    `input_config` json NOT NULL COMMENT '输入参数模板，例：{\"params\":[{\"name\":\"user_define_param01\",\"type\":\"string\"}]}',
                                    `node_config` json NULL COMMENT '节点执行配置，例：{\"params\":[{\"prompt\":\"Summarize the following content:{user_define_param01}\"}]}',
                                    `position_x` double NOT NULL DEFAULT 0 COMMENT '画布 x 坐标',
                                    `position_y` double NOT NULL DEFAULT 0 COMMENT '画布 y 坐标',
                                    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：0 正常，1 已删',
                                    `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `idx_workflow_node_workflow_id`(`workflow_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 272 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流定义的节点 | Node of Workflow Definition' ROW_FORMAT = DYNAMIC;

INSERT INTO `t_workflow_node` VALUES (269, 'f4660cebe26b439f8264ad0111b56c85', 119, 17, 0, '开始', '用户输入', '{\"ref_inputs\": [], \"user_inputs\": [{\"name\": \"var_user_input\", \"type\": 1, \"uuid\": \"dc9590d781764ace943bf03b383e742b\", \"title\": \"用户输入\", \"required\": false, \"max_length\": 1000}]}', '{}', -336.4794845046116, -67.23231445984582, '2025-11-07 16:44:41', '2026-02-02 18:21:17', 0, '000000');
INSERT INTO `t_workflow_node` VALUES (270, 'b3a95e6a16104598909269ed8cb3bb04', 119, 18, 0, '结束', '', '{\"ref_inputs\": [], \"user_inputs\": []}', '{\"result\": \"\"}', 186.97027554892657, 275.3464833818887, '2026-02-02 18:21:17', '2026-02-02 18:21:17', 0, '000000');
INSERT INTO `t_workflow_node` VALUES (271, '1b9c6f83822546b9af497e48108cea71', 119, 19, 0, '生成回答', '', '{\"ref_inputs\": [], \"user_inputs\": []}', '{\"prompt\": \"\", \"category\": \"\", \"model_name\": \"\"}', -46.766188892645644, 7.548790841996912, '2026-02-02 18:21:17', '2026-02-02 18:21:17', 0, '000000');


-- ----------------------------
-- Table structure for t_workflow_runtime
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow_runtime`;
CREATE TABLE `t_workflow_runtime`  (
                                       `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                       `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '运行实例唯一标识',
                                       `user_id` bigint NOT NULL DEFAULT 0 COMMENT '启动人',
                                       `workflow_id` bigint NOT NULL DEFAULT 0 COMMENT '对应工作流定义 id',
                                       `input` json NULL COMMENT '运行输入，例：{\"userInput01\":\"text01\",\"userInput02\":true,\"userInput03\":10,\"userInput04\":[\"selectedA\",\"selectedB\"],\"userInput05\":[\"https://a.com/a.xlsx\",\"https://a.com/b.png\"]}',
                                       `output` json NULL COMMENT '运行输出，成功或失败的结果',
                                       `status` smallint NOT NULL DEFAULT 1 COMMENT '执行状态：1 就绪，2 执行中，3 成功，4 失败',
                                       `status_remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '状态补充说明，如失败原因',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：0 正常，1 已删',
                                       `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                       PRIMARY KEY (`id`) USING BTREE,
                                       INDEX `idx_workflow_runtime_workflow_id`(`workflow_id` ASC) USING BTREE,
                                       INDEX `idx_workflow_runtime_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 297 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流实例（运行时）| Workflow Runtime' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for t_workflow_runtime_node
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow_runtime_node`;
CREATE TABLE `t_workflow_runtime_node`  (
                                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                            `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '节点运行实例唯一标识',
                                            `user_id` bigint NOT NULL DEFAULT 0 COMMENT '创建人',
                                            `workflow_runtime_id` bigint NOT NULL DEFAULT 0 COMMENT '所属运行实例 id',
                                            `node_id` bigint NOT NULL DEFAULT 0 COMMENT '对应工作流定义里的节点 id',
                                            `input` json NULL COMMENT '节点本次输入数据',
                                            `output` json NULL COMMENT '节点本次输出数据',
                                            `status` smallint NOT NULL DEFAULT 1 COMMENT '节点执行状态：1 进行中，2 失败，3 成功',
                                            `status_remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '状态补充说明，如失败堆栈',
                                            `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                            `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                            `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：0 正常，1 已删',
                                            `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            INDEX `idx_runtime_node_runtime_id`(`workflow_runtime_id` ASC) USING BTREE,
                                            INDEX `idx_runtime_node_node_id`(`node_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 805 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流实例（运行时）- 节点 | Workflow Runtime Node' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for image_record
-- ----------------------------
DROP TABLE IF EXISTS `image_record`;
CREATE TABLE `image_record` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                `user_id` bigint NOT NULL COMMENT '用户ID',
                                `model_name` varchar(255) DEFAULT NULL COMMENT '模型名称',
                                `session_id` varchar(64) DEFAULT NULL COMMENT '会话ID',
                                `content` mediumtext COMMENT '消息内容',
                                `role` varchar(255) DEFAULT 'user' COMMENT '对话角色',
                                `total_tokens` int DEFAULT 0 COMMENT '累计 Tokens',
                                `size` varchar(20) DEFAULT NULL COMMENT '图片尺寸',
                                `seed` int DEFAULT NULL COMMENT '随机种子',
                                `image_url` varchar(500) DEFAULT NULL COMMENT '图片URL',
                                `reference_image_url` varchar(500) DEFAULT NULL COMMENT '参考图片URL',
                                `status` int DEFAULT 0 COMMENT '0生成中 1完成 2失败 3已取消',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `tenant_id` bigint DEFAULT 0 COMMENT '租户Id',
                                `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
                                `create_by` bigint DEFAULT NULL COMMENT '创建者',
                                `update_by` bigint DEFAULT NULL COMMENT '更新者',
                                `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                PRIMARY KEY (`id`),
                                KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI生图记录';

-- ----------------------------
-- Table structure for video_record
-- ----------------------------
DROP TABLE IF EXISTS `video_record`;
CREATE TABLE `video_record` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
                                `user_id` bigint NOT NULL COMMENT '用户ID',
                                `model_name` varchar(255) DEFAULT NULL COMMENT '模型名称',
                                `session_id` varchar(64) DEFAULT NULL COMMENT '会话ID',
                                `content` mediumtext COMMENT '消息内容',
                                `role` varchar(255) DEFAULT 'user' COMMENT '对话角色',
                                `total_tokens` int DEFAULT 0 COMMENT '累计 Tokens',
                                `size` varchar(32) DEFAULT NULL COMMENT '视频尺寸',
                                `duration` int DEFAULT NULL COMMENT '视频时长(秒)',
                                `seed` int DEFAULT NULL COMMENT '随机种子',
                                `video_url` varchar(512) DEFAULT NULL COMMENT '视频URL',
                                `reference_image_url` varchar(500) DEFAULT NULL COMMENT '参考图片URL',
                                `status` int DEFAULT 0 COMMENT '0生成中 1完成 2失败 3已取消',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `tenant_id` bigint DEFAULT 0 COMMENT '租户Id',
                                `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
                                `create_by` bigint DEFAULT NULL COMMENT '创建者',
                                `update_by` bigint DEFAULT NULL COMMENT '更新者',
                                `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                `del_flag` int DEFAULT 0 COMMENT '删除标志',
                                PRIMARY KEY (`id`),
                                KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI视频生成记录';

INSERT INTO `chat_model`
(id, category, model_name, provider_code, model_describe, model_dimension, model_show, api_host, api_key, create_dept, create_by, create_time, update_by, update_time, remark, tenant_id)
VALUES(2045071617578237953, 'rerank', 'rerank', 'zhipu', '智谱重排序', NULL, 'Y', 'https://open.bigmodel.cn', 'e9xx', 103, 1, '2026-04-17 17:27:24', 1, '2026-04-20 15:21:48', '智谱重排序', 0);

INSERT INTO `chat_model`
(id, category, model_name, provider_code, model_describe, model_dimension, model_show, api_host, api_key, create_dept, create_by, create_time, update_by, update_time, remark, tenant_id)
VALUES(2046119803482902530, 'rerank', 'qwen3-rerank', 'qianwen', '千问3重排序', NULL, NULL, 'https://dashscope.aliyuncs.com', 'sk-xx', 103, 1, '2026-04-20 14:52:31', 1, '2026-04-20 15:03:13', '千问3文本重排序', 0);

INSERT INTO `sys_dict_data`
(dict_code, tenant_id, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES(2045070879435259905, '000000', 4, '重排序', 'rerank', 'chat_model_category', NULL, '#000000', 'N', 103, 1, '2026-04-17 17:24:28', 1, '2026-04-19 01:02:20', '重排序模型');

DELETE FROM sys_role_menu WHERE menu_id IN (115, 116, 1055, 1056, 1057, 1058, 1059, 1060);
DELETE FROM sys_role_menu WHERE menu_id IN (11616, 11618, 11619, 11620, 11621, 11622, 11623, 11624, 11625, 11626, 11627, 11629, 11630, 11631, 11632, 11633, 11700, 11701, 11801, 11802, 11803, 11804, 11805, 11806);

DELETE FROM sys_menu WHERE menu_id IN (115, 116, 1055, 1056, 1057, 1058, 1059, 1060);
DELETE FROM sys_menu WHERE menu_id IN (11616, 11618, 11619, 11620, 11621, 11622, 11623, 11624, 11625, 11626, 11627, 11629, 11630, 11631, 11632, 11633, 11700, 11701, 11801, 11802, 11803, 11804, 11805, 11806);

DELETE FROM sys_role_menu WHERE menu_id IN (117, 120);

DELETE FROM sys_menu WHERE menu_id = 117;
DELETE FROM sys_menu WHERE menu_id = 120;

DELETE FROM sys_role_menu WHERE menu_id IN (130, 131);

DELETE FROM sys_menu WHERE menu_id IN (130, 131);

SET FOREIGN_KEY_CHECKS = 1;
