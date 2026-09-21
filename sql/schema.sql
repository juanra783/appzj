CREATE TABLE IF NOT EXISTS bonilla_clients (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  business_name VARCHAR(180) NOT NULL,
  address VARCHAR(255) DEFAULT NULL,
  phone VARCHAR(60) DEFAULT NULL,
  contact_person VARCHAR(120) DEFAULT NULL,
  localidad VARCHAR(120) DEFAULT NULL,
  commercial_status VARCHAR(40) NOT NULL DEFAULT 'pendiente',
  last_visit DATE DEFAULT NULL,
  next_visit DATE DEFAULT NULL,
  route_id INT UNSIGNED DEFAULT NULL,
  route_order INT NOT NULL DEFAULT 0,
  image_path VARCHAR(255) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bonilla_products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  cost_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  vat DECIMAL(5,2) NOT NULL DEFAULT 21.00,
  unit VARCHAR(30) NOT NULL DEFAULT 'unidad',
  sku VARCHAR(80) NULL,
  description TEXT NULL,
  category VARCHAR(80) NOT NULL DEFAULT 'Otros',
  format VARCHAR(120) NULL,
  units_per_box INT UNSIGNED NOT NULL DEFAULT 0,
  image_path VARCHAR(255) DEFAULT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bonilla_orders (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  client_id INT UNSIGNED NOT NULL,
  order_date DATE DEFAULT NULL,
  receive_date DATE DEFAULT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'pendiente',
  notes TEXT DEFAULT NULL,
  subtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  vat_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  include_vat TINYINT(1) NOT NULL DEFAULT 1,
  discount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  payment_status VARCHAR(20) NOT NULL DEFAULT 'pendiente',
  payment_date DATE DEFAULT NULL,
  payment_method VARCHAR(30) DEFAULT NULL,
  albaran_number VARCHAR(80) DEFAULT NULL,
  request_token VARCHAR(64) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_bonilla_orders_request_token (request_token),
  UNIQUE KEY uq_bonilla_orders_albaran (albaran_number),
  CONSTRAINT fk_bonilla_orders_client FOREIGN KEY (client_id) REFERENCES bonilla_clients(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bonilla_order_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED DEFAULT NULL,
  product_name VARCHAR(120) NOT NULL,
  quantity DECIMAL(10,2) NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  vat DECIMAL(5,2) NOT NULL DEFAULT 21.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_bonilla_items_order FOREIGN KEY (order_id) REFERENCES bonilla_orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_bonilla_items_product FOREIGN KEY (product_id) REFERENCES bonilla_products(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bonilla_custom_fields (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  field_name VARCHAR(100) NOT NULL,
  field_type VARCHAR(30) NOT NULL DEFAULT 'text',
  options_json TEXT DEFAULT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bonilla_client_field_values (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  client_id INT UNSIGNED NOT NULL,
  field_id INT UNSIGNED NOT NULL,
  field_value TEXT DEFAULT NULL,
  UNIQUE KEY uq_bonilla_client_field (client_id, field_id),
  CONSTRAINT fk_bonilla_values_client FOREIGN KEY (client_id) REFERENCES bonilla_clients(id) ON DELETE CASCADE,
  CONSTRAINT fk_bonilla_values_field FOREIGN KEY (field_id) REFERENCES bonilla_custom_fields(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO bonilla_products (name, sort_order)
SELECT 'Caja de patatas', 1 WHERE NOT EXISTS (SELECT 1 FROM bonilla_products WHERE name='Caja de patatas');
INSERT INTO bonilla_products (name, sort_order)
SELECT 'Cesta 1', 2 WHERE NOT EXISTS (SELECT 1 FROM bonilla_products WHERE name='Cesta 1');
INSERT INTO bonilla_products (name, sort_order)
SELECT 'Cesta 2', 3 WHERE NOT EXISTS (SELECT 1 FROM bonilla_products WHERE name='Cesta 2');
INSERT INTO bonilla_products (name, sort_order)
SELECT 'Cesta 3', 4 WHERE NOT EXISTS (SELECT 1 FROM bonilla_products WHERE name='Cesta 3');
