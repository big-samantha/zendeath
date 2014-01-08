Gem::Specification.new do |s|
  s.name        = 'zendeath'
  s.version     = '0.0.3'
  s.date        = '2013-12-10'
  s.summary     = "Command Line Zendeath"
  s.description = "Zendeath is a command line client for Zendesk, primarily focused on Puppet Labs' use case. It may be made more generic in the future."
  s.authors     = ["Zachary Alex Stern"]
  s.email       = 'zacharyalexstern@gmail.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.executables << 'zendeath'
  s.homepage    =
    'https://github.com/zacharyalexstern/zendeath'
  s.license       = 'WTFPL'
  s.add_runtime_dependency 'cri', '~> 2.4.1'
end
