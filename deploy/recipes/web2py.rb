include_recipe 'deploy'
include_recipe "nginx::service"

node[:opsworks][:applications].each do |app|

  Chef::Log.info ">>>>>>>>> #{app}"

  if !app[:name].downcase.include? "web2py"
    Chef::Log.info "Skipping deploy::web2py for application #{app[:name]} as it is not a web2py app"
    next
  end

  application = app[:slug_name]
  deploy = node[:deploy][application]


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
end
