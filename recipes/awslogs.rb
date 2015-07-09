vars = {}

begin
  user_creds = Chef::EncryptedDataBagItem.load(node[:cw_mon][:aws_users_databag], node[:cw_mon][:user])
  vars[:access_key_id] = user_creds['access_key_id']
  vars[:secret_access_key] = user_creds['secret_access_key']
  log "AWS key for user #{ node[:cw_mon][:user]} found in databag #{node[:cw_mon][:aws_users_databag]}"
rescue
  vars = node[:cw_mon]
end

directory '/root/.aws' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/root/.aws/credentials" do
  source 'awslogs/credentials.erb'
  mode '0644'
  variables :cw_mon => vars
  action :create
end

template "/root/awslogs.conf" do
  source 'awslogs/awslogs.conf.erb'
  mode '0644'
  variables :cw_mon => vars
  action :create
end

execute "Fetch awslogs agent" do
  command "wget #{node['cw_mon']['release_url']} -P /root/"
end

execute "Install awslogs agent" do
  command "python ~/awslogs-agent-setup.py -r eu-west-1 -n -c ~/awslogs.conf"
end
