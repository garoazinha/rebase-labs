require_relative 'exam_query'


exam_query = ExamQuery.new
exam_query.truncate_table
exam_query.CSVtoSQL
exam_query.conn.close
