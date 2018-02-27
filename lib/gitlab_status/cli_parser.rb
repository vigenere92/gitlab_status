module GitlabStatus
  require 'optparse'

  class CliParser

    # ==== Params
    # +args+ - Arguments to parse
    def self.parse(args)
      options = {}

      opts = OptionParser.new do |opts|
        opts.banner = <<-BANNER
        \n Ruby CLI app to report average response time for Gitlab\n
        BANNER

        opts.on('-v', '--verbose', 'Show detailed output') do
          options[:verbose] = true
        end

        opts.on('-h', '--help', 'Displays help') do
          puts opts
          exit
        end
      end

      opts.parse!(args)
      options
    end

  end

end
