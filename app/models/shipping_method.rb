class ShippingMethod < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '宅急便' },
    { id: 3, name: '直接手渡し' }
  ]
end
