class MailerBase < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  FROM = "wxl_test@163.com"

  def gundam_info(email,gundam_id)
    gundam_id = gundam_id || 1
    @gumdam_mongo = GundamMongo.find(gundam_id)
    mail(:from=>FROM, :to => email, :subject => @gumdam_mongo.name_chs) do |format|
      format.html
    end
  end

end
