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
        return 0 unless $CHILD_STATUS.exitstatus != 0
        puts "\e[31matomic mount #{image} #{@docker_antivirus_directory}/#{directory} failed\e[0m"
        puts "\e[31m#{@docker_antivirus_directory}/#{directory} left for debugging\e[0m"
        exit 1
      end

      def clamav_scan(image, directory)
        puts "Scanning #{image} in #{@docker_antivirus_directory}/#{directory} with ClamAV"
        `clamscan -r --quiet #{@docker_antivirus_directory}/#{directory}`
        $CHILD_STATUS.exitstatus
      end

      def cleanup(directory)
        FileUtils.rm_rf("#{@docker_antivirus_directory}/#{directory}")
        puts "#{@docker_antivirus_directory}/#{directory} cleaned up"
      end
    end
  end
end
