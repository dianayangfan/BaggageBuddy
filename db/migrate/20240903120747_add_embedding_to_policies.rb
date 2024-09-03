class AddEmbeddingToPolicies < ActiveRecord::Migration[7.1]
  def change
    add_column :policies, :embedding, :vector, limit: 1536
  end
end
