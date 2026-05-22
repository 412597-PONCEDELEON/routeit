# RouteIt

Aplicación web para planificación de road trips. Centraliza ruta, paradas sugeridas, clima, presupuesto y gastos en un solo lugar.

**Alumno:** Federico Ponce de León | Legajo: 412597  
**UTN - Tecnicatura Universitaria en Programación - TFI 2026**

## Stack

| Capa | Tecnología |
|------|-----------|
| Backend | Java 21 + Spring Boot 3.3 + Spring Cloud |
| Frontend | Angular + Angular Material |
| Base de datos | PostgreSQL 15 (schema-per-service) |
| Storage | MinIO |
| APIs externas | Google Maps Platform, OpenWeatherMap, Mercado Pago |
| Testing | JUnit 5 + Mockito |
| Contenedores | Docker + Docker Compose |

## Arquitectura

9 microservicios backend + 1 frontend Angular:

```
api-gateway (8080)
├── discovery-server (8761) - Eureka
├── config-server (8888)
├── user-service (8081)
├── trip-service (8082)
├── stops-service (8083)
├── subscription-service (8084)
├── groups-service (8085)
└── stats-service (8086)
```

## Levantar el proyecto

```bash
# 1. Copiar y completar las variables de entorno
cp infrastructure/.env.example infrastructure/.env

# 2. Levantar toda la infraestructura
docker-compose -f infrastructure/docker-compose.yml up -d

# 3. Frontend (desarrollo)
cd frontend
npm install
ng serve
```

La app estará disponible en http://localhost:4200  
El API Gateway en http://localhost:8080  
Eureka Dashboard en http://localhost:8761

## Repositorio Jira

https://tesistup.atlassian.net/jira/software/projects/SCRUM/boards
