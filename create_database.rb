require 'pg'

db = PG.connect(host: 'postgres', user: 'postgres', password: 'postgres')

begin 
  db.exec('CREATE DATABASE test')
  puts('Database test created')
rescue PG::DuplicateDatabase => e
  puts('Database already exists')
rescue PG::ConnectionBad => e
  puts('Postgres is unreachable')
end