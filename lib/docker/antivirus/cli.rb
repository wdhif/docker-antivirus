require 'thor'
require 'fileutils'

require 'docker/antivirus/helpers'

module Docker
  module Antivirus
    # Cli Class, used to define user interactions
    class Cli < Thor
      desc 'scan', 'Scan a docker image'

      method_option :image, required: true, aliases: '-i'
      method_option :pull, required: false, aliases: '-p'

      def scan
        if options[:pull]
          puts "Pulling #{options[:image]}"
          system("docker pull #{options[:image]}")
        end
        begin
          directory = Docker::Antivirus::Helpers.create_directory
          Docker::Antivirus::Helpers.atomic_mount(options[:image], directory)
          result = Docker::Antivirus::Helpers.clamav_scan(options[:image], directory)
        ensure
          Docker::Antivirus::Helpers.cleanup(directory)
        end
        if result
          puts "\e[32mNo virus detected in #{options[:image]}\e[0m"
          exit 0
        else
          puts "\e[31mVirus detected in #{options[:image]}\e[0m"
          exit 1
        end
      end

      desc 'cleanup', 'Cleanup all folders'

      def cleanup
        FileUtils.rm_rf('/tmp/docker-antivirus/*')
        puts 'All folders cleaned up'
      end
    end
  end
end
