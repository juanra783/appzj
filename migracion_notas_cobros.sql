ALTER TABLE bonilla_delivery_notes ADD COLUMN IF NOT EXISTS payment_date DATE NULL;
ALTER TABLE bonilla_delivery_notes ADD COLUMN IF NOT EXISTS payment_method VARCHAR(40) NULL;
