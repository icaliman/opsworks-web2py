#
# Cookbook Name:: uwsgi
# Recipe:: default
# Author:: Ion Caliman <icaliman92@gmail.com>
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

include_recipe "uwsgi::service"

service "uwsgi" do
  action [ :enable, :start ]
end
