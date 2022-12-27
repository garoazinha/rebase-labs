require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'exam_query'


get '/tests' do
  
  query = ExamQuery.new
  all_exams = query.find_all
  query.conn.close
  content_type :json
  all_exams.to_a.to_json

end

get '/hello' do
  'Hello world!'
end

