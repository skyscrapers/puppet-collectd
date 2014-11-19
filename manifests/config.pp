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

# == Class collectd::config
#
# This class is called from collectd
#
class collectd::config {

  if ($::lsbdistrelease == '14.04') {
    file {
      '/etc/collectd/collectd.conf':
          ensure  => file,
          content => template('collectd/etc/collectd/collectd.conf'),
          mode    => '0644',
          owner   => root,
          group   => root,
          require => Class['collectd::install'],
          notify  => Class['collectd::service'];
    }
  }
  elsif (($::lsbdistrelease == '10.04') or ($::lsbdistrelease == '12.04')) {
    file {
      '/usr/local/collectd/etc/collectd.d':
        ensure  => directory,
        mode    => '0755',
        owner   => root,
        group   => root,
        require => Class['collectd::install'],
        notify  => Class['collectd::service'];
    }

    file {
      '/usr/local/collectd/etc/collectd.conf':
        ensure  => file,
        content => template('collectd/usr/local/collectd/etc/collectd.conf'),
        mode    => '0644',
        owner   => root,
        group   => root,
        require => Class['collectd::install'],
        notify  => Class['collectd::service'];
    }
  }
}
