class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :description

      # paperclip columns
      t.string :metadata_file_name, :null => false 
      t.string :metadata_content_type, :null => false
      t.integer :metadata_file_size, :null => false
      t.datetime :metadata_updated_at, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
