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

get '/tests/:token' do
  content_type :json
  query = ExamQuery.new
  exam = query.find_by_token(token: params['token'])
  if exam.empty?
    return 404
  end
  query.render_json(data: exam).to_json
end

get '/exams' do
  send_file 'public/index.html'
end

get '/exams/:token' do
  query = ExamQuery.new
  exams = query.find_by_token(token: params['token'])
  template = File.read('public/show.html')
  template.gsub!('{{token}}', params['token'])
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

post '/importfile' do
  file = params['file']['tempfile']

  csv = CSV.open(file, col_sep: ';', headers: true).to_a
  csv.map! { |r| r.to_hash }
  Import.perform_async(csv.to_json)
  "OK!"
end