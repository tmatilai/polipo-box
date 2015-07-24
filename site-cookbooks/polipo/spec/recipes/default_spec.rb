require 'spec_helper'

describe 'polipo::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'debian', version: '8.0') do |node|
      node.set['polipo']['allowed_clients'] = '10.44.55.0/24'
      node.set['polipo']['proxy_address']   = '0.0.0.0'
    end.converge(described_recipe)
  end

  it 'installs polipo' do
    expect(chef_run).to install_package('polipo')
  end

  it 'configures polipo' do
    expect(chef_run).to render_file('/etc/polipo/config').with_content { |content|
      expect(content).to match(/^proxyAddress = 0\.0\.0\.0$/)
      expect(content).to match(%r{^allowedClients = 10\.44\.55\.0/24$})
    }
  end
end
