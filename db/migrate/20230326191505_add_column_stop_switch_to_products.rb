class AddColumnStopSwitchToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :stop_switch, :boolean,default: false
  end
end
