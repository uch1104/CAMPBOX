class Cost < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '着払い' },
    { id: 3, name: '送料込み' },
    { id: 4, name: 'なし(直接手渡し)' }
  ]
end