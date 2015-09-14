class aws_demo::vpc{

  $creator = $aws_demo::creator
  $aws_region  = $aws_demo::aws_region

  ec2_vpc { "${creator}-vpc":
    ensure       => present,
    region       => $aws_region,
    cidr_block   => '10.0.0.0/16',
  }

  ec2_vpc_subnet { "${creator}-subnet":
    ensure            => present,
    region            => $aws_region,
    vpc               => "${creator}-vpc",
    cidr_block        => '10.0.0.0/24',
    route_table       => "${creator}-routes",
  }

  ec2_vpc_internet_gateway { "${creator}-igw":
    ensure => present,
    region => $aws_region,
    vpc    => "${creator}-vpc",
  }

  ec2_vpc_routetable { "${creator}-routes":
    ensure => present,
    region => $aws_region,
    vpc    => "${creator}-vpc",
    routes => [
      {
        destination_cidr_block => '10.0.0.0/16',
        gateway                => 'local'
        },{
          destination_cidr_block => '0.0.0.0/0',
          gateway                => "${creator}-igw"
        },
    ],
  }
}
