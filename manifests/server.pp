##### LICENSE

# Copyright (c) Skyscrapers (iLibris bvba) 2014 - http://skyscrape.rs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# == Class: collectd::server
#
# This class is able to activate and configure collectd to act as a server
# A bit of a hack, as we load collectd client for every instance in our setup
# Should be rewritten once we pull client and server apart on the server
#
#
# === Parameters
#
# [*server*]
#   Collectd servername or ip.
#
# [*security_level*]
#   Security level used by collectd server.
#
# [*username*]
#   Username
#
# [*password*]
#   Password
#
# === Examples
#
# * Installation of collectd server
#     class {'collectd::server':
#       server          => 'server.example.com',
#       security_level  => 'Encrypt',
#       username        => 'username',
#       password        => 'password',
#     }
#
class collectd::server(
  $server            = undef,
  $security_level    = $collectd::params::security_level,
  $username          = undef,
  $password          = undef
  ) inherits collectd::params {

  file {
    '/etc/collectd/passwd':
      ensure  => file,
      content => template('collectd/etc/collectd/passwd.erb'),
      mode    => '0640',
      owner   => root,
      group   => root,
      notify  => Class['collectd::service'];

    '/etc/collectd/collectd-server.conf':
      ensure  => file,
      content => template('collectd/etc/collectd/collectd-server.conf.erb'),
      mode    => '0644',
      owner   => root,
      group   => root,
      notify  => Class['collectd::service'];

    '/etc/init.d/collectd':
      ensure  => file,
      source  => 'puppet:///modules/collectd/etc/init.d/collectd',
      mode    => '0755',
      owner   => root,
      group   => root,
      notify  => Class['collectd::service'];
  }

}
