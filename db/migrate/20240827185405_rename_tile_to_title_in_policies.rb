class RenameTileToTitleInPolicies < ActiveRecord::Migration[7.1]
  def change
    rename_column :policies, :tile, :title
  end
end
