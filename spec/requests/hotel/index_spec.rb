RSpec.describe "GET /api/v1/hotels", type: :request do
  let(:acme_data) { load_fixture('api/acme.json') }
  let(:patagonia_data) { load_fixture('api/patagonia.json') }

  # Setup all the hotel data using fixtures
  let(:warehouse) do
    sources = [
      Hotebase::Hotel::Stores::Acme::Repo.new(acme_data),
      Hotebase::Hotel::Stores::Patagonia::Repo.new(patagonia_data),
    ]

    Hotebase::Hotel::Warehouse.new(sources: sources)
  end

  context "when there are hotels" do
    before do
      warehouse.fetch
    end

    it "returns hotels array with size > 1" do
      get "/api/v1/hotels"

      expect(last_response.status).to be(200)

      json_response = JSON.parse(last_response.body)
      expect(json_response).to have_key("hotels")
      expect(json_response).to have_key("metadata")
      expect(json_response["metadata"]["total"]).to eq(3)
      expect(json_response["hotels"].size).to be > 1
    end

    context "when filtering by destination id" do
      it "returns hotels for the specified destination" do
        get "/api/v1/hotels?destination_id=5432"

        expect(last_response.status).to be(200)

        json_response = JSON.parse(last_response.body)
        expect(json_response).to have_key("hotels")
        expect(json_response["hotels"].size).to eq(2)
        expect(json_response["hotels"][0]["destination_id"]).to eq(5432)
      end
    end

    context "when filtering by hotel id" do
      it "returns the specific hotel by pub_id" do
        get "/api/v1/hotels?id=iJhz"

        expect(last_response.status).to be(200)

        json_response = JSON.parse(last_response.body)
        expect(json_response).to have_key("hotels")
        expect(json_response["hotels"].size).to eq(1)
        expect(json_response["hotels"][0]["id"]).to eq("iJhz")
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

