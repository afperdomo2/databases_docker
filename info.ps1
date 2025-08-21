# Script para mostrar información de conexión de las bases de datos
# Ejecutar con: .\info.ps1

Write-Host "🔗 Información de Conexión - Entorno de Bases de Datos" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green

# Leer variables del archivo .env si existe
$envFile = ".env"
$envVars = @{}

if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^#][^=]+)=(.*)$') {
            $envVars[$matches[1]] = $matches[2]
        }
    }
}

# Función para obtener variable de entorno
function Get-EnvVar($name, $default) {
    if ($envVars.ContainsKey($name)) {
        return $envVars[$name]
    }
    return $default
}

# Mostrar estado de servicios
Write-Host "`n📊 Estado de Servicios:" -ForegroundColor Cyan
docker-compose ps

Write-Host "`n🗄️ Conexiones a Bases de Datos:" -ForegroundColor Yellow
Write-Host "================================" -ForegroundColor Yellow

# MySQL
Write-Host "`n🐬 MySQL:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'MYSQL_PORT' '3306')" -ForegroundColor White
Write-Host "  Usuario: $(Get-EnvVar 'MYSQL_USER' 'devuser') (o root)" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'MYSQL_PASSWORD' 'devpassword123') (o $(Get-EnvVar 'MYSQL_ROOT_PASSWORD' 'rootpassword123') para root)" -ForegroundColor White
Write-Host "  Base de datos: (crear desde tu aplicación)" -ForegroundColor Yellow
Write-Host "  Connection String: mysql://$(Get-EnvVar 'MYSQL_USER' 'devuser'):$(Get-EnvVar 'MYSQL_PASSWORD' 'devpassword123')@localhost:$(Get-EnvVar 'MYSQL_PORT' '3306')/tu_database" -ForegroundColor Gray

# MariaDB
Write-Host "`n🦭 MariaDB:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'MARIADB_PORT' '3307')" -ForegroundColor White
Write-Host "  Usuario: $(Get-EnvVar 'MYSQL_USER' 'devuser') (o root)" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'MYSQL_PASSWORD' 'devpassword123') (o $(Get-EnvVar 'MYSQL_ROOT_PASSWORD' 'rootpassword123') para root)" -ForegroundColor White
Write-Host "  Base de datos: (crear desde tu aplicación)" -ForegroundColor Yellow

# PostgreSQL
Write-Host "`n🐘 PostgreSQL:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'POSTGRES_PORT' '5432')" -ForegroundColor White
Write-Host "  Usuario: $(Get-EnvVar 'POSTGRES_USER' 'devuser')" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'POSTGRES_PASSWORD' 'devpassword123')" -ForegroundColor White
Write-Host "  Base de datos: (crear desde tu aplicación)" -ForegroundColor Yellow
Write-Host "  Connection String: postgresql://$(Get-EnvVar 'POSTGRES_USER' 'devuser'):$(Get-EnvVar 'POSTGRES_PASSWORD' 'devpassword123')@localhost:$(Get-EnvVar 'POSTGRES_PORT' '5432')/tu_database" -ForegroundColor Gray

# SQL Server
Write-Host "`n🏢 SQL Server:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'SQLSERVER_PORT' '1433')" -ForegroundColor White
Write-Host "  Usuario: sa" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'SQLSERVER_SA_PASSWORD' 'SqlServer123!')" -ForegroundColor White
Write-Host "  Connection String: Server=localhost,$(Get-EnvVar 'SQLSERVER_PORT' '1433');User Id=sa;Password=$(Get-EnvVar 'SQLSERVER_SA_PASSWORD' 'SqlServer123!');" -ForegroundColor Gray

# MongoDB
Write-Host "`n🍃 MongoDB:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'MONGO_PORT' '27017')" -ForegroundColor White
Write-Host "  Usuario: $(Get-EnvVar 'MONGO_INITDB_ROOT_USERNAME' 'root')" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'MONGO_INITDB_ROOT_PASSWORD' 'mongopassword123')" -ForegroundColor White
Write-Host "  Connection String: mongodb://$(Get-EnvVar 'MONGO_INITDB_ROOT_USERNAME' 'root'):$(Get-EnvVar 'MONGO_INITDB_ROOT_PASSWORD' 'mongopassword123')@localhost:$(Get-EnvVar 'MONGO_PORT' '27017')/" -ForegroundColor Gray

# Redis
Write-Host "`n🔴 Redis:" -ForegroundColor Green
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Puerto: $(Get-EnvVar 'REDIS_PORT' '6379')" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'REDIS_PASSWORD' 'redispassword123')" -ForegroundColor White
Write-Host "  Connection String: redis://:$(Get-EnvVar 'REDIS_PASSWORD' 'redispassword123')@localhost:$(Get-EnvVar 'REDIS_PORT' '6379')" -ForegroundColor Gray

Write-Host "`n🌐 Herramientas de Administración Web:" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow

Write-Host "`n🔧 pgAdmin (PostgreSQL):" -ForegroundColor Green
Write-Host "  URL: http://localhost:$(Get-EnvVar 'PGADMIN_PORT' '8080')" -ForegroundColor Cyan
Write-Host "  Email: $(Get-EnvVar 'PGADMIN_DEFAULT_EMAIL' 'admin@example.com')" -ForegroundColor White
Write-Host "  Contraseña: $(Get-EnvVar 'PGADMIN_DEFAULT_PASSWORD' 'pgadminpassword123')" -ForegroundColor White

Write-Host "`n Comandos útiles:" -ForegroundColor Cyan
Write-Host "  .\start.ps1 - Iniciar servicios" -ForegroundColor White
Write-Host "  .\stop.ps1 - Detener servicios" -ForegroundColor White
Write-Host "  docker-compose logs [servicio] - Ver logs" -ForegroundColor White
Write-Host "  docker-compose exec [servicio] bash - Acceder al contenedor" -ForegroundColor White
