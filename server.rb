require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'exam_query'

set :port, 3000
set :bind, '0.0.0.0'

before do
  headers 'Access-Control-Allow-Origin' => '*', 
           'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']  
end

options '*' do
  200
end

get '/tests' do
  content_type :json
  query = ExamQuery.new
  all_exams = query.find_all
  query.conn.close

  all_exams.to_a.to_json

end

get '/exams' do
  content_type 'text/html'
  send_file 'public/index.html'
end


get '/hello' do
  'Hello world!'
end

