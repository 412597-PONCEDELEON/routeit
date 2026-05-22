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

### Sprint 0 — COMPLETADO ✓

Todos los tickets SCRUM-6 a SCRUM-28 → **Done**

**Infraestructura corriendo:**
- 11/11 contenedores up en docker-compose
- PostgreSQL :5432 (healthy), MinIO :9010 (healthy, remapeado por conflicto de puerto)
- discovery-server :8761 (healthy), config-server :8888 (healthy)
- api-gateway :8080, user-service :8081, trip-service :8082, stops-service :8083
- subscription-service :8084, groups-service :8085, stats-service :8086

**Nota importante — MinIO:** el puerto host está en 9010 (no 9000) porque el proceso `javaw.exe` (JDK 1.8, PID variable) ocupa el 9000. Internamente Docker sigue usando minio:9000, no afecta a ningún servicio.

**Archivos clave generados:**
- `CLAUDE.md` — guía para Claude Code
- `docs/architecture.md` — diagrama Mermaid de los 9 servicios
- `docs/AI-USAGE-STATEMENT.md` — v1 creado
- `docs/ADRs/ADR-001-arquitectura-inicial.md` — creado
- `frontend/` — Angular 19, routing + SCSS, Dockerfile multi-stage nginx
- `services/*/Dockerfile` — multi-stage (maven:3.9 + eclipse-temurin:21-jre-alpine)
- `infrastructure/docker-compose.yml` — healthchecks con wget/curl según imagen

**Google Cloud (proyecto routeit-497102):**
APIs habilitadas: Maps JS, Directions, Distance Matrix, Places, Geocoding

---

## Próximo paso: Sprint 1 — Auth & Gestión de Usuarios (25/05–07/06)

### Issues Sprint 1

| Key | Descripción |
|-----|-------------|
| SCRUM-7 | Epic: Sprint 1 - Auth & Gestión de Usuarios |
| SCRUM-29 | [user-service] Modelo dominio: User + Vehicle |
| SCRUM-30 | [user-service] Registro + email verificación |
| SCRUM-31 | [user-service] Login, JWT + refresh token |
| SCRUM-32 | [user-service] Perfil de usuario y vehículo |
| SCRUM-33 | [api-gateway] Filtro JWT |
| SCRUM-34 | [frontend] Auth: Login, Register, Activate |
| SCRUM-35 | [frontend] Perfil de usuario y vehículo |
| SCRUM-36 | [user-service] Testing JUnit |

### Orden recomendado de implementación Sprint 1

1. **SCRUM-29** — Modelo de dominio: entidades `User` + `Vehicle` con Flyway V2
2. **SCRUM-31** — JWT: login, generación de tokens, refresh (base para todo lo demás)
3. **SCRUM-30** — Registro + email de verificación (usa SMTP ya configurado)
4. **SCRUM-33** — Filtro JWT en api-gateway (habilita endpoints protegidos)
5. **SCRUM-32** — Perfil de usuario y vehículo (CRUD)
6. **SCRUM-34/35** — Frontend: pantallas de auth y perfil en Angular
7. **SCRUM-36** — Tests JUnit para user-service

### Stack de auth a implementar

- **JWT:** JJWT 0.12.6 (ya en pom.xml)
- **Entidades:** `User` (id, email, password hash, nombre, activo, roles) + `Vehicle` (tipo, marca, modelo, año, consumo L/100km)
- **Endpoints públicos** (sin JWT): `POST /api/auth/register`, `POST /api/auth/login`, `GET /api/auth/activate`, `POST /api/auth/refresh-token`
- **Endpoints protegidos**: todo lo demás bajo `/api/users/**`
- **Email:** Mailtrap o Gmail App Password (ya configurado en .env)
- **Filtro gateway:** Spring Cloud Gateway `GatewayFilter` que valida el JWT antes de hacer forward

---

## Planificación completa

### Épicas y sprints

| Epic | Jira | Período | Entregable |
|------|------|---------|-----------|
| Sprint 0 - Setup | SCRUM-6 | 18/05–24/05 | **DONE** ✓ |
| Sprint 1 - Auth & Usuarios | SCRUM-7 | 25/05–07/06 | Login, registro, JWT, perfil |
| Sprint 2 - Viajes & Maps | SCRUM-8 | 08/06–21/06 | ABM viajes + ruta + gastos |
| Sprint 3 - Paradas & Clima | SCRUM-9 | 22/06–05/07 | Places API + OpenWeatherMap |
| Sprint 4 - Premium & Grupos | SCRUM-10 | 06/07–19/07 | Mercado Pago + MinIO fotos |
| Sprint 5 - Dashboard | SCRUM-11 | 20/07–02/08 | KPIs + gráficos Angular |
| Sprint 6 - Testing & Docs | SCRUM-12 | 03/08–16/08 | Tests, docs, despliegue, video |

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
                    MinIO :9010 host / :9000 interno (fotos)
    Eureka :8761 (service discovery)
    Config-server :8888
```

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
| Angular | 19 |
| Mercado Pago SDK | 2.1.24 |

---

## Credenciales externas (NO commitear valores reales)

- **Google Cloud:** proyecto `routeit-497102` (número: `601295162661`)
  - APIs habilitadas: Maps JS, Directions, Distance Matrix, Places, Geocoding ✓
  - Variable: `GOOGLE_MAPS_API_KEY`
- **OpenWeatherMap:** variable `OPENWEATHERMAP_API_KEY`
- **Mercado Pago sandbox:** variables `MP_ACCESS_TOKEN`, `MP_PUBLIC_KEY`
- **SMTP:** configurado en `.env` ✓

Todas las variables en `infrastructure/.env` (no commiteado).

---

## Requisitos de facultad (CRÍTICOS para regularidad)

| Requisito | Sprint | Estado |
|-----------|--------|--------|
| AI Usage Statement (documento vivo) | S0–S6 | v1 creada ✓ |
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
"Leé CONTEXTO-SESION.md y arrancá Sprint 1 con el user-service"
```
