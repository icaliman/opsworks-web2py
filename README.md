# opsworks-web2py

## Requirements:

1. Because OpsWorks doesn't have web2py application type the application you wont to deploy must contain "web2py" in name

2. Add these recipes in "Custom Chef Recipes" of your layer:

| Stage  | Recipies |
| ------------- | ------------- |
| Setup  | nginx, uwsgi |
| Deploy | deploy::web2py |