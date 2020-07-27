RSpec.describe "`blockr deactivate` command", type: :cli do
  it "executes `blockr help deactivate` command successfully" do
    output = `blockr help deactivate`
    expected_output = <<-OUT
Usage:
  blockr deactivate

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
