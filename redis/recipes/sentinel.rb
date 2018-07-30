
package 'redis-sentinel'


sentinel_port = 0
template "#{node[:redis][:conf_dir]}/sentinel.conf" do
  source        "sentinel.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :sentinel_port => sentinel_port, :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name], :nodes => node[:redis][:ports]
end



execute 'redis-sentinel-run' do
  command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel.conf"
  user 'root'
end
