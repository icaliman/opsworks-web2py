if File.exists?("/etc/uwsgi")
  include_recipe "uwsgi::service"

  service "uwsgi" do
    action :stop
  end

  package "uwsgi" do
    action :remove
  end
end