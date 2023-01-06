require 'pg'
require 'csv'
require 'yaml'

class ExamQuery
  attr_accessor :conn
  

  def initialize
    @conn = PG.connect(host: 'postgres', user: 'postgres', password: 'postgres', dbname: ExamQuery.database_name)
  end

  def self.database_name
    data = YAML.safe_load_file('database.yml')
    data[ENV['APP_ENV']||='development']['database_name']
  end

  def find_all
    @conn.exec('SELECT * FROM exams')
  end

  def truncate_table
    @conn.exec('TRUNCATE exams RESTART IDENTITY;')
  end

  def insert_params(hash)
    @conn.exec("INSERT INTO exams (cpf, patient_name, patient_email, patient_birth_date,
                patient_address, patient_city, patient_state, doctor_crm, doctor_crm_state,
                doctor_name, doctor_email, exam_result_token,
                exam_date, exam_type, limits_exam_type, result_exam_type)
              VALUES
              ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16);",
              [hash['cpf'],hash['patient_name'],hash['patient_email'], hash['patient_birth_date'], hash['patient_address'], 
              hash['patient_city'], hash['patient_state'], hash['doctor_crm'], hash['doctor_crm_state'],
              hash['doctor_name'], hash['doctor_email'], hash['exam_result_token'], hash['exam_date'],
              hash['exam_type'], hash['limits_exam_type'], hash['result_exam_type']] )
  end
  
  def create_exam_table
    @conn.exec('CREATE TABLE exams (id SERIAL, 
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
    result_exam_type INTEGER);')
  end

  def import_to_exams_table(data:)

    rows = CSV.parse(data, col_sep: ';', row_sep: '\n')

    columns = YAML.safe_load_file('columns.yml')['columns'].keys

    rows.each do |row|
      x = row.each_with_object({}).with_index do |(cell, acc), idx|
        data = YAML.safe_load_file('columns.yml')['columns']
        column = columns[idx]
        acc[data[column]] = cell
      end
      insert_params(x)
    end

  end

  def CSVtoSQL
    rows = CSV.read("./data.csv", col_sep: ';')

    columns = rows.shift

    rows.map do |row|
      x = row.each_with_object({}).with_index do |(cell, acc), idx|
        data = YAML.safe_load_file('columns.yml')['columns']
        column = columns[idx]
        acc[data[column]] = cell
      end
      insert_params(x)
    end
  end
end

