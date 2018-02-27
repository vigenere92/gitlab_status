require "spec_helper"

RSpec.describe GitlabStatus::CliParser do

  it "returns hash with :verbose true for -v, --verbose" do
    expect(GitlabStatus::CliParser.parse(["-v"])).to eq({:verbose => true})
    expect(GitlabStatus::CliParser.parse(["--verbose"])).to eq({:verbose => true})
  end

  it "returns empty hash for -h, --help or other options" do
    expect(GitlabStatus::CliParser.parse(["-h"])).to eq({})
    expect(GitlabStatus::CliParser.parse(["--help"])).to eq({})
    expect(GitlabStatus::CliParser.parse([])).to eq({})
    expect(GitlabStatus::CliParser.parse(["randometext", "-tv"])).to eq({})
  end

end
