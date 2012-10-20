require 'rspec'
require 'vcr'
require 'vcr_helper'
require './lib/undantag/exceptions'
require './lib/undantag/notifier'

class Undantag::Configuration; end

describe Undantag::Notifier do
  config_vars = { api_key: ENV['UNDANTAG_API_KEY'],
    github_user: ENV['GITHUB_USER'],
    github_repo: ENV['GITHUB_REPO']
  }
  excpetion = Exception.new
  before do
    Undantag::Configuration.stub(:to_hash).and_return(config_vars)
    Undantag::Configuration.stub(:api_key).and_return(config_vars[:api_key])
    Undantag.stub(:configure)
    excpetion.set_backtrace("super backtrace")
  end
  it 'makes a post to the server when notify is called' do
    VCR.use_cassette("undantag-server-authorized") do
      Undantag.configure(config_vars)
      Undantag::Notifier.notify('env', excpetion, 'req')
    end
  end
  it 'throws Undantag::NotAuthorized when a 401 is returned' do
    VCR.use_cassette("undantag-server-not-authorized") do
      wrong = config_vars.merge(api_key: "this isn't right")
      Undantag::Configuration.stub(:to_hash).and_return(wrong)
      expect { Undantag::Notifier.notify('env', excpetion, 'req') }.to raise_error(Undantag::NotAuthorized)
    end
  end
  it 'throws "Undantag::ConfigurationError::NoApiKey" if send is called' do
    #temp hack
    Undantag::Configuration.stub(:to_hash).and_return({})
    expect { Undantag::Notifier.notify('env', excpetion, 'req') }.to raise_error(Undantag::ConfigurationError::NoApiKey)
  end
end

