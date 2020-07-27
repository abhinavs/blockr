require 'blockr/commands/unblock'

RSpec.describe Blockr::Commands::Unblock do
  it "executes `unblock` command successfully" do
    output = StringIO.new
    options = {}
    command = Blockr::Commands::Unblock.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
