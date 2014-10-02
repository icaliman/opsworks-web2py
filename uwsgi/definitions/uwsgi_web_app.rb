define :uwsgi_web_app, :template => "app.ini.erb" do
  include_recipe "uwsgi::service"

  application = params[:application]
  application_name = params[:name]

  template "#{node[:uwsgi][:dir]}/#{application_name}.ini" do
    Chef::Log.debug("Generating Uwsgi configuration file for #{application_name.inspect}")
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    variables(
        :application => application
    )
    if File.exists?("#{node[:uwsgi][:dir]}/#{application_name}.ini")
      notifies :restart, "service[uwsgi-emperor]", :delayed
    end
  end

end
