# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blockr
  module Commands
    class Deactivate < Blockr::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Deactivating focus mode..."
        manager = Blockr::Manager.new()
        manager.deactivate()
      end
    end
  end
end
