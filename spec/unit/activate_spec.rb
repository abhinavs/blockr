require 'blockr/commands/activate'

RSpec.describe Blockr::Commands::Activate do
  it "executes `activate` command successfully" do
    output = StringIO.new
    options = {}
    command = Blockr::Commands::Activate.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
