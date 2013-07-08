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

namespace :deploy do
  

  task :links, :roles => :app do
    # 建立配置文件链接
    run "ln -sf #{shared}/database.yml #{latest_release}/config/database.yml"
  end
end