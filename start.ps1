# Script de inicialización para el entorno de bases de datos
# Ejecutar con: .\start.ps1

Write-Host "🗄️  Iniciando entorno de bases de datos Docker..." -ForegroundColor Green

# Verificar si Docker está ejecutándose
Write-Host "Verificando Docker..." -ForegroundColor Yellow
try {
    docker --version | Out-Null
    Write-Host "✅ Docker está disponible" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Docker no está disponible o no está ejecutándose" -ForegroundColor Red
    Write-Host "Por favor, inicia Docker Desktop y vuelve a intentar." -ForegroundColor Red
    exit 1
}

# Verificar si Docker Compose está disponible
Write-Host "Verificando Docker Compose..." -ForegroundColor Yellow
try {
    docker-compose --version | Out-Null
    Write-Host "✅ Docker Compose está disponible" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Docker Compose no está disponible" -ForegroundColor Red
    exit 1
}

# Verificar si existe el archivo .env
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  Archivo .env no encontrado, copiando desde .env.example..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
    Write-Host "✅ Archivo .env creado" -ForegroundColor Green
    Write-Host "💡 Puedes editar el archivo .env para personalizar las configuraciones" -ForegroundColor Cyan
}

# Mostrar servicios disponibles
Write-Host "`n📋 Servicios disponibles:" -ForegroundColor Cyan
Write-Host "  • MySQL (Puerto 3306)" -ForegroundColor White
Write-Host "  • MariaDB (Puerto 3307)" -ForegroundColor White  
Write-Host "  • PostgreSQL (Puerto 5432)" -ForegroundColor White
Write-Host "  • SQL Server (Puerto 1433)" -ForegroundColor White
Write-Host "  • MongoDB (Puerto 27017)" -ForegroundColor White
Write-Host "  • Redis (Puerto 6379)" -ForegroundColor White
Write-Host "  • pgAdmin (Puerto 8080)" -ForegroundColor White

# Preguntar qué servicios iniciar
Write-Host "`n🚀 ¿Qué servicios deseas iniciar?" -ForegroundColor Green
Write-Host "1. Todos los servicios" -ForegroundColor White
Write-Host "2. Solo PostgreSQL + pgAdmin" -ForegroundColor White
Write-Host "3. Solo MySQL" -ForegroundColor White
Write-Host "4. Solo MongoDB" -ForegroundColor White
Write-Host "5. Personalizado" -ForegroundColor White

$choice = Read-Host "Selecciona una opción (1-5)"

switch ($choice) {
    "1" { 
        Write-Host "Iniciando todos los servicios..." -ForegroundColor Yellow
        docker-compose up -d
    }
    "2" { 
        Write-Host "Iniciando PostgreSQL y pgAdmin..." -ForegroundColor Yellow
        docker-compose up -d postgres pgadmin
    }
    "3" { 
        Write-Host "Iniciando MySQL..." -ForegroundColor Yellow
        docker-compose up -d mysql
    }
    "4" { 
        Write-Host "Iniciando MongoDB..." -ForegroundColor Yellow
        docker-compose up -d mongodb
    }
    "5" { 
        Write-Host "Servicios disponibles: mysql, mariadb, postgres, sqlserver, mongodb, redis, pgadmin" -ForegroundColor Cyan
        $services = Read-Host "Ingresa los servicios separados por espacios"
        Write-Host "Iniciando servicios: $services" -ForegroundColor Yellow
        docker-compose up -d $services.Split(' ')
    }
    default { 
        Write-Host "Opción no válida, iniciando todos los servicios..." -ForegroundColor Yellow
        docker-compose up -d
    }
}

# Esperar un momento para que los servicios se inicien
Start-Sleep -Seconds 5

# Mostrar estado de los servicios
Write-Host "`n📊 Estado de los servicios:" -ForegroundColor Green
docker-compose ps

# Mostrar URLs de acceso
Write-Host "`n🌐 URLs de acceso:" -ForegroundColor Green
Write-Host "  • pgAdmin: http://localhost:8080" -ForegroundColor Cyan

Write-Host "`n✅ ¡Entorno iniciado correctamente!" -ForegroundColor Green
Write-Host "💡 Usa 'docker-compose logs -f [servicio]' para ver los logs" -ForegroundColor Cyan
Write-Host "💡 Usa 'docker-compose down' para detener todos los servicios" -ForegroundColor Cyan
