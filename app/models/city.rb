class City < ActiveRecord::Base

  def self.custom_sort
    City.find(:all, :conditions => {:code => '34'}) + City.ascend_by_code.reject {|c| c.code == '34'}
  end

end
