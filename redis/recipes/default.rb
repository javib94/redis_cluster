
apt_repository 'redis-server' do
  uri          'ppa:chris-lea/redis-server'
end

# Repositorios
execute "update" do
  command "apt-get update"
  action :run
end

package 'redis-server'

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end

execute 'redis-server-master' do
  command "redis-server #{node[:redis][:conf_dir]}/redis.conf"
  user 'root'
end
