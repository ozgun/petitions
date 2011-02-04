class Country < ActiveRecord::Base

  def self.custom_sort
    Country.find(:all, :conditions => {:code => 'TR'}) + Country.ascend_by_name_tr.reject {|c| c.code == 'TR'}
  end

end
