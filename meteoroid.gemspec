# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "meteoroid/version"

Gem::Specification.new do |s|
  s.name        = "meteoroid"
  s.version     = Meteoroid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Duncan Grazier", "Paul Guelpa"]
  s.email       = ["duncan@impossiblerocket.com"]
  s.homepage    = "http://github.com/itsmeduncan/meteoroid"
  s.summary     = %q{Transform JMeter output into something useful}
  s.description = %q{Use this library to transform JML into other stuff}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_development_dependency('mocha', ['~> 0.9.12'])
  s.add_development_dependency('rake', ['~> 0.9.2'])
  s.add_development_dependency('rspec', ['~> 2.6.0'])
  
  s.add_dependency('nokogiri', ['~> 1.5.0'])
end
