namespace :app do

  desc "Ornek rake task"
  task :sample_rake_task => :environment do
    puts "Ornek rake task"
  end

end
