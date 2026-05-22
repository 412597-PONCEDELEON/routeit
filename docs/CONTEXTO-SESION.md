# Contexto del proyecto — RouteIt (sesión 22/05/2026)

Archivo para retomar el trabajo con Claude Code desde el repo.  
Abrí este archivo y decile a Claude: **"Leé CONTEXTO-SESION.md y continuemos"**

---

## Datos del proyecto

- **Alumno:** Federico Ponce de León | Legajo: 412597
- **Mail institucional:** 412597@tecnicatura.frc.utn.edu.ar
- **Jira:** https://tesistup.atlassian.net/jira/software/projects/SCRUM/boards
- **Project key Jira:** SCRUM | **cloudId:** `8e7f081c-f6ac-46e3-8864-27df0641b57d`
- **Transiciones Jira:** To Do=11 | In Progress=21 | In Review=31 | Done=41
- **Repo:** https://github.com/412597-PONCEDELEON/routeit.git
- **Directorio local:** `C:\Users\feder\Documents\UTN\Tesis\routeit\`

---

## Estado al cierre de sesión (22/05/2026)

### Hecho ✓
- Backlog completo en Jira: 58 issues (SCRUM-5 a SCRUM-58), 7 épicas
- Scaffolding completo commiteado en `main` (commit `f04b7af`)
- 9 microservicios con pom.xml, Application.java, application.yml, Dockerfile, Flyway V1
- docker-compose.yml con todos los servicios + PostgreSQL + MinIO
- docs/AI-USAGE-STATEMENT.md v1 creado
- docs/ADRs/ADR-001-arquitectura-inicial.md creado
- SCRUM-13 (monorepo) → Done | SCRUM-14 (parent POM) → Done
- SCRUM-6 (Sprint 0 épica) → In Progress
- MCP Mercado Pago agregado: `https://mcp.mercadopago.com/mcp`

### Pendiente para cerrar Sprint 0
- [ ] **SCRUM-15** — Crear `docs/architecture.md` con diagrama Mermaid de los 9 servicios
- [ ] **SCRUM-16** — AI Usage Statement v1 (ya existe, mover a Done)
- [ ] **SCRUM-17 a SCRUM-21** — Scaffoldings ya creados → marcar Done
- [ ] **SCRUM-22** — `ng new routeit-frontend --routing --style=scss` en `frontend/`
- [ ] **SCRUM-23** — Levantar `docker-compose up` y verificar que todos los servicios arrancan
- [ ] **SCRUM-24** — Habilitar APIs en Google Cloud Console (Maps JS, Directions, Distance Matrix, Places, Geocoding)
- [ ] **SCRUM-25** — Configurar credenciales Mercado Pago sandbox en `.env`
- [ ] **SCRUM-26** — Crear `.env` copiando `.env.example` y completando valores reales
- [ ] **SCRUM-27** — ADR-001 ya existe → marcar Done
- [ ] **SCRUM-28** — Verificación final: checklist del docker-compose completo

---

## Planificación completa

### Épicas y sprints

| Epic | Jira | Período | Entregable |
|------|------|---------|-----------|
| Sprint 0 - Setup | SCRUM-6 | 18/05–24/05 | Todos los servicios corriendo |
| Sprint 1 - Auth & Usuarios | SCRUM-7 | 25/05–07/06 | Login, registro, JWT, perfil |
| Sprint 2 - Viajes & Maps | SCRUM-8 | 08/06–21/06 | ABM viajes + ruta + gastos |
| Sprint 3 - Paradas & Clima | SCRUM-9 | 22/06–05/07 | Places API + OpenWeatherMap |
| Sprint 4 - Premium & Grupos | SCRUM-10 | 06/07–19/07 | Mercado Pago + MinIO fotos |
| Sprint 5 - Dashboard | SCRUM-11 | 20/07–02/08 | KPIs + gráficos Angular |
| Sprint 6 - Testing & Docs | SCRUM-12 | 03/08–16/08 | Tests, docs, despliegue, video |

### Todos los issues

