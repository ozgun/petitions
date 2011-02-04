MAIN_SITE_URL = "http://example.com"
COMPANY_NAME = "Dilekçeler ve Sözleşmeler"
EMAIL_BANNER = "http://example.com"
ADMIN_EMAIL_BANNER = "Bu mesaj size yönetici olduğunuz için gönderilmiştir."
TEST_EMAILS_ACCOUNTS = ["test@example.com", "admin@example.com"]

PHONE_REGEX = /\A[0-9 \+]+\Z/i
#EMAIL_REGEX = /\A[A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i #User.rb modelinde.
#WEBSITE_REGEX = /\A(http:\/\/)?(([a-z0-9\-]+\.([a-z0-9]+))+)\Z/i
WEBSITE_REGEX = /\A(([a-z0-9\-]+\.([a-z0-9]+))+)\Z/i

# static files
#STATIC_FILES = ["site.css", "app.js"]
#STATIC_FILES_PATH = File.join(RAILS_ROOT, "public", "data", "static_files")
#unless File.exist?(STATIC_FILES_PATH)
#  Dir.mkdir(STATIC_FILES_PATH)
#end
#STATIC_FILES.each do |item|
#  full_path = File.join(STATIC_FILES_PATH, item)
#  unless File.exist?(full_path)
#    f = File.new(full_path, "w")
#    f.chmod(0777)
#    f.close
#  end
#   
#end
