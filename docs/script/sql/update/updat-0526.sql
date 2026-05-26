-- chat_session 添加会话类型字段
ALTER TABLE chat_session ADD COLUMN type varchar(10) DEFAULT 'chat' COMMENT '会话类型: chat/image/video';
