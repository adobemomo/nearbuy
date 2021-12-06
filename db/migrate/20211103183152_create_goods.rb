class CreateGoods < ActiveRecord::Migration[5.0]
  def change
    create_table :goods do |t|
      t.string  "user_name"
      t.string   "name"
      t.string   "address"
      t.datetime "create_time", default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime "update_time", default: -> { 'CURRENT_TIMESTAMP' }
      t.float    "latitude"
      t.float    "longitude"
      t.string   "description"
    end
    add_index :goods, :user_name
  end
end
