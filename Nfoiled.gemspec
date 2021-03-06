Gem::Specification.new do |s|
  s.name = %q{nfoiled}
  s.version = "0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["elliottcable"]
  s.date = %q{2009-03-05}
  s.description = %q{The Rubyist's interface to Ncurses.}
  s.email = ["Nfoiled@elliottcable.com"]
  s.extra_rdoc_files = ["lib/nfoiled/window.rb", "lib/nfoiled.rb", "LICENSE.text", "README.markdown"]
  s.files = ["examples/initialization.rb", "lib/nfoiled/window.rb", "lib/nfoiled.rb", "LICENSE.text", "Rakefile.rb", "README.markdown", "spec/nfoiled/window_spec.rb", "spec/nfoiled_spec.rb", "spec/spec_helper.rb", ".manifest", "nfoiled.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/elliottcable/nfoiled}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Nfoiled", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nfoiled}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{The Rubyist's interface to Ncurses.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<ncurses>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<stringray>, [">= 0"])
    else
      s.add_dependency(%q<ncurses>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<stringray>, [">= 0"])
    end
  else
    s.add_dependency(%q<ncurses>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<stringray>, [">= 0"])
  end
end
