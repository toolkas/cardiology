CREATE TABLE ddt_xray (
  r_object_id varchar(16) PRIMARY KEY DEFAULT GetNextId(),
  r_creation_date TIMESTAMP DEFAULT NOW() NOT NULL,
  r_modify_date TIMESTAMP NOT NULL,

  dsid_hospitality_session VARCHAR(16) REFERENCES ddt_hospital(r_object_id),
  dsid_patient VARCHAR(16) REFERENCES ddt_patient(r_object_id),
  dsid_doctor VARCHAR(16) REFERENCES ddt_doctors(r_object_id),
  dsdt_analysis_date timestamp,
  dss_chest_xray VARCHAR(512),
  dss_control_radiography VARCHAR(512),
  dss_mskt VARCHAR(512),
  dss_kt VARCHAR(512),
  dss_mrt VARCHAR(512),
  dsdt_kt_date timestamp,
  
  dsid_parent VARCHAR(16),
  dss_parent_type VARCHAR(30)
);



CREATE TRIGGER ddt_xray BEFORE INSERT OR UPDATE
  ON ddt_xray FOR EACH ROW
EXECUTE PROCEDURE dmtrg_f_modify_date();

CREATE OR REPLACE FUNCTION audit_ddt_xray_creating_row () RETURNS TRIGGER AS '
BEGIN
INSERT INTO ddt_history 
(dsid_hospitality_session, dsid_patient, dsid_doctor, dsid_operation_id, dss_operation_type, dsdt_operation_date)
 VALUES (NEW.dsid_hospitality_session, NEW.dsid_patient, NEW.dsid_doctor, NEW.r_object_id, TG_TABLE_NAME, dsdt_analysis_date);
 RETURN NEW;
END;
' LANGUAGE  plpgsql;


CREATE TRIGGER audit_ddt_xray AFTER INSERT 
	ON ddt_xray FOR EACH ROW 
EXECUTE PROCEDURE audit_ddt_xray_creating_row();