class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.text :html
      t.integer :document_id, :null => false
      t.integer :position

      t.timestamps
    end
    add_index :samples, :document_id
  end

  def self.down
    drop_table :samples
  end
end
