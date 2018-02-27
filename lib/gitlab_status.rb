require "gitlab_status/version"
require "gitlab_status/cli_parser"
require "benchmark"
require "httpclient"

module GitlabStatus

  class Probe

    # ==== Params
    # +site_url+ - Site to probe
    # +probe_interval+ - Time between each probe request
    # +total_probe_time+ - Total number of times to probe the site
    def initialize(site_url, probe_interval, total_probe_time)
      # pass the arguments passed via CLI to Cliparser
      parsed_args = GitlabStatus::CliParser.parse(ARGV)
      @verbose = parsed_args[:verbose]
      @probe_interval = probe_interval
      @site_url = site_url
      @total_probe_time = total_probe_time
    end

    def start
      puts "Probe started"
      probe_result = start_probing

      puts "Site status: #{probe_result[:site_status]}"
      puts "Average response time: #{probe_result[:average_time]}" unless probe_result[:average_time].nil?
    end

    def start_probing
      probe_times = []

      @total_probe_time.times do |index|
        time_taken = @verbose ? make_verbose_request : make_request
        probe_times.push(time_taken)
        sleep @probe_interval if index < 5
      end

      probe_result = {}
      probe_result[:site_status] = get_site_status(probe_times.size)

      if probe_times.size > 0
        average_time = probe_times.reduce(:+).to_f / probe_times.size
        probe_result[:average_time] = average_time
      end

      probe_result
    end

    def get_site_status(successful_probe_count)
      case successful_probe_count
      when 0
        'DOWN'
      when 6
        'ACTIVE'
      else
        'FLAKY'
      end
    end

    def make_verbose_request
      puts "Making request"
      time_taken = make_request
      puts "Request took: #{time_taken} seconds"
      time_taken
    end

    def make_request
      begin
        time = Benchmark.measure do
          http_client.get(@site_url)
        end
        time.total
      rescue Exception => e
        puts e
        puts 'Request failed'
      end
    end

    private

    def http_client
      @http_client = @http_client || HTTPClient.new
      # We will be probing every 10s, so set the timeout at 9 seconds
      @http_client.receive_timeout = 9
      @http_client
    end

  end

end
