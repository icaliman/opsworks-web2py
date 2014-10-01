define :nginx_web_app, :template => "site.erb", :enable => true do
  include_recipe "uwsgi::service"

  application = params[:application]
  application_name = params[:name]

  template "#{node[:uwsgi][:dir]}/sites-available/#{application_name}" do
    Chef::Log.debug("Generating Nginx site template for #{application_name.inspect}")
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
      :application => application,
      :application_name => application_name,
      :params => params
    )
    if File.exists?("#{node[:uwsgi][:dir]}/sites-enabled/#{application_name}")
      notifies :reload, "service[nginx]", :delayed
    end
  end

  directory "#{node[:uwsgi][:dir]}/ssl" do
    action :create
    owner "root"
    group "root"
    mode 0600
  end

  template "#{node[:uwsgi][:dir]}/ssl/#{application[:domains].first}.crt" do
    cookbook 'uwsgi'
    mode '0600'
    source "ssl.key.erb"
    variables :key => application[:ssl_certificate]
    notifies :restart, "service[nginx]"
    only_if do
      application[:ssl_support]
    end
  end

  template "#{node[:uwsgi][:dir]}/ssl/#{application[:domains].first}.key" do
    cookbook 'uwsgi'
    mode '0600'
    source "ssl.key.erb"
    variables :key => application[:ssl_certificate_key]
    notifies :restart, "service[nginx]"
    only_if do
      application[:ssl_support]
    end
  end

  template "#{node[:uwsgi][:dir]}/ssl/#{application[:domains].first}.ca" do
    cookbook 'uwsgi'
    mode '0600'
    source "ssl.key.erb"
    variables :key => application[:ssl_certificate_ca]
    notifies :restart, "service[nginx]"
    only_if do
      application[:ssl_support] && application[:ssl_certificate_ca]
    end
  end

  file "#{node[:uwsgi][:dir]}/sites-enabled/default" do
    action :delete
    only_if do
      File.exists?("#{node[:uwsgi][:dir]}/sites-enabled/default")
    end
  end

  if params[:enable]
    execute "nxensite #{application_name}" do
      command "/usr/sbin/nxensite #{application_name}"
      notifies :reload, "service[nginx]"
      not_if do File.symlink?("#{node[:uwsgi][:dir]}/sites-enabled/#{application_name}") end
    end
  else
    execute "nxdissite #{application_name}" do
      command "/usr/sbin/nxdissite #{application_name}"
      notifies :reload, "service[nginx]"
      only_if do File.symlink?("#{node[:uwsgi][:dir]}/sites-enabled/#{application_name}") end
    end
  end
end
