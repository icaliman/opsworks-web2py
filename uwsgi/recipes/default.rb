#
# Cookbook Name:: uwsgi
# Recipe:: default
# Author:: ialiman <icaliman92@gmail.com>
#

package "uwsgi"

directory node[:uwsgi][:dir] do
  owner 'root'
  group 'root'
  mode '0755'
end

directory node[:uwsgi][:log_dir] do
  mode 0755
  owner node[:uwsgi][:user]
  action :create
end

template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:nginx][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
end

include_recipe "uwsgi::service"

service "uwsgi-emperor" do
  action [ :enable, :start ]
end
