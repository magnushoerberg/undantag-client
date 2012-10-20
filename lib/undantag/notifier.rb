module Undantag
  class Notifier
    URL = "https://undantag.herokuapp.com/exception"
    def self.notify request, exception
      unless Undantag::Configuration.api_key
        raise Undantag::ConfigurationError::NoApiKey
      end
      uri = URI(Notifier::URL)
      key = Undantag::Configuration.api_key
      post_params = Undantag::Configuration.to_hash.merge(env: ENV,
                                                          request: request,
                                                          exception: exception)

      resp = Net::HTTP.post_form(uri, post_params)
      case resp.code
      when "401"
        raise Undantag::NotAuthorized
      end
    end
  end
end
