class DeleteLogoFromAirlines < ActiveRecord::Migration[7.1]
  def change
    remove_column :airlines, :logo, :string
  end
end
