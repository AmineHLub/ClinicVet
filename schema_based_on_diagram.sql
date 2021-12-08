CREATE TABLE patients (
  id SERIAL,
  name VARCHAR(120),
  date_of_birth DATE,
  PRIMARY KEY (id)
);
CREATE TABLE medical_history (
  id SERIAL,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(120),
  PRIMARY KEY (id),
  CONSTRAINT FK_patient_id
    FOREIGN KEY (patient_id)
      REFERENCES patients(id)
);
CREATE TABLE treatments (
  id SERIAL,
  type VARCHAR(120),
  name VARCHAR(120),
  PRIMARY KEY (id)
);
CREATE TABLE invoices (
  id SERIAL,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  PRIMARY KEY (id)
);
CREATE TABLE invoice_items (
  id SERIAL,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY (id),
  CONSTRAINT FK_invoice_id
    FOREIGN KEY (invoice_id)
      REFERENCES invoices(id),
  CONSTRAINT FK_treatment_id
    FOREIGN KEY (treatment_id)
      REFERENCES treatments(id)
);
CREATE TABLE treat_medi (
  id SERIAL,
  med_history_id INT,
  treat_id INT,
  PRIMARY KEY (id),
  CONSTRAINT FK_treat_id
    FOREIGN KEY (treat_id)
      REFERENCES treatments(id),
  CONSTRAINT FK_med_history_id
    FOREIGN KEY (med_history_id)
      REFERENCES medical_history(id)
);
