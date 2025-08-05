# frozen_string_literal: true
require_relative '../api'

module Hotebase
  module Hotel
    module Stores
      module Acme
        class Repo < ::Hotebase::Hotel::Stores::Api
          BASE_URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'

          COUNTRY_MAP = {
            'SG' => 'Singapore',
            'JP' => 'Japan',
            '' => nil,
          }

          def map(data)
            {
              pub_id: data['Id'],
              destination_id: data['DestinationId'],
              name: data['Name'],
              description: data['Description'],

              location: {
                lat: normalize_coordinate(data['Latitude']),
                lng: normalize_coordinate(data['Longitude']),
                address: build_address(data),
                city: data['City'],
                country: normalize_country(data['Country']),
              },

              amenities: {
                general: normalize_facilities(data['Facilities']),
                room: []
              },

              images: {
                rooms: [],
                site: [],
                amenities: []
              },

              booking_conditions: []
            }
          end

          private

          # Use country gem to map
          # SG -> Singapore
          # JP -> Japan
          # In this example, we just use our own map
          def normalize_country(country)
            COUNTRY_MAP[country]
          end

          def normalize_coordinate(coord)
            return nil if coord.nil? || coord == ""
            coord.is_a?(String) ? coord.to_f : coord
          end

          def build_address(data)
            parts = [
              data['Address']&.strip,
              data['PostalCode']
            ].compact.reject(&:empty?)
            parts.join(', ')
          end

          def normalize_facilities(facilities)
            return [] unless facilities.is_a?(Array)

            facilities.map do |facility|
              facility.strip.downcase.gsub(/\s+/, ' ')
            end
          end
        end
      end
    end
  end
end
