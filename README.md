# Undantag

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'undantag'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install undantag

## Usage

In your sinatra application add the following lines
    
    configure :production do
      set :show_exceptions, false
      Undantag.configure(api_key: ENV['UNDANTAG_API_KEY']
                         github_user: ENV['GITHUB_USER']
                         github_repo: ENV['GITHUB_REPO'])
    end
    error do
      if ENV['RACK_ENV'] == 'production'
        require 'undantag'
        resp = Undantag::Notifier.notify(env,
                                         env['sinatra.error'],
                                         Rack::Request.new(env))
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
