# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **ruoyi-ai**, the backend service for the RuoYi AI platform. It's a Java 17 Spring Boot 3.5.8 multi-module Maven project providing AI chat, multi-agent orchestration, RAG knowledge management, workflow automation, and system administration APIs.

## Commands

```bash
# Build the entire project (skips tests by default)
mvn clean install -Pdev

# Build with tests
mvn clean install -Pdev -DskipTests=false

# Run the application (dev profile, port 6039)
cd ruoyi-admin && mvn spring-boot:run -Pdev

# Run with production profile
cd ruoyi-admin && mvn spring-boot:run -Pprod

# Run a specific test class
mvn test -pl ruoyi-modules/ruoyi-system -Dtest=ClassNameTest -Pdev -DskipTests=false

# Package for deployment
mvn clean package -Pprod
```

### Docker development services

```bash
# Start MySQL + Redis
docker-compose -f docs/docker/ruoyi-ai/docker-compose.yaml up -d

# Start with vector database (Milvus/Weaviate/Qdrant)
docker-compose -f docs/docker/milvus/docker-compose.yml up -d
```

## Architecture

### Module Structure

```
ruoyi-ai/
├── ruoyi-admin/              # Spring Boot application entry point (port 6039)
│   └── src/main/java/org/ruoyi/
│       ├── RuoYiAIApplication.java   # Main class (@SpringBootApplication)
│       ├── config/                    # App-level Spring configuration
│       └── controller/                # Top-level controllers (Auth, Captcha, Index)
├── ruoyi-common/              # Shared libraries (20+ sub-modules)
│   ├── ruoyi-common-core/     # Base classes, exceptions, annotations, enums
│   ├── ruoyi-common-mybatis/  # MyBatis-Plus integration, base mapper
│   ├── ruoyi-common-satoken/  # Sa-Token auth integration + JWT
│   ├── ruoyi-common-security/ # Spring Security filters, XSS, encryption
│   ├── ruoyi-common-redis/    # Redis + Redisson distributed lock config
│   ├── ruoyi-common-chat/     # AI chat shared models
│   ├── ruoyi-common-doc/      # Document parsing (PDF/Word/Excel)
│   ├── ruoyi-common-oss/      # Object storage (AWS S3 SDK)
│   └── ruoyi-common-bom/      # Bill of Materials POM
├── ruoyi-modules/             # Business modules
│   ├── ruoyi-system/          # System management (users, roles, menus, tenants, depts, configs)
│   ├── ruoyi-chat/            # AI chat: sessions, messages, models, multi-agent
│   └── ruoyi-aiflow/          # AI workflow orchestration engine
```

### Key Patterns

**Multi-module Maven**: The root `pom.xml` defines `<packaging>pom</packaging>` and manages all dependency versions via `<dependencyManagement>`. Each sub-module only declares direct dependencies. Version property `${revision}` (3.0.0) is the single source of truth.

**Maven profiles**: `local`, `dev` (default), `prod` — select via `-P<profile>`. Profile determines `profiles.active` which controls which `application-*.yml` is loaded.

**Service architecture**: Controllers are spread across modules (not just in `ruoyi-admin`). Each business module (`ruoyi-system`, `ruoyi-chat`, etc.) has its own `controller/`, `service/`, `mapper/`, `domain/` packages. `ruoyi-admin` scans all packages via `org.ruoyi.**` patterns.

**MyBatis-Plus**: All entities use `ASSIGN_ID` (Snowflake) for primary keys. Mappers must implement `BaseMapper<T>`. XML mapper files are at `classpath*:mapper/**/*Mapper.xml`. Logical delete is enabled globally.

**Auth**: Uses Sa-Token with JWT. Token name is `Authorization` header. Supports concurrent login (configurable). `security.excludes` lists paths that skip authentication. Multi-tenant support filters queries by `tenant_id`.

**API docs**: Springdoc-openapi with Knife4j. Access at `/doc.html` when running. Group configs organize endpoints by module.

### Tech Stack

| Area | Technology |
|------|-----------|
| Framework | Spring Boot 3.5.8 |
| Language | Java 17 |
| Database | MySQL 8.0 + MyBatis-Plus 3.5.14 |
| Cache | Redis + Redisson 3.51.0 |
| Auth | Sa-Token 1.44.0 + JWT |
| AI | Langchain4j 1.13.0 + LangGraph4j 1.5.3 |
| Vector DB | Milvus / Weaviate / Qdrant (configurable) |
| Object Storage | MinIO (AWS S3 SDK 2.x) |
| API Docs | springdoc-openapi 2.8.13 + Knife4j |
| Bean Mapping | mapstruct-plus 1.5.0 + Lombok |
| Utilities | Hutool 5.8.40 |

### Configuration

- **application.yml** — shared config (server, security, mybatis-plus, sa-token, vector-store)
- **application-dev.yml** / **application-prod.yml** — environment-specific (datasource, redis, minio, logging)
- **logback-plus.xml** — logging configuration
- Maven repository uses Huawei Cloud mirror: `https://mirrors.huaweicloud.com/repository/maven/`
