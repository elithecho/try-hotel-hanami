RSpec.describe Hotebase::Hotel::Stores::Patagonia::Repo do
  let(:api_response) { load_fixture('api/patagonia.json') }

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
      entity = entities.first

      # Sample a few attributes to check
      expect(entity[:pub_id]).to eq('iJhz')
      expect(entity[:destination_id]).to eq(5432)
      expect(entity[:name]).to eq('Beach Villas Singapore')
      expect(entity[:description]).to match(/Located at the western tip of Resorts World Sentosa, guests at the/)
    end
  end
end
