CREATE TABLE ddt_doctors (
  r_object_id varchar(16) PRIMARY KEY DEFAULT GetNextId(),
  r_creation_date TIMESTAMP DEFAULT NOW() NOT NULL,
  r_modify_date TIMESTAMP NOT NULL,

  dss_login VARCHAR(100) NOT NULL UNIQUE,
  dss_full_name VARCHAR(256),
  dss_initials VARCHAR(256),
  dss_appointment_name VARCHAR(128),
  dss_phone VARCHAR(15),
  dss_email VARCHAR(40),
  dsi_appointment_type int
);

CREATE TRIGGER ddt_doctors_trg_modify_date BEFORE INSERT OR UPDATE
  ON ddt_doctors FOR EACH ROW
EXECUTE PROCEDURE dmtrg_f_modify_date();