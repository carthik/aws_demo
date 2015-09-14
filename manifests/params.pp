class aws_demo::params {
  $pe_version  = '2015.2.0'
  $pe_password = 'puppetlabs'
  $aws_region = 'us-west-2'
  if versioncmp($pe_version_string, '3.7.0') >= 0 {
    # PE > 3.7 doesn't like email usernames
    $pe_username = 'admin'
  }
  else {
    $pe_username = 'admin@puppetlabs.com'
  }
}
