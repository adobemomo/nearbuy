class AddLocationsToGoods < ActiveRecord::Migration[5.0]
  def change
    add_column :goods, :address1, :string
    add_column :goods, :latitude1, :float
    add_column :goods, :longitude1, :float
    add_column :goods, :address2, :string
    add_column :goods, :latitude2, :float
    add_column :goods, :longitude2, :float
    change_column_default :goods, :update_time, -> { 'CURRENT_TIMESTAMP' }
  end
end
