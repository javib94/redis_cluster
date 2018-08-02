
package 'redis-sentinel'

server = search("aws_opsworks_instance",  "hostname:masterserver").first
node.default[:redis][:master_server] = server['private_ip']
layer_slave = search("aws_opsworks_layer", "shortname:redisslaves").first
layer_id = layer_slave['layer_id']
instances = search("aws_opsworks_instance", "layer_ids:#{layer_id}")


template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :sentinel_port => node[:sentinel][:port], :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name], :serverip => node[:redis][:master_server], :instance => instances
end

execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end
