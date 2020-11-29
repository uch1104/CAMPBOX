const change = () => {
  const myPage = document.getElementById('mypage-modal');
  const itemList = document.getElementById('list-modal');
  const myItem = document.getElementById('my-item-list');
  const noticeList = document.getElementById('notice-lists');



  myItem.addEventListener('click', () => {
    myPage.classList.add('hidden');
    itemList.classList.remove('hidden');
  });

}

window.addEventListener("load", change);