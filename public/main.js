
const fragment = new DocumentFragment();
const url = `http://localhost:3000/tests`;
const tbody = document.getElementById('tbody');
const parentlist = document.getElementById('parent-list');
const bottomList  = document.getElementById('bottom-list');
let currPage = 1;
let data;
let pageSize = 100;
fetch(url)
  .then((response) => response.json())
  .then((json_response) => {
    data = json_response;
    pages = Math.ceil(data.length/pageSize);
    for (let i = 0; i < pages; i++) {
      const li = document.createElement('li');
      x = document.createElement("a");
      x.href = "#";
      x.innerHTML = `${i+1}`;
      x.id = `page-${i+1}`;
  
      li.appendChild(x);
      dup = li.cloneNode(deep = true);
      dup.firstChild.id = `bottom-page-${i+1}`;
      parentlist.appendChild(li);
      bottomList.appendChild(dup);

    }
    display_data();
    document.getElementById('page-1').classList.add('active');
    document.getElementById('bottom-page-1').classList.add('active');
  })
  .catch(function(error) {
    console.log(error);
  });
let elements = document.querySelectorAll('.nav');
console.log(Array.from(elements));
elements.forEach(function(elem) {
  console.log(elem);
  elem.addEventListener("click", function(e) {
    if(e.target && e.target.nodeName == "A") {
      tbody.innerHTML = '';
      page = parseInt(e.target.id.match(/\d+/)[0]);
      currPage = parseInt(page);
      topButton = document.getElementById(`page-${page}`);
      bottomButton = document.getElementById(`bottom-${topButton.id}`)
      active_button(topButton, bottomButton);
      display_data();
    }
  })
});

function active_button(button, bottomButton) {
  document.querySelectorAll(".nav li a").forEach((btn) => {
    btn.classList.remove("active");
  });
  button.classList.add("active");
  bottomButton.classList.add("active");
}

function display_data() {
  data.filter(function(row, index) {
    let start = (currPage-1)*pageSize;
    let end = currPage*pageSize;
    if(index >= start && index < end) return true;
  }).forEach(function(exam, index) {
  const tr = document.createElement('tr');
  
  tr.insertCell(0).textContent = `${exam.patient_name}`;
  tr.insertCell(1).textContent = `${exam.patient_email}`;
  tr.insertCell(2).textContent = `${exam.exam_date}`;
  tr.insertCell(3).textContent = `${exam.exam_result_token}`;
  tr.insertCell(4).textContent = `${exam.exam_type}`;
  tr.insertCell(5).textContent = `${exam.limits_exam_type}`;
  tr.insertCell(6).textContent = `${exam.result_exam_type}`;
  fragment.appendChild(tr);
  
  tbody.appendChild(fragment);

})};