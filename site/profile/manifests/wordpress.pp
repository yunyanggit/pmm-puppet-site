class profile::wordpress (
  Sensitive[String] $db_password = "password"
) {

  class { 'apache':
    default_vhost => true,
  }

  class { 'apache::mod::php': }

  class { 'wordpress':
    db_password => $db_password,
    require  => [
      Class['mysql::server'],
      Class['apache'],
      Class['apache::mod::php'],
    ],
  }

  class { 'mysql::server': }

  class { 'php':
    extensions => { 'mysql' => {} },
  }

  apache::vhost { 'wordpress':
    docroot => '/opt/wordpress',
  }
}
