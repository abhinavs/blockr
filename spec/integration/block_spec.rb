RSpec.describe "`blocky block` command", type: :cli do
  it "executes `blocky help block` command successfully" do
    output = `blocky help block`
    expected_output = <<-OUT
Usage:
  blocky block WEBSITES...

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
