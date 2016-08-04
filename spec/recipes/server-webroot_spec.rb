describe 'certbot::server-webroots' do
  context 'with nginx in run_list' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['ruby_block']).converge('fake::configure-nginx')
    end

    it "will create a nginx configuration for certbot webroot plugin" do
      expect(chef_run).to create_template('/etc/nginx/certbot.conf')
    end
  end

  context 'with apache2 in run_list' do
    cached(:chef_run) do
      stub_command("/usr/sbin/apache2 -t")
      ChefSpec::SoloRunner.new(step_into: ['ruby_block']).converge('fake::configure-apache2')
    end

    it "will create a nginx configuration for certbot webroot plugin" do
      expect(chef_run).to create_template('/etc/apache2/certbot.conf')
    end
  end
end
