class Spider::Aemedia < Spider
  BASE_URL = 'http://www.aemedia.org/wiki'
  
  def self.stories
    @stories = []
    response = Typhoeus::Request.get(BASE_URL)
    charset = response.get_charset
    html = Nokogiri::HTML(response.body,nil,charset)
    html.css('.wiki a').each_slice(2) do |a_img,a_text|
      story = {}
      img = a_img.css('img')[0]
      story['img'] = img.attr('src')
      story['url'] = a_img.attr('href')
      story['name'] = img.attr('title').split('<br>')[1]
      story['name_ch'] = img.attr('title').split('<br>')[0]
      @stories << story
    end
    return @stories
  end

  def self.ms_urls(url)
    ms_urls = []
    response = Typhoeus::Request.get(url)
    charset = response.get_charset
    html = Nokogiri::HTML(response.body,nil,charset)
    html.css('.mechanic li a').each do |ms_link|
      ms_url = {}
      img = ms_link.css('img')[0]
      ms_url['img'] = img.attr('src')
      ms_url['url'] = ms_link.attr('href')
      ms_urls << ms_url
      p ms_url
    end
    return ms_urls
  end

  def self.ms_info(url)

  end

  def self.save_image(url)
    GundamPhoto.new(remote_image_url: url)
  end

end