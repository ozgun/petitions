class AddSectionIdentifierToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :section_identifier, :string
    add_index :documents, :section_identifier
  end

  def self.down
    remove_column :documents, :section_identifier
  end
end
