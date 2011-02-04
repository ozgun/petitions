class AddSampeIdToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :sample_id, :integer
    add_index :assets, :sample_id
  end

  def self.down
    remove_column :assets, :sample_id
  end
end
