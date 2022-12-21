require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'import_csv'


get '/tests' do
  nc = CSVtoSQL.new
  e = nc.conn.exec('SELECT * FROM exams;')
  e.map {|i| i.to_json }
end

get '/hello' do
  'Hello world!'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)