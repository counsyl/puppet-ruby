# == Class: ruby::debian
#
# Performs additional configuration for Debian platforms, including
# setting up alternatives correctly for a preferred version.  For
# example, it's used to prefer Ruby 1.9 on Ubuntu 12.04 platforms
# (where default Ruby is 1.8).
#
# === Parameters
#
# [*update_alternatives*]
#  Update the system alternatives to prefer the newer version of
#  Ruby for the system (if applicable), defaults to true.
#
class ruby::debian(
  $update_alternatives = true,
) inherits ruby::params {
  if $update_alternatives {
    if $::lsbdistcodename == 'precise' {
      ruby::debian::alternative { '1.9.1': }
    }
  }
}
