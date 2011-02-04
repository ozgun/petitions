class AddPermalinkToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :permalink, :string
    add_index :categories, :permalink
  end

  def self.down
    remove_column :categories, :permalink
  end
end
