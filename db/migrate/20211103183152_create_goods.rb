class CreateGoods < ActiveRecord::Migration[5.0]
  def change
    create_table :goods do |t|
      t.integer  "user_id"
      t.string   "name"
      t.string   "address"
      t.datetime "create_time"
      t.datetime "update_time"
      t.float    "latitude"
      t.float    "longitude"
    end
    add_index :goods, :user_id
  end
end
