class CreateDocumentCategories < ActiveRecord::Migration
  def self.up
    create_table :document_categories do |t|
      t.integer :document_id
      t.integer :category_id

      t.timestamps
    end
    add_index :document_categories, :document_id
    add_index :document_categories, :category_id
  end

  def self.down
    drop_table :document_categories
  end
end
