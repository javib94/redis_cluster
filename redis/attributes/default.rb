# Locations
default[:redis][:conf_dir]          = "/etc/redis"
default[:redis][:log_dir]           = "/var/log/redis"
default[:redis][:data_dir]          = "/var/lib/redis"
default[:redis][:pid_file]          = "/var/run/redis.pid"
default[:redis][:db_basename]       = "dump.rdb"

# Server
default[:redis][:server][:addr]     = "0.0.0.0"
default[:redis][:server][:port]     = "6379"
default[:redis][:server][:timeout]  = "60"
default[:redis][:saves]             = [["900", "1"], ["300", "10"], ["60", "10000"]]

# Replication
default[:redis][:slave]             = "no"
default[:redis][:master_server]     = "127.0.0.1"
default[:redis][:master_port]       = "6379"

#sentinel
default[:sentinel][:master_name]    = "mymaster"
default[:sentinel][:port]           = "26379";
