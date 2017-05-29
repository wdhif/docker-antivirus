require 'thor'
require 'fileutils'

require 'docker/antivirus/helpers'

module Docker
  module Antivirus
    # Cli Class, used to define user interactions
    class Cli < Thor
      desc 'scan', 'Scan a docker image'

      method_option :image, required: true, aliases: '-i'

      def scan
        directory = Docker::Antivirus::Helpers.create_directory
        Docker::Antivirus::Helpers.atomic_mount(options[:image], directory)
        exit_status = Docker::Antivirus::Helpers.clamav_scan(options[:image], directory)
        Docker::Antivirus::Helpers.cleanup(directory)
        if exit_status.zero?
          puts "\e[32mNo virus detected\e[0m"
          exit 0
        else
          puts "\e[31m!!! Virus detected !!!\e[0m"
          exit 1
        end
      end

      desc 'cleanup', 'Cleanup all folders'

      def cleanup
        `rm -rf /tmp/docker-antivirus/*`
        puts 'All folders cleaned up'
      end
    end
  end
end
