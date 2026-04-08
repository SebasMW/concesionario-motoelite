const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
app.use(cors());
app.use(express.json());

// Crear pool de conexiones
const pool = mysql.createPool({
  host: process.env.DB_HOST || "db",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "root",
  database: process.env.DB_NAME || "concesionario",
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// GET - Obtener todas las motos
app.get("/motos", async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query("SELECT * FROM motos ORDER BY id ASC");
    connection.release();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// GET - Obtener moto por ID
app.get("/motos/:id", async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query("SELECT * FROM motos WHERE id = ?", [req.params.id]);
    connection.release();
    
    if (rows.length === 0) {
      return res.status(404).json({ error: "Moto no encontrada" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// POST - Crear nueva moto
app.post("/motos", async (req, res) => {
  try {
    const { nombre, marca, precio, imagen } = req.body;
    
    if (!nombre || !marca || !precio) {
      return res.status(400).json({ error: "Faltan campos requeridos" });
    }

    const connection = await pool.getConnection();
    const [result] = await connection.query(
      "INSERT INTO motos (nombre, marca, precio, imagen) VALUES (?, ?, ?, ?)",
      [nombre, marca, precio, imagen || null]
    );
    connection.release();

    res.status(201).json({
      id: result.insertId,
      nombre,
      marca,
      precio,
      imagen: imagen || null,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// PUT - Actualizar moto
app.put("/motos/:id", async (req, res) => {
  try {
    const { nombre, marca, precio, imagen } = req.body;
    const connection = await pool.getConnection();
    
    // Verificar si existe
    const [check] = await connection.query("SELECT * FROM motos WHERE id = ?", [req.params.id]);
    if (check.length === 0) {
      connection.release();
      return res.status(404).json({ error: "Moto no encontrada" });
    }

    // Actualizar
    await connection.query(
      "UPDATE motos SET nombre = ?, marca = ?, precio = ?, imagen = ? WHERE id = ?",
      [nombre, marca, precio, imagen || null, req.params.id]
    );
    connection.release();

    res.json({ id: req.params.id, nombre, marca, precio, imagen });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// DELETE - Eliminar moto
app.delete("/motos/:id", async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [result] = await connection.query("DELETE FROM motos WHERE id = ?", [req.params.id]);
    connection.release();

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Moto no encontrada" });
    }
    res.json({ message: "Moto eliminada correctamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

// Health check
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.listen(3000, "0.0.0.0", () => {
  console.log("✅ API corriendo en puerto 3000");
  console.log("🗄️ Conectado a MySQL");
});