| Key | Tipo | Descripción | Estado |
|-----|------|-------------|--------|
| SCRUM-5 | Task | PROJECT KICK OFF 2026 PDF adjunto | To Do |
| SCRUM-6 | Epic | Sprint 0 - Setup & Arquitectura | In Progress |
| SCRUM-7 | Epic | Sprint 1 - Auth & Gestión de Usuarios | To Do |
| SCRUM-8 | Epic | Sprint 2 - Viajes & Google Maps | To Do |
| SCRUM-9 | Epic | Sprint 3 - Paradas, Clima & Presupuesto | To Do |
| SCRUM-10 | Epic | Sprint 4 - Suscripción Premium, Grupos & Fotos | To Do |
| SCRUM-11 | Epic | Sprint 5 - Dashboard & Estadísticas | To Do |
| SCRUM-12 | Epic | Sprint 6 - Testing, Docs & Despliegue | To Do |
| SCRUM-13 | Task | [S0] Crear estructura monorepo en GitHub | **Done** |
| SCRUM-14 | Task | [S0] Configurar parent POM Spring Boot 3.x + Java 21 | **Done** |
| SCRUM-15 | Task | [S0] DOC: Diagrama de arquitectura de microservicios | To Do |
| SCRUM-16 | Task | [S0] DOC: AI Usage Statement v1 | To Do |
| SCRUM-17 | Task | [S0] Scaffolding: discovery-server (Eureka) | To Do |
| SCRUM-18 | Task | [S0] Scaffolding: config-server | To Do |
| SCRUM-19 | Task | [S0] Scaffolding: api-gateway | To Do |
| SCRUM-20 | Task | [S0] Scaffolding: user, trip, stops | To Do |
| SCRUM-21 | Task | [S0] Scaffolding: subscription, groups, stats | To Do |
| SCRUM-22 | Task | [S0] Scaffolding: frontend Angular | To Do |
| SCRUM-23 | Task | [S0] docker-compose completo | To Do |
| SCRUM-24 | Task | [S0] Google Cloud APIs habilitadas | To Do |
| SCRUM-25 | Task | [S0] OpenWeatherMap en stops-service | To Do |
| SCRUM-26 | Task | [S0] Mercado Pago sandbox credenciales | To Do |
| SCRUM-27 | Task | [S0] ADR-001 decisiones arquitectura | To Do |
| SCRUM-28 | Task | [S0] Verificación final todos los servicios up | To Do |
| SCRUM-29 | Story | [S1] [user-service] Modelo dominio: User + Vehicle | To Do |
| SCRUM-30 | Story | [S1] [user-service] Registro + email verificación | To Do |
| SCRUM-31 | Story | [S1] [user-service] Login, JWT + refresh token | To Do |
| SCRUM-32 | Story | [S1] [user-service] Perfil de usuario y vehículo | To Do |
| SCRUM-33 | Story | [S1] [api-gateway] Filtro JWT | To Do |
| SCRUM-34 | Story | [S1] [frontend] Auth: Login, Register, Activate | To Do |
| SCRUM-35 | Story | [S1] [frontend] Perfil de usuario y vehículo | To Do |
| SCRUM-36 | Story | [S1] Testing JUnit user-service | To Do |
| SCRUM-37 | Story | [S2] [trip-service] Modelo dominio: Trip, Waypoint, Expense | To Do |
| SCRUM-38 | Story | [S2] [trip-service] ABM viajes + Google Maps Directions | To Do |
| SCRUM-39 | Story | [S2] [trip-service] Presupuesto combustible + gastos reales | To Do |
| SCRUM-40 | Story | [S2] [frontend] Vista viajes + mapa | To Do |
| SCRUM-41 | Story | [S2] Testing JUnit trip-service | To Do |
| SCRUM-42 | Story | [S3] [stops-service] Paradas sugeridas con Places API | To Do |
| SCRUM-43 | Story | [S3] [stops-service] Clima con OpenWeatherMap | To Do |
| SCRUM-44 | Story | [S3] [frontend] Vista paradas y clima en mapa | To Do |
| SCRUM-45 | Story | [S3] Testing JUnit stops-service | To Do |
| SCRUM-46 | Story | [S4] [subscription-service] Mercado Pago + webhook | To Do |
| SCRUM-47 | Story | [S4] [groups-service] ABM grupos + fotos MinIO | To Do |
| SCRUM-48 | Story | [S4] [frontend] Premium: suscripción, grupos, galería | To Do |
| SCRUM-49 | Story | [S4] Testing subscription-service y groups-service | To Do |
| SCRUM-50 | Story | [S5] [stats-service] KPIs del viajero | To Do |
| SCRUM-51 | Story | [S5] [frontend] Dashboard con gráficos | To Do |
| SCRUM-52 | Story | [S5] Testing stats-service | To Do |
| SCRUM-53 | Story | [S6] Cobertura global de tests (JaCoCo) | To Do |
| SCRUM-54 | Story | [S6] DOC: T&C + Protección Datos + FAQ en la app | To Do |
| SCRUM-55 | Story | [S6] DOC: Informe técnico final + Manual de usuario | To Do |
| SCRUM-56 | Story | [S6] DOC: AI Usage Statement final + aprobación tutor | To Do |
| SCRUM-57 | Story | [S6] Despliegue final con Docker Compose | To Do |
| SCRUM-58 | Story | [S6] Video presentación del proyecto | To Do |

