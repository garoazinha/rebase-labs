require 'test_helper'


RSpec.describe 'Exams page', type: :feature do
  it 'Usuário visita página de exame' do
    csv = CSV.open('./spec/support/sample.csv', col_sep: ';', headers: true).to_a
    csv.map! { |r| r.to_hash }
    ExamQuery.new.import_to_exams_table(data: csv.to_json)

    visit '/exams/ABCD21'

    expect(page).to have_content('ABCD21')
  end
end