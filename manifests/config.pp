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
    $mainconffile             = '/etc/collectd/collectd.conf'
    $mainconftemplatelocation = 'collectd/etc/collectd/collectd.conf'
    $confincludedir           = '/etc/collectd/collectd.conf.d'
  }
  elsif (($::lsbdistrelease == '10.04') or ($::lsbdistrelease == '12.04')) {
    $mainconffile             = '/usr/local/collectd/etc/collectd.conf'
    $mainconftemplatelocation = 'collectd/usr/local/collectd/etc/collectd.conf'
    $confincludedir           = '/usr/local/collectd/etc/collectd.d'
  }

  file {
    $mainconffile:
      ensure  => file,
      content => template($mainconftemplatelocation),
      mode    => '0644',
      owner   => root,
      group   => root,
      require => Class['collectd::install'],
      notify  => Class['collectd::service'];

    $confincludedir:
      ensure  => directory,
      mode    => '0755',
      owner   => root,
      group   => root,
      require => Class['collectd::install'];
  }

  # Autodiscover services
  # Defined function wasn't an option because of issues with the ordering of loaded classes.

  if ('apache2' in $::puppet_classes) {
    file {
      "$confincludedir/apache2.conf":
        ensure   => file,
        source   => "puppet:///modules/collectd/etc/collectd/collectd.conf.d/apache2.conf",
        mode     => '0644',
        owner    => root,
        group    => root,
        require  => File[$confincludedir],
        notify   => Class['collectd::service'];
    }
  }

  if ('nginx' in $::puppet_classes) {
    file {
      "$confincludedir/nginx.conf":
      ensure   => file,
      source   => "puppet:///modules/collectd/etc/collectd/collectd.conf.d/nginx.conf",
      mode     => '0644',
      owner    => root,
      group    => root,
      require  => File[$confincludedir],
      notify   => Class['collectd::service'];
    }
  }

  if ('couchdb' in $::puppet_classes) {
    file {
      "$confincludedir/couchdb.conf":
      ensure   => file,
      source   => "puppet:///modules/collectd/etc/collectd/collectd.conf.d/couchdb.conf",
      mode     => '0644',
      owner    => root,
      group    => root,
      require  => File[$confincludedir],
      notify   => Class['collectd::service'];
    }
  }

  if ('pdns' in $::puppet_classes) {
    file {
      "$confincludedir/powerdns.conf":
      ensure   => file,
      source   => "puppet:///modules/collectd/etc/collectd/collectd.conf.d/powerdns.conf",
      mode     => '0644',
      owner    => root,
      group    => root,
      require  => File[$confincludedir],
      notify   => Class['collectd::service'];
    }
  }

}
