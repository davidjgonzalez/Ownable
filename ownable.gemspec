# -*- encoding: utf-8 -*-
require File.expand_path("../lib/ownable/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ownable"
  s.version     = Ownable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Gonzalez"]
  s.email       = ["davidjgonzalez@gmail.com"]
  s.homepage    = "http://http://github.com/emp29/Ownable"
  s.summary     = "Model ownership with Rails 3"
  s.description = "Model ownership with Rails 3"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency 'rails', '~> 3.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
