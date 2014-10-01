if File.exists?("/etc/init.d/nginx")
  include_recipe "uwsgi::service"

  service "uwsgi-emperor" do
    action :stop
  end

  package "uwsgi" do
    action :remove
  end
end