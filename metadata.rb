name 'redis'
maintainer 'Luis Ramirez'
maintainer_email 'lermquilerm@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures redis'
long_description 'Installs/Configures redis'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

recipe "redis::default", "Install server"
recipe "redis::slave", "Install 3 slaves"
