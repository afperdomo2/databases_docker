# 🏗️ Development Infrastructure Services

Este proyecto proporciona una infraestructura completa de servicios para el desarrollo de software usando Docker Compose, incluyendo bases de datos, mensajería y herramientas de administración web.

## 📋 Servicios Incluidos

### Bases de Datos

- **MySQL 8.0** - Puerto 3306
- **MariaDB 10.11** - Puerto 3307
- **PostgreSQL 15** - Puerto 5432
- **SQL Server 2022 Express** - Puerto 1433
- **MongoDB 7.0** - Puerto 27017
- **Redis 7.2** - Puerto 6379

### Mensajería

- **Kafka 4.1.1** - Puertos 9092 (interno), 9093 (externo)
- **NATS** - Puerto 4222

### Herramientas de Administración

- **pgAdmin** - Puerto 8080 (para PostgreSQL)
- **Kafka UI** - Puerto 8083 (para Kafka)

## 🚀 Instalación y Configuración

### Prerrequisitos

- Docker Desktop instalado
- Docker Compose v3.8 o superior

### Configuración Inicial

1. **Clonar o descargar el proyecto**

   ```bash
   git clone <tu-repositorio>
   cd databases
   ```

2. **Configurar variables de entorno**

   ```bash
   # Copiar el archivo de ejemplo
   cp .env.example .env

   # Editar las variables según tus necesidades
   # Las contraseñas por defecto están configuradas para desarrollo
   ```

3. **Crear directorios para scripts de inicialización (opcional)**

   ```bash
   mkdir -p init-scripts/mysql
   mkdir -p init-scripts/mariadb
   mkdir -p init-scripts/postgres
   mkdir -p init-scripts/sqlserver
   mkdir -p init-scripts/mongodb
   ```

## 🏃‍♂️ Ejecución

### Iniciar todos los servicios

```bash
docker-compose up -d
```

### Iniciar servicios específicos

```bash
# Solo PostgreSQL y pgAdmin
docker-compose up -d postgres pgadmin

# Solo MySQL
docker-compose up -d mysql

# Solo MongoDB
docker-compose up -d mongodb

# Solo Kafka y Kafka UI
docker-compose up -d kafka-dev kafka-ui-dev

# Solo NATS
docker-compose up -d nats-dev
```

### Verificar el estado

```bash
docker-compose ps
```

### Ver logs

```bash
# Logs de todos los servicios
docker-compose logs -f

# Logs de un servicio específico
docker-compose logs -f postgres
```

## 🔗 Conexiones

### Conexiones desde aplicaciones externas

**Importante:** Las bases de datos se inician vacías (sin tablas predefinidas). Las aplicaciones (Spring Boot, NestJS, etc.) deben crear sus propias bases de datos, tablas y esquemas según sus necesidades usando los usuarios configurados.

#### MySQL

- **Host:** localhost
- **Puerto:** 3306
- **Usuario:** devuser (o root)
- **Contraseña:** devpassword123 (o rootpassword123 para root)
- **Base de datos:** (crear desde tu aplicación)

#### MariaDB

- **Host:** localhost
- **Puerto:** 3307
- **Usuario:** devuser (o root)
- **Contraseña:** devpassword123 (o rootpassword123 para root)
- **Base de datos:** (crear desde tu aplicación)

#### PostgreSQL

- **Host:** localhost
- **Puerto:** 5432
- **Usuario:** devuser
- **Contraseña:** devpassword123
- **Base de datos:** (crear desde tu aplicación)

#### SQL Server

- **Host:** localhost
- **Puerto:** 1433
- **Usuario:** sa
- **Contraseña:** SqlServer123!
- **Base de datos:** (crear desde tu aplicación)

#### MongoDB

- **Host:** localhost
- **Puerto:** 27017
- **Usuario:** root
- **Contraseña:** mongopassword123
- **Connection String:** `mongodb://root:mongopassword123@localhost:27017/`
- **Base de datos:** (crear desde tu aplicación)

#### Redis

- **Host:** localhost
- **Puerto:** 6379
- **Contraseña:** redispassword123

#### Kafka

- **Host:** localhost
- **Puerto externo:** 9093
- **Puerto interno:** 9092 (para contenedores)
- **Bootstrap Servers:** localhost:9093

#### NATS

- **Host:** localhost
- **Puerto:** 4222
- **Token:** dev_token_123

### Herramientas de Administración Web

#### pgAdmin (PostgreSQL)

- **URL:** <http://localhost:8080>
- **Email:** <admin@example.com>
- **Contraseña:** pgadminpassword123

#### Kafka UI (Kafka)

- **URL:** <http://localhost:8083>
- **Cluster Name:** local

