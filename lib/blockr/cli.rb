# frozen_string_literal: true

require 'thor'

module Blockr
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'blockr version'
    def version
      require_relative 'version'
      puts "v#{Blockr::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'deactivate', 'deactivate focus mode, make all blocked websites accessible; shortcut -d'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def deactivate(*)
      if options[:help]
        invoke :help, ['deactivate']
      else
        require_relative 'commands/deactivate'
        Blockr::Commands::Deactivate.new(options).execute
      end
    end
    map %w(--deactivate -d) => :deactivate

    desc 'activate', 'activate blockr, make all websites blocked by blockr inaccessible; shortcut -a'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def activate(*)
      if options[:help]
        invoke :help, ['activate']
      else
        require_relative 'commands/activate'
        Blockr::Commands::Activate.new(options).execute
      end
    end
    map %w(--activate -a) => :activate

    desc 'unblock [WEBSITES]', 'unblock websites; shortcut -u'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def unblock(*websites)
      if options[:help]
        invoke :help, ['unblock']
      else
        require_relative 'commands/unblock'
        Blockr::Commands::Unblock.new(websites, options).execute
      end
    end
    map %w(--unblock -u) => :unblock

    desc 'block [WEBSITES]', 'block websites; shortcut -d'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def block(*websites)
      if options[:help]
        invoke :help, ['block']
      else
        require_relative 'commands/block'
        Blockr::Commands::Block.new(websites, options).execute
      end
    end
    map %w(--block -b) => :block
  end
end
