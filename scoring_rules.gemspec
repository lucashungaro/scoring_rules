# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scoring_rules/version"

Gem::Specification.new do |s|
  s.name        = "scoring_rules"
  s.version     = ScoringRules::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Húngaro"]
  s.email       = ["lucashungaro@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/scoring_rules"
  s.summary     = %q{A small library that provides a simple DSL for creating scoring rules (for rankings, rating and similar uses).}
  s.description = %q{A small library that provides a simple DSL for creating scoring rules (for rankings, rating and similar uses).}

  s.rubyforge_project = "scoring_rules"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
  s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
end
