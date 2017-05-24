module Docker
  module Antivirus
    # Cli Class, used to define user interactions
    class Cli < Thor
      desc 'scan', 'Scan a docker image'

      method_option :image, required: true, aliases: '-i'

      def call
        directory = random_folder_name
        puts directory
        create_random_directory(directory)
        sleep 1
        cleanup(directory)
      end

      def random_folder_name
        ('a'..'z').to_a.sample(12).join
      end

      def create_random_directory(directory)
        `mkdir -p /docker-antivirus/#{directory}`
      end

      def cleanup(directory)
        `rm -rf /docker-antivirus/#{directory}`
      end

      def atomic_mount
        `atomic mount #{image}`
      end
    end
  end
end
