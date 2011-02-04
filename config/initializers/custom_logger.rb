# Logu log/custom_development.log dosyasına yazar.
# Örnek kullanım: 
#   CUSTOM_LOGGER.debug "--debug mesaj--"
#   CUSTOM_LOGGER.error "--hata mesajı--"
# 
# Sadece "development" environment'ta çalışacak şekilde ayarlandı.
log_file = File.join(RAILS_ROOT, "log", "custom_#{RAILS_ENV}.log")
if RAILS_ENV == "development"
  CUSTOM_LOGGER = ActiveSupport::BufferedLogger.new(log_file)
else
  class FakeLogger
    def warn(msg)
    end
    def info(msg)
    end
    def error(msg)
    end
    def debug(msg)
    end
  end
  CUSTOM_LOGGER = FakeLogger.new
end
