RSpec.describe "`blockr activate` command", type: :cli do
  it "executes `blockr help activate` command successfully" do
    output = `blockr help activate`
    expected_output = <<-OUT
Usage:
  blockr activate

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
