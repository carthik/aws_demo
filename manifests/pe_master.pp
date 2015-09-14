class aws_demo::pe_master {
  $creator     = $aws_demo::creator
  $key_pair    = $aws_demo::key_pair
  $pe_version  = $aws_demo::pe_version
  $pe_username = $aws_demo::pe_username
  $pe_password = $aws_demo::pe_password
  $aws_region  = $aws_demo::aws_region

  ec2_instance { 'puppet-master':
    ensure                      => present,
    associate_public_ip_address => true,
    region                      => $aws_region,
    image_id                    => 'ami-e08efbd0',
    instance_type               => 'm3.medium',
    key_name                    => $key_pair,
    security_groups             => ["${creator}-sg"],
    subnet                      => "${creator}-subnet",
    monitoring                  => 'true',
    user_data                   => template('aws_demo/master-pe-userdata.erb'),
  }

}
