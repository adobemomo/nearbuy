class AddAddressToGoods < ActiveRecord::Migration[5.0]
  def change
    add_column :goods, :address2, :string
    add_column :goods, :address3, :string
  end
end
