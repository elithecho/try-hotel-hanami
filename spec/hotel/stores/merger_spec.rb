RSpec.describe Hotebase::Hotel::Merger do
  let(:acme_data) { load_fixture('api/acme.json') }
  let(:patagonia_data) { load_fixture('api/patagonia.json') }
  let(:paperflies_data) { load_fixture('api/paperflies.json') }

  let(:acme_result) { Hotebase::Hotel::Stores::Acme::Repo.new(acme_data).fetch_all.first }
  let(:patagonia_result) { Hotebase::Hotel::Stores::Patagonia::Repo.new(patagonia_data).fetch_all.first }
  let(:paperflies_result) { Hotebase::Hotel::Stores::Paperflies::Repo.new(paperflies_data).fetch_all.first }

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

      expect(merged_data[:location_data]).to eq({
        lat: 1.264751,
        lng: 103.824006,
        address: '8 Sentosa Gateway, Beach Villas, 098269',
        country: 'Singapore',
        city: 'Singapore',
      }.to_json)
    end

    it 'merges image_data' do
      merged_data = merger.merge(paperflies_result, patagonia_result)
      images = JSON.parse(merged_data[:image_data], symbolize_names: true)

      expect(images[:rooms].length).to be > 2
    end

    it 'gets the correct booking conditions' do
      merged_data = merger.merge(paperflies_result, patagonia_result)
      booking_conditions = JSON.parse(merged_data[:booking_conditions])

      expect(booking_conditions.length).to be > 0
    end

    it 'merges amenities' do
      merged_data = merger.merge(acme_result, patagonia_result)
      amenities = JSON.parse(merged_data[:amenities_data], symbolize_names: true)

      expect(amenities[:general].length).to be > 0
      expect(amenities[:room].length).to be > 0
    end
  end
end
