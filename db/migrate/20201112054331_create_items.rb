class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :name,               null: false
      t.integer :price,              null: false
      t.text    :description,        null: false
      t.text    :precaution
      t.integer :condition_id,       null: false
      t.integer :cost_id,            null: false
      t.integer :prefecture_id,      null: false
      t.integer :delivery_time_id,   null: false
      t.date    :start_date,         null: false
      t.date    :limit_date,         null: false
      t.references :user, null: false, foreign_key:true
      t.timestamps
    end
  end
end
