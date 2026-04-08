# 🏍️ Concesionario Elite - MotoElite

Aplicación web full-stack para gestionar un concesionario de motocicletas con Docker, Node.js y MySQL.

## 🛠️ Tecnologías

- **Backend**: Node.js + Express
- **Base de Datos**: MySQL 8.0
- **Frontend**: HTML5 + Vanilla JavaScript
- **Contenedores**: Docker + Docker Compose

## 📋 Requisitos Previos

- Docker (versión 20.10+)
- Docker Compose (versión 1.29+)

## 🚀 Instalación y Ejecución

### 1. Clonar el repositorio
```bash
cd /home/sebastianWM/Descargas/Concesionario_MotoElite
```

### 2. Iniciar los contenedores
```bash
docker-compose up --build
```

Esto inicializará:
- **MySQL** (puerto 3306)
- **Backend API** (puerto 3000)
- **Frontend** (puerto 8080)

### 3. Acceder a la aplicación
```
http://localhost:8080
```

## 📡 API Endpoints

### Obtener todas las motos
```
GET /motos
```

### Obtener moto por ID
```
GET /motos/:id
```

### Crear nueva moto
```
POST /motos
Content-Type: application/json

{
  "nombre": "Harley-Davidson Street 750",
  "marca": "Harley-Davidson",
  "precio": 8500,
  "imagen": "https://..."
}
```

### Actualizar moto
```
PUT /motos/:id
Content-Type: application/json

{
  "nombre": "Nuevo nombre",
  "marca": "Nueva marca",
  "precio": 9000,
  "imagen": "https://..."
}
```

### Eliminar moto
```
DELETE /motos/:id
```

### Health Check
```
GET /health
```

## 📊 Esquema de Base de Datos

### Tabla: motos
```sql
CREATE TABLE motos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  marca VARCHAR(100) NOT NULL,
  precio INT NOT NULL,
  imagen LONGTEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## 🗄️ Credenciales MySQL

- **Usuario**: admin
- **Contraseña**: admin
- **Base de datos**: motos
- **Host**: db (dentro de Docker)
- **Puerto**: 3306

## 🐳 Comandos Docker Útiles

### Ver los contenedores en ejecución
```bash
docker-compose ps
```

### Ver logs del backend
```bash
docker-compose logs backend
```

### Ver logs de MySQL
```bash
docker-compose logs db
```

### Detener los contenedores
```bash
docker-compose down
```

### Detener y eliminar todo (incluyendo volúmenes)
```bash
docker-compose down -v
```

### Acceder a la consola MySQL
```bash
docker exec -it motos_db mysql -u admin -p motos
# Contraseña: admin
```

## 📁 Estructura del Proyecto

```
Concesionario_MotoElite/
├── backend/
│   ├── server.js          # API Express
│   ├── package.json       # Dependencias Node
│   ├── init.sql           # Script SQL inicial
│   └── Dockerfile
├── frontend/
│   ├── index.html         # App web
│   └── Dockerfile
├── docker-compose.yml     # Configuración Docker
└── README.md             # Este archivo
```

## ✨ Características

✅ CRUD completo de motos  
✅ Validación de datos  
✅ Manejo de errores robusto  
✅ Interfaz responsiva  
✅ Datos iniciales precargados  
✅ Timestamps automáticos  
✅ Health check endpoint  

## 🔧 Desarrollo

### Modificar el Backend
1. Editar `backend/server.js`
2. Ejecutar: `docker-compose down` y `docker-compose up --build`

### Modificar la Base de Datos
1. Editar `backend/init.sql`
2. Eliminar volúmenes: `docker-compose down -v`
3. Reiniciar: `docker-compose up --build`

### Modificar el Frontend
1. Editar `frontend/index.html`
2. Recargar el navegador

## 📝 Notas

- La base de datos se inicializa automáticamente con 6 motos de ejemplo
- Los datos persisten en el volumen `db_data`
- El backend espera que MySQL esté disponible antes de iniciar
- CORS está habilitado para todas las rutas

## 🐛 Troubleshooting

### Error: "Cannot connect to database"
- Asegurate que MySQL está en ejecución: `docker-compose logs db`
- Espera 5-10 segundos para que MySQL termine de inicializar

### Error: "Port already in use"
- Cambia los puertos en `docker-compose.yml`

### Error: "Module not found"
- Ejecuta: `docker-compose down -v` y `docker-compose up --build`

## 📞 Soporte

Para reportar problemas, revisa los logs con:
```bash
docker-compose logs -f
```

---

**Desarrollado con ❤️ para MotoElite** 🏍️
