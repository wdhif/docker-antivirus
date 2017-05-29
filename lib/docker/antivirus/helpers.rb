require 'English'
require 'fileutils'

module Docker
  module Antivirus
    # Helpers Module
    module Helpers
      @docker_antivirus_directory = '/tmp/docker-antivirus'

      module_function

      def create_directory
        directory = ('a'..'z').to_a.sample(12).join
        puts "Creating #{@docker_antivirus_directory}/#{directory}"
        FileUtils.mkdir_p("#{@docker_antivirus_directory}/#{directory}")
        directory
      end

      def atomic_mount(image, directory)
        puts "Mounting #{image} in #{@docker_antivirus_directory}/#{directory}"
        `atomic mount #{image} #{@docker_antivirus_directory}/#{directory}`
      end

      def clamav_scan(image, directory)
        puts "Scanning #{image} in #{@docker_antivirus_directory}/#{directory} with ClamAV"
        `clamscan -r --quiet #{@docker_antivirus_directory}/#{directory}`
        $CHILD_STATUS.exitstatus
      end

      def cleanup(directory)
        `rm -rf #{@docker_antivirus_directory}#{directory}`
        puts "#{@docker_antivirus_directory}/#{directory} cleaned up"
      end
    end
  end
end
