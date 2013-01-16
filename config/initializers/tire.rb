require 'tire/http/clients/faraday'

Tire.configure do
  Tire::HTTP::Client::Faraday.faraday_middleware = Proc.new do |builder|
    builder.adapter :typhoeus
  end

  url $conf[:search]
  client Tire::HTTP::Client::Faraday
  logger Rails.root.join('log', 'elasticsearch.log')
end
