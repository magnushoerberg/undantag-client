require 'rspec'
require 'vcr'
require 'vcr_helper'
require './lib/undantag/exceptions'
require './lib/undantag/notifier'

class Undantag::Configuration; end

describe Undantag::Notifier do
  before do
    Undantag.stub(:configure)
    Undantag::Configuration.stub(:api_key)
  end
  it 'makes a post to the server when notify is called' do
    VCR.use_cassette("undantag-server-authorized") do
      Undantag.configure(api_key: ENV['UNDANTAG_API_KEY'],
                         github_user: ENV['GITHUB_USER'],
                         github_repo: ENV['GITHUB_REPO'])
      Undantag::Notifier.notify(Exception.to_s)
    end
  end
  it 'throws Undantag::NotAuthorized when a 401 is returned' do
    VCR.use_cassette("undantag-server-not-authorized") do
      Undantag.configure api_key: ENV['UNDANTAG_API_KEY']
      expect { Undantag::Notifier.notify(Exception.to_s) }.to raise_error(Undantag::NotAuthorized)
    end
  end
  it 'throws "Undantag::ConfigurationError::NoApiKey" if send is called' do
    #temp hack
    Undantag.configure api_key: nil
    expect { Undantag::Notifier.notify(Exception.to_s) }.to raise_error(Undantag::ConfigurationError::NoApiKey)
  end
end

