module Undantag
  class Notifier
    URL = "http://undantag.duh.se/exception"
    def self.notify exception
      unless Undantag::Configuration.api_key
        raise Undantag::ConfigurationError::NoApiKey
      end
      uri = URI(Notifier::URL)
      key = Undantag::Configuration.api_key
      post_params = Undantag::Configuration.to_hash.merge(title: 'test',
                                                          body: exception)
      resp = Net::HTTP.post_form(uri, post_params)
      case resp.code
      when "401"
        raise Undantag::NotAuthorized
      end
    end
  end
end
