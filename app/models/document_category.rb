class DocumentCategory < ActiveRecord::Base

  belongs_to :document
  belongs_to :category

end
