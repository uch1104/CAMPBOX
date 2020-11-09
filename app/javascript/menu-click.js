const menu = () => {
  const open = document.getElementById('open');
  const overlay = document.querySelector('.overlay');
  const close = document.getElementById('close');

  open.addEventListener('click', () => {
    overlay.classList.toggle('show');
  });
}

window.addEventListener("load", menu);