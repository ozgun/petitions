class Exception
  def log()
    ActiveRecord::Base.logger.error("***ERROR!***: Class: #{self.class}. Exception: #{self.exception}. \nBacktrace: ") 
    ActiveRecord::Base.logger.error(self.backtrace.join("\n"))
  end

end
