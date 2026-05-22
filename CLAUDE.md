# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

RouteIt is a web application for planning road trips, centralizing routes, suggested stops, weather, budgets, and expenses. It is a Spring Boot microservices monorepo developed as a UTN Final Integration Project (TFI 2026).

- Student: Federico Ponce de León (Legajo: 412597)
- Status: Active development (Sprint 0 completed, using Jira for issue tracking)
- Repository: Monorepo structure with Maven parent POM

---

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Backend | Java 21 + Spring Boot 3.3 + Spring Cloud 2023.0.3 |
| Frontend | Angular + Angular Material (TBD) |
| Database | PostgreSQL 15 (schema-per-service isolation) |
| Object Storage | MinIO (for group photos) |
| Migration Tool | Flyway 10.15.0 |
| Testing | JUnit 5 + Mockito, H2 in-memory DB |
| Authentication | JWT (JJWT 0.12.6) |
| External APIs | Google Maps, OpenWeatherMap, Mercado Pago |
| Build Tool | Maven 3.x |
| Containerization | Docker + Docker Compose |

---

## Architecture

### Microservices Overview

The project uses Spring Cloud with Netflix Eureka for service discovery and Spring Cloud Gateway for API routing. Each business service owns its own PostgreSQL schema (schema-per-service pattern).

Service Topology:
- Discovery Server (8761): Eureka registry - all services discover each other
- Config Server (8888): Centralized configuration management
- API Gateway (8080): Single entry point, routes requests, validates JWT tokens
- User Service (8081): Authentication, user profiles, email verification
- Trip Service (8082): Trip planning, Google Maps integration
- Stops Service (8083): Suggested stops, weather via OpenWeatherMap, caching
- Subscription Service (8084): Payment processing via Mercado Pago
- Groups Service (8085): Group management, MinIO photo storage
- Stats Service (8086): Analytics and statistics aggregation

All business services connect to PostgreSQL (6 separate schemas).

### Module Structure

`
routeit/
├── pom.xml                          # Parent POM (version 1.0.0-SNAPSHOT)
├── README.md
├── infrastructure/
│   ├── docker-compose.yml           # Orchestrates all services + databases
│   ├── .env.example                 # Environment variables template
│   └── postgres/init.sql            # Creates 6 schemas at startup
├── services/
│   ├── discovery-server/            # Eureka server
│   ├── config-server/               # Spring Cloud Config
│   ├── api-gateway/                 # Spring Cloud Gateway + JWT validation
│   ├── user-service/                # Users, auth, email
│   ├── trip-service/                # Trip management + Google Maps
│   ├── stops-service/               # Stop suggestions + OpenWeatherMap + caching
│   ├── subscription-service/        # Payments with Mercado Pago
│   ├── groups-service/              # Groups + MinIO storage
│   └── stats-service/               # Statistics and analytics
└── frontend/                        # Angular (TBD)
`

### Key Architectural Patterns

Schema-per-Service: Each service owns its PostgreSQL schema. Services communicate via REST APIs only. Schemas created in infrastructure/postgres/init.sql.

Flyway Migrations: Automatic schema evolution via src/main/resources/db/migration/V<N>__description.sql. Hibernate set to ddl-auto: validate (Flyway handles schema creation).

