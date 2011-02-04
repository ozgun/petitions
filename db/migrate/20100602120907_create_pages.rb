class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.boolean :active, :null => false, :default => 0
      t.boolean :category_main_page, :null => false, :default => 0
      t.boolean :home_page, :null => false, :default => 0
      t.integer :page_category_id
      t.text :slogan
      t.string :cached_slug
      t.integer :contact_form_id

      # paperclip columns for page icon
      #t.string :icon_file_name
      #t.string :icon_content_type
      #t.integer :icon_file_size
      #t.datetime :icon_updated_at
      t.integer :icon_id #foreign key for asset_id

      # paperclip columns for banner
      #t.string :banner_file_name
      #t.string :banner_content_type
      #t.integer :banner_file_size
      #t.datetime :banner_updated_at
      t.integer :banner_id #foreign key for asset_id

      t.timestamps
    end
    add_index :pages, :page_category_id  
    add_index :pages, :home_page  
    #add_index :pages, :cached_slug
  end

  def self.down
    drop_table :pages
  end
end
