require 'test_helper'


RSpec.describe 'Exams' do
  

  it "retorna exames" do

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
end