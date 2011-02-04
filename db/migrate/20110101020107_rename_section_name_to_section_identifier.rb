class RenameSectionNameToSectionIdentifier < ActiveRecord::Migration
  def self.up
    rename_column :categories, :section_name, :section_identifier
  end

  def self.down
    rename_column :categories, :section_identifier, :section_name
  end
end
