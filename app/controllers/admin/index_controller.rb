# coding: utf-8
class Admin::IndexController < Admin::ApplicationController
  before_filter :authenticate_user!

  def index
    @menus = @@menuMap[1].to_json
    $output_logger.info("welcome to index ,#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}")
  end

  private

  @@menuMap = {
    1 => [
      { :id => 1, :name => '网站功能列表', :image => 'assets/system/bricks.png',
        :url => '#', :qtip => '网站功能列表', :leaf => true,
        :children => [
          { :id => 10, :name => '系列', :image => 'assets/system/user_red.png',
            :hrefTarget => 'admin/dimensions', :qtip => '系列', :leaf => true
          },{ :id => 13, :name => '年代', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'admin/periods', :qtip => '年代', :leaf => true
          },{ :id => 11, :name => 'gundam', :image => 'assets/system/user_red.png',
            :hrefTarget => 'admin/gundams', :qtip => 'gundam', :leaf => true
          },{ :id => 12, :name => '驾驶员', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'admin/drivers', :qtip => '驾驶员', :leaf => true
          },{ :id => 14, :name => '机体类型', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'admin/usages', :qtip => '机体类型', :leaf => true
          },{ :id => 15, :name => '图片审核', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'admin/gundam_photos', :qtip => '图片审核', :leaf => true
          }
        ]
      },
      { :id => 2, :name => '网站用户管理', :image => 'assets/system/group_gear.png',
        :url => '#', :qtip => '网站用户管理', :leaf => true,
        :children => [
          { :id => 21, :name => '网站用户管理', :image => 'assets/system/group_gear.png',
            :url => 'admin/users', :qtip => '网站用户管理', :leaf => true
          }
        ]
      }
    ]
  }

end
