#!/bin/bash

echo "🐳 Iniciando setup de Concesionario MotoElite..."

# 1️⃣ Crear redes
echo "📡 Creando redes Docker..."
docker network create front_net 2>/dev/null || echo "   (front_net ya existe)"
docker network create back_net 2>/dev/null || echo "   (back_net ya existe)"

# 2️⃣ Crear volumen
echo "💾 Creando volumen para DB..."
docker volume create mysql_data 2>/dev/null || echo "   (mysql_data ya existe)"

# 3️⃣ Detener y eliminar contenedores previos (opcional)
echo "🛑 Deteniendo contenedores previos..."
docker stop db backend frontend 2>/dev/null || true
docker rm db backend frontend 2>/dev/null || true

# 4️⃣ Construir imágenes
echo "🏗️  Construyendo imágenes..."
docker build -t backend ./back
docker build -t frontend ./front

# 5️⃣ Crear contenedor DB
echo "🗄️  Creando contenedor de Base de Datos..."
docker run -d \
  --name db \
  --network back_net \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=concesionario \
  -v mysql_data:/var/lib/mysql \
  mysql:8

# 6️⃣ Esperar a que DB esté lista
echo "⏳ Esperando que BD esté lista..."
sleep 5

# 7️⃣ Crear contenedor Backend
echo "🔙 Creando contenedor Backend..."
docker run -d \
  --name backend \
  --network back_net \
  -p 3001:3000 \
  backend

# 8️⃣ Crear contenedor Frontend + Nginx
echo "🌐 Creando contenedor Frontend + Nginx..."
docker run -d \
  --name frontend \
  --network front_net \
  --network back_net \
  -p 8081:80 \
  frontend

echo ""
echo "✅ Setup completado!"
echo ""
echo "🌐 Acceso a:"
echo "   Frontend:  http://localhost:8081"
echo "   Backend:   http://localhost:3001"
echo ""
echo "📝 Logs:"
echo "   docker logs frontend"
echo "   docker logs backend"
echo "   docker logs db"
