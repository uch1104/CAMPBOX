const menu = () => {
  const open = document.getElementById('open');
  const overlay = document.querySelector('.overlay');

  open.addEventListener('click', () => {
    overlay.classList.toggle('show');
  });
}

window.addEventListener("load", menu);