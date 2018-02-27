require "spec_helper"

RSpec.describe GitlabStatus do

  it "has a version number" do
    expect(GitlabStatus::VERSION).not_to be(nil)
  end

end

RSpec.describe GitlabStatus::Probe do

  before(:all) do
    @probe = GitlabStatus::Probe.new('https://www.gitlab.com', 10, 6)
  end

  it "returns correct site status" do
    expect(@probe.get_site_status(0)).to eq('DOWN')
    expect(@probe.get_site_status(5)).to eq('FLAKY')
    expect(@probe.get_site_status(6)).to eq('ACTIVE')
  end

  it "returns a response time" do
    expect(@probe.make_request).not_to be(nil)
    expect(@probe.make_verbose_request).not_to be(nil)
  end

  it "probe returns correct response without verbose" do
    @probe.stub(:make_request) { 2 }

    probe_result = @probe.start_probing
    expect(probe_result[:average_time]).to eq(2)
    expect(probe_result[:site_status]).to eq('ACTIVE')
  end

  it "probe returns correct response with verbose" do
    ARGV = ["-v"]
    @probe = GitlabStatus::Probe.new('https://www.gitlab.com', 10, 6)
    @probe.stub(:make_verbose_request) { 1 }

    probe_result = @probe.start_probing
    expect(probe_result[:average_time]).to eq(1)
    expect(probe_result[:site_status]).to eq('ACTIVE')
  end

end
