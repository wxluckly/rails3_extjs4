class InfoMailer
  @queue = :rails3_extjs4_info_mailer

  def self.perform(email, gundam_id)
    MailerBase.gundam_info(email,gundam_id).deliver
  end
end
