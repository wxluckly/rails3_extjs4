# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end


ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'news', 'news'
  inflect.irregular 'data', 'data'
  # I18n中汉字复数结尾不加s
  inflect.plural /(\.*[\u4e00-\u9fa5]+)$/i, '\1'
end

# 表名对应时删除mongo后缀
module ActiveSupport::Inflector
  def pluralize_with_mongo(word)
    word = word[0..-7] if word[-6..-1] == '_mongo'
    pluralize_without_mongo(word)
  end
  alias_method_chain :pluralize, :mongo
end