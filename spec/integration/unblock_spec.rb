RSpec.describe "`blocky unblock` command", type: :cli do
  it "executes `blocky help unblock` command successfully" do
    output = `blocky help unblock`
    expected_output = <<-OUT
Usage:
  blocky unblock

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
