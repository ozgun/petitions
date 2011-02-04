set :rails_env, "production"
set :domain, "kozgun.net"
set :application, "dilekceler"
set :repository,  "ssh://deployer@#{domain}/srv/repositories/dilekceler.git"

set :use_sudo, false
ssh_options[:forward_agent] = true
set :keep_releases, 10
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
on :start do
  `ssh-add`
end

#The name of the user to use when logging into the remote host(s).
set :user, "deployer" 
#The password to use for logging into the remote host(s).
#:password     password  

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain

set :deploy_to, "/srv/www/#{application}"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


# Database related tasks
namespace :db do
  desc "Symlink database.yml"
  task :symlink_database_yml do
    run "ln -nfs #{deploy_to}/shared/database.yml #{deploy_to}/current/config/database.yml" 
  end
end

# Custom tasks
namespace :customs do

  desc "Symlinks public/data folder"
  task :symlink_data do
    run "ln -nfs #{deploy_to}/shared/data #{deploy_to}/current/public/data" 
  end

end

# Deploy Tasks
namespace :deploy do

  # Deprecated!
  #desc "Copy/symlink app config"
  #task :after_symlink do
  #  deploy.config
  #  #deploy.chmod_tmp_folder
  #end

  desc "Restarting passanger(staging) or mongrel(production)"
  task :restart, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
    run "chmod 777 #{File.join(current_path,'tmp','restart.txt')}"
    #if ENV['DEPLOY'] == 'PRODUCTION'
    #  run "cd #{deploy_to}/current && ./restart_mongrel_cluster.sh"
    #else
    #  run "touch #{deploy_to}/current/tmp/restart.txt"
    #end
  end

  # Stub the Start and Stop Tasks
  #[:start, :stop].each do |t|
  #  desc "#{t} is a no-op with mod_rails"
  #  task t, :roles => :app do ; end
  #end

  #desc "Copy/Symlink Config"
  #task :config do
  #  config_files.each do |c|
  #    #run "cp #{deploy_to}/shared/#{c} #{deploy_to}/current/config/" 
  #    run "ln -nfs #{deploy_to}/shared/#{c} #{deploy_to}/current/config/" 
  #  end
  #end

  #desc "Chmod tmp folder"
  #task :chmod_tmp_folder do
  #  run "chmod -R 777 #{deploy_to}/current/tmp" 
  #end
  
  # This runs before creating the "current" symlink, so it is not working!
  #after "deploy:update_code", "db:symlink_database_yml"

  # a normal deploy involves symlinking to the current directory
  after "deploy:symlink", "db:symlink_database_yml"
  after "deploy:symlink", "customs:symlink_data"
end

#namespace :delayed_job do
#  desc "Start delayed_job process" 
#  task :start, :roles => :app do
#    #run "cd #{current_path}; script/delayed_job start #{rails_env}" 
#    #run "cd #{current_path} && RAILS_ENV=#{ENV['DEPLOY']} script/delayed_job start"
#    run "cd #{current_path} && RAILS_ENV=production script/delayed_job start"
#    
#  end
#
#  desc "Stop delayed_job process" 
#  task :stop, :roles => :app do
#    #run "cd #{current_path}; script/delayed_job stop #{rails_env}" 
#    #run "cd #{current_path} && RAILS_ENV=#{ENV['DEPLOY']} script/delayed_job stop"
#    run "cd #{current_path} && RAILS_ENV=production script/delayed_job stop"
#  end
#
#  desc "Restart delayed_job process" 
#  task :restart, :roles => :app do
#    #run "cd #{current_path}; script/delayed_job restart #{rails_env}" 
#    #run "cd #{current_path} && RAILS_ENV=#{ENV['DEPLOY']} script/delayed_job restart"
#    run "cd #{current_path} && RAILS_ENV=production script/delayed_job restart"
#  end
#end
#after "deploy:start", "delayed_job:start" 
#after "deploy:stop", "delayed_job:stop" 
#after "deploy:restart", "delayed_job:restart" 


#namespace :rake do
#  desc "drop, create and migrate database"
#  task :db_dm do
#    run "cd #{deploy_to}/current; rake db:dm RAILS_ENV=production"
#  end
#
#  desc "migrate database"
#  task :db_migrate do
#    run "cd #{deploy_to}/current; rake db:migrate RAILS_ENV=production"
#  end
#
#  desc "Reset Database"
#  task :db_migrate_reset do
#    run "cd #{deploy_to}/current; rake db:migrate:reset RAILS_ENV=production"
#  end
#end
