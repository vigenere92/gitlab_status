lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitlab_status/version'

Gem::Specification.new do |gem|
  gem.name            = 'gitlab_status'
  gem.version         = GitlabStatus::VERSION
  gem.authors         = ['Gaurav Saini']
  gem.email           = 'vigenere10@gmail.com'
  gem.summary         = 'A ruby CLI for gitlab status'

  gem.description     = <<-DESCRIPTION
    A ruby CLI for checking the status of gitlab.com and reporting average response times
    over 10 second intervals for 1 minute
  DESCRIPTION

  gem.license         = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  gem.executables   = ["gitlab_status"]
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.14"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_runtime_dependency 'httpclient', '~> 2.8', '>= 2.8.3'
end
