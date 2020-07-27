# frozen_string_literal: true

require_relative '../command'
require_relative '../manager'

module Blockr
  module Commands
    class Block < Blockr::Command
      def initialize(websites, options)
        @websites = websites
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts "Blocking websites..."
        manager = Blockr::Manager.new()
        manager.block(@websites)
      end
    end
  end
end
