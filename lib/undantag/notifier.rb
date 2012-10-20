require 'net/https'
require 'pp'

module Undantag
  class Notifier
    URL = "https://undantag.herokuapp.com/exception"
    def self.notify env, exception, request
      config_vars = Undantag::Configuration.to_hash
      unless config_vars[:api_key]
        raise Undantag::ConfigurationError::NoApiKey
      end
      post_params = config_vars.merge(env: PP.pp(env, ""),
                                      request: PP.pp(request, ""),
                                      backtrace: exception.backtrace.join("\n"),
                                      exception: PP.pp(exception, ''))

      uri = URI(Notifier::URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(post_params)

      response = http.request(request)
      case response.code
      when "401"
        raise Undantag::NotAuthorized
      end
    end
  end
end
