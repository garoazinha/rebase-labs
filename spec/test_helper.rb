
require 'rack/test'
require_relative '../server'
require 'json'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.around(:each) do |test|
    db = ExamQuery.new
    db.truncate_table
    test.run
    db.truncate_table
  end

  def app
    Sinatra::Application
  end
end