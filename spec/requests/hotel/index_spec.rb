RSpec.describe "GET /api/v1/hotels", type: :request do
  context "when there are hotels" do
    before do
      hotels = [
        {
          pub_id: "iJhz",
          destination_id: 5432,
          name: "Beach Villas Singapore",
          description: "This 5 star hotel is located on the coastline of Singapore.",
          location_data: "{}",
        },
        {
          pub_id: "aBcD",
          destination_id: 1234,
          name: "Mountain Retreat",
          description: "A serene getaway in the mountains.",
          location_data: "{}",
        }
      ]

      Hotebase::Repos::HotelRepo.new.upsert(hotels)
    end

    it "returns hotels array with size > 1" do
      get "/api/v1/hotels"

      expect(last_response.status).to be(200)

      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response).to have_key("metadata")
      expect(json_response["hotels"].size).to be > 1
    end

    context "when filtering by destination id" do
      it "returns hotels for the specified destination" do
        get "/api/v1/hotels?destination_id=1234"

        expect(last_response.status).to be(200)

        json_response = JSON.parse(last_response.body)
        expect(json_response).to have_key("hotels")
        expect(json_response["hotels"].size).to eq(1)
        expect(json_response["hotels"][0]["destination_id"]).to eq(1234)
      end
    end

    context "when filtering by hotel id" do
      it "returns the specific hotel by pub_id" do
        get "/api/v1/hotels?id=iJhz"

        expect(last_response.status).to be(200)

        json_response = JSON.parse(last_response.body)
        expect(json_response).to have_key("hotels")
        expect(json_response["hotels"].size).to eq(1)
        expect(json_response["hotels"][0]["pub_id"]).to eq("iJhz")
        expect(json_response["hotels"][0]["name"]).to eq("Beach Villas Singapore")
      end
    end
  end

  context "when there are no hotels" do
    it "returns empty hotels array" do
      get "/api/v1/hotels"

      expect(last_response.status).to be(200)

      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response["hotels"]).to eq([])
    end
  end
end

