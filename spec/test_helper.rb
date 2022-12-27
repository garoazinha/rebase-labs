
require 'rack/test'
require_relative '../server'
require 'json'
require 'test_helper'

include Rack::Test::Methods

RSpec.configure do |config|
  config.around(:each) do |db|
    ExamQuery.new.truncate_table
    db.run
    ExamQuery.new.truncate_table
  end

  def app
    Sinatra::Application
  end
end