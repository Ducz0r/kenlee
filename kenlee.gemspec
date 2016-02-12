$:.push File.expand_path('../lib', __FILE__)
require 'kenlee/version'

Gem::Specification.new do |s|
  s.name        = 'kenlee'
  s.version     = KenLee::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2016-02-10'
  s.summary     = %q{Generate fake data from various Internet sources}
  s.description = %q{KenLee generates random fake data: sentences, names, comments, etc. from Internet sources}
  s.authors     = ['Luka Murn']
  s.email       = 'murn.luka@gmail.com'
  s.homepage    = 'https://github.com/Ducz0r/kenlee'
  s.license     = 'MIT'

  s.add_dependency('curb', '>= 0.9.1')

  s.files         = Dir['lib/**/*'] + %w(LICENSE.txt README.md)
  s.test_files    = Dir['test/**/*']
  s.require_paths = ['lib']
end