Eureka Service Discovery: All services (except Gateway) auto-register with Discovery Server on startup via @EnableDiscoveryClient. Gateway uses service names for routing (e.g., lb://user-service).

API Gateway Routing: Single entry point /api/** routes to services:
- /api/auth/**, /api/users/** -> user-service:8081
- /api/trips/** -> trip-service:8082
- /api/stops/** -> stops-service:8083
- /api/subscriptions/** -> subscription-service:8084
- /api/groups/** -> groups-service:8085
- /api/stats/** -> stats-service:8086

JWT Validation: Tokens validated at Gateway before reaching services. Public paths (register, login, activate, refresh-token) bypass validation. Token lifetimes: 15 min (access), 7 days (refresh).

External Integrations:
- Google Maps: Directions and distance matrix in trip-service and stops-service
- OpenWeatherMap: Weather data in stops-service
- Mercado Pago: Payment gateway in subscription-service (SDK 2.1.24)
- MinIO: S3-compatible storage for group photos in groups-service

---

## Build and Run

### Prerequisites

- Java 21 (eclipse-temurin recommended)
- Maven 3.x
- Docker & Docker Compose (for full stack)
- PostgreSQL 15 (if running services locally without Docker)

### Build Commands

mvn clean install              # Build entire monorepo with tests
mvn -pl services/user-service clean install  # Build single service
mvn clean install -DskipTests  # Build without tests
mvn clean install jacoco:report  # Generate JaCoCo coverage reports

Reports available at: services/<SERVICE>/target/site/jacoco/index.html

### Run Full Stack (Docker Compose)

`
cp infrastructure/.env.example infrastructure/.env
# Edit infrastructure/.env with real values

docker-compose -f infrastructure/docker-compose.yml up -d
docker-compose -f infrastructure/docker-compose.yml logs -f
docker-compose -f infrastructure/docker-compose.yml down
`

Docker Compose starts services in dependency order using health checks.

### Run Services Locally (without Docker)

Start in order (Discovery -> Config -> Gateway -> Business Services):

Terminal 1: Discovery Server
cd services/discovery-server && mvn spring-boot:run

Terminal 2: Config Server
cd services/config-server && mvn spring-boot:run

Terminal 3: API Gateway
cd services/api-gateway && mvn spring-boot:run

Terminal 4+: Business services (parallel)
cd services/user-service && mvn spring-boot:run
cd services/trip-service && mvn spring-boot:run

Access Points:
- API Gateway: http://localhost:8080
- Eureka Dashboard: http://localhost:8761
- Config Server: http://localhost:8888
- PostgreSQL: localhost:5432

---

## Testing

### Run Tests

mvn test                        # All tests in monorepo
mvn -pl services/user-service test  # Tests for single service
mvn -pl services/user-service test -Dtest=UserServiceTest  # Specific test class
mvn test -Dtest=UserServiceTest#testCreateUser  # Specific test method
mvn install -DskipTests        # Skip tests during build

### Test Configuration

- Framework: JUnit 5 + Mockito
- Test Database: H2 (in-memory, test scope only)
- Location: src/test/java/com/routeit/<service>/

Note: As of Sprint 0, test files are created but empty.

### Code Coverage

mvn clean test jacoco:report
# Access: services/<SERVICE>/target/site/jacoco/index.html

---

## Development Workflow

### Environment Setup

git clone <repo>
cd routeit
mvn clean install -DskipTests

cp infrastructure/.env.example infrastructure/.env
# Edit: POSTGRES_PASSWORD, JWT_SECRET (256+ bits), API keys

docker-compose -f infrastructure/docker-compose.yml up -d

### Adding Endpoints

1. Create Controller in controller/ with @RestController
2. Create Service in service/ with @Service
3. Create Repository extending JpaRepository
4. Create DTOs in dto/
5. Add Flyway migration if new tables: db/migration/V<N>__description.sql
6. Test with JUnit 5 in src/test/java/

### Adding a New Service

1. Create services/new-service/ directory
2. Copy structure from existing service
3. Update pom.xml: change <artifactId>, <name>, adjust dependencies
4. Create src/main/resources/application.yml with unique port and schema
5. Update infrastructure/docker-compose.yml
6. Update root pom.xml: add <module>services/new-service</module>
7. Create schema in infrastructure/postgres/init.sql
8. Create standard Dockerfile

### Database Migrations (Flyway)

Migrations run automatically on startup:

1. Create: src/main/resources/db/migration/V<N>__description.sql
   - Naming: V<NUMBER>__snake_case.sql (e.g., V2__add_phone_to_users.sql)
   - Prefix with schema: ALTER TABLE users_schema.users ADD COLUMN phone VARCHAR(20);

2. Each service application.yml:
   spring.flyway.schemas: <service>_schema
   spring.flyway.locations: classpath:db/migration

3. Migrations execute in numeric order on startup

---

## Key Configuration Files

### Root pom.xml

- Parent: Spring Boot 3.3.6, Spring Cloud 2023.0.3
- Java: Version 21
- Managed Versions: JJWT 0.12.6, MinIO 8.5.12, Flyway 10.15.0, MapStruct 1.6.2, JaCoCo 0.8.12
- Plugins: Spring Boot Maven Plugin, JaCoCo

### infrastructure/docker-compose.yml

- PostgreSQL 15: Single instance, 6 schemas, healthcheck on 5432
- MinIO: Object storage, healthcheck on 9000
- Discovery Server: Eureka, healthcheck on 8761
- Config Server: Depends on Discovery, healthcheck on 8888
- API Gateway: Depends on Config, port 8080
- Business Services: Depend on PostgreSQL + Config, ports 8081-8086

Uses depends_on: { condition: service_healthy } for startup ordering.

### infrastructure/postgres/init.sql

Creates 6 schemas:
- users_schema - accounts, auth, user profiles
- trips_schema - routes, waypoints, metadata
- stops_schema - stops, POIs, weather
- subscriptions_schema - subscriptions, payments
- groups_schema - groups, memberships
- stats_schema - statistics, analytics

### Service application.yml Files

Standard per service:
server.port: <unique 8081-8086>
spring.application.name: <service-name>
spring.datasource.url: jdbc:postgresql://localhost:5432/routeit?currentSchema=<service>_schema
spring.jpa.hibernate.ddl-auto: validate
spring.flyway.schemas: <service>_schema
eureka.client.service-url.defaultZone: http://localhost:8761/eureka
management.endpoints.web.exposure.include: health,info

Special configurations:
- user-service: SMTP for email
- trip-service: Google Maps API key
- stops-service: Google Maps + OpenWeatherMap keys, caching enabled
- subscription-service: Mercado Pago token
- groups-service: MinIO URL/credentials, 10MB upload limit
- api-gateway: CORS (http://localhost:4200), public paths

---

## Git and Commit Conventions

Jira Integration: Commits reference issue tickets:

git commit -m '[SCRUM-13][SCRUM-14] Sprint 0: scaffolding monorepo'

Never Commit:
- .env files (use .env.example)
- IDE files (.idea/, *.iml)
- Build artifacts (target/, *.jar)
- Node modules/Angular build

See .gitignore for full list.

---

## AI Usage

See docs/AI-USAGE-STATEMENT.md for detailed accounting.

Generated by AI (Sprint 0):
- Monorepo structure, parent POM
- docker-compose.yml, PostgreSQL initialization
- Service skeletons

Always manually developed:
- Business logic and domain models
- Real API integrations
- Domain validations
- Tests

---

## Troubleshooting

### Docker Containers Fail

docker-compose -f infrastructure/docker-compose.yml ps
docker-compose -f infrastructure/docker-compose.yml logs <service-name>
docker-compose -f infrastructure/docker-compose.yml restart

### Database Connection Issues

1. Verify .env: POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
2. Confirm PostgreSQL is healthy
3. Verify schemas exist (connect and run \dn)

### Flyway Migration Fails

- Migrations run in numeric order (V1, V2, etc.)
- Service wont start if migration fails
- Check logs for SQL syntax errors
- Verify PostgreSQL dialect compatibility

### JWT Token Problems

- All /api/** requests require Authorization: Bearer <token>
- Public paths bypass validation (configured in Gateway)
- Token expiration: 15 min (access), 7 days (refresh)
- Add new public paths to routeit.gateway.public-paths

---

## Useful Links

- Jira Backlog: https://tesistup.atlassian.net/jira/software/projects/SCRUM/boards
- Architecture Decisions: docs/ADRs/

