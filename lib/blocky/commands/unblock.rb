# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blocky
  module Commands
    class Unblock < Blocky::Command
      def initialize(websites, options)
        @websites = websites
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Unblocking websites..."
        manager = Blocky::Manager.new()
        manager.unblock(@websites)
      end
    end
  end
end
