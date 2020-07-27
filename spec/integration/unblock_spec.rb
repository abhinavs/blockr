RSpec.describe "`blockr unblock` command", type: :cli do
  it "executes `blockr help unblock` command successfully" do
    output = `blockr help unblock`
    expected_output = <<-OUT
Usage:
  blockr unblock

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
