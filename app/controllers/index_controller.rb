class IndexController < ApplicationController
  def index
    @menus = @@menuMap[1].to_json
  end

  private

  @@menuMap = {
    1 => [
      { :id => 1, :name => '网站功能列表', :image => 'assets/system/bricks.png',
        :url => '#', :qtip => '网站功能列表', :leaf => true,
        :children => [
          { :id => 11, :name => 'gundam', :image => 'assets/system/user_red.png',
            :hrefTarget => 'gundams', :qtip => 'gundam', :leaf => true
          },{ :id => 12, :name => '驾驶员', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'drivers', :qtip => '驾驶员', :leaf => true
          },{ :id => 13, :name => '年代', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'periods', :qtip => '年代', :leaf => true
          },{ :id => 14, :name => '机体类型', :image => 'assets/system/group_gear.png',
            :hrefTarget => 'types', :qtip => '机体类型', :leaf => true
          }
        ]
      },
      { :id => 2, :name => '网站用户管理', :image => 'assets/system/group_gear.png',
        :url => '#', :qtip => '网站用户管理', :leaf => true,
        :children => [
          { :id => 21, :name => '网站用户管理', :image => 'assets/system/group_gear.png',
            :url => 'users', :qtip => '网站用户管理', :leaf => true
          }
        ]
      }
    ]
  }

end
