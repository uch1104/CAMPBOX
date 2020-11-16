class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :category

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :start_date
    validates :limit_date
    validates :price, format: { with: /\A[0-9]+\z/ }
  end
  validates :price, inclusion: { in: (500..100_000), message: 'に正しい値を入力してください' }
  validates :condition_id, :cost_id, :prefecture_id, :shipping_method_id, :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validate  :after_today

  def after_today
    errors.add(:start_date, "は明日以降の日付を選択してください") if start_date < Date.today + 1
    errors.add(:limit_date, "は開始日より後の日付を選択してください") if limit_date <= start_date
  end
end
