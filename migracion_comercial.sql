ALTER TABLE bonilla_orders ADD COLUMN IF NOT EXISTS payment_status VARCHAR(20) NOT NULL DEFAULT 'pendiente';
ALTER TABLE bonilla_orders ADD COLUMN IF NOT EXISTS payment_date DATE NULL;
ALTER TABLE bonilla_orders ADD COLUMN IF NOT EXISTS payment_method VARCHAR(30) NULL;
ALTER TABLE bonilla_delivery_notes ADD COLUMN IF NOT EXISTS payment_status VARCHAR(20) NOT NULL DEFAULT 'pendiente';
ALTER TABLE bonilla_delivery_notes ADD COLUMN IF NOT EXISTS payment_date DATE NULL;
ALTER TABLE bonilla_delivery_notes ADD COLUMN IF NOT EXISTS payment_method VARCHAR(30) NULL;
