require 'test_helper'


RSpec.describe 'Exams page', type: :feature do
  
  it 'Usuário visita página de exames' do
    visit '/exams'

    expect(page).to have_content('Exames')
    expect(page).to have_button('Upload')
    expect(page).to have_field('Arquivo')
  end

  it 'Usuário faz upload' do
    visit '/exams'

    Sidekiq::Testing.inline! do
      attach_file("Arquivo", './spec/support/sample.csv')
      click_on 'Upload'
    end

    array = ExamQuery.new.find_all.to_a
    expect(array[0]['exam_type']).to eq('hemácias')
  end
end
  