service "uwsgi-emperor" do
  supports :status => false, :restart => true, :reload => false
  action :nothing
end