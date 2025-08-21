# Script para detener el entorno de bases de datos
# Ejecutar con: .\stop.ps1

Write-Host "🛑 Deteniendo entorno de bases de datos Docker..." -ForegroundColor Red

# Mostrar servicios en ejecución
Write-Host "`n📊 Servicios actualmente en ejecución:" -ForegroundColor Yellow
docker-compose ps

Write-Host "`n¿Qué deseas hacer?" -ForegroundColor Cyan
Write-Host "1. Detener servicios (mantener datos)" -ForegroundColor White
Write-Host "2. Detener y eliminar contenedores (mantener datos)" -ForegroundColor White
Write-Host "3. Detener y eliminar TODO (⚠️ elimina todos los datos)" -ForegroundColor Red
Write-Host "4. Cancelar" -ForegroundColor White

$choice = Read-Host "Selecciona una opción (1-4)"

switch ($choice) {
    "1" { 
        Write-Host "Deteniendo servicios..." -ForegroundColor Yellow
        docker-compose stop
        Write-Host "✅ Servicios detenidos (datos preservados)" -ForegroundColor Green
    }
    "2" { 
        Write-Host "Deteniendo y eliminando contenedores..." -ForegroundColor Yellow
        docker-compose down
        Write-Host "✅ Contenedores eliminados (datos preservados en volúmenes)" -ForegroundColor Green
    }
    "3" { 
        Write-Host "⚠️  ADVERTENCIA: Esto eliminará TODOS los datos de las bases de datos" -ForegroundColor Red
        $confirm = Read-Host "¿Estás seguro? Escribe 'YES' para confirmar"
        if ($confirm -eq "YES") {
            Write-Host "Eliminando todo..." -ForegroundColor Red
            docker-compose down -v
            Write-Host "✅ Todo eliminado (contenedores y datos)" -ForegroundColor Green
        } else {
            Write-Host "❌ Operación cancelada" -ForegroundColor Yellow
        }
    }
    "4" { 
        Write-Host "❌ Operación cancelada" -ForegroundColor Yellow
        exit 0
    }
    default { 
        Write-Host "❌ Opción no válida" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n💡 Para volver a iniciar los servicios, ejecuta: .\start.ps1" -ForegroundColor Cyan
