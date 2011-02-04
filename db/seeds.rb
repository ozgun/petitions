# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

pass = "12345"

u = User.new(:email => "kozgun@gmail.com", :password => pass, :password_confirmation => pass)
u.admin = true
u.active = true
u.save

Category.create(:name => "Aile Hukuku", :permalink => "aile-hukuku", :section_identifier => "dilekceler", :active => true, :position => 1)
Category.create(:name => "İş Hukuku", :permalink => "is-hukuku", :section_identifier => "dilekceler", :active => true, :position => 2)
Category.create(:name => "Ceza Hukuku", :permalink => "ceza-hukuku", :section_identifier => "dilekceler", :active => true, :position => 3)
Category.create(:name => "İdare Hukuku", :permalink => "idare-hukulu", :section_identifier => "dilekceler", :active => true, :position => 4)
Category.create(:name => "Gayrimenkul Hukuku", :permalink => "gayrimenkul-hukuku", :section_identifier => "dilekceler", :active => true, :position => 5)
Category.create(:name => "Miras Hukuku", :permalink => "miras-hukuku", :section_identifier => "dilekceler", :active => true, :position => 6)
Category.create(:name => "Borçlar Hukuku", :permalink => "borclar-hukuku", :section_identifier => "dilekceler", :active => true, :position => 7)
Category.create(:name => "Tüketici Hukuku", :permalink => "tuketici-hukuku", :section_identifier => "dilekceler", :active => true, :position => 8)
Category.create(:name => "İcra Hukuku", :permalink => "icra-hukuku", :section_identifier => "dilekceler", :active => true, :position => 9)

Category.create(:name => "Aile Hukuku", :permalink => "aile-hukuku", :section_identifier => "sozlesmeler", :active => true, :position => 1)
Category.create(:name => "İş Hukuku", :permalink => "is-hukuku", :section_identifier => "sozlesmeler", :active => true, :position => 2)
Category.create(:name => "Ticaret Hukuku", :permalink => "ticaret-Hukuku", :section_identifier => "sozlesmeler", :active => true, :position => 3)
Category.create(:name => "Gayrimenkul Hukuku", :permalink => "gayrimenkul-hukuku", :section_identifier => "sozlesmeler", :active => true, :position => 3)
Category.create(:name => "Miras Hukuku", :permalink => "miras-hukuku", :section_identifier => "sozlesmeler", :active => true, :position => 4)

Category.create(:name => "İhtarnameler", :permalink => "ihtarnameler", :section_identifier => "diger-yazismalar", :active => true, :position => 1)
Category.create(:name => "İbranameler", :permalink => "ibranameler", :section_identifier => "diger-yazismalar", :active => true, :position => 2)

