# == Class: ruby::params
#
# Default parameters for the Ruby runtime.
#
class ruby::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package = 'ruby'
      $ensure  = $sys::openbsd::pkg::ruby
      $source  = $sys::openbsd::pkg::source
      $gems    = 'ruby-gems'
      $gemhome = '/usr/local/lib/ruby/gems/1.8/gems'
    }
    solaris: {
      include sys::solaris
      $package  = 'runtime/ruby-18'
      $provider = 'pkg'
      $gemhome  = '/var/ruby/1.8/gem_home/gems'
    }
    debian: {
      $package = 'ruby1.8'
      $gems    = 'rubygems'
      $gemhome = '/var/lib/gems/1.8/gems'
      $devel   = "${package}-dev"

      # The `libopenssl-ruby` package was merged into `libruby`
      # in Debian 6/Ubuntu 11.
      if $::operatingsystem == 'Ubuntu' {
        $lsb_compare = '11'
      } else {
        $lsb_compare = '6'
      }
      if versioncmp($::lsbmajdistrelease, $lsb_compare) >= 0 {
        $extras  = ['libruby', "libshadow-${package}"]
      } else {
        $extras  = ['libopenssl-ruby', "libshadow-${package}"]
      }
    }
    redhat: {
      $package = 'ruby'
      $gems    = 'rubygems'
      $gemhome = '/usr/lib/ruby/gems/1.8/gems'
      $devel   = 'ruby-devel'
    }
    default: {
      fail("Do not know how to install/configure Ruby on ${::osfamily}.\n")
    }
  }

  # Default parameters for gems.
  $gem_bindir = '/usr/local/bin'
  $gem_conf   = '/etc/gemrc'
  $gem_rdoc   = false
  $gem_ri     = false
}
