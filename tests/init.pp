bininstall { 'mplabxc16linux' :
  download_referer    => 'http://www.microchip.com/pagehandler/en_us/devtools/mplabxc/',
  download_user_agent => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6',
  download_url        => 'http://www.microchip.com/mplabxc16linux',
  download_path       => '/tmp',
  download_file       => 'mplabxc16linux',
  download_timeout    => 600,
  extract_file        => 'xc16-v1.21-linux-installer.run',
  extract_method      => 'tar',
  install_options     => ' --mode unattended --installerfunction installcompiler --netclient 0 --netservername localhost',
  install_creates     => '/opt/microchip/xc16/v1.21/bin/xc16-gcc',
}
