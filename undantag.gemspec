# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'undantag/version'

Gem::Specification.new do |gem|
  gem.name          = "undantag"
  gem.version       = Undantag::VERSION
  gem.authors       = ["Magnus Hörberg"]
  gem.email         = ["magnus.hoerberg@gmail.com"]
  gem.description   = %q{Gem for the exception service UNDANTAG}
  gem.summary       = %q{After configuration posts exceptions to https://undantag.herokuapp.com/exception}
  gem.homepage      = "https://undantag.herokuapp.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
