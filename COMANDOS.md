# 📋 COMANDOS DOCKER - CONCESIONARIO MOTOELITE

## OPCIÓN 1: Ejecutar automáticamente (recomendado)
bash deploy.sh

---

## OPCIÓN 2: Ejecutar comandos manualmente

### 1️⃣ CREAR REDES
docker network create front_net
docker network create back_net

### 2️⃣ CREAR VOLUMEN
docker volume create mysql_data

### 3️⃣ LIMPIAR (opcional - si tienes contenedores previos)
docker stop db backend frontend 2>/dev/null || true
docker rm db backend frontend 2>/dev/null || true

### 4️⃣ CONSTRUIR IMÁGENES
docker build -t backend ./backend
docker build -t frontend ./frontend

### 5️⃣ EJECUTAR BASE DE DATOS
docker run -d \
  --name db \
  --network back_net \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=concesionario \
  -v mysql_data:/var/lib/mysql \
  mysql:8

### 6️⃣ EJECUTAR BACKEND
docker run -d \
  --name backend \
  --network back_net \
  -p 3001:3000 \
  backend

### 7️⃣ EJECUTAR FRONTEND + NGINX
docker run -d \
  --name frontend \
  --network front_net \
  --network back_net \
  -p 8081:80 \
  frontend

---

## 🔍 VERIFICAR STATE
docker ps -a
docker logs frontend
docker logs backend
docker logs db

## 🌐 ACCESO
Frontend:  http://localhost:8081
Backend:   http://localhost:3001
API:       http://localhost:8081/api (desde frontend)

## 🧹 LIMPIAR TODO
docker stop db backend frontend
docker rm db backend frontend
docker volume rm mysql_data
docker network rm front_net back_net