## 📁 Persistencia de Datos

Todos los datos se almacenan en volúmenes Docker nombrados:

- `mysql_data` - Datos de MySQL
- `mariadb_data` - Datos de MariaDB
- `postgres_data` - Datos de PostgreSQL
- `sqlserver_data` - Datos de SQL Server
- `mongodb_data` - Datos de MongoDB
- `redis_data` - Datos de Redis
- `pgadmin_data` - Configuración de pgAdmin

## 🔩 Configuración para Aplicaciones

### Spring Boot (application.yml)

```yaml
# MySQL
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/tu_database_name
    username: devuser  # o root
    password: devpassword123  # o rootpassword123
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: create-drop  # o update, validate, etc.

# PostgreSQL
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/tu_database_name
    username: devuser
    password: devpassword123
    driver-class-name: org.postgresql.Driver
```

### NestJS (TypeORM)

```typescript
// MySQL
TypeOrmModule.forRoot({
  type: 'mysql',
  host: 'localhost',
  port: 3306,
  username: 'devuser',  // o 'root'
  password: 'devpassword123',  // o 'rootpassword123'
  database: 'tu_database_name',
  entities: [__dirname + '/**/*.entity{.ts,.js}'],
  synchronize: true, // solo en desarrollo
})

// PostgreSQL
TypeOrmModule.forRoot({
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'devuser',
  password: 'devpassword123',
  database: 'tu_database_name',
  entities: [__dirname + '/**/*.entity{.ts,.js}'],
  synchronize: true, // solo en desarrollo
})
```

### Variables de Entorno Recomendadas

```env
# Para tus aplicaciones
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=devuser
DB_PASSWORD=devpassword123
DB_NAME=mi_aplicacion

# MongoDB
MONGO_URI=mongodb://root:mongopassword123@localhost:27017/mi_aplicacion

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=redispassword123

# Kafka
KAFKA_BOOTSTRAP_SERVERS=localhost:9093
KAFKA_EXTERNAL_PORT=9093

# NATS
NATS_HOST=localhost
NATS_PORT=4222
NATS_TOKEN=dev_token_123
```

## 🔨 Comandos Útiles

### Detener servicios

```bash
docker-compose down
```

### Detener y eliminar volúmenes (⚠️ elimina todos los datos)

```bash
docker-compose down -v
```

### Reconstruir contenedores

```bash
docker-compose up -d --build
```

### Acceder a un contenedor

```bash
# Ejemplo: acceder a PostgreSQL
docker-compose exec postgres psql -U testuser -d testdb

# Ejemplo: acceder a MySQL
docker-compose exec mysql mysql -u testuser -p testdb

# Ejemplo: acceder a MongoDB
docker-compose exec mongodb mongosh -u root -p
```

## 🔧 Personalización

### Cambiar puertos

Todos los puertos son configurables a través de variables de entorno para evitar conflictos con servicios existentes:

```env
# Bases de datos
MYSQL_PORT=3306
MARIADB_PORT=3307
POSTGRES_PORT=5432
SQLSERVER_PORT=1433
MONGO_PORT=27017
REDIS_PORT=6379

# Herramientas web
PGADMIN_PORT=8080
KAFKA_UI_PORT=8083
KAFKA_EXTERNAL_PORT=9093
NATS_PORT=4222
```

Si tienes conflictos de puertos, simplemente cambia los valores en tu archivo `.env`. Por ejemplo:

```env
# Evitar conflictos con servicios locales
MYSQL_PORT=3326
POSTGRES_PORT=5442
PGADMIN_PORT=8090
KAFKA_UI_PORT=8093
KAFKA_EXTERNAL_PORT=9094
NATS_PORT=4223
```

### Cambiar contraseñas

Modifica las variables de contraseña en `.env` antes del primer inicio.

### Agregar más bases de datos

Puedes agregar más servicios al `docker-compose.yaml` siguiendo el mismo patrón.

## ⚠️ Consideraciones de Seguridad

- Las contraseñas por defecto son para desarrollo únicamente
- Cambia todas las contraseñas antes de usar en producción
- Considera usar Docker Secrets para entornos productivos
- Restringe el acceso a los puertos según sea necesario

## 🐛 Troubleshooting

### Error de puerto en uso

```bash
# Verificar qué proceso está usando el puerto
netstat -tulpn | grep :5432

# Cambiar el puerto en .env o detener el servicio conflictivo
```

### Error de memoria en SQL Server

SQL Server requiere al menos 2GB de RAM asignados a Docker Desktop.

### Problemas de conexión

Verifica que los contenedores estén ejecutándose:

```bash
docker-compose ps
docker-compose logs [nombre-servicio]
```

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
