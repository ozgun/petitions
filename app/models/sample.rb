class Sample < ActiveRecord::Base

  belongs_to :document
  has_many :assets, :dependent => :destroy

  named_scope :by_position, :order => "position ASC"

  accepts_nested_attributes_for :assets, :allow_destroy => true

  #accepts_nested_attributes_for :assets, 
  #  :allow_destroy => true, 
  #  :reject_if => proc { |attributes| attributes['sample_id'].blank? }

end