---

## Arquitectura de microservicios

```
                        ┌──────────────┐
                        │  api-gateway │  :8080  ← único punto de entrada del frontend
                        └──────┬───────┘
               ┌───────────────┼───────────────────┐
       lb://   │               │                   │
    ┌──────────▼──┐  ┌─────────▼──┐  ┌────────────▼───┐
    │ user-service│  │trip-service│  │ stops-service  │
    │    :8081    │  │   :8082    │  │     :8083      │
    └─────────────┘  └────────────┘  └────────────────┘
    ┌──────────────┐  ┌─────────────┐  ┌─────────────┐
    │subscription- │  │  groups-    │  │   stats-    │
    │  service     │  │  service    │  │   service   │
    │   :8084      │  │   :8085     │  │   :8086     │
    └──────────────┘  └─────────────┘  └─────────────┘
         │                   │
    ┌────▼────────────────────▼─────┐
    │       PostgreSQL :5432        │
    │  6 schemas (users, trips,     │
    │  stops, subscriptions,        │
    │  groups, stats)               │
    └───────────────────────────────┘
                    MinIO :9000 (fotos)
    Eureka :8761 (service discovery)
    Config-server :8888
```

### Puertos asignados

| Servicio | Puerto |
|---------|--------|
| api-gateway | 8080 |
| discovery-server (Eureka) | 8761 |
| config-server | 8888 |
| user-service | 8081 |
| trip-service | 8082 |
| stops-service | 8083 |
| subscription-service | 8084 |
| groups-service | 8085 |
| stats-service | 8086 |
| PostgreSQL | 5432 |
| MinIO API | 9000 |
| MinIO Console | 9001 |
| Frontend Angular | 4200 |

---

## Stack y versiones

| Tecnología | Versión |
|-----------|---------|
| Java | 21 |
| Spring Boot | 3.3.6 |
| Spring Cloud | 2023.0.3 |
| jjwt | 0.12.6 |
| MinIO SDK | 8.5.12 |
| Flyway | 10.15.0 |
| MapStruct | 1.6.2 |
| JaCoCo | 0.8.12 |
| PostgreSQL | 15 |
| Angular | 17+ (pendiente) |
| Mercado Pago SDK | 2.1.24 |

---

## Credenciales externas (NO commitear valores reales)

- **Google Cloud:** proyecto `routeit-497102` (número: `601295162661`)
  - APIs a habilitar: Maps JS, Directions, Distance Matrix, Places, Geocoding
  - Variable: `GOOGLE_MAPS_API_KEY`
- **OpenWeatherMap:** variable `OPENWEATHERMAP_API_KEY`
- **Mercado Pago sandbox:** variables `MP_ACCESS_TOKEN`, `MP_PUBLIC_KEY`
  - MCP configurado en Claude Code: `https://mcp.mercadopago.com/mcp`
- **SMTP:** Gmail App Password o Mailtrap para dev

Todas las variables están en `infrastructure/.env.example`. Copiar a `infrastructure/.env`.

---

## Decisiones de arquitectura (ADR-001)

1. **Monorepo** — 1 repo, atomic commits entre servicios
2. **Schema-per-service** en PostgreSQL — aislamiento lógico sin overhead de múltiples instancias
3. **REST + Feign Client** — sin message broker (scope no lo justifica)
4. **JWT stateless** + refresh token en DB — sin estado compartido entre servicios
5. **MinIO local** compatible S3 — gratuito, migrable a S3 real en producción
6. **budget-service fusionado en trip-service** — era un servicio anémico con dependencia circular

---

## Requisitos de facultad (CRÍTICOS para regularidad)

| Requisito | Sprint | Estado |
|-----------|--------|--------|
| AI Usage Statement (documento vivo) | S0–S6 | v1 creada |
| Términos & Condiciones en la app | S6 | Pendiente |
| Política de Protección de Datos en la app | S6 | Pendiente |
| Preguntas Frecuentes (FAQ) en la app | S6 | Pendiente |
| Informe técnico final | S6 | Pendiente |
| Video presentación | S6 | Pendiente |
| Aprobación Sofía Enamorado | S6 | Pendiente |
| Aprobación Oscar Botta (obotta@frc.utn.edu.ar) | S6 | Pendiente |

**Sin aprobación del AI Usage Statement = sin regularidad.**

---

## Cómo retomar con Claude Code

```
# Abrir Claude Code desde el directorio del repo
cd C:\Users\feder\Documents\UTN\Tesis\routeit
claude

# Decirle a Claude:
"Leé CONTEXTO-SESION.md y continuemos con el Sprint 0"
# o
"Leé CONTEXTO-SESION.md y arrancá Sprint 1 con el user-service"
```
