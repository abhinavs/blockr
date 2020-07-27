require 'blocky/commands/unblock'

RSpec.describe Blocky::Commands::Unblock do
  it "executes `unblock` command successfully" do
    output = StringIO.new
    options = {}
    command = Blocky::Commands::Unblock.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
