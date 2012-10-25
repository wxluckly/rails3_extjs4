# add by joey_wang
$output_logger = Rails.env.development? ? Logger.new(Rails.root.join("log", "output.log")) : Logger.new("/tianji/web/file/shared/invite.log")
