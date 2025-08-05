RSpec.describe Hotebase::Hotel::Merger do
  let(:acme_data) { load_fixture('api/acme.json') }
  let(:patagonia_data) { load_fixture('api/patagonia.json') }

  let(:acme_result) { Hotebase::Hotel::Stores::Acme::Repo.new(acme_data).fetch_all.first }
  let(:patagonia_result) { Hotebase::Hotel::Stores::Patagonia::Repo.new(patagonia_data).fetch_all.first }

  let(:merger) { described_class.new }

  let(:subject) { merged_data.first }

  describe '#merge' do

    it 'merges two hashes' do
      merged_data = merger.merge(acme_result, patagonia_result)

      expect(merged_data).to include({
        pub_id: 'iJhz',
        destination_id: 5432,
        name: 'Beach Villas Singapore',
      })
    end

    it 'merges location data' do
      merged_data = merger.merge(acme_result, patagonia_result)

      expect(merged_data[:location]).to include({
        lat: 1.264751,
        long: 103.824006,
        address: '8 Sentosa Gateway, Beach Villas, 098269',
        city: 'Singapore',
        country: 'Singapore',
      })
    end
  end
end
