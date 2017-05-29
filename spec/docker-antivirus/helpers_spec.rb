require 'spec_helper'

RSpec.describe Docker::Antivirus::Helpers do
  context 'Helpers' do
    it 'creates a folder' do
      directory = subject.create_directory
      expect(File.directory?("/tmp/docker-antivirus/#{directory}")).to be true
      `rm -rf /tmp/docker-antivirus/rspec`
    end

    it 'should delete the random directory' do
      directory = subject.create_directory
      subject.cleanup(directory)
      expect(File.directory?(directory)).to be false
    end
  end
end
