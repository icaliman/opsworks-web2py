require 'minitest/spec'

describe_recipe 'web2py_nginx_uwsgi::service' do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions

end
