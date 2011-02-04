class Category < ActiveRecord::Base
  #has_friendly_id :name, :use_slug => true

  SECTIONS = [
    [I18n.t('petitions'), "dilekceler"], 
    [I18n.t('agreements'), "sozlesmeler"], 
    [I18n.t('other_documents'), "diger-yazismalar"]
  ].freeze

  has_many :document_categories, :dependent => :destroy
  has_many :documents, :through => :document_categories

  validates_presence_of :name, :permalink, :section_identifier
  validates_uniqueness_of :name, :scope => [:section_identifier]
  validates_uniqueness_of :permalink, :scope => [:section_identifier]
  validates_inclusion_of :section_identifier, :in => Category::SECTIONS.map{|x| x[1]}

  named_scope :petitions, :conditions => {:section_identifier => "dilekceler"}, :order => "position ASC"
  named_scope :agreements, :conditions => {:section_identifier => "sozlesmeler"}, :order => "position ASC"
  named_scope :other_documents, :conditions => {:section_identifier => "diger-yazismalar"}, :order => "position ASC"

  def self.section(identifier)
    x = self::SECTIONS.select{|x| x[1] == identifier}
    x.empty? ? nil : x[0][0]
  end

end
