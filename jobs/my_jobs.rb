require "sidekiq"
require_relative '../exam_query'

class Import
  include Sidekiq::Job
  Sidekiq.strict_args!(false)

  def perform(csv)
    ExamQuery.new.import_to_exams_table(data: csv)
  end
end
