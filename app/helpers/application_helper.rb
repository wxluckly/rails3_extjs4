# coding: utf-8
module ApplicationHelper

  def gundam_title(gundam)
    "#{gundam.try(:model)} #{gundam.try(:name)}" 
  end

  def year_title(period)
    if period.present?
      "#{period.dimension.try(:name)} #{period.try(:year)}"
    else
      "尚未设置"
    end
  end

  def display_flash
    flash_div = []
    flash_div << "<span class='label label-success'>#{flash[:notice]}</span>" if flash[:notice].present?
    flash_div << "<span class='label label-warning'>#{flash[:warn]}</span>" if flash[:warn].present?
    flash_div << "<span class='label alert-error'>#{flash[:error]}</span>" if flash[:error].present?
    erb = ['<div class=flash>',flash_div,'</div>'].flatten.join('')
    return raw erb
  end
end