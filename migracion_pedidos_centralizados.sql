-- ZJ Sur / Bonilla
-- Centraliza albarán y cobro en bonilla_orders.
-- Ejecutar una sola vez si se desea preparar la BD antes de subir la nueva versión.

ALTER TABLE bonilla_orders ADD COLUMN receive_date DATE NULL;
ALTER TABLE bonilla_orders ADD COLUMN subtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00;
ALTER TABLE bonilla_orders ADD COLUMN vat_total DECIMAL(10,2) NOT NULL DEFAULT 0.00;
ALTER TABLE bonilla_orders ADD COLUMN total DECIMAL(10,2) NOT NULL DEFAULT 0.00;
ALTER TABLE bonilla_orders ADD COLUMN include_vat TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE bonilla_orders ADD COLUMN discount DECIMAL(10,2) NOT NULL DEFAULT 0.00;
ALTER TABLE bonilla_orders ADD COLUMN payment_status VARCHAR(20) NOT NULL DEFAULT 'pendiente';
ALTER TABLE bonilla_orders ADD COLUMN payment_date DATE NULL;
ALTER TABLE bonilla_orders ADD COLUMN payment_method VARCHAR(30) NULL;
ALTER TABLE bonilla_orders ADD COLUMN albaran_number VARCHAR(80) NULL;
ALTER TABLE bonilla_orders ADD COLUMN request_token VARCHAR(64) NULL;

ALTER TABLE bonilla_orders ADD UNIQUE KEY uq_bonilla_orders_request_token (request_token);
ALTER TABLE bonilla_orders ADD UNIQUE KEY uq_bonilla_orders_albaran (albaran_number);

-- La aplicación rellena automáticamente albaranes de pedidos antiguos y migra
-- el estado de cobro que exista en bonilla_delivery_notes.
