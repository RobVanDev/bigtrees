# -*- encoding: utf-8 -*-
# stub: exception_handler 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "exception_handler"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Richard Peck"]
  s.date = "2016-03-14"
  s.description = "Rails gem to create custom error pages. Captures exceptions using \"exception_app\" callback, routing to \"Exception\" controller, rendering the view as required."
  s.email = ["rpeck@frontlineutilities.co.uk"]
  s.homepage = "http://github.com/richpeck/exception_handler"
  s.licenses = ["MIT"]
  s.post_install_message = "########################################################################################\n##  _____                   _   _               _   _                 _ _             ##\n## |  ___|                 | | (_)             | | | |               | | |            ##\n## | |____  _____ ___ _ __ | |_ _  ___  _ __   | |_| | __ _ _ __   __| | | ___ _ __   ##\n## |  __\\ \\/ / __/ _ \\ '_ \\| __| |/ _ \\| '_ \\  |  _  |/ _` | '_ \\ / _` | |/ _ \\ '__|  ##\n## | |___>  < (_|  __/ |_) | |_| | (_) | | | | | | | | (_| | | | | (_| | |  __/ |     ##\n## \\____/_/\\_\\___\\___| .__/ \\__|_|\\___/|_| |_| \\_| |_/\\__,_|_| |_|\\__,_|_|\\___|_|     ## \n##                   | |                                                              ##\n##                  |_|                                                               ##\n########################################################################################\n\nIMPORTANT -\n**IF UPGRADING EXCEPTION HANDLER (to 0.4.7)***\n**DELETE INITIALIZER (config/initializers/exception_handler.rb)**\n\nWe've changed the initialization process for ExceptionHandler.\n\nThe initializer has been replaced with /config/application.rb\noptions:\n\n#config/application.rb\nconfig.exception_handler = {\n\tdb:   \tfalse, #-> defaults to :errors if true, else use :table_name\n\temail: \tfalse, #-> need to integrate\n\tsocial: {\n\t    :twitter \t=> \t'frontlineutils',\n\t    :facebook \t=> \t'frontline.utilities',\n\t    :linkedin \t=> \t'frontline-utilities',\n\t    :youtube \t=>\t'frontlineutils',\n\t    :fusion \t=> \t'frontlineutils',\n\t    :url => {\n\t\t    :facebook \t=> \t'https://facebook.com',\n\t\t    :twitter \t=> \t'http://twitter.com',\n\t\t    :youtube \t=>\t'https://youtube.com/user',\n\t\t    :linkedin \t=> \t'https://linkedin.com/company',\n\t\t    :fusion \t=> \t'https://frontlinefusion.com',\n\t\t},\n\t},\n\tlayouts: {\n\t    '400' => nil,\n\t    '500' => 'exception'\n\t},\n}\n\nIf you've made any changes to your initializer,\nyou MUST DELETE it, replacing the options with\nthose in config/application.rb, or\nconfig/environments/production.rb.\n\nMore info on the ExceptionHandler github page:\nhttp://github.com/richpeck/exception_handler\n\nThank you & enjoy!!"
  s.rubygems_version = "2.4.5.1"
  s.summary = "Rails gem to show custom error pages in production. Also logs errors in db & sends notification emails"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rails>, ["~> 4.0.0"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.3"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.3"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.10"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rails>, ["~> 4.0.0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.3"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.3"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.10"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rails>, ["~> 4.0.0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.3"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.3"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.10"])
  end
end
