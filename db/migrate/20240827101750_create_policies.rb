class CreatePolicies < ActiveRecord::Migration[7.1]
  def change
    create_table :policies do |t|
      t.string :tile
      t.text :content
      t.string :category
      t.references :airline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
