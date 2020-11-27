require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatters = [
  SimpleCov::Formatter::Codecov,
  SimpleCov::Formatter::HTMLFormatter
]
