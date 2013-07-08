set :rails_env, 'production'

set :branch, 'master'

# 代码发布服务器
role :app, '115.28.37.253'

# 网站服务器
role :web, '115.28.37.253'

# 后台任务服务器
role :bg, '115.28.37.253'

# 使用数据库服务器运行迁移，当前所用地址为HA的虚拟IP
role :db,  '115.28.37.253', primary: true, no_release: true

set :keep_releases, 3 #维护较少数量
after("deploy", "deploy:cleanup") 