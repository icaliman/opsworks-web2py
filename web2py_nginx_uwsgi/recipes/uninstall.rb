if File.exists?("/etc/init.d/nginx")
  include_recipe "web2py_nginx_uwsgi::service"

  service "nginx" do
    action :stop
  end

  package "nginx" do
    action :remove
  end
end