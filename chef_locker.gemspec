Gem::Specification.new do |s|
  s.name = 'chef_locker'
  s.version = '0.1.0'
  s.authors = ['AnyPerk Engineering']
  s.email = ['engineering@anyperk.com']
  s.summary = 'Lock Chef runs'
  s.description = 'This contains a script to lock Chef runs.'
  s.homepage = 'https://github.com/anyperk/chef_locker'
  s.license = 'MIT'

  s.add_dependency 'chef', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.5'

  s.executables = %w(chef_locker)

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{\Aspec/})
end
