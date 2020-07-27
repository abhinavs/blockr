RSpec.describe "`blocky deactivate` command", type: :cli do
  it "executes `blocky help deactivate` command successfully" do
    output = `blocky help deactivate`
    expected_output = <<-OUT
Usage:
  blocky deactivate

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
