RSpec.describe Hotebase::Hotel::Stores::Acme::Repo do
  # VCR works too
  let(:api_response) { load_fixture('api/acme.json') }

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
      expect(entities.first[:description]).to eq("This 5 star hotel is located on the coastline of Singapore.")
    end
  end
end
