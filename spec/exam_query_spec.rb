require 'test_helper'


describe 'ExamQuery', type: :model do

  it '#import_to_exams_table' do
    string = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;hemácias;45-52;97
033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;eletrólitos;2-68;85'
    parsed = CSV.new(string, col_sep: ';', headers: true)
    final = parsed.to_a.map { |r| r.to_hash }

    query = ExamQuery.new
    query.import_to_exams_table(data: final.to_json)

    array = query.find_all.to_a
    expect(array[0]['exam_type']).to eq('hemácias')
    expect(array[0]['patient_city']).to eq('Nova Esperança')
    expect(array[1]['exam_type']).to eq('eletrólitos')
  end

end
