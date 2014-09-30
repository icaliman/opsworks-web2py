require 'minitest/spec'

describe_recipe 'web2py_nginx_uwsgi::uninstall' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

  it 'stops nginx' do
    service('nginx').wont_be_running
  end

  it 'uninstalls nginx' do
    package('nginx').wont_be_installed
  end
end
