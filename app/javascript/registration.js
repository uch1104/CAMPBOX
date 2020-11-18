const registration = () => {
  const openRegistration = document.getElementById('open-registration');
  const openSession = document.getElementById('open-session');
  const newModal = document.getElementById('new-modal');
  const selectModal = document.getElementById('select-modal');
  const emailRegistration = document.getElementById('email-registration');
  const sessionModal = document.getElementById('session-modal');
  const mask = document.getElementById('mask');
  const body = document.body;

  openRegistration.addEventListener('click', () => {
    selectModal.classList.remove('hidden');
    mask.classList.remove('hidden');
    // body.style.overflowY = 'hidden';
  });

  emailRegistration.addEventListener('click', () => {
    newModal.classList.remove('hidden');
    selectModal.classList.add('hidden');
  });

  openSession.addEventListener('click', () => {
    sessionModal.classList.remove('hidden');
    mask.classList.remove('hidden');
    // body.style.overflowY = 'hidden';
  });

  mask.addEventListener('click', () => {
    newModal.classList.add('hidden');
    sessionModal.classList.add('hidden');
    mask.classList.add('hidden');
    selectModal.classList.add('hidden');
    // body.style.overflowY = '';
  });

}

window.addEventListener("load", registration);