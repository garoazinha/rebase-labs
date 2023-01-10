const formData = new FormData();
const form = document.querySelector('.form form')
const input = document.getElementById('file');
const alert =  document.querySelector('.form p')

form.addEventListener('submit', function(e) {
  e.preventDefault();
  formData.append('file', input.files[0]);

  fetch('http://localhost:3000/importfile', {
    method: 'POST',
    body: formData

  }).then((response) => {
    if (!response.ok) {
      alert.innerHTML = 'Algo deu errado! :/';
      return;
    }
    alert.innerHTML = 'Algo deu muuuito certo';
  }).catch((error) => {
    console.log(error);
  })
  
  
})

