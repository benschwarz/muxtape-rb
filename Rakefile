require File.join(File.dirname(__FILE__), 'muxtape-rb.gemspec')
require "rake/clean"
require "rake/gempackagetask"

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

# Things that we don't want in our package
CLEAN.include ["**/.*.sw?", "pkg", "lib/*.bundle", "*.gem"]

# Windows install support
windows = (PLATFORM =~ /win32|cygwin/) rescue nil
SUDO = windows ? "" : "sudo"

desc "Install muxtape-rb"
task :install => [:package] do
  sh %{#{SUDO} gem install --local pkg/muxtape-rb-0.0.1.gem}
end