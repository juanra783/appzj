ALTER TABLE bonilla_clients
  ADD COLUMN contact_person VARCHAR(120) NULL AFTER phone,
  ADD COLUMN commercial_status VARCHAR(30) NOT NULL DEFAULT 'pendiente' AFTER contact_person,
  ADD COLUMN last_visit DATE NULL AFTER commercial_status,
  ADD COLUMN next_visit DATE NULL AFTER last_visit;
