# AI Usage Statement — RouteIt

**Alumno:** Federico Ponce de León | Legajo: 412597  
**Proyecto:** RouteIt — UTN TFI 2026  
**Documento:** Declaración jurada de uso de IA (VIVO — se actualiza cada sprint)

---

## 1. Herramientas de IA utilizadas

| Herramienta | Proveedor | Propósito en el proyecto |
|-------------|-----------|--------------------------|
| Claude Code | Anthropic | Asistencia principal en desarrollo, scaffolding, revisión de código, planificación |

---

## 2. Propósito del uso de IA en el proyecto

Claude Code fue utilizado como herramienta de asistencia durante todo el ciclo de desarrollo del proyecto RouteIt. Su uso se enmarca dentro de los principios de **transparencia**, **comprensión** y **responsabilidad** establecidos por la política institucional de la UTN.

El uso de IA permitió acelerar la etapa de scaffolding y configuración inicial, explorar alternativas técnicas, y generar código base que luego fue revisado, comprendido y adaptado al dominio específico del proyecto.

---

## 3. Registro por sprint

| Sprint | Herramienta | Qué generó IA | Qué modificó el alumno | Problemas encontrados |
|--------|-------------|---------------|------------------------|-----------------------|
| Sprint 0 | Claude Code | Estructura monorepo, parent POM, docker-compose, .gitignore, README, .env.example, schemas PostgreSQL | Validación de dependencias y versiones, ajuste de puertos, decisiones de arquitectura | — |
| Sprint 1 | — | — | — | — |
| Sprint 2 | — | — | — | — |
| Sprint 3 | — | — | — | — |
| Sprint 4 | — | — | — | — |
| Sprint 5 | — | — | — | — |
| Sprint 6 | — | — | — | — |

*Esta tabla se completa al cierre de cada sprint.*

---

## 4. Partes del proyecto generadas con IA

- Estructura de directorios del monorepo
- Parent POM con dependencias y versiones
- docker-compose.yml con todos los servicios
- Backlog completo de Jira (58 issues con descripciones detalladas)
- Plantillas base de los microservicios (Application.java, application.yml, Dockerfile)
- Scripts de inicialización de PostgreSQL

---

## 5. Partes desarrolladas/modificadas por el alumno

- Lógica de negocio de cada microservicio
- Decisiones de diseño de dominio (entidades, relaciones)
- Integración real con APIs externas (Google Maps, OpenWeatherMap, Mercado Pago)
- Validaciones específicas del dominio (consumo de vehículo, tipos de parada, etc.)
- Tests unitarios y de integración (comprensión y adaptación de casos generados)
- Configuración de cuentas y credenciales externas
- Resolución de problemas técnicos encontrados durante el desarrollo

---

## 6. Reflexión sobre el uso de IA

*(Se completa progresivamente durante el desarrollo)*

El uso de Claude Code en este proyecto me permitió enfocarme más rápido en la lógica de negocio específica de RouteIt, evitando tiempo en configuración repetitiva de infraestructura. Sin embargo, cada archivo generado fue revisado y comprendido antes de ser aceptado, especialmente en lo relacionado a decisiones de arquitectura de microservicios.

---

**Versión:** v1.0 (Sprint 0) — 22/05/2026  
**Próxima actualización:** cierre de Sprint 1
