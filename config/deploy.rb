require 'capistrano/ext/multistage'
set :stages, %w(production staging)
set :default_stage, "production"

# 扩展bundle管理
require 'bundler/capistrano'
set :bundle_flags, '--no-deployment --quiet'

set :application, "gundam"
set :repository,  "git@github.com:wxluckly/rails3_extjs4.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git

set :deploy_to, "/www/gundam"
set :shared, "#{deploy_to}/shared"

set :user, "railsu"
set :use_sudo, false

before('deploy:finalize_update', 'deploy:links')

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :bluepill do
  #确认问题：
  #  创建 /var/run/bluepill被创建并属于www用户？
  task :prepare, :role=>:web do
    set :user, 'railsu'
    default_run_options[:pty] = true #for remote interaction
    sudo "mkdir -p /var/run/bluepill"
    sudo "chown railsu:railsu /var/run/bluepill"
    puts "Prepare bluepill to monitor unicorn... "
  end

  task :start, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec bluepill --no-privileged load #{current_path}/config/bluepill.rb"
  end
  
  task :stop do
    run "cd #{current_path} && bundle exec bluepill --no-privileged quit"
  end
end

namespace :deploy do

  # 重启服务
  task :start do
    run "cd #{current_path} && bundle exec bluepill --no-privileged start unicorn RAILS_ENV=#{rails_env}"
  end

  task :stop do
    run "cd #{current_path} && bundle exec bluepill --no-privileged stop unicorn RAILS_ENV=#{rails_env}"
  end
  
  task :restart, :roles => :web do
    if rails_env == "production"
      run "cd #{current_path} && bundle exec bluepill --no-privileged restart unicorn RAILS_ENV=#{rails_env}"
    else
      deploy.restart_unicorn
    end
  end

  task :links, :roles => :app do
    # 建立配置文件链接
    run "ln -sf #{shared}/database.yml #{latest_release}/config/database.yml"
  end
end