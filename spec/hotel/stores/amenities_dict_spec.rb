require 'spec_helper'

RSpec.describe Hotebase::Hotel::Stores::AmenitiesDict do
  describe '.sort_amenities' do
    it 'sorts amenities into general and room categories' do
      amenities = ['WiFi', 'aircon', 'outdoor pool', 'Coffee machine', 'business center']

      result = described_class.sort_amenities(amenities)

      expect(result['general']).to include('wifi', 'outdoor pool', 'business center')
      expect(result['room']).to include('aircon', 'coffee machine')
    end

    it 'handles empty amenities list' do
      result = described_class.sort_amenities([])

      expect(result).to eq({ 'general' => [], 'room' => [] })
    end
  end

  describe '#initialize' do
    it 'initializes with amenity string' do
      dict = described_class.new('WiFi')

      expect(dict.normal_name).to eq('wifi')
    end
  end

  describe '#normal_name' do
    context 'with known synonyms' do
      it 'normalizes WiFi variants' do
        expect(described_class.new('wifi').normal_name).to eq('wifi')
      end

      it 'normalizes business center variants' do
        expect(described_class.new('business center').normal_name).to eq('business center')
        expect(described_class.new('BusinessCenter').normal_name).to eq('business center')
      end

      it 'normalizes bathtub variants' do
        expect(described_class.new('Tub').normal_name).to eq('bathtub')
        expect(described_class.new('BathTub').normal_name).to eq('bathtub')
      end
    end
  end

  describe '#category' do
    context 'general amenities' do
      it 'returns general for pool' do
        expect(described_class.new('outdoor pool').category).to eq('general')
      end

      it 'returns general for wifi' do
        expect(described_class.new('WiFi').category).to eq('general')
      end

      it 'returns general for business center' do
        expect(described_class.new('business center').category).to eq('general')
      end
    end

    context 'room amenities' do
      it 'returns room for aircon' do
        expect(described_class.new('Aircon').category).to eq('room')
      end

      it 'returns room for tv' do
        expect(described_class.new('Tv').category).to eq('room')
      end

      it 'returns room for bathtub' do
        expect(described_class.new('Tub').category).to eq('room')
      end
    end
  end
end
