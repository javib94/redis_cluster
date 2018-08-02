
server = search("aws_opsworks_instance",  "hostname:masterserver")
node.default[:redis][:slave] = "yes"
node.default[:redis][:master_server] = server['private_ip']

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server], :master_server => node[:redis][:master_server]
end

execute 'redis-server' do
  command "redis-server restart #{node[:redis][:conf_dir]}/redis.conf"
  user 'root'
end
