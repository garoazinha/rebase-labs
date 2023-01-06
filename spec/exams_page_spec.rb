require 'test_helper'


RSpec.describe 'Exams page', type: :feature do
  
  it 'Usuário visita página de exames' do
    visit '/exams'

    expect(page).to have_content('Exames')
  end
end
  