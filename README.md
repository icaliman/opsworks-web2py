# opsworks-web2py

## Requirements:

1. The git repository with your app must contain all web2py source code.

2. Because OpsWorks doesn't have web2py application type the application you want to deploy must contain "web2py" in name

3. Add these recipes in "Custom Chef Recipes" of your layer:

| Stage  | Recipies |
| ------------- | ------------- |
| Setup  | nginx, uwsgi |
| Deploy | deploy::web2py |


## Setting admin password (optional)

1. Set environment variable <b>ADMIN_PASSWORD</b> with password in OpsWorks admin interface

2. Create file <b>before_symlink.rb</b> in the <b>deploy</b> directory of your project with this content:

```ruby
if new_resource.environment["ADMIN_PASSWORD"]
    execute "Save web2py admin password" do
        cwd release_path
        command "sudo -u #{new_resource.user} python -c \"from gluon.main import save_password; save_password('#{new_resource.environment["ADMIN_PASSWORD"]}',443)\""
    end
end
```
