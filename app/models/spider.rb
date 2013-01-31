# encoding: utf-8
class Spider
  @@time = 200
  @@charset = nil
  def self.timeout
    @@time
  end

  def self.timeout=(time)
    @@time=time
  end

  def self.charset
    @@charset
  end

  def self.get_charset(body)
    /charset=(\w*)[\"\s\']/.match(body)
    @@charset = $1
  end

  def self.desc_attr
    hash = {
      "机体番号：" => "model",
      "机体代号(日文)：" => "name_jp",
      "中文：" => "name_chs",
      "英文：" => "name",
      "出现作品：" => "story",
      "机体类型：" => "usage",
      "制造商：" => "manufactory",
      "所属：" => "force",
      "初次配备：" => "period",
      "技术参数：" => "specifications",
      "内部环境：" => "internal_environment",
      "尺寸：" => "measurement",
      "重量：" => "weight",
      "装甲材料及结构：" => "armor",
      "发电机出力：" => "output",
      "推进力：" => "propulsion",
      "加速度：" => "acceleration",
      "装备及设计特征：" => "special_equipped",
      "固定武装：" => "default_weapon",
      "选用武装：" => "selected_weapon",
      "选用手部武器：" => "hand_weapon",
      "远程武器：" => "ranged_weapon"
    }
  end

  def self.desc2attr(name)
    desc_attr[name]
  end

end

class Typhoeus::Response
  def get_charset
    /charset=(\w*)[\"\s\']/.match(body)
    @@charset = $1
  end
end
