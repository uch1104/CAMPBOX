class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :item,         null: false, foreign_key: true
      t.references :user,         null: false, foreign_key: true
      t.date :rental_start_date,  null: false
      t.date :rental_limit_date,  null: false
      t.timestamps
    end
  end
end
