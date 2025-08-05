# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  it "is not found" do
    get "/"

    # Generate new action via:
    #   `bundle exec hanami generate action home.index --url=/`
    expect(last_response.status).to be(200)

    json_response = JSON.parse(last_response.body)
    expect(json_response).to eq({ "ok" => true })
  end
end
