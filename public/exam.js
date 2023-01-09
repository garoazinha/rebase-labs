const show = document.getElementById('data');
const dl = document.getElementById('patient-data');
const doctordl = document.getElementById('doctor-data');
const results = document.getElementById('exam-results');
const token = document.getElementById('token').innerText;
const url = `http://localhost:3000/tests/` + token
span = document.createElement('span');
span.innerHTML = token;
let data;
fetch(url)
  .then((response) => { if (!response.ok) {
    c = document.querySelector('.container');
    document.body.style.backgroundColor = 'lightgrey';
    c.innerHTML = `<h1>${response.status}</h1>`;
    throw Error(response.statusText);
    
  }
  return response; })
  .then((response) => response.json() )
  .then((data) => {
    console.log(data);

    newPoint('CPF', data.cpf, dl);
    newPoint('Nome', data.patient_name, dl);
    newPoint('E-mail', data.patient_email, dl);
    newPoint('Data de Nascimento', data.patient_birth_date, dl);
    newPoint('Data do exame', data.exam_date, dl);
    newPoint('Médico', data.doctor.doctor_name, doctordl);
    newPoint('CRM', data.doctor.doctor_crm, doctordl);
    newPoint('E-mail do profissional de saúde', data.patient_email, doctordl);

    data.tests.forEach(element => {
      examResult(element);
    });

  })
  .catch(function(error) {
    console.log(error);
  });

function newPoint(datatitle, datastring, list) {
  dt = document.createElement('dt');
  dt.innerHTML = datatitle;
  dd = document.createElement('dd');
  dd.innerHTML = datastring;
  list.appendChild(dt);
  list.appendChild(dd);
}

function examResult(element) {
  const tr = document.createElement('tr');
  
  tr.insertCell(0).textContent = `${element.exam_type}`;
  tr.insertCell(1).textContent = `${element.limits_exam_type}`;
  tr.insertCell(2).textContent = `${element.result_exam_type}`;
  results.appendChild(tr);

}



