class aws_demo::pe_master {
  $pe_version_string = '2015.2.0'
  $pe_password = 'puppetlabs'
  $whoami = 'carthik'

  if versioncmp($pe_version_string, '3.7.0') >= 0 {
    # PE > 3.7 doesn't like email usernames
    $pe_username = 'admin'
  }
  else {
    $pe_username = 'admin@puppetlabs.com'
  }

  ec2_instance { 'puppet-master':
    ensure                      => present,
    associate_public_ip_address => true,
    region                      => 'us-west-2',
    image_id                    => 'ami-e08efbd0',
    instance_type               => 'm3.medium',
    key_name                    => 'aws_demo',
    security_groups             => ["${whoami}-sg"],
    subnet                      => "${whoami}-subnet",
    monitoring                  => 'true',
    user_data                   => template('aws_demo/master-pe-userdata.erb'),
  }
}
