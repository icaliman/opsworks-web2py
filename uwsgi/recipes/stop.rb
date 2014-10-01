include_recipe "uwsgi::service"

service "uwsgi-emperor" do
  action :stop
end