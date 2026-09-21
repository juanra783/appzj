-- Ejecutar una sola vez si la columna localidad todavía no existe.
ALTER TABLE bonilla_clients ADD COLUMN localidad VARCHAR(120) NULL;

-- Rellena localidades conocidas cuando aparecen dentro de la dirección.
UPDATE bonilla_clients SET localidad='Algeciras' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%Algeciras%';
UPDATE bonilla_clients SET localidad='Los Barrios' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%Los Barrios%';
UPDATE bonilla_clients SET localidad='San Roque' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%San Roque%';
UPDATE bonilla_clients SET localidad='La Línea de la Concepción' WHERE (localidad IS NULL OR localidad='') AND (address LIKE '%La Línea%' OR address LIKE '%La Linea%');
UPDATE bonilla_clients SET localidad='Tarifa' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%Tarifa%';
UPDATE bonilla_clients SET localidad='Jimena de la Frontera' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%Jimena%';
UPDATE bonilla_clients SET localidad='Castellar de la Frontera' WHERE (localidad IS NULL OR localidad='') AND address LIKE '%Castellar%';
