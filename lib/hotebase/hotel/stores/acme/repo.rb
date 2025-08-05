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
                lat: data['Latitude'],
                long: data['Longitude'],
                address: [data['Address'], data['PostalCode']].compact.join(', '),
                city: data['City'],
                country: normalize_country(data['Country']),
              },
              facilities: data['Facilities'] || [],
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
        end
      end
    end
  end
end
