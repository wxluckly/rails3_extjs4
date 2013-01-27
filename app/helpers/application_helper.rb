module ApplicationHelper
  def gundam_title(gundam)
     "#{gundam.try(:model)} #{gundam.try(:name)}" 
  end
end