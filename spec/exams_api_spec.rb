require 'test_helper'


RSpec.describe 'Exams API' do
  
  context 'GET /TESTS' do
    it 'com sucessos' do

      exam = {                                                                                
      "cpf"=>"048.973.170-88",                                                                   
      "patient_name"=>"Emilly Batista Neto",                                                     
      "patient_email"=>"gerald.crona@ebert-quigley.com",                                         
      "patient_birth_date"=>"2001-03-11",                                                        
      "patient_address"=>"165 Rua Rafaela",                                                      
      "patient_city"=>"Ituverava",                                                               
      "patient_state"=>"Alagoas",                                                                
      "doctor_crm"=>"B000BJ20J4",                                                                
      "doctor_crm_state"=>"PI",                                                                  
      "doctor_name"=>"Maria Luiza Pires",                                                        
      "doctor_email"=>"denna@wisozk.biz",                                                        
      "exam_result_token"=>"IQCZ17",                   
      "exam_date"=>"2021-08-05",                       
      "exam_type"=>"hemácias",
      "limits_exam_type"=>"45-52",
      "result_exam_type"=>"97"}
      ExamQuery.new.insert_params(exam)

      get '/tests'

      expect(last_response).to be_ok
      data = JSON.parse(last_response.body)
      expect(data[0]['cpf']).to eq('048.973.170-88')
      expect(data[0]['patient_name']).to eq("Emilly Batista Neto")
      expect(data[0]['patient_email']).to eq("gerald.crona@ebert-quigley.com")
      expect(data.length).to eq 1
      expect(data[0].keys.length).to eq 17
    end

    it 'retorna erro' do 
      allow(PG).to receive(:connect).and_raise(PG::ConnectionBad)

      get '/tests'

      expect(last_response.status).to eq 500
    end
  end

  context 'POST /IMPORT' do
    it 'e dados são importados para banco de dados' do
      string = "cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame\n033.568.987-99;Pedro Amaro;pedro@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;hdl;45-52;97\n033.568.987-99;Pedro Amaro;pedro@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;ldl;2-68;85"
      
      Sidekiq::Testing.inline! do
        post '/import', string
      end

      array = ExamQuery.new.find_all.to_a
      expect(array[0]['exam_type']).to eq('hdl')
      expect(array[0]['patient_name']).to eq('Pedro Amaro')
      expect(array[1]['exam_type']).to eq('ldl')
    end

    it 'e a ação fica enfileirada' do
      string = 'cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame\n033.568.987-99;Pedro Amaro;pedro@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;hdl;45-52;97\n033.568.987-99;Pedro Amaro;pedro@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;MSNA12;2022-12-05;ldl;2-68;85'

      post '/import', string

      expect(Import.jobs.length).to eq 1
    end
  end

  context 'POST /IMPORTFILE' do
    it 'com sucesso' do
      file = Rack::Test::UploadedFile.new('./spec/support/sample.csv', 'text/csv')

      Sidekiq::Testing.inline! do
        post "/importfile", file:
      end

      array = ExamQuery.new.find_all.to_a
      expect(array[0]['exam_type']).to eq('hemácias')
      expect(array[0]['exam_result_token']).to eq 'ABCD21'
      expect(array.length).to eq 13
    end
  end
end