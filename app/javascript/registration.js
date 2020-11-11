const registration = () => {
  const openRegistration = document.getElementById('open-registration');
  const openSession = document.getElementById('open-session');
  const newModal = document.getElementById('new-modal');
  const sessionModal = document.getElementById('session-modal')
  const mask = document.getElementById('mask');
  const body = document.body;

  openRegistration.addEventListener('click', () => {
    newModal.classList.remove('hidden');
    mask.classList.remove('hidden');
  });

  openSession.addEventListener('click', () => {
    sessionModal.classList.remove('hidden');
    mask.classList.remove('hidden');
  });

  mask.addEventListener('click', () => {
    newModal.classList.add('hidden');
    sessionModal.classList.add('hidden');
    mask.classList.add('hidden');
  });

}

window.addEventListener("load", registration);