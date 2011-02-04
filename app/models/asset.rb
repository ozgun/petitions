class Asset < ActiveRecord::Base

  belongs_to :sample

  #validates_presence_of :sample_id

  # Paperclip
  has_attached_file :metadata,
    :url => "/data/assets/:id/:basename.:extension",
    :path => ":rails_root/public/data/assets/:id/:basename.:extension"

  def image?
    self.metadata_content_type =~ /image/
  end

  def file_name
    self.metadata_file_name
  end

  def content_type
    self.metadata_content_type
  end

  def file_size
    self.metadata_file_size
  end

  def updated_at
    self.metadata_updated_at
  end

  def url
    self.metadata.url
  end

end
