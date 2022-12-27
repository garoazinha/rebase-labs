
CREATE TABLE exams (id SERIAL, 
                    cpf VARCHAR,
                    patient_name VARCHAR,
                    patient_email VARCHAR,
                    patient_birth_date DATE,
                    patient_address TEXT,
                    patient_city TEXT,
                    patient_state VARCHAR,
                    doctor_crm VARCHAR,
                    doctor_crm_state VARCHAR(2),
                    doctor_name VARCHAR,
                    doctor_email VARCHAR,
                    exam_result_token VARCHAR,
                    exam_date DATE,
                    exam_type TEXT,
                    limits_exam_type VARCHAR,
                    result_exam_type INTEGER);

