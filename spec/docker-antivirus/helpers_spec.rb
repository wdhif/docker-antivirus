require 'spec_helper'

RSpec.describe Docker::Antivirus::Helpers do
  context 'Helpers' do
    it 'chooses a random name' do
      puts subject.random_folder_name
      expect(subject.random_folder_name).not_to be nil
    end

    it 'creates a folder' do
      directory = 'rspec'
      subject.create_directory(directory)
      expect(File.directory?("/tmp/docker-antivirus/#{directory}")).to be true
      `rm -rf /tmp/docker-antivirus/rspec`
    end

    it 'should delete the random directory' do
      directory = 'rspec'
      subject.create_directory(directory)
      subject.cleanup(directory)
      expect(File.directory?(directory)).to be false
    end
  end

  context 'Antivirus' do
    it 'does not detect viruses if not present' do
      image = 'rspec_image'
      directory = 'rspec'
      subject.create_directory(directory)
      expect(subject.clamav_scan(image, directory)).to eq(0)
      `rm -rf /tmp/docker-antivirus/#{directory}`
    end

    it 'detect viruses if present' do
      image = 'rspec_image'
      directory = 'rspec'
      eicar_test_string = 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
      subject.create_directory(directory)
      eicar_test_file = File.new("/tmp/docker-antivirus/#{directory}/eicar_test_file", 'w')
      eicar_test_file.puts(eicar_test_string)
      eicar_test_file.close
      expect(subject.clamav_scan(image, directory)).to eq(1)
      `rm -rf /tmp/docker-antivirus/#{directory}`
    end
  end
end
