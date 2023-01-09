
require_relative '../exam_query'

begin 
  ENV['APP_ENV'] = 'development'
  db = ExamQuery.new
  db.conn.exec('CREATE DATABASE test')
  # Criando database de teste
rescue PG::DuplicateDatabase => e
  puts('Database already exists')
rescue PG::ConnectionBad => e
  puts('Postgres is unreachable')
end

begin
  ENV['APP_ENV'] = 'development'
  db = ExamQuery.new
  db.create_exam_table
  puts('Exams table created in development database')
rescue PG::DuplicateTable => e
  puts('Exams table already exists')
rescue PG::ConnectionBad => e
  puts('Postgres is unreachable')
end

begin
  ENV['APP_ENV'] = 'test'
  db = ExamQuery.new
  db.create_exam_table
  puts('Exams table created in test database')
rescue PG::DuplicateTable => e
  puts('Table already exists')
rescue PG::ConnectionBad => e
  puts('Postgres is unreachable')
end