class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_method

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :start_date
    validates :limit_date
    validates :price, format: { with: /\A[0-9]+\z/ }
  end
  validates :price, inclusion: { in: (300..9_999_999) }
  validates :condition_id, :cost_id, :prefecture_id, :shipping_method_id, numericality: { other_than: 1 }
end
