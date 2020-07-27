require 'blockr/commands/deactivate'

RSpec.describe Blockr::Commands::Deactivate do
  it "executes `deactivate` command successfully" do
    output = StringIO.new
    options = {}
    command = Blockr::Commands::Deactivate.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
