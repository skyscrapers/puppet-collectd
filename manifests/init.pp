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

# == Class: collectd
#
# This class is able to activate and configure collectd
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
# * Installation of collectd
#     class {'collectd':
#       server          => 'server.example.com',
#       security_level  => 'Encrypt',
#       username        => 'username',
#       password        => 'password',
#     }
#
class collectd(
  $server            = undef,
  $security_level    = $collectd::params::security_level,
  $username          = undef,
  $password          = undef
) inherits collectd::params {

  include collectd::repo
  include collectd::install
  include collectd::config
  include collectd::service

  Class['collectd::repo'] -> Class['collectd::install'] -> Class['collectd::config'] -> Class['collectd::service']
}
