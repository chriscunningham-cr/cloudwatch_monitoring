default[:cw_mon][:release_url]       = 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'

default[:cw_mon][:aws_users_databag] = 'aws_users'
default[:cw_mon][:access_key_id]     = nil
default[:cw_mon][:secret_access_key] = nil

default[:cw_mon][:log_file]          = '/srv/log/vertx.log'
