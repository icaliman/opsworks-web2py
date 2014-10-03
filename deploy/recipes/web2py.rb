include_recipe 'deploy'
include_recipe 'nginx::service'
include_recipe 'uwsgi::service'

require 'fileutils'

node[:opsworks][:applications].each do |app|
  application = app[:slug_name]
  deploy = node[:deploy][application]

  if !app[:name].downcase.include? "web2py"
    Chef::Log.info ">>>>>>>> Skipping deploy::web2py for application #{application} as it is not a web2py app"
    next
  end

  Chef::Log.info ">>>>>>>>>>>>>>>> Deploy application: #{application}"

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    app application
    deploy_data deploy
  end

  nginx_web_app application do
    application deploy
    cookbook "nginx"
  end

  directory "#{deploy[:deploy_to]}" do
    group node[:uwsgi][:group]
    owner node[:uwsgi][:user]
    mode "0775"
    action :nothing
    recursive true
  end

  # wsgihandler.py must be moved manually to root dir of web2py
  # TODO: move file here
  # if File.exists?("#{deploy[:current_path]}/handlers/wsgihandler.py")
  #   FileUtils.cp("#{deploy[:current_path]}/handlers/wsgihandler.py",
  #                "#{deploy[:current_path]}/wsgihandler.py")
  # end

  uwsgi_web_app application do
    application deploy
    cookbook "uwsgi"
  end
end
