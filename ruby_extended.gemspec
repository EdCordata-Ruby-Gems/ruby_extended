$:.push File.expand_path('../lib', __FILE__)
require 'ruby_extended/version'

Gem::Specification.new do |s|
  s.name                  = 'ruby_extended'
  s.version               = RubyExtended::VERSION.dup
  s.platform              = Gem::Platform::RUBY
  s.authors               = 'EdCordata'
  s.description           = 'Extend Ruby classes with helpful methods'
  s.summary               = 'Extend Ruby classes with helpful methods'
  s.licenses              = ['CC BY 4.0']
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = 'https://github.com/EdCordata-Ruby-Gems/ruby_extended'
  s.metadata              = {
    'documentation_uri' => 'https://github.com/EdCordata-Ruby-Gems/ruby_extended/blob/master/documentation/readme.md',
    'source_code_uri'   => 'https://github.com/EdCordata-Ruby-Gems/ruby_extended',
    'bug_tracker_uri'   => 'https://github.com/EdCordata-Ruby-Gems/ruby_extended/issues',
    'wiki_uri'          => 'https://github.com/EdCordata-Ruby-Gems/ruby_extended/blob/master/documentation/readme.md',
  }
  s.require_paths         = ['lib']
  s.required_ruby_version = '>= 1.9.3'
  s.rubygems_version      = '1.6.2'
  s.add_runtime_dependency 'unicode_utils', '~> 1'
end
