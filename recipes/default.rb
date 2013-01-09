include_recipe "postgresql"
include_recipe "postgresql::client"

service "kannel" do
  supports :start => true, :stop => true
end

cookbook_file "#{Chef::Config[:file_cache_path]}/kannel-1.4.3-1.x86_64.rpm" do
    source "kannel-1.4.3-1.x86_64.rpm"
    action :create_if_missing
end

rpm_package "#{Chef::Config[:file_cache_path]}/kannel-1.4.3-1.x86_64.rpm" do
  action :install
end

execute "ldconfig" do
  user "root"
end

template "/etc/kannel/kannel.conf" do
  source "kannel.conf.erb"
  mode 0755
  owner "kannel"
  group "kannel"
  variables({
    :admin_port => node[:boot][:kannel][:admin_port],
    :smsbox_port => node[:boot][:kannel][:smsbox_port]
  })
  notifies :restart, "service[kannel]"
end

service "kannel" do
  action [:enable, :start]
end