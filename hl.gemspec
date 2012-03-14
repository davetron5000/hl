# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hl/version"

Gem::Specification.new do |s|
  s.name        = "hl"
  s.version     = Hl::VERSION
  s.authors     = ["Dave Copeland"]
  s.email       = ["davetron5000@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Highlight words in stdin or files}
  s.description = %q{To help with reading the results of grep without further reducing the output, hl will highlight terms in the output}

  s.rubyforge_project = "hl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rdoc')
  s.add_development_dependency('ronn')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rake','~> 0.9.2')
  s.add_dependency('methadone', '~>1.0.0.rc5')
  s.add_dependency('rainbow')
  s.add_dependency('gem-man')
end
