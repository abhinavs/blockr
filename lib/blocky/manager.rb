require 'tty-file'
require 'tty-command'
require 'tempfile'

module Blocky

  class Manager
    HOSTS_FILE = "/etc/hosts"

    KEY_STATUS = "status"
    KEY_NON_BLOCKY_LINES = "non_blocky_lines"
    KEY_BLOCKY_HOSTNAMES = "blocked_hostnames"

    FILE_EDITED_BY_BLOCKY_HEADER = "# NOTE: following entries were added by blocky, please DON'T manually edit this or any of the following lines  ; "
    ACTIVATED = "activated"
    DEACTIVATED = "deactivated"

    LINE_EDITED_BY_BLOCKY = "# XXX: added by blocky ;"
    DISABLED_BLOCKY_LINE_PREFIX = "#  "
    DUMMY_IP = "127.0.0.1"

    # for testing
    attr_reader :parsed_data

    def initialize
      @parsed_data = parse_file(HOSTS_FILE)
    end

    def block(hostnames)
      return if blank?(hostnames) 

      hostnames.each do |h|
        @parsed_data[KEY_BLOCKY_HOSTNAMES].push(h) if !blank?(h)
      end
      serialize()
    end

    def unblock(hostnames)
      return if blank?(hostnames)

      @parsed_data[KEY_BLOCKY_HOSTNAMES].reject! { |h| hostnames.include?(h)}
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
      line.include?(FILE_EDITED_BY_BLOCKY_HEADER)
    end

    def get_status(header_line)
      matched = header_line.match(/#{FILE_EDITED_BY_BLOCKY_HEADER}#{KEY_STATUS}:(?<status>\w+)/)
      matched['status'] == ACTIVATED ? ACTIVATED : DEACTIVATED
    end

    def line_edited_by_blocky?(line)
      line.include?(LINE_EDITED_BY_BLOCKY)
    end

    def blank?(str)
      str.nil? || str.empty?
    end

    def parse_file(filename)
      lines = read_file(filename)
      puts lines.inspect
      parse(lines)
    end

    def parse(lines)
      parsed_data = {
        KEY_STATUS => DEACTIVATED,
        KEY_NON_BLOCKY_LINES => [],
        KEY_BLOCKY_HOSTNAMES => []
      }

      parsed_data[KEY_NON_BLOCKY_LINES] = lines.select do |line|
        !header_line?(line) && !line_edited_by_blocky?(line)
      end

      header_line, _ = lines.select { |line| header_line?(line) }
      if !blank?(header_line)
        parsed_data[KEY_STATUS] = get_status(header_line)
      end

      blocky_lines = lines.select do |line|
        !blank?(line) && !header_line?(line) && line_edited_by_blocky?(line)
      end

      parsed_data[KEY_BLOCKY_HOSTNAMES] = blocky_lines.map do |line|
        line.sub!(DISABLED_BLOCKY_LINE_PREFIX, '')
        line.sub!(LINE_EDITED_BY_BLOCKY, '')
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

      serialized_output = @parsed_data[KEY_NON_BLOCKY_LINES].map { |line| line }

      blocky_line_prefix = @parsed_data[KEY_STATUS] == DEACTIVATED ? DISABLED_BLOCKY_LINE_PREFIX : ""

      serialized_output.push("#{FILE_EDITED_BY_BLOCKY_HEADER}#{KEY_STATUS}:#{@parsed_data[KEY_STATUS]}")

      serialized_output = serialized_output + @parsed_data[KEY_BLOCKY_HOSTNAMES].map do |hostname|
        "#{blocky_line_prefix}#{DUMMY_IP} #{hostname} #{LINE_EDITED_BY_BLOCKY}"
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
        cmd.run("sudo dscacheutil -flushcache")
      rescue
        $stderr.puts "Couldn't clear the cache, please clear cache manually."
        $strderr.puts "See https://abhinav.co/clear-dns-cache.html to findout command for your operating system"
      end
    end

  end
end
