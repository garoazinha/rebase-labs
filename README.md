Projeto de página para visualização de exames médicos.

## 💎 Gems

- PG
- Rack
- Sinatra
- Puma
- Rspec
- Rack-test
- Capybara
- Sidekiq

## Dependências

- Docker
- Ruby
- Postgres
- Redis

## Instruções

- Clone o repositório
- Comando bin/bundle para instalar gems e preparar banco de dados em conteiner docker
- Comandos bin/server, bin/postgres, bin/redis e bin/sidekiq.

## Endpoints

### GET /tests

**Resposta**

200 (Sucesso)

```
[{
"id": "1",
"cpf": "048.973.170-88",
"patient_name": "Emilly Batista Neto",
"patient_email": "gerald.crona@ebert-quigley.com",
"patient_birth_date": "2001-03-11",
"patient_address": "165 Rua Rafaela",
"patient_city": "Ituverava",
"patient_state": "Alagoas",
"doctor_crm": "B000BJ20J4",
"doctor_crm_state": "PI",
"doctor_name": "Maria Luiza Pires",
"doctor_email": "denna@wisozk.biz",
"exam_result_token": "IQCZ17",
"exam_date": "2021-08-05",
"exam_type": "hemácias",
"limits_exam_type": "45-52",
"result_exam_type": "97"
}]
```

### POST /import

**Parâmetros**

```csv
cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;ABCD21;2022-12-05;hemácias;45-52;97
033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;ABCD21;2022-12-05;leucócitos;9-61;89
033.568.987-99;Mariana Souza;mari@email.com;1997-12-15;333 Rua Azul;Nova Esperança;Paraná;B000BJ20J5;PR;Maria Amélia Junco;maria@wisozk.biz;ABCD21;2022-12-05;plaquetas;11-93;97
```
**Resposta**

200

```
Ok!
```

### GET /tests/:token

**Resposta**

200

```json
{
  "cpf": "048.973.170-88",
  "patient_name": "Emilly Batista Neto",
  "patient_email": "gerald.crona@ebert-quigley.com",
  "patient_birth_date": "2001-03-11",
  "exam_result_token": "IQCZ17",
  "exam_date": "2021-08-05",
  "doctor": {
    "doctor_crm": "B000BJ20J4",
    "doctor_crm_state": "PI",
    "doctor_name": "Maria Luiza Pires"
  },
  "tests": [
    {
      "exam_type": "hemácias",
      "limits_exam_type": "45-52",
      "result_exam_type": "97"
    },
    {
      "exam_type": "leucócitos",
      "limits_exam_type": "9-61",
      "result_exam_type": "89"
    },
    {
      "exam_type": "plaquetas",
      "limits_exam_type": "11-93",
      "result_exam_type": "97"
    },
    {
      "exam_type": "hdl",
      "limits_exam_type": "19-75",
      "result_exam_type": "0"
    },
    {
      "exam_type": "ldl",
      "limits_exam_type": "45-54",
      "result_exam_type": "80"
    },
    {
      "exam_type": "vldl",
      "limits_exam_type": "48-72",
      "result_exam_type": "82"
    },
    {
      "exam_type": "glicemia",
      "limits_exam_type": "25-83",
      "result_exam_type": "98"
    },
    {
      "exam_type": "tgo",
      "limits_exam_type": "50-84",
      "result_exam_type": "87"
    },
    {
      "exam_type": "tgp",
      "limits_exam_type": "38-63",
      "result_exam_type": "9"
    },
    {
      "exam_type": "eletrólitos",
      "limits_exam_type": "2-68",
      "result_exam_type": "85"
    },
    {
      "exam_type": "tsh",
      "limits_exam_type": "25-80",
      "result_exam_type": "65"
    },
    {
      "exam_type": "t4-livre",
      "limits_exam_type": "34-60",
      "result_exam_type": "94"
    },
    {
      "exam_type": "ácido úrico",
      "limits_exam_type": "15-61",
      "result_exam_type": "2"
    }
  ]
}
```

## A implementar 

- [x] Busca por token
- [x] Headers
- [ ] Melhorias no css
- [ ] Tratamento de erros




