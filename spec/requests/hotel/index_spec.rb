RSpec.describe "GET /api/hotels", type: :request do
  context "when there are hotels" do
    it "returns hotels array with size > 1" do
      get "/api/hotels"

      expect(last_response).to have_http_status(:ok)
      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response["hotels"].size).to be > 1
    end
  end

  context "when there are no hotels" do
    it "returns empty hotels array" do
      get "/api/hotels"

      expect(last_response).to have_http_status(:ok)
      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response["hotels"]).to eq([])
    end
  end

  context "when filtering by destination id" do

  end

  context "when filtering by hotel id"
end

