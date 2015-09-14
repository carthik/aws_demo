class aws_demo (
  $creator     = undef,
  $key_pair    = undef,
  $pe_version  = $aws_demo::params::pe_version,
  $pe_username = $aws_demo::params::pe_username,
  $pe_password = $aws_demo::params::pe_password,
  $aws_region  = $aws_demo::params::aws_region,
) inherits aws_demo::params {
  
  anchor { 'aws_demo::begin': }
  -> class { 'aws_demo::vpc': }
  -> class { 'aws_demo::security_group': }
  -> class { 'aws_demo::pe_master': }
  -> anchor { 'aws_demo::end': }

}
