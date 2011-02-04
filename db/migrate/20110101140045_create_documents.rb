class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :name, :null => false
      t.boolean :published, :default => false
      t.string :permalink, :null => false

      t.timestamps
    end
    add_index :documents, :published
  end

  def self.down
    drop_table :documents
  end
end
