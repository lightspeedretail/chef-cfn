# Install aws-cfn-bootstrap which will provide
# - cfn-init    : cloudformation node init
# - cfn-hup     : cloudformation monitor and event trigger
# - cfn-signal  : cloudformation send signals for Policy
# - cfn-get-metadata
#
python_execute "-m pip install #{node['cfn']['tools']['url']}"

# Create cfn-hup configurations
#
directory '/etc/cfn/hooks.d' do
  recursive true
  mode '0700'
end

template '/etc/cfn/cfn-hup.conf' do
  variables lazy {
    {
      stack:    node['cfn']['stack']['stack_name'],
      region:   node['cfn']['vpc']['region_id'],
      interval: node['cfn']['tools']['cfn_hup']['interval'],
      verbose:  node['cfn']['tools']['cfn_hup']['verbose']
    }
  }
  only_if do
    node['cfn']['stack']['stack_name'] rescue false
  end
end

# Create hook to execute action on metadata change
#
template '/etc/cfn/hooks.d/cfn-auto-reloader.conf' do
  source 'hooks.d/cfn_auto_reloader.conf.erb'
  variables lazy {
    {
      stack:      node['cfn']['stack']['stack_name'],
      region:     node['cfn']['vpc']['region_id'],
      logical_id: node['cfn']['stack']['logical_id'],
      properties: node['cfn']['properties'],
      configsets: 'chef_exec'
    }
  }
  only_if do
    node['cfn']['stack']['stack_name'] rescue false
  end
end
