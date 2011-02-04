class Document < ActiveRecord::Base

  has_many :document_categories, :dependent => :destroy
  has_many :categories, :through => :document_categories
  has_many :samples, :dependent => :destroy

  validates_presence_of :name, :permalink
  validates_inclusion_of :section_identifier, :in => Category::SECTIONS.map{|x| x[1]}

  named_scope :published, :conditions => {:published => true}
  named_scope :not_published, :conditions => {:published => false}
  named_scope :section_identifier_is, lambda {|si| {:conditions => {:section_identifier => si}}} 

  before_validation :set_permalink

  accepts_nested_attributes_for :samples, 
    :allow_destroy => true, 
    :reject_if => proc { |attributes| attributes['document_id'].blank? }

  accepts_nested_attributes_for :document_categories, 
    :allow_destroy => true, 
    :reject_if => proc { |attributes| attributes['category_id'].blank? }

  def set_permalink
    self.permalink = self.name
  end

end
