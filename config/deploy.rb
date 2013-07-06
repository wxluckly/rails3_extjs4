# 多环境发布
require 'capistrano/ext/multistage'
set :stages, %w(qa)
set :default_stage, 'qa'

# 扩展bundle管理
require 'bundler/capistrano'
set :bundle_flags, '--no-deployment --quiet'

# 重置/etc/environment中的gemfile变量
set :rake, "bundle exec rake"

# patch for "deploy:migrate is only run..." in versions > 2.5.20
set(:releases) { capture("ls -x #{releases_path}").split.sort }

# 创建tmp下子目录的符号链接
set :shared_children, %w(public/system log tmp/pids tmp/sockets)

# 系统参数
set :application, 'gundam'
set :root_path, '/gundam'
set :deploy_to, "#{root_path}/web"
set :config, "#{deploy_to}/config"
set :assets_path, "#{shared_path}/public"
# ruby application shared file path
set :file_shared_path, "#{root_path}/web/file/shared"
set :deploy_via, :remote_cache
set :group_writable, false
set :normalize_asset_timestamps, false

# 执行用户
set :user, 'railsu'
set :use_sudo, false

# 代码库
set :scm, :git
set :repository, 'git@github.com:wxluckly/rails3_extjs4.git'


# apt包管理
namespace :apt do
  task :install, :roles => :app do
    set :user, 'seamon'
    default_run_options[:pty] = true     #访问git时候确认fingerprint和password的时候必须设置
   
    sudo "apt-get -y install #{fetch(:name)}"
  end

  task :upgrade, :roles => :app do
    set :user, 'seamon'
    default_run_options[:pty] = true     #访问git时候确认fingerprint和password的时候必须设置
   
    sudo "apt-get update"
    sudo "apt-get -y upgrade"
    sudo "apt-get -y dist-upgrade"
  end
end

# gem包管理
namespace :gems do
  task :bundler, :roles => :app do
    set :user, 'seamon'
    default_run_options[:pty] = true     #访问git时候确认fingerprint和password的时候必须设置
   
    sudo "gem install bundler"
  end
 
  task :install, :roles => :app do
    run "cd #{current_path} && bundle exec gem install #{fetch(:name)}"
  end

  task :update, :roles => :app do
    set :user, 'seamon'
    default_run_options[:pty] = true     #访问git时候确认fingerprint和password的时候必须设置
   
    sudo "gem update --system"
  end
end

# bundle管理
namespace :bundle do
  # 建立bundle连接
  task :prepare, :roles => :app do
    run "ln -sfT #{shared_path}/.bundle #{latest_release}/.bundle"
    run "cp -f #{shared_path}/Gemfile.lock #{latest_release}/"
   
    # 如果Gemfile中rails版本更改，自动bundle:install会依赖失败
    # 此时则需要传入-s update=*参数，触发bundle update语句
    run "cd #{latest_release} && bundle update" if exists?(:update)
  end
 
  task :gemfilelock, :roles => :app do
    run "cp -f #{latest_release}/Gemfile.lock #{shared_path}/"
  end
 
  # 手动更新所有gem
  task :update, :roles => :app do
    run "cd #{current_path} && bundle update && cp -f Gemfile.lock #{shared_path}/"
    deploy.restart
  end
end

namespace :bluepill do
  task :start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec bluepill --no-privileged load #{current_path}/config/bluepill.rb"
  end
 
  task :stop do
    run "cd #{current_path} && bundle exec bluepill --no-privileged quit"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
        from = source.next_revision(current_revision)
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
    end
  end

  task :clean_git_cache, :roles => :app do
    run "rm -rf /tianji/web/shared/cached-copy/ "
  end
 
  # 临时运行的一些shell
  task :tmp_shell, :roles => :app do
    run "mkdir -p #{current_path}/log/regist"
  end
 
  # 重启服务
  task :start do
    run "cd #{current_path} && bundle exec bluepill --no-privileged start unicorn RAILS_ENV=#{rails_env}"
  end
  task :stop do
    run "cd #{current_path} && bundle exec bluepill --no-privileged stop unicorn RAILS_ENV=#{rails_env}"
  end
  task :restart, :roles => :web do
    run "cd #{current_path} && bundle exec bluepill --no-privileged restart unicorn RAILS_ENV=#{rails_env}"
  end

  # 如果加入或修改了mongodb的索引，特别是变动了hint语句，则需要传入-s index=true来更新索引
  task :create_mongo_indexes, roles: :db do
    run "cd #{latest_release} && #{rake} db:mongoid:create_indexes RAILS_ENV=#{rails_env}" if exists?(:index)
  end
 
  task :links, :roles => :app do
    # 建立配置文件链接
    run "ln -sf #{config}/database.yml #{latest_release}/config/database.yml"
    # run "ln -sf #{config}/mongoid.yml #{latest_release}/config/mongoid.yml"
    run "ln -sf #{root_path}/web/file/bdsitemap.txt #{latest_release}/public/bdsitemap.txt"

    # 建立文件目录链接
    run "ln -sfT #{root_path}/web/file/upload #{latest_release}/public/upload"
    # run "ln -sfT #{root_path}/web/file/log/quiz #{latest_release}/log/quiz"
   
    # assets folder
    run "ln -sfT #{assets_path}/javascripts #{latest_release}/public/javascripts"
    run "ln -sfT #{assets_path}/stylesheets #{latest_release}/public/stylesheets"
    run "ln -sfT #{assets_path}/images #{latest_release}/public/images"
  end
 
  task :update_assets, :roles => :web do
    run "cd #{assets_path} && git checkout #{assets_branch} && git pull"
  end
 
 
   # 初始化 assets
  task :clean_assets, :roles => :web do
    run "rm -rf #{assets_path}"
  end
 
  # 初始化 assets
  task :setup_assets, :roles => :web do
    run "git clone ssh://git@211.151.73.231:65022/html #{assets_path} --branch #{assets_branch}"
  end
 
  task :bg, :roles => :bg do
    # 杀掉resque相关的进程（再由monitor自动重启）
    run "ruby #{current_path}/server/scripts/resque.rb kill"
  end
 
  task :link_sitemap, :roles => :web do
    if rails_env=="production"
      run "ln -sf #{file_shared_path}/sitemap/sitemap_index.xml.gz #{latest_release}/public/sitemap_index.xml.gz"
      (1..6).each do |i|
      run "ln -sf #{file_shared_path}/sitemap/sitemap#{i}.xml.gz #{latest_release}/public/sitemap#{i}.xml.gz"
      end
    end
  end
 
  task :sitemap, :roles => :sitemap do
    run "cd #{current_path} && #{rake} sitemap:refresh RAILS_ENV=#{rails_env}" if rails_env=="production"
  end
 
  task :move_sitemap, :roles => :web do
    run "rm -rf #{shared_path}/sitemap"
  end

  task :delcache, :roles => :app do
    run "cd #{current_path} && rm -rf public/profile"
  end

  task :install_bundler, :roles => :app do
      run "ruby -v"
  end
end

before "deploy:cold",  "deploy:install_bundler"

before('bundle:install', 'bundle:prepare')
after('bundle:install', 'bundle:gemfilelock')

before('deploy:finalize_update', 'deploy:links')
after('deploy:update_code', 'deploy:create_mongo_indexes')
after('deploy:update', 'deploy:migrate', 'deploy:update_assets', 'deploy:link_sitemap', 'deploy:bg', 'deploy:delcache')