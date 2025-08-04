require_relative '../api'

module Hotebase
  module Hotel
    module Stores
      module Acme
        class Repo < ::Hotebase::Hotel::Stores::Api
          BASE_URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'

          def map(data)
            {
              pub_id: data['Id'],
              destination_id: data['DestinationId'],
              name: data['Name'],
              description: data['Description'],
              loc_city: data['City'],
              loc_country: data['Country'],

              location: {
                lat: data['Latitude'],
                long: data['Longitude'],
                address: [data['Address'], data['PostalCode']].compact.join(', ')
              },
              facilities: data['Facilities'] || [],
            }
          end
        end
      end
    end
  end
end
