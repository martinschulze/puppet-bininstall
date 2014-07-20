# Copyright 2014 Martin Schulze
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Type: bininstall
#
# This module installs a binary package by different methods.
#
# Parameters:
#
# Actions:
#
# Requires: -
#
# Sample Usage:
#

define bininstall(
  $download_referer    = '',
  $download_user_agent = '',
  $download_url        = '',
  $download_path       = '',
  $download_file       = '',
  $download_timeout    = 300,
  $extract_file        = '',
  $extract_method      = '',
  $install_options     = '',
  $install_creates     = '',
) {

#  include mplabxc16linux::params
  $extract_command = $extract_method ? {
    tar     => "/usr/bin/tar xf ${download_path}/${download_file}",
    tar-gz  => "/usr/bin/tar xzf ${download_path}/${download_file}",
    default => "/usr/bin/tar xf ${download_path}/${download_file}",
  }

  exec { 'download' :
    command => "/usr/bin/wget -q --referer=\"${download_referer}\" --user-agent=\"${download_user_agent}\" ${download_url}",
    cwd     => $download_path,
    creates => "${download_path}/${download_file}",
    timeout => $download_timeout,
  }

  exec { 'extract' :
    command => $extract_command,
    cwd     => $download_path,
    creates => "${download_path}/${extract_file}",
    require => Exec [ 'download' ],
  }

  exec { 'install' :
    command => "${download_path}/${extract_file} ${install_options}",
    cwd     => $download_path,
    creates => $install_creates,
    require => Exec [ 'extract' ],
  }

}