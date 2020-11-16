class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: 'テント' },
    { id: 3, name: 'タープ' },
    { id: 4, name: 'シェラフ・寝具' },
    { id: 5, name: 'テーブル' },
    { id: 6, name: 'チェア' },
    { id: 7, name: 'ランタン・照明器具' },
    { id: 8, name: '調理道具' },
    { id: 9, name: '暖房器具' },
    { id: 10, name: 'コット' },
    { id: 11, name: '電化製品' },
    { id: 12, name: 'キャンプセット' },
    { id: 13, name: 'その他' }
  ]
end

