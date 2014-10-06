# opsworks-web2py

## Requirements:

1. Because OpsWorks doesn't have web2py application type the application you want to deploy must contain "web2py" in name

2. Add these recipes in "Custom Chef Recipes" of your layer:

| Stage  | Recipies |
| ------------- | ------------- |
| Setup  | nginx, uwsgi |
| Deploy | deploy::web2py |


## Setting admin password (optional)

1. Set environment variable ADMIN_PASSWORD with password on OpsWorks admin interface

2. Create file <i><b>deploy/before_symlink.rb</b></i> in root directory of your project with this content:

```ruby
if new_resource.environment["ADMIN_PASSWORD"]
    execute "Save web2py admin password" do
        cwd release_path
        command "sudo -u #{new_resource.user} python -c \"from gluon.main import save_password; save_password('#{new_resource.environment["ADMIN_PASSWORD"]}',443)\""
    end
end
```
