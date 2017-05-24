require 'English'

module Docker
  module Antivirus
    # Helpers Module
    module Helpers
      @eicar_test_string = 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'

      module_function

      def random_folder_name
        ('a'..'z').to_a.sample(12).join
      end

      def create_directory(directory)
        puts "Creating #{directory}"
        `mkdir -p /docker-antivirus/#{directory}`
      end

      def atomic_mount(image, directory)
        puts "Mounting #{image} in #{directory}"
        # `atomic mount #{image}`
      end

      def clamav_scan(image, directory)
        puts "Scanning #{image} in #{directory} with ClamAV"
        `clamscan -r --quiet /docker-antivirus/#{directory}`
        $CHILD_STATUS.exitstatus
      end

      def cleanup(directory)
        `rm -rf /docker-antivirus/#{directory}`
        puts "#{directory} cleaned up"
      end
    end
  end
end
