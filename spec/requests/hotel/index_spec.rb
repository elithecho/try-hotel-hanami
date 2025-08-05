RSpec.describe "GET /api/v1/hotels", type: :request do
  context "when there are hotels" do
    before do
      hotels = [
        {
          pub_id: "iJhz",
          destination_id: 5432,
          name: "Beach Villas Singapore",
          description: "This 5 star hotel is located on the coastline of Singapore.",
        },
        {
          pub_id: "aBcD",
          destination_id: 1234,
          name: "Mountain Retreat",
          description: "A serene getaway in the mountains.",
        }
      ]

      Hotebase::Repos::HotelRepo.new.upsert(hotels)
    end

    it "returns hotels array with size > 1" do
      get "/api/v1/hotels"

      expect(last_response).to have_http_status(:ok)
      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response["hotels"].size).to be > 1
    end
  end

  context "when there are no hotels" do
    it "returns empty hotels array" do
      get "/api/v1/hotels"

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

