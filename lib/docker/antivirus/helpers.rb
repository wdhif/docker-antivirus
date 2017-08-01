require 'English'
require 'fileutils'

module Docker
  module Antivirus
    # Helpers Module
    module Helpers

      module_function

      def create_directory
        directory = Dir.mktmpdir(nil, "/tmp/docker-antivirus")
        puts "Creating #{directory}"
        return directory
      end

      def atomic_mount(image, directory)
        puts "Mounting #{image} in #{directory}"
        system("atomic mount #{image} #{directory}")
      end

      def clamav_scan(image, directory)
        puts "Scanning #{image} in #{directory} with ClamAV"
        system("clamscan -ri #{directory}")
      end

      def cleanup(directory, atomic = true)
        system("atomic umount #{directory}") if atomic
        FileUtils.rm_rf("#{directory}")
        puts "#{directory} cleaned up"
      end
    end
  end
end
