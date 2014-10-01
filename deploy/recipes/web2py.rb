include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|

  unless application.downcase.include? "web2py" do
    Chef::Log.debug("Skipping deploy::web2py for application #{application} as it is not a web2py app")
    next
  end

  Chef::Log.debug(">>>>>>>>>>>>>>>> Deploy application: #{application}")

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
end
