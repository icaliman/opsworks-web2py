define :uwsgi_web_app, :template => "app.ini.erb", :enable => true do
  include_recipe "uwsgi::service"

  application = params[:application]
  application_name = params[:name]

  template "#{node[:uwsgi][:dir]}/apps-available/#{application_name}.ini" do
    Chef::Log.info("Generating uWSGI configuration file for #{application_name.inspect}")
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
        :application => application,
        :application_name => application_name
    )

    if !File.symlink?("#{node[:uwsgi][:dir]}/apps-enabled/#{application_name}.ini")
      File.symlink("#{node[:uwsgi][:dir]}/apps-available/#{application_name}.ini",
                   "#{node[:uwsgi][:dir]}/apps-enabled/#{application_name}.ini")
    end
  end

  service "uwsgi" do
    action :restart
  end
end
