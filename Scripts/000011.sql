CREATE TABLE ddt_anamnesis (
  r_object_id varchar(16) PRIMARY KEY DEFAULT GetNextId(),
  r_creation_date TIMESTAMP DEFAULT NOW() NOT NULL,
  r_modify_date TIMESTAMP NOT NULL,

  dsid_hospitality_session VARCHAR(16) REFERENCES ddt_hospital(r_object_id),
  dsid_patient VARCHAR(16) REFERENCES ddt_patient(r_object_id),
  dsid_doctor VARCHAR(16) REFERENCES ddt_doctors(r_object_id),
  dss_complaints VARCHAR(2048),
  dss_anamnesis_morbi VARCHAR(2048),
  dss_anamnesis_vitae VARCHAR(2048),
  dss_anamnesis_allergy VARCHAR(512),
  dss_anamnesis_epid VARCHAR(512),
  dss_past_surgeries VARCHAR(512),
  dss_accompanying_illnesses VARCHAR(512),
  dss_drugs_intoxication VARCHAR(512),
  dss_st_presens VARCHAR(512),
  dss_respiratory_system VARCHAR(512),
  dss_cardiovascular_system VARCHAR(512),
  dss_digestive_system VARCHAR(512),
  dss_urinary_system VARCHAR(512),
  dss_nervous_system VARCHAR(512),
  dss_diagnosis_justification VARCHAR(512),
  dss_operation_cause VARCHAR(512),
  dss_template_name VARCHAR(128),
  dsb_template BOOLEAN,
  dss_diagnosis VARCHAR(512)
);

CREATE TRIGGER ddt_anamnesis BEFORE INSERT OR UPDATE
  ON ddt_anamnesis FOR EACH ROW
EXECUTE PROCEDURE dmtrg_f_modify_date();

CREATE OR REPLACE FUNCTION audit_anamnesis_creating_row () RETURNS TRIGGER AS '
BEGIN
INSERT INTO ddt_history 
(dsid_hospitality_session, dsid_patient, dsid_doctor, dsid_operation_id, dss_operation_type)
 VALUES (NEW.dsid_hospitality_session, NEW.dsid_patient, NEW.dsid_doctor, NEW.r_object_id, TG_TABLE_NAME );
 RETURN NEW;
END;
' LANGUAGE  plpgsql;


CREATE TRIGGER audit_ddt_anamnesis AFTER INSERT 
	ON ddt_anamnesis FOR EACH ROW 
EXECUTE PROCEDURE audit_anamnesis_creating_row();

INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause,
	dss_diagnosis_justification) VALUES ('oksup', 
	true, 
	'�� ����� ��������', 
	'��������� �������� ������������ ������������. ��������� ������������ �������� �� ������������. ������� �� ���������.  ��������� ������� �� 120/80 ��.��.��. �� ���� ��������, ����� ���������� �������� ������� �� ����������, ������������� � ���������� �������� ���� ������������������.������� ����� ���������� ���� � ������� ������ ��������, ������� ��������� � ����������� ����� �������, �������������  15 �����. ������ ������� ���. ���������������� � ��� �67.',
	'�� ���� ��������, ����� ������������� ������� �� ���������. �������� ��� �������� ������ 1,0 �� �������������� �����.',
	'��������� �������. ������� � ��������, ����������� �������, ������������� �������� ��������, �� ������� ��������, ������������ �� ������� � ������������, ������ �� �������. ��������� ��������. T ���� 36.5�. ������ ������� � ������� ��������� ��������������� �������, ��������� ���������, ���������� ���������� ��� ������ �����������, �������������� ����� - ����������� ����. ������������ ����������, ����������������. ������-������������ ������� - ��� ������������. ������������� ���� �� ���������.',
	'������� ������ ���������� �����, ����������������. �� 17 � ������. ��� ����� �������, ����������� ���������� �� ���������. ����������: ������� ����� �� ��������, ������� ���� � 2-� ������. �������������� � ������� ������� � 2-� ������, ������ ���. ��������� �������� ���������� �� ������������ �������� ������� ������.',
	'������� ������ �� ��������. ����������� ������ ������ �� ������-��������� �����, �� ���������������. ������� ������������� ������� ������ � ��������� �� 0,5 �� ������� ����� � ����� �� ����� ��������������� �����. �� 100/60 �� ��.��, ��іPS�59, ���� ����������, ������������������� ���������� � ����������.',
	'���: ������ ���������� ������� � �������� �������� ST.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'�������� �������, ������������� ���������, �������� �������� ����������������, , �������������, ������������������, ����������������� �������. ��������� ������� ���������� � �������������  ���������� ������� ������� ����������� ��������, ��������������� �������',
	'� �����  ����������� �� ���, �������� �� ��������� ����������� ������ �������� ��� � �������� ���������������� ��������.');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause,
	dss_diagnosis_justification) VALUES ('oksdown', 
	true, 
	'�� ����� ��������', 
	'����� ��������� �� �� ������� , ����������� 120/80 �� �� ��. . ������������ ��� ��������. ��������� ���������  �� ���������.    ��������� ��������� � ������� ���������� ����, ��������� ������� ���� �� ��������, ������� ���� � ������� ������ �����������, ��������� � ���, ��������� � ��� 67, ���������������� �  ���.',
	'�� ���� ��������, �����  ������������� �������  �� ��������.',
	'��������� ������� ������� �������. ������ ������� �������, ��������������� �������, ���� ������, ��������� ���������, �����������  ���� �� ��������, ����� �� ��������, ����������� ������� � ����. ������������ ����������, ����������������. ������-������������ ������� � ��� ������������. ���������� ������ �  ��� ������������. ������������� ���� �� ���������.',
	'������� ������ ���������� �����,  ����������������. �� 17 � ������. ��� ����� �������, ����������� ���������� �� ���������. ����������: ������� ����� �� ��������, ������� ���� � 2-� ������. �������������� � ������� ������������ � ������� �������� � 2-� ������, ������ ���. ��������� �������� ���������� �� ������������ �������� ������� ������. ',
	'������� ������ �� ��������. ����������� ������ ������ �� ������-��������� �����, �� ���������������.  ������� ������������� ������� ������ � ��������� �� 0,5 �� ������� ����� � �����. ���� - �� ����. �� 140/80 �� ��.��, ���-PS�68, ���� ����������, ������������������� ���������� � ����������.',
	'�������� �����. ���������, ������������� � �����, �������, ��������. ������������� ������ ���. ������ D=S. ����������� �������� �����������. �������� ��������������� ��������� ���.',
	'���: ������ ���������� ������� ��� ������� �������� ST.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'�������� �������, ������������� ���������, �������� �������� ����������������, , �������������, ������������������, ����������������� �������. ��������� ������� ���������� � �������������  ���������� ������� ������� ����������� ��������, ��������������� �������',
	'ST �������� ���������� �������� ��������� �� ���, ���������� ��������� ������������ �������� �������� �������� ��� � �������� ���������������� �������� ����� ��������� ������������ � �������������� ������� �����.');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('kag', 
	true, 
	'�� ����� ��������', 
	'��������� �������� ��������������� �������� � ���������� �� 180/100 �� �� ��, ����������� � ��130/80�� �� ��. �� ���� �������� ����������� ������������ � ����� � �������� �� �������� ������������� � ���������� ��������. �� ����������� ������������ ������������� ��� � �������� �������. ��������� ��������� �������������, �������������, �������������� �������. ��������� ��������� �������, �� ���� ������� ������������� �������� �� �� 190/100 �� �� ��, �������������� �������� ������������� � ��������� ������������� ��������. �������������� ��������� � ���, ����������������.',
	'�� ���� ��������, ����� ������������� �������� �� �����������.',
	'��������� �������. ������� � ��������, ����������� �������, ������������� �������� ��������, �� ������� ��������, ������������ �� ������� � ������������, ������ �� �������. ��������� ��������. T ���� 36.5�. ������ ������� � ������� ��������� ��������������� �������, ��������� ���������, ���������� ���������� ��� ������ �����������, �������������� ����� - ����������� ����. ������������ ����������, ����������������. ������-������������ ������� - ��� ������������. ������������� ���� �� ���������.',
	'������� ������ ���������� �����. ���������� ���� ��������. ������� ������ � �����. ��������� �������� ���������� �����������. ��� ������� ��������������: ������� �������, ����������� � ������ �������. �� 18 � ���.',
	'������� ������ ��� ������������. ����������� ������ ������������ � V ����������. ������� ������������� ������� ������: ������� - III ����������, ������ - �� ������� ���� �������, ����� - 3 �� ������� �� ����� ��������������� �����. ���� ������ ����������, ���������. ��� 77 � ���. PS 77 � ���. ������������������� ����������, ������������ �� ����� ����� ��  170/100 �� �� ��.',
	'�������� �����. ���������, ������������ � �����, �������, ��������. ������������� ������ ���. ������ D=S. ����������� �������� �����������. �������� ��������������� ��������� ���.',
	'��������������� ������� II ������, ���� 3. ��������������� ���� �� . ���: ����������� ���������� 2 -3 ��. HII.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('aorta', 
	true, 
	'�� ����� ��������', 
	'� ������� ���������� ������� ������� ��������� �� �� 140/80 �� �� ��, ����������� 120/80 �� �� ��. ������� ���� �������  � ������� ��������� ���������� ����, �����  ��������� ���� �� ��������, � ������� ������ ������������, � ������. ��������� � ���, ��������� � ��� 67, ���������������� � ���.',
	'�������� � ������ ������������� ���������� ����� ���.',
	'����� ��������� �������. ��������� � ��������. ������ �������: �������,  ��������� ���������. T 36,7. ����������� ��������� ���� ���. ����������������� ������������. ������������� ���� �� ������������. ���������� ������ �� ���������. �������������� �����- ���.',
	'������� ������ ���������� �����. ���������� ���� ��������. ������� ������ � �����. ��������� �������� ���������� �����������. ��� ������� ��������������: ������� �������, ����������� � ������ �������. �� 18 � ���.',
	'������� ������ ��� ������������. ����������� ������ ������������ � V ����������. ������� ������������� ������� ������: ������� � III ����������, ������ � �� ������� ���� �������, ����� � 3 �� ������� �� ����� ��������������� �����. ���� ������ ����������, ���������. ��� 123 � ���. PS 120  � ���. ������������������� ����������, ������������ �� ����� ����� ��  150/80 �� �� ��.',
	'�������� �����. ���������, ������������ � �����, �������, ��������. ������������� ������ ���. ������ D=S. ����������� �������� �����������. �������� ��������������� ��������� ���.',
	'��������������� ������� II ������, ���� 4. HII. ���������� ����� , ������������, �������������� ����� ������������ �������.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause,
	dss_diagnosis_justification) VALUES ('gb', 
	true, 
	'�� ����� ��������', 
	'������� ������ ���� ������� � ������� ���������� ���, ����� ���� �������� ��������� �� �� 180/120 �� �� ��. ����������� � �� 130/80�� �� ��. ������������  ��� ��������. � ��������� ����� ��������� �� ���������. ������� �� ���� ��������� �� �� 180/100, ������� ���������� � ������� ������, ��������, ������ ������� ���. ���������������� � ��� �67.',
	'�� ���� ��������, ����� ������������� �������� �� �����������.',
	'����� ��������� ������� �������. ��������� � ��������. ������ �������: ������-�������, ��������� ���������. T 36,7. ����������� ��������� ���� ���. ����������������� ������������. ������������� ���� �� ������������. ���������� ������ �� ���������. �������������� ����� - �����������.',
	'������� ������ ���������� �����. ���������� ���� ��������. ������� ������ � �����. ��������� �������� ���������� �����������. ��� ������� ��������������: ������� �������, ������ ��� . �� 18 � ���.',
	'������� ������ ��� ������������. ����������� ������ ������������ � V ����������. ������� ������������� ������� ������: ������� � III ����������, ������ � �� ������� ���� �������, ����� � 3 �� ������� �� ����� ��������������� �����. ���� ������ ����������, ���������. ��� 77 � ���. PS 77 � ���. ������������������� ����������, ������������ �� ����� ����� ��  140/80 �� �� ��.',
	'�������� �����. ���������, ������������� � �����, �������, ��������. ������������� ������ ���. ������ D=S. ����������� �������� �����������. �������� ��������������� ��������� ���.',
	'��������������� ������� II ������, ���� 3. ��������������� ���� �� ',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'�������� �������, ������������� ���������, ������� �������� ������������� �������. ��������� ������� ���������� � ������������� ���������� ������� ��������������� �������',
	'� ������ ��������, ������ ������� �������� �������� �������������, ����������, ����-������������� �������');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('piks', 
	true, 
	'�� ������, �� ����� ��������', 
	'������� ���� ������� � ������� ���������� ���, ����� ������� ��������� �� �� 180/100 �� �� ��. ����������� � ��120/80�� �� ��. ������� ���. ����������� ���. �������� ��������������� ���������, ������������� � �������������.  �������������� ����� ����������� ����������. ������������ ������������������ � ���������� � ����� � �������������� ��������������� ��������������. ����� ������� �������� ��������������� ���������. ��������� ��������� � ������� ��������� ���������� ����, ����� ������� ������,  ��������� � ���,  ���������������� � ���.',
	'�� ���� ��������, ����� ������������� ������� �� ���������. �������� ��� �������� ������ 1,0 �� �������������� �����.',
	'��������� ������. � ��������, �������� ������������� ��������. ��������� �����������. T ���� 36.5�. ������ ������� � ������� ��������� ��������������� �������, ���� ������, ��������� ���������, ����������� ���� �� ��������, �������������� ����� - ����������� ����. ������������ ����������. ��� ��������� ������� ������ �������������. ������-������������ ������� - ��� ������������. ������������� ���� �� ���������.',
	'������� ������ ���������� �����, ����������������. �� 19 � ������. ��� ����� �������, ����������� ���������� �� ���������. ����������: ������� ����� �� ��������, ������� ���� � 2-� ������. �������������� � ������� �������, ��������� � �/� � 2-� ������, ������ ���. ��������� �������� ���������� �� ������������ �������� ������� ������.',
	'������� ������ �� ��������. ����������� ������ ������ �� ������-��������� �����, �� ���������������. ������� ������������� ������� ������ � ��������� �� 0,5 �� ������� ����� � ����� �� ����� ��������������� �����. �� 140/90 �� ��.��, ��іPS�51, ���� ����������, ������������������� ���������� � ����������.',
	'������� �������� � �����, ������������� �������� ��������, ������������� �������� �� ����������, �������� ��������������� ������������ ���.',
	'���: �������������� �������������. �2�.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'�������� �������, ������������� ���������, �������� �������� ����������������, ����������������, ����������������� , �������������, ������������������, ����������������� �������. ��������� ������� ���������� � ������������� ���������� ������� ���, ��������� �����  ������������� ��������������� ��������������.');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('pikvik', 
	true, 
	'�� ������ ������� ��������� ����� ��������, ������ ��� ���������� ���������� ��������, ���������� ������ � ������, ����� ������ �����������', 
	'����� ��������-���������� ����������� �������� �� ���������. ������������ �������� �� ������������, ��������������� ������� �� ���������. ��������������� ����������� ����������, ���������� �����.  ��������� ������ �������� ����� ������ �����������, ������. ��������� ��������� ��������� ��� ������ - �������� ���������� ������ � ������, ���������� ������ ���, ������ ��� ����������� ���������� ��������. ��������� ��� ��� ������ ����� ���������. �  ����� � ��������� ������ � �����, ������ ������� ��� ��������� � ��� ����67, ����������������.',
	'�� ���� ��������, ����� ������������� ������� �� ���������.',
	'��������� �������. ��������� � ���������. ������ �������: ������� �������. T 36,7. ����������������� ������������. ������������� ���� �� ������������. ���������� ������ �� ���������. �������������� �����: ����� ���.',
	'������� ������ ���������� �����, ����������������. �� 21 � ������. ��� ����� �������, ����������� ���������� �� ���������. ����������: ������� ����� �� ��������, ������� ���� � 2-� ������. �������������� � ��� ������������ ������ ������� �������, ��������� ����� �����.',
	'������� ������������� ������� ������ ��������� ������ � ����� � �� ����� ��������������� �����; ������ � �� ������� ���� �������, ������� � �� ������ III �����. ��� ������������ ������: ���� ������ ������, ���������, ����� ���. �� 150/110 ��.��.��.; ���-84 �� � ���. �����- 84 � ���.',
	'������� �������� � �����, ������������� �������� ��������. ������������� ��������� ���. �������� ��������������� ������������ ���.',
	'������� �������. ����������� �������� ������ � ������ �������������. ��������.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'�������� �������, ������������� ���������, �������� �������� ����������������, ����������������, ����������������� , �������������, ������������������, ����������������� �������. ��������� ������� ���������� � ������������� ���������� ������� ���, ��������� �����  ������������� ��������������� ��������������.');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('dep', 
	true, 
	'�� ����������� �� ������� ���������', 
	'(�� ��������� ����������� ������������): �������� ��������������� ��������, ���, ����������� ����� � ������������. ���������� ����� �� ������ � �������, ������������ ���� ����������������� � ��������� ����������� ������. ��������� ���������  , ����� ������� ����� �� ���������� � �����, � ��� ���������� � ����������������� � ��� �67. � ������������ ��������� ��������� ��������������� ������� ���������� � ���.',
	'��� ������.',
	'��������� �������. �������� �� ��������. t� ���� 36,7��. ��������� � � ����������� �������� ������. ������� ����������������. ������ ������� ������-������� �������, �����, ���� ���. ����������� ������ �����������. ����������� ������ �����������.',
	'������� ������ ���������� �����, ����������������. �� 24 � ������. ��� ������������ ������ ������������� ����� ��������� ����� � ����� ������, ����������� ������� � ������ ������� �� �������� �������.',
	'������� ������ �� ��������. ������� ������������� ������� ������ � �� ����� ��������������� �����; ������ � �� ������� ���� �������, ������� � �� ������ III �����. ��� ������������ ������: ���� ������ ������, ���������, ����� ���. ��-165/100 ��.��.��.; ���-88 �� � ���. �����- 88 � ���.',
	'����� �������� ����������. ������������� ��������� ���.',
	'��� ����������� ����������� ���� �� ������� ��������������� ���������. ���: ������������������� �������������. ��������� ����� � ������������: ��������������� ������� III ��, ���� 4. ��������������� ���� �� ',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'');

	INSERT INTO ddt_anamnesis (dss_template_name, 
	dsb_template, 
	dss_complaints, 
	dss_anamnesis_morbi,
	dss_drugs_intoxication, 
	dss_st_presens, 
	dss_respiratory_system,
	dss_cardiovascular_system,
	dss_nervous_system,
	dss_diagnosis,
	dss_anamnesis_epid,
	dss_anamnesis_allergy,
	dss_operation_cause) VALUES ('death', 
	true, 
	'�� ����������� �� ������� ���������', 
	'������� �������� �� �������� ��-�� ������� ���������. ��������� � ��������� ����������� ������.  ������� ������ �� ������ ��� ������������. ���������� ����� �������� ��������� ������������� ��������. ������� �������� �� ���������. ��������� ��������� ��������, ����� � �������� ����� ��������� ������, ������� ��������, �������� ��������� � ������� � ��������������. ������������ ������� ���. ��������� � ��������� ��� ����� ������� ���������.',
	'��� ������.',
	'���������  ������ ������. ������� �������� ����. ��������� ���� � ������ ����������. T ���� 36.5?�. ������ ������� � ������� ��������� �������, ����������, ��������� ���������, ����������� ���� �� ��������. ���������� ���������� ��� ������ �����������, �������������� ����� � ���. ������������ ����������, ����������������.',
	'������� ������ ���������� �����, ����������������. �� 24 � ������. ��� ������������ ������ ������������� ����� ��������� ����� � ����� ������, ����������� ������� � ������ ������� �� �������� �������.',
	'������� ������ �� ��������. �� 80/40 �� ��.��, ��іPS�30, ���� ������������.',
	'������� �������� � ����.',
	'���. ��������������� ��������� ���������� �������. ��������������� ����� ������������ �������. ������� ����. ��2�. ��������������� ������� III ��, ���� �������.',
	'�� ��������� 6 ������� �� ������ �� �������, � ������� � ������������� ��������, �������� � ���� �� �������',
	'�� ��������',
	'');

	


