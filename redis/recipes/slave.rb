
server = search("aws_opsworks_instance",  "hostname:masterserver").first
Chef::Log.info("#{server}")
node.default[:redis][:slave] = "yes"
node.default[:redis][:master_server] = "#{server['private_ip']}"

template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server], :master_server => node[:redis][:master_server]
end

execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end
