
require 'rack/test'
require_relative '../server'
require 'json'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  
  ENV['APP_ENV'] = 'test'
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
  Capybara.app = Sinatra::Application
  
  

end