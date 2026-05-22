-- RouteIt - Inicialización de schemas por servicio
-- Cada microservicio tiene su propio schema para aislamiento lógico

CREATE SCHEMA IF NOT EXISTS users_schema;
CREATE SCHEMA IF NOT EXISTS trips_schema;
CREATE SCHEMA IF NOT EXISTS stops_schema;
CREATE SCHEMA IF NOT EXISTS subscriptions_schema;
CREATE SCHEMA IF NOT EXISTS groups_schema;
CREATE SCHEMA IF NOT EXISTS stats_schema;

-- Permisos al usuario de la app
GRANT ALL PRIVILEGES ON SCHEMA users_schema TO routeit;
GRANT ALL PRIVILEGES ON SCHEMA trips_schema TO routeit;
GRANT ALL PRIVILEGES ON SCHEMA stops_schema TO routeit;
GRANT ALL PRIVILEGES ON SCHEMA subscriptions_schema TO routeit;
GRANT ALL PRIVILEGES ON SCHEMA groups_schema TO routeit;
GRANT ALL PRIVILEGES ON SCHEMA stats_schema TO routeit;
