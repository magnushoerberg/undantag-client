VCR.configure do |config|
  config.cassette_library_dir = "fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<Undantag API key>") { ENV['UNDANTAG_API_KEY'] }
  config.filter_sensitive_data("<GitHub user>") { ENV['GITHUB_USER'] }
  config.filter_sensitive_data("<GitHub repo>") { ENV['GITHUB_REPO'] }
end

