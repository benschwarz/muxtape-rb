Gem::Specification.new do |s|
  s.name = "muxtape"
  s.version = "0.0.1"
  s.date = "2008-04-26"
  s.summary = "Download your favorite muxtapes with ease"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://github.com/benschwarz/muxtape-rb"
  s.description = "A command line ruby based tool to download muxtapes from muxtape.com"
  s.authors = ["Ben Schwarz"]
  s.files = ["README", "muxtape-rb.gemspec", "lib/muxtape.rb", "bin/muxtape"]
  
  # Deps
  s.add_dependency("hpricot", [">= 0.6"])
  s.add_dependency("highline", [">= 1.4.0"])
  s.add_dependency("rb-appscript", [">= 0.5.1"])
  
  # 'Binary' goodness
  s.default_executable = 'bin/muxtape'
end