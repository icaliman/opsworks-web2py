include_recipe "web2py_nginx_uwsgi::service"

service "nginx" do
  action :stop
end