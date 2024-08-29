class AddInfoToAirlines < ActiveRecord::Migration[7.1]
  def change
    add_column :airlines, :logo, :string
    add_column :airlines, :contact_info, :string
    add_column :airlines, :description, :string
  end
end
