
require 'rack/test'
require_relative '../server'
require 'json'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'sidekiq/testing'

RSpec.configure do |config|
  
  ENV['APP_ENV'] = 'test'
  config.include Rack::Test::Methods
  config.around(:each) do |test|
    db = ExamQuery.new
    db.truncate_table
    test.run

  end

  def app
    Sinatra::Application
  end
  
  Capybara.app = Sinatra::Application
  
  

end