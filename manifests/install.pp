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

# == Class collectd::install
#
# This class is called from collectd for install.
#
class collectd::install inherits ::collectd {

  if (($::lsbdistrelease == '14.04') or ($::lsbdistrelease == '16.04')) {
    $packagelist = ['collectd']
  } elsif (($::lsbdistrelease == '10.04') or ($::lsbdistrelease == '12.04')) {
    $packagelist = ['collectd-custom','libltdl-dev']
  }

  package {
    $packagelist:
      ensure => latest;
  }
}
