require 'tty-file'
require 'tty-command'
require 'tempfile'

module Blockr

  class Manager
    HOSTS_FILE = "/etc/hosts"

    KEY_STATUS = "status"
    KEY_NON_BLOCKR_LINES = "non_blockr_lines"
    KEY_BLOCKR_HOSTNAMES = "blocked_hostnames"

    FILE_EDITED_BY_BLOCKR_HEADER = "# NOTE: following entries were added by blockr, please DON'T manually edit this or any of the following lines  ; "
    ACTIVATED = "activated"
    DEACTIVATED = "deactivated"

    LINE_EDITED_BY_BLOCKR = "# XXX: added by blockr ;"
    DISABLED_BLOCKR_LINE_PREFIX = "#  "
    DUMMY_IP = "127.0.0.1"

    # for testing
    attr_reader :parsed_data

    def initialize
      @parsed_data = parse_file(HOSTS_FILE)
    end

    def block(hostnames)
      return if blank?(hostnames)

      hostnames.each do |h|
        @parsed_data[KEY_BLOCKR_HOSTNAMES].push(h) if !blank?(h)
      end
      serialize()
    end

    def unblock(hostnames)
      return if blank?(hostnames)

      @parsed_data[KEY_BLOCKR_HOSTNAMES].reject! { |h| hostnames.include?(h)}
      serialize()
    end

    def activate()
      enable()
      serialize()
    end

    def deactivate()
      disable()
      serialize()
    end

    private

    def read_file(filename)
      File.readlines(filename).map(&:chomp)
    end

    def header_line?(line)
      line.include?(FILE_EDITED_BY_BLOCKR_HEADER)
    end

    def get_status(header_line)
      matched = header_line.match(/#{FILE_EDITED_BY_BLOCKR_HEADER}#{KEY_STATUS}:(?<status>\w+)/)
      matched['status'] == ACTIVATED ? ACTIVATED : DEACTIVATED
    end

    def line_edited_by_blockr?(line)
      line.include?(LINE_EDITED_BY_BLOCKR)
    end

    def blank?(str)
      str.nil? || str.empty?
    end

    def parse_file(filename)
      lines = read_file(filename)
      parse(lines)
    end

    def parse(lines)
      parsed_data = {
        KEY_STATUS => ACTIVATED,
        KEY_NON_BLOCKR_LINES => [],
        KEY_BLOCKR_HOSTNAMES => []
      }

      parsed_data[KEY_NON_BLOCKR_LINES] = lines.select do |line|
        !header_line?(line) && !line_edited_by_blockr?(line)
      end

      header_line, _ = lines.select { |line| header_line?(line) }
      if !blank?(header_line)
        parsed_data[KEY_STATUS] = get_status(header_line)
      end

      blockr_lines = lines.select do |line|
        !blank?(line) && !header_line?(line) && line_edited_by_blockr?(line)
      end

      parsed_data[KEY_BLOCKR_HOSTNAMES] = blockr_lines.map do |line|
        line.sub!(DISABLED_BLOCKR_LINE_PREFIX, '')
        line.sub!(LINE_EDITED_BY_BLOCKR, '')
        words = line.split(' ')
        _ip_address, hostname = words.select { |word| !blank?(word) }
        hostname
      end

      parsed_data
    end

    def disable()
      @parsed_data[KEY_STATUS] = DEACTIVATED
    end

    def enable()
      @parsed_data[KEY_STATUS] = ACTIVATED
    end

    def serialize()

      serialized_output = @parsed_data[KEY_NON_BLOCKR_LINES].map { |line| line }

      blockr_line_prefix = @parsed_data[KEY_STATUS] == DEACTIVATED ? DISABLED_BLOCKR_LINE_PREFIX : ""

      serialized_output.push("#{FILE_EDITED_BY_BLOCKR_HEADER}#{KEY_STATUS}:#{@parsed_data[KEY_STATUS]}")

      # uniq
      @parsed_data[KEY_BLOCKR_HOSTNAMES].uniq!

      serialized_output = serialized_output + @parsed_data[KEY_BLOCKR_HOSTNAMES].map do |hostname|
        "#{blockr_line_prefix}#{DUMMY_IP} #{hostname} #{LINE_EDITED_BY_BLOCKR}"
      end

      if(write_file(serialized_output))
        clear_cache()
      end
    end

    def write_file(serialized_output)
      begin
        TTY::File.create_file HOSTS_FILE, serialized_output.join("\n")
      rescue
        $stderr.puts "Error in writing file, please try using sudo"
        return false
      end
      return true
    end

    def clear_cache
      begin
        cmd = TTY::Command.new
        $stdout.puts "Clearing DNS cache"

        # XXX mac specific
        out, _ = cmd.run("sudo killall -HUP mDNSResponder", only_output_on_error: true)
        $stdout.puts out
      rescue
        $stderr.puts "Couldn't clear the cache, please clear cache manually."
        $stderr.puts "See https://www.abhinav.co/clear-dns-cache.html to findout command for your operating system"
      end
    end

  end
end
