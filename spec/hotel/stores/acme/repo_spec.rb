RSpec.describe Hotebase::Hotel::Stores::Acme::Repo do
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

      expect(entities.first[:id]).to eq('iJhz')
    end
  end
end
