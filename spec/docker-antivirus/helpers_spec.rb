require 'spec_helper'
require 'fileutils'
require 'fakefs/safe'

RSpec.describe Docker::Antivirus::Helpers do
  context 'Helpers' do
    it 'creates a folder' do
      FakeFS do
        FileUtils.mkdir_p("/tmp/docker-antivirus")
        directory = subject.create_directory
        expect(File.directory?(directory)).to be true
      end
    end

    it 'should delete the random directory' do
      FakeFS do
        FileUtils.mkdir_p("/tmp/docker-antivirus")
        directory = subject.create_directory
        subject.cleanup(directory, false)
        expect(File.directory?(directory)).to be false
      end
    end
  end
end
