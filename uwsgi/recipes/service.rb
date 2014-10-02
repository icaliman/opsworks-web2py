service "uwsgi" do
  supports :status => true, :restart => true, :reload => false
  action :nothing
end