IP  = ENV.fetch('IP', '192.168.33.200')
BOX = ENV.fetch('BOX', 'chef/debian-7.6')

Vagrant.configure("2") do |config|
  config.vm.box      = BOX
  config.vm.hostname = 'proxy'

  config.vm.network :private_network, ip: IP

  # Disable default share
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Configure plugins
  config.omnibus.chef_version = :latest

  # Disable the vagrant-proxyconf plugin, as the proxy might not
  # have been installed or configured yet.
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.enabled = false
  end

  # Update apt cache
  config.vm.provision :shell, inline: 'apt-get update'

  # Install and configure polipo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['site-cookbooks']
    chef.add_recipe 'polipo'

    chef.json = {
      polipo: {
        allowed_clients: '0.0.0.0/0',
        proxy_address: '::0'
      }
    }
  end
end
