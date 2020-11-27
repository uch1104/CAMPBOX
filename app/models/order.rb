class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :notifications, dependent: :destroy

  with_options presence: true do
    validates :rental_start_date
    validates :rental_limit_date
  end

  validate :date_validates

  def date_validates
    errors.add(:rental_start_date, 'はレンタル可能期間内の日付を選択してください') if rental_start_date < item.start_date
    errors.add(:rental_limit_date, 'は開始日より後の日付を選択してください') if rental_limit_date <= rental_start_date
    errors.add(:rental_limit_date, 'はレンタル可能期間内の日付を選択してください') if rental_limit_date > item.limit_date
  end
end
