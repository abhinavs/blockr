# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blockr
  module Commands
    class Activate < Blockr::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Activating focus mode..."
        manager = Blockr::Manager.new()
        manager.activate()
      end
    end
  end
end
