# coding: utf-8
class SearchSuggestion
  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end
  
  def self.index_products
    Gundam.find_each do |gundam|
      index_term(gundam.model)
      index_term(gundam.name)
      index_term(gundam.name_chs)
      gundam.name.split.each { |t| index_term(t) }
    end
  end
  
  def self.index_term(term)
    1.upto(term.length-1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, term.downcase
    end
  end
end