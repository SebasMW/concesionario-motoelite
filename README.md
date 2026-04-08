# Concesionario MotoElite
---

##  Descripción del proyecto

Este proyecto consiste en una aplicación web para gestionar un concesionario de motos.
Permite listar, crear y eliminar motos mediante una API REST.

La aplicación está dividida en tres servicios:

* Backend (API REST)
* Frontend (cliente web)
* Base de datos (MySQL)

El frontend consume el backend mediante un proxy inverso configurado con Nginx.

---

## Tecnologías utilizadas

* Node.js + Express (Backend)
* HTML + JavaScript (Frontend)
* Nginx (Servidor web + Proxy inverso)
* MySQL (Base de datos)
* Docker (Contenedores)
* Redes Docker
* Volúmenes Docker

---

## Estructura del proyecto

```bash
/back
/front
README.md
```

---
#  DESPLIEGUE COMPLETO (PASO A PASO)

## 1️⃣ Crear redes

```bash
docker network create front_net
docker network create back_net
```

---

## 2️⃣ Crear volumen para la base de datos

```bash
docker volume create mysql_data
```

---

## 3️⃣ Ejecutar base de datos

```bash
docker run -d \
  --name db \
  --network back_net \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=concesionario \
  -v mysql_data:/var/lib/mysql \
  mysql:8
```

---

## 4️⃣ Construcción de imagen BACKEND (multi-stage)

```bash
docker build -t backend ./back
```

---

## 5️⃣ Ejecutar backend

```bash
docker run -d \
  --name backend \
  --network back_net \
  -p 3001:3000 \
  backend
```

---

## 6️⃣ Construcción de imagen FRONTEND (multi-stage + Nginx)

```bash
docker build -t frontend ./front
```

---

## 7️⃣ Ejecutar frontend

```bash
docker run -d \
  --name frontend \
  --network front_net \
  --network back_net \
  -p 8081:80 \
  frontend
```

---

# ACCESO A LA APLICACIÓN

* Frontend: http://localhost:8081
* Backend: http://localhost:3001

---

# FUNCIONAMIENTO

El frontend realiza peticiones a:

```bash
/api/motos
```

Nginx redirige estas peticiones al backend:

```nginx
location /api/ {
  proxy_pass http://backend:3000/;
}
```

---

# ENDPOINTS

* GET /motos → Obtener motos
* POST /motos → Crear moto
* DELETE /motos/:id → Eliminar moto

---

#  CUMPLIMIENTO DE REQUISITOS

✔ Backend con framework (Express)
✔ Frontend servido con Nginx
✔ Proxy inverso configurado
✔ Imágenes Docker personalizadas
✔ Multi-stage build
✔ Base de datos con volumen
✔ Dos redes Docker
✔ Sin docker-compose
✔ Arquitectura no monolítica
✔ Frontend consume backend correctamente


---

## 👨‍💻 Autor

SebasMW

```
