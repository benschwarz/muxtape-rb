spec = Gem::Specification.new do |s| 
  s.name = "muxtape"
  s.version = Muxtape::VERSION
  s.author = "Ben Schwarz"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://germanforblack.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Download your favorite muxtapes with ease"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "muxtape"
  
  # Deps
  s.add_dependency("hpricot", ">= 0.6")
  s.add_dependency("highline", ">= 1.4.0")
  s.add_dependency("rb-appscript", ">= 0.5.1")
  
  # 'Binary' goodness
  s.default_executable = 'bin/muxtape'
end


