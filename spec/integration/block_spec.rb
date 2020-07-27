RSpec.describe "`blockr block` command", type: :cli do
  it "executes `blockr help block` command successfully" do
    output = `blockr help block`
    expected_output = <<-OUT
Usage:
  blockr block WEBSITES...

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
