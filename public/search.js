const searchButton = document.getElementById('search')
const searchInput = document.getElementById('tokensearch');
const searchUrl = `http://localhost:3000/tests/`;
const searchResults = document.querySelector('.search');

searchButton.addEventListener('click', function(e){
  e.preventDefault();
  value = searchInput.value;

  if (value == '') {
    searchResults.style.display = 'none';
    
    return;
  }
  fetchExams(value).then(exams => {
    searchResults.innerHTML = '';
    a = document.createElement('a');
    a.href = `http://localhost:3000/exams/${value}`;
    a.textContent = `Exames de token ${value}`;
    searchResults.appendChild(a);
    searchResults.style.display = 'block';
  })
  .catch(e => {
    console.log(e.message);
    searchResults.innerHTML = 'Não há registros com esse token'
    searchResults.style.display = 'block';
  })



});

async function fetchExams(token) {
  const response = await fetch(searchUrl+token);
  if (!response.ok) {
    const message = `ERROR: ${response.status}`;
    throw new Error(message);
  }
  const exams = await response.json();
  return exams;

}

document.body.addEventListener('click', function(e) {
  searchResults.style.display = 'none';
});