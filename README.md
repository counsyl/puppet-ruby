ruby
====

This Puppet module installs and configures the Ruby language runtime and popular Ruby packages.

* `ruby`: This class installs the default packaged Ruby interpreter for the platform.
* `ruby::devel`: Installs the default Ruby development headers for the platform.
* `ruby::gemrc`: Configures the system's global [gem environment](http://guides.rubygems.org/command-reference/#gem_environment) configuration file including gem mirrors.
* `ruby::openbsd`: Creates symbolic links for a better experience on OpenBSD.
* `ruby::passenger`: Installs the open source version of [Phusion Passenger](https://www.phusionpassenger.com/), commonly used to deploy Ruby web applications.
* `ruby::rack`: Installs [Rack](http://rack.github.io/), the Ruby Webserver Interface.
* `ruby::rake`: Installs [RAKE](http://rake.rubyforge.org/), a simple Ruby build program analogous to make.

License
-------

Apache License, Version 2.0

Contact
-------

Justin Bronn <justin@counsyl.com>

Support
-------

Please log tickets and issues at https://github.com/counsyl/puppet-ruby
