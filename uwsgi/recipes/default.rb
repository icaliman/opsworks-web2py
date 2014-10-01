
package "uwsgi"

include_recipe "uwsgi::service"

service "uwsgi-emperor" do
  action [ :enable, :start ]
end
