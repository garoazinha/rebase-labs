require 'test_helper'


describe 'Exams page' do

  it 'Método' do
    string = '033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;hemácias;45-52;45\n033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;plaquetas;11-92;25'

    query = ExamQuery.new
    query.import_to_exams_table(data: string)

    array = query.find_all.to_a
    expect(array[0]['exam_type']).to eq('hemácias')
    expect(array[0]['patient_city']).to eq('Nova Esperança')
    expect(array[1]['exam_type']).to eq('plaquetas')
  end
end
