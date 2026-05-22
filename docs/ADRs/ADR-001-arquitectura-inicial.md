# ADR-001: Decisiones de Arquitectura Iniciales — RouteIt

**Fecha:** 22/05/2026 | **Estado:** Aceptado | **Autor:** Federico Ponce de León

---

## ADR-001: Monorepo vs Multi-repo

**Decisión:** Monorepo  
**Razón:** Para un proyecto de desarrollo individual, el monorepo simplifica los commits atómicos entre servicios, facilita el CI, y permite una visión unificada del código sin overhead de coordinación entre repos.  
**Consecuencias:** Un solo `git clone`, un `docker-compose` para todo. Si el proyecto escala a un equipo, se puede migrar a multi-repo.

---

## ADR-002: Schema-per-service vs DB-per-service

**Decisión:** Schema-per-service en una sola instancia de PostgreSQL  
**Razón:** Mantiene el aislamiento lógico entre servicios (cada uno solo accede a su schema) sin el overhead operacional de gestionar múltiples instancias de base de datos en un entorno de desarrollo.  
**Consecuencias:** Cada servicio usa `?currentSchema={schema}` en su datasource URL. Flyway gestiona las migraciones dentro del schema correspondiente. Si se migra a producción multi-tenant, se puede separar fácilmente.

---

## ADR-003: Comunicación sincrónica REST vs asincrónica (Kafka/RabbitMQ)

**Decisión:** REST sincrónico con Feign Client  
**Razón:** El scope del proyecto no justifica la complejidad de un message broker. Los flujos de negocio (crear viaje → consultar usuario → calcular combustible) son naturalmente sincrónico-secuenciales. Feign Client simplifica las llamadas entre servicios y se integra nativamente con Eureka.  
**Consecuencias:** Acoplamiento temporal entre servicios en operaciones que cruzan bounded contexts. Aceptable para el scope académico del proyecto.

---

## ADR-004: JWT stateless vs sesiones con estado

**Decisión:** JWT stateless con access token (15 min) + refresh token en DB (7 días)  
**Razón:** Los microservicios no comparten estado de sesión. Cada servicio valida el JWT de forma independiente usando la misma secret. El refresh token en DB permite revocar sesiones (logout).  
**Consecuencias:** El api-gateway valida el JWT y propaga headers `X-User-Id`, `X-User-Role` a los servicios internos. Los servicios internos confían en esos headers (no re-validan el JWT).

---

## ADR-005: MinIO vs Amazon S3 para almacenamiento de fotos

**Decisión:** MinIO en Docker local, compatible con S3 API  
**Razón:** Gratis, auto-hospedado, API 100% compatible con S3. En producción se puede migrar a S3 real cambiando solo las credenciales y la URL del endpoint.  
**Consecuencias:** El código de grupos-service usa el SDK de AWS S3 (compatible con MinIO), lo que facilita la migración futura.

---

## ADR-006: budget-service fusionado en trip-service

**Decisión:** El presupuesto y gastos viven en trip-service (no en un servicio separado)  
**Razón:** El presupuesto está intrínsecamente ligado al viaje: se calcula al crear el viaje, usa los datos del vehículo ya disponibles en ese contexto, y los gastos son atributos del viaje. Un budget-service separado sería un servicio anémico con dependencia circular hacia trip-service.  
**Consecuencias:** La entidad `Expense` y la lógica de `estimatedFuelCost` viven en trips_schema y son gestionadas por trip-service.
