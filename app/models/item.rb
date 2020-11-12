class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_method

end
