require 'spec_helper'

RSpec.describe Docker::Antivirus::Helpers, integration: true do
  context 'Helper Integration' do
    it 'does not detect viruses if not present' do
      image = 'rspec_image'
      directory = subject.create_directory
      expect(subject.clamav_scan(image, directory)).to eq(0)
      `rm -rf /tmp/docker-antivirus/#{directory}`
    end

    it 'detect viruses if present' do
      image = 'rspec_image'
      eicar_test_string = 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
      directory = subject.create_directory
      eicar_test_file = File.new("/tmp/docker-antivirus/#{directory}/eicar_test_file", 'w')
      eicar_test_file.puts(eicar_test_string)
      eicar_test_file.close
      expect(subject.clamav_scan(image, directory)).to eq(1)
      `rm -rf /tmp/docker-antivirus/#{directory}`
    end
  end
end
