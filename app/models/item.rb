class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :order

  acts_as_taggable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :category
  has_many :notifications, dependent: :destroy
  has_many :favorites

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
    errors.add(:start_date, 'は明日以降の日付を選択してください') if start_date < Date.today + 1
    errors.add(:limit_date, 'は開始日より後の日付を選択してください') if limit_date <= start_date
  end

  def self.search(search)
    if search != ""
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  def self.divide(category_id)
    if search
      Item.where(category_id: category_id)
    else
      Item.all
    end
  end

  def create_notification_order(current_user, order_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Item.select(:user_id).where(item_id: id).distinct
    temp_ids.each do |temp_id|
      save_notification_order(current_user, order_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_order(current_user, order_id, user_id) if temp_ids.blank?
  end

  def save_notification_order(current_user, order_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.create(
      item_id: id,
      order_id: order_id,
      visited_id: visited_id,
      action: 'order'
    )
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
