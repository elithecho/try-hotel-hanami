# frozen_string_literal: true

module FixtureHelpers
  def load_fixture(path)
    fixture_path = SPEC_ROOT.join("fixtures", path)
    JSON.parse(File.read(fixture_path))
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers
end