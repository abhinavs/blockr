RSpec.describe "`blocky activate` command", type: :cli do
  it "executes `blocky help activate` command successfully" do
    output = `blocky help activate`
    expected_output = <<-OUT
Usage:
  blocky activate

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
