class Page < ActiveRecord::Base
  #has_friendly_id :title, :use_slug => true
  
  #belongs_to :page_category

  #validates_presence_of :title
  #validates_presence_of :body

  #named_scope :active, :conditions => {:active => true}

  #def self.get_home_page
  #  a = self.active.home_page
  #  a.empty? ? nil : a[0]
  #end

  #def url_with_category
  #  if self.page_category
  #    "/#{self.page_category.cached_slug}/#{self.cached_slug}"
  #  else
  #    "/#{self.cached_slug}"
  #  end
  #end

  #def url
  #  self.url_with_category
  #end

  #def url_preview
  #  self.url_with_category + "?preview=1"
  #end
end
