# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blocky
  module Commands
    class Activate < Blocky::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Activating focus mode..."
        manager = Blocky::Manager.new()
        manager.activate()
      end
    end
  end
end
