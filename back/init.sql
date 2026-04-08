-- Crear tabla de motos
CREATE TABLE IF NOT EXISTS motos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  marca VARCHAR(100) NOT NULL,
  precio INT NOT NULL,
  imagen LONGTEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar datos de ejemplo
INSERT INTO motos (nombre, marca, precio, imagen) VALUES
('Harley-Davidson Street 750', 'Harley-Davidson', 8500, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500&h=350&fit=crop'),
('Yamaha MT-07', 'Yamaha', 7200, 'https://images.unsplash.com/photo-1516522091618-baf7a0dfcc5f?w=500&h=350&fit=crop'),
('Kawasaki Ninja 400', 'Kawasaki', 4500, 'https://images.unsplash.com/photo-1558618667-841d18f2b4f9?w=500&h=350&fit=crop'),
('BMW S1000RR', 'BMW', 15000, 'https://images.unsplash.com/photo-1570295676195-d45d34b73cee?w=500&h=350&fit=crop'),
('Ducati Panigale V4', 'Ducati', 16500, 'https://images.unsplash.com/photo-1549399542-7e3f8b83ad38?w=500&h=350&fit=crop'),
('Honda CB500', 'Honda', 6000, 'https://images.unsplash.com/photo-1516522091618-baf7a0dfcc5f?w=500&h=350&fit=crop');
