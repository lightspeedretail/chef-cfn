# Description

Provide tools to aid in the integration of Chef with AWS Cloudformation.

# Requirements

## Cookbooks:

* chef_handler
* ohai

# Attributes

* `node['cfn']['stack']['autoscaling_name']` - Name of the autoscaling group that spawn the instance. Defaults to `ohai`.
* `node['cfn']['stack']['logical_id']` - Cloudformation stack logical id. Defaults to `ohai`.
* `node['cfn']['stack']['stack_id']` - Cloudformation stack id. Defaults to `ohai`.
* `node['cfn']['stack']['stack_name']` - Cloudformation stack name. Defaults to `ohai`.
* `node['cfn']['tools']['delete_on_shutdown']` - Delete the chef node on instance shutdown. Defaults to `true`.
* `node['cfn']['tools']['cfn_hup']['interval']` - cfn-hup will scan for metadata changes every N seconds. Defaults to `10`.
* `node['cfn']['tools']['cfn_hup']['verbose']` - Should cfn-hup provide verbose output. Defaults to `false`.
* `node['cfn']['tools']['url']` - Tarball url for cfn-init installation. Defaults to ``.
* `node['cfn']['vpc']['region_id']` - Aws region the instance belongs to. Defaults to `ohai`.
* `node['cfn']['vpc']['subnet_id']` - Aws subnet the instance belongs to. Defaults to `ohai`.
* `node['cfn']['vpc']['vpc_id']` - Aws vpc the instance belongs to. Defaults to `ohai`.

# Recipes

* chef_cfn::default - Installs dependencies
* chef_cfn::knife - (optional) Provides a basic knife.rb
* chef_cfn::ohai - Installs the ohai[cfn] plugin
* chef_cfn::handler - Installs a handler to signal cloudformation
* chef_cfn::mounts - Mounts cloudformation defined volumes
* chef_cfn::tools - Installs cloudformation cfn-init tools
* chef_cfn::shutdown - Installs a service which will delete the node

# Resources

* [chef_cfn_signal](#chef_cfn_signal)

## chef_cfn_signal

Provides an interface to trigger cloudformation signals from within recipes. 

### Actions

- signal:  Default action.

### Attribute Parameters

- url:
- unique_id:
- data:  Defaults to <code>""</code>.
- success:  Defaults to <code>true</code>.
- reason:  Defaults to <code>"Chef triggered signal from resource"</code>.
- once:  Defaults to <code>true</code>.

# Ohai

* [ohai_cfn](#ohai_cfn)

## ohai_cfn

Fetches instance attributes from Cloudformation:DescribeResource as well as EC2:DescribeInstances. 

### Required IAM Permissions

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1434370036000",
            "Effect": "Allow",
            "Action": [
                "cloudformation:DescribeStackResource",
                "ec2:DescribeInstances"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

# License and Maintainer

Maintainer:: Jonathan Serafini (<jonathan@serafini.ca>)

License:: Apache 2.0
