class Spider::CNMSL < Spider::Spider
  @@url_list = []
  SIDES = ['DSSD','MO-V资源卫星防卫队','OZ','P3武装组织','Preventer','SIDE','ZAFT','阿克泰昂','阿纳海姆','艾斯丹东王国','奥布','奥古','白色芬古','大天使号/永恒号','抵抗组织','地球联合军','地球议会军','地球住民','回收屋','火星独立吉恩军','吉恩','旧地球联邦','巨蛇之尾','卡拉巴','联邦','猎鹰','马法迪','玛莉美亚军','民间','木星帝国','神圣军事同盟','死亡先锋','泰坦斯','统一联合军','新迪塞斯','新地球联邦','新吉恩','宇宙革命军','月面住民','赞斯卡尔帝国','殖民卫星','殖民卫星联合']
  DESCS = ["机体番号：","机体代号(日文)：","中文：","英文：","出现作品：","机体类型：","制造商：","所属：","初次配备：","技术参数：","内部环境：","尺寸：","重量：","装甲材料及结构：","发电机出力：","推进力：","加速度：","装备及设计特征：","固定武装：","选用武装：","选用手部武器：","远程武器："]
  BASE_URL = 'http://ae.cnmsl.net'

  def self.get_charset(body)
    /charset=(\w*)[\"\s\']/.match(body)
    $1
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

  def self.get_url
    @url_list = []
    list_base_url = 'http://ae.cnmsl.net/MobileSuit_Data.aspx'
    SIDES.each do |side|
      size = 0
      pre_list_trs = ''
      var = {}
      var["Operator"] = side.encode!('GB2312')
      1.upto(100) do|page_no|
        var["PageNo"]=page_no
        url = "#{list_base_url}?#{var.to_param}"
        response = Typhoeus::Request.get(url)
        charset = response.get_charset
        html = Nokogiri::HTML(response.body,nil,'GBK')
        p "html.to_html.size : #{html.to_html.size}"
        list_trs = html.css('tr')
        if pre_list_trs.present? and pre_list_trs.to_html == list_trs.to_html
          break
        else
          pre_list_trs = list_trs
          list_trs[11..list_trs.size-3].each do |tr_element|
            /href=\"(.*?)\"/.match tr_element.css('td').at(0).to_html
            @@url_list << "#{BASE_URL}#{$1}"
            size += 1
          end
        end
      end
      p "#{size.to_s.ljust(3)}  #{side.encode!('UTF-8')}"
      p '-'*30
    end
    p "==========  Fin  #{@@url_list.size}  =========="
    return @@url_list
  end

  def self.test(url = 'http://ae.cnmsl.net//MachineData/20071113145629.htm')
    RawGundam.new(info(url))
  end

    def self.get_infos
      get_url.each{|url| p url, RawGundam.create(info(url))}
    end

  def self.info(url)
    response = Typhoeus::Request.get("#{url}")
    charset = get_charset(response.body)
    info_trs = Nokogiri::HTML(response.body,nil,'GBK').css('table')[4].css('tr')
    var = {}
    var['summary'] = info_trs[1].css('td').text
    info_trs.each do |info_tr|
      next if info_tr.css('td').blank? or info_tr.css('td').size < 2
      info_tr.css('td').each_slice(2) do |k,v|
        var[desc2attr(k.text)] = v.text if v.present?
      end
    end
    var['url'] = url
    return var
  end
end
