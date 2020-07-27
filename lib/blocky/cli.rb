# frozen_string_literal: true

require 'thor'

module Blocky
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'blocky version'
    def version
      require_relative 'version'
      puts "v#{Blocky::VERSION}"
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
        Blocky::Commands::Deactivate.new(options).execute
      end
    end
    map %w(--deactivate -d) => :deactivate

    desc 'activate', 'activate blocky, make all websites blocked by blocky inaccessible; shortcut -a'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def activate(*)
      if options[:help]
        invoke :help, ['activate']
      else
        require_relative 'commands/activate'
        Blocky::Commands::Activate.new(options).execute
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
        Blocky::Commands::Unblock.new(websites, options).execute
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
        Blocky::Commands::Block.new(websites, options).execute
      end
    end
    map %w(--block -b) => :block
  end
end
