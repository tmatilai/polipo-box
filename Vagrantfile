IP  = ENV.fetch('IP', '192.168.33.200')
BOX = ENV.fetch('BOX', 'debian-7')

Vagrant.configure("2") do |config|
  config.vm.box      = BOX
  config.vm.hostname = 'proxy'

  config.vm.network :private_network, ip: IP

  # Disable default share
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Configure plugins
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # Disable the vagrant-proxyconf plugin, as the proxy might not
  # have been installed or configured yet.
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.enabled = false
  end

  # Install and configure polipo
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt'
    chef.add_recipe 'polipo_appliance'

    chef.json = {
      polipo_appliance: {
        allowed_clients: "0.0.0.0/0"
      }
    }
  end
end
