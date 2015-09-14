class aws_demo::security_group {

  $creator    = $aws_demo::creator
  $aws_region = $aws_demo::aws_region

  ec2_securitygroup { "${creator}-sg":
    ensure      => present,
    region      => $aws_region,
    vpc         => "${creator}-vpc",
    description => 'Security group for VPC',
    ingress     => [{
      protocol => 'tcp',
      port     => 22,
      cidr     => '0.0.0.0/0'
      },{
        protocol => 'tcp',
        port     => 443,
        cidr     => '0.0.0.0/0'
      }]
  }

}
