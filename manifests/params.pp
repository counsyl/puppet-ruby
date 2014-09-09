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
      if versioncmp($::kernelmajversion, '5.4') >= 0 {
        $gems = false
        $gemhome = '/usr/local/lib/ruby/gems/1.9.1/gems'
        $suffix = '19'
      } else {
        $gems = 'ruby-gems'
        $gemhome = '/usr/local/lib/ruby/gems/1.8/gems'
        $suffix = '18'
      }
    }
    solaris: {
      include sys::solaris
      $package  = 'runtime/ruby-18'
      $provider = 'pkg'
      $gemhome  = '/var/ruby/1.8/gem_home/gems'
    }
    debian: {
      # There have been multiple changes to default Ruby packages over
      # the years, set up different comparison variables based on LSB
      # major release numbers.
      if $::operatingsystem == 'Ubuntu' {
        $libruby_compare = '11'
        $ruby18_compare = '12'
      } else {
        $libruby_compare = '6'
        $ruby18_compare = '6'
      }

      # Facter 2.2+ changed lsbmajdistrelease fact, e.g., now returns
      # '12.04' instead of '12' for Ubuntu precise.
      $lsb_major_release = regsubst($::lsbmajdistrelease, '^(\d+).*', '\1')

      if versioncmp($lsb_major_release, $ruby18_compare) > 0 {
        $package_version = '1.9.1'
        $gems = false
        $libruby = 'libruby'
        $libshadow = 'ruby-shadow'
      } else {
        $package_version = '1.8'
        $gems = 'rubygems'
        $libshadow = "libshadow-ruby${package_version}"
        # The `libopenssl-ruby` package was merged into `libruby`
        # in Debian 6/Ubuntu 11.
        if versioncmp($lsb_major_release, $libruby_compare) >= 0 {
          $libruby = 'libruby'
        } else {
          $libruby = 'libopenssl-ruby'
        }
      }

      $package = "ruby${package_version}"
      $gemhome = "/var/lib/gems/${package_version}/gems"
      $devel   = "${package}-dev"
      $extras  = [$libruby, $libshadow]
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
  $gem_bindir  = '/usr/local/bin'
  $gem_conf    = '/etc/gemrc'
  $gem_rdoc    = false
  $gem_ri      = false
  $gem_sources = ['https://rubygems.org/']
}
