
class CSVtoSQL
  def initialize
  end

  def self.sqling
    require 'pg'
    require 'csv'
    conn = PG.connect(host: 'postgres', user: 'postgres', password: 'postgres')
    conn.exec('DROP TABLE patients;')
    conn.exec('CREATE TABLE patients (cpf TEXT, name TEXT, email VARCHAR);')
    rows = CSV.read("./data.csv", col_sep: ';')

    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
        if column =='cpf' 
          conn.exec("INSERT INTO patients (cpf) VALUES ('#{cell}');")

        end
      end
    end
  end
end