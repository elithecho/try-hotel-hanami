RSpec.describe Hotebase::Hotel::Stores::Paperflies::Repo do
  let(:api_response) { load_fixture('api/paperflies.json') }

  subject(:repo) { described_class.new }

  before do
    allow(repo).to receive(:get).and_return(api_response)
  end

  describe '#fetch_all' do
    it 'fetches all entities' do
      entities = repo.fetch_all

      expect(entities).not_to be_empty
      expect(entities.first).to be_a Hash
    end

    it 'returns entities with some attributes' do
      entities = repo.fetch_all

      # Sample a few attributes to check
      expect(entities.first[:pub_id]).to eq('iJhz')
      expect(entities.first[:destination_id]).to eq(5432)
      expect(entities.first[:name]).to eq('Beach Villas Singapore')
      expect(entities.first[:description]).to eq("Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.")
    end
  end
end