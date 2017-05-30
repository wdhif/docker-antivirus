require 'spec_helper'

RSpec.describe Docker::Antivirus::Helpers, integration: true do
  context 'Helper Integration' do
    it 'does not detect viruses if not present' do
      `docker pull busybox`
      image = 'busybox'
      directory = subject.create_directory
      subject.atomic_mount(image, directory)
      expect(subject.clamav_scan(image, directory)).to eq(0)
      subject.cleanup(directory)
    end

    it 'detect viruses if present' do
      `docker pull wdhif/docker-eicar`
      image = 'wdhif/docker-eicar'
      directory = subject.create_directory
      subject.atomic_mount(image, directory)
      expect(subject.clamav_scan(image, directory)).to eq(1)
      subject.cleanup(directory)
    end
  end
end
