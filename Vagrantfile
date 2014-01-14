IP  = ENV.fetch('IP', '192.168.33.200')
BOX = ENV.fetch('BOX', 'debian-7')

Vagrant.configure("2") do |config|
  config.vm.box      = BOX
  config.vm.hostname = 'proxy'

  config.vm.network :private_network, ip: IP

  # Disable default share
  config.vm.synced_folder '.', '/vagrant', id: 'vagrant-root', disabled: true

  # Configure plugins
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # Override global vagrant-proxyconf settings.
  # Do not configure this VM to use the proxy as it might not been
  # installed or configured yet.
  %w[
    VAGRANT_HTTP_PROXY VAGRANT_HTTPS_PROXY
    VAGRANT_ENV_HTTP_PROXY VAGRANT_ENV_HTTPS_PROXY
    VAGRANT_APT_HTTP_PROXY VAGRANT_APT_HTTPS_PROXY
  ].each { |var| ENV[var] = '' }

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
