# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blocky
  module Commands
    class Deactivate < Blocky::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Deactivating focus mode..."
        manager = Blocky::Manager.new()
        manager.deactivate()
        sudo dscacheutil -flushcache
      end
    end
  end
end
