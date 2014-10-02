###
# Do not use this file to override the uwsgi cookbook's default
# attributes.  Instead, please use the customize.rb attributes file,
# which will keep your adjustments separate from this code and make it easier to upgrade.
#
# However, you should not edit customize.rb directly. Instead, create
# "uwsgi/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
#
# Do NOT create an 'uwsgi/attributes/uwsgi.rb' in your cookbooks. Doing so
# would completely override this file and might cause upgrade issues.
#
# See also: http://docs.aws.amazon.com/opsworks/latest/userguide/customizing.html
###


default[:uwsgi][:dir]           = "/etc/uwsgi"
default[:uwsgi][:log_dir]       = "/var/log/uwsgi"
default[:uwsgi][:user]          = "www-data"
default[:uwsgi][:group]         = "www-data"


default[:uwsgi][:processes]     = 4
default[:uwsgi][:max_requests]  = 2000


# case node[:platform_family]
#   when "debian"
#   when "rhel"
# end