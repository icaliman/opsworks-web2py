include_recipe "uwsgi::service"

service "uwsgi" do
  action :stop
end