package { "mysql-server": ensure => "present" }

service { "mysqld":
  ensure => "running",
  enable => true
}

# TODO
# ensure - GRANT ALL ON *.* TO root@192.168.33.22 IDENTIFIED BY '';

package { "git": ensure => "present" }

package { "wget": ensure => "present" }

# no browserid processes, just mysql
file {"/service/browserid-browserid": ensure => "absent", force => true }
file {"/service/browserid-example": ensure => "absent", force => true }
file {"/service/browserid-example-primary": ensure => "absent", force => true }
file {"/service/browserid-router": ensure => "absent", force => true }
file {"/service/browserid-proxy": ensure => "absent", force => true }
file {"/service/browserid-static": ensure => "absent", force => true }
file {"/service/browserid-verifier": ensure => "absent", force => true }
file {"/service/browserid-keysigner": ensure => "absent", force => true }
file {"/service/browserid-dbwriter": ensure => "absent", force => true }