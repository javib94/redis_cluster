
priority = 100
node[:redis][:slaves].each do |port|
  node.default[:redis][:slave] = "yes"
  node.default[:redis][:pid_file] = "/var/run/redis-#{port}.pid"
  node.default[:redis][:server][:port] = port
  node.default[:redis][:log_dir] = "/var/log/redis-#{port}"
  node.default[:redis][:data_dir] = "/var/lib/redis-#{port}"
  directory node[:redis][:log_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  directory node[:redis][:data_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  template "#{node[:redis][:conf_dir]}/redis#{port}.conf" do
    source        "redis.conf.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :redis => node[:redis], :redis_server => node[:redis][:server], :priority => priority
  end
  execute 'redis-server' do
    command "redis-server #{node[:redis][:conf_dir]}/redis#{port}.conf"
    user 'root'
  end
  priority = priority + 100
end
