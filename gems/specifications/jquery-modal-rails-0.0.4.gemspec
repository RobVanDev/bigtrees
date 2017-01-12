# -*- encoding: utf-8 -*-
# stub: jquery-modal-rails 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-modal-rails"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dirk Eisenberg"]
  s.date = "2013-12-25"
  s.description = "The simplest possible modal for jQuery for the Rails 3.1+ asset pipeline based on https://github.com/kylefox/jquery-modal."
  s.email = ["dirk.eisenberg@gmail.com"]
  s.homepage = "https://github.com/dei79/jquery-modal-rails"
  s.rubygems_version = "2.4.5.1"
  s.summary = "The simplest possible modal for jQuery for the Rails 3.1+ asset pipeline"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.14"])
      s.add_runtime_dependency(%q<jquery-ui-rails>, [">= 0"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 0"])
    else
      s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
      s.add_dependency(%q<thor>, ["~> 0.14"])
      s.add_dependency(%q<jquery-ui-rails>, [">= 0"])
      s.add_dependency(%q<uuidtools>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
    s.add_dependency(%q<thor>, ["~> 0.14"])
    s.add_dependency(%q<jquery-ui-rails>, [">= 0"])
    s.add_dependency(%q<uuidtools>, [">= 0"])
  end
end
