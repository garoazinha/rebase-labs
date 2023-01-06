require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'exam_query'
require_relative 'jobs/my_jobs'

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

post '/import' do
  csv = CSV.new(request.body.read, col_sep: ';', headers: true).to_a
  csv.map! { |r| r.to_hash }
  Import.perform_async(csv.to_json)
  "Ok"
end

