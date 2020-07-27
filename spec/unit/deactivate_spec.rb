require 'blocky/commands/deactivate'

RSpec.describe Blocky::Commands::Deactivate do
  it "executes `deactivate` command successfully" do
    output = StringIO.new
    options = {}
    command = Blocky::Commands::Deactivate.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
