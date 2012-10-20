module Undantag
  class NotAuthorized < Exception; end
  module ConfigurationError
    class NoApiKey < Exception; end
  end
end

