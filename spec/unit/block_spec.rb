require 'blockr/commands/block'

RSpec.describe Blockr::Commands::Block do
  it "executes `block` command successfully" do
    output = StringIO.new
    websites = nil
    options = {}
    command = Blockr::Commands::Block.new(websites, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
