set :rails_env, 'master'

set :branch, 'master'

# 静态文件git对应的分支
set :assets_branch, 'master'

# 代码发布服务器
role :app, '115.28.37.253'

# 网站服务器
role :web, '115.28.37.253'

# 后台任务服务器
role :bg, '115.28.37.253'

# 使用数据库服务器运行迁移，当前所用地址为HA的虚拟IP
role :db,  '115.28.37.253', primary: true, no_release: true

namespace :gems do
  task :bundler, :roles => :app do
    set :user, 'railsu'
    default_run_options[:pty] = true
    
    sudo "gem install bundler"
  end
end

# 测试时可能发布比较频繁，自动清理旧版本
set :keep_releases, 3 #维护较少数量
after("deploy", "deploy:cleanup") 
