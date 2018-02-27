require "spec_helper"

RSpec.describe GitlabStatus::CliParser do

  it "exits for -h, --help" do
    expect {GitlabStatus::CliParser.parse(["-h"])}.to raise_error(SystemExit)
    expect {GitlabStatus::CliParser.parse(["--help"])}.to raise_error(SystemExit)
  end

  it "returns hash with :verbose true for -v, --verbose" do
    expect(GitlabStatus::CliParser.parse(["-v"])).to eq({:verbose => true})
    expect(GitlabStatus::CliParser.parse(["--verbose"])).to eq({:verbose => true})
  end

  it "raise error on invalid options" do
    expect{GitlabStatus::CliParser.parse(["-tv"])}.to raise_error
  end

  it "returns empty hash for other options" do
    expect(GitlabStatus::CliParser.parse([])).to eq({})
    expect(GitlabStatus::CliParser.parse(["randometext"])).to eq({})
  end

end
