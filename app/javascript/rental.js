const rental = () => {
  const rentalBtn = document.getElementById('rental-btn');
  const dateSelect = document.getElementById('date-select-modal');
  const mask = document.getElementById('mask');

  rentalBtn.addEventListener('click', () => {
    dateSelect.classList.remove('hidden');
    mask.classList.remove('hidden');
  });

  mask.addEventListener('click', () => {
    dateSelect.classList.add('hidden');
    mask.classList.add('hidden');
  });

}

window.addEventListener("load", rental);