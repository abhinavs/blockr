require 'blocky/commands/activate'

RSpec.describe Blocky::Commands::Activate do
  it "executes `activate` command successfully" do
    output = StringIO.new
    options = {}
    command = Blocky::Commands::Activate.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
