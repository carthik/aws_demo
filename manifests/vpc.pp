class aws_demo::vpc{

  $whoami = 'carthik'

  ec2_vpc { "${whoami}-vpc":
    ensure       => present,
    region       => 'us-west-2',
    cidr_block   => '10.0.0.0/16',
  }

  ec2_securitygroup { "${whoami}-sg":
    ensure      => present,
    # TBD: all these region entries should read from the ~/.aws/config 
    # by means of a custom fact if needed
    region      => 'us-west-2',
    vpc         => "${whoami}-vpc",
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

  ec2_vpc_subnet { "${whoami}-subnet":
    ensure            => present,
    region            => 'us-west-2',
    vpc               => "${whoami}-vpc",
    cidr_block        => '10.0.0.0/24',
    availability_zone => 'us-west-2a',
    route_table       => "${whoami}-routes",
  }

  ec2_vpc_internet_gateway { "${whoami}-igw":
    ensure => present,
    region => 'us-west-2',
    vpc    => "${whoami}-vpc",
  }

  ec2_vpc_routetable { "${whoami}-routes":
    ensure => present,
    region => 'us-west-2',
    vpc    => "${whoami}-vpc",
    routes => [
      {
        destination_cidr_block => '10.0.0.0/16',
        gateway                => 'local'
        },{
          destination_cidr_block => '0.0.0.0/0',
          gateway                => "${whoami}-igw"
        },
    ],
  }
}
