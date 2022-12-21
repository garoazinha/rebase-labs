
class CSVtoSQL
  require 'pg'
  require 'csv'
  attr_accessor :conn

  def initialize
    @conn = PG.connect(host: 'postgres', user: 'postgres', password: 'postgres')
  end


  def insert_params(hash)
    @conn.exec("INSERT INTO exams (cpf, patient_name, patient_email, patient_birth_date,
                patient_address, patient_city, patient_state, doctor_crm, doctor_crm_state,
                doctor_name, doctor_email, exam_result_token,
                exam_date, exam_type, limits_exam_type, result_exam_type)
              VALUES
              ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16);",
              [hash['cpf'],hash['nome paciente'],hash['email paciente'], hash['data nascimento paciente'], hash['endereço/rua paciente'], 
              hash['cidade paciente'], hash['estado patiente'], hash['crm médico'], hash['crm médico estado'],
              hash['nome médico'], hash['email médico'], hash['token resultado exame'], hash['data exame'],
              hash['tipo exame'], hash['limites tipo exame'], hash['resultado tipo exame']] )
  end

  def self.sqling
    conn = CSVtoSQL.new
    rows = CSV.read("./data.csv", col_sep: ';')

    columns = rows.shift

    rows.map do |row|
      x = row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
      conn.insert_params(x)
    end
    conn.conn.close
  end
end

