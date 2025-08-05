require_relative '../api'

module Hotebase
  module Hotel
    module Stores
      module Patagonia
        class Repo < ::Hotebase::Hotel::Stores::Api
          BASE_URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia'

          def map(data)
            {
              pub_id: data['id'],
              destination_id: data['destination'],
              name: data['name'],
              description: data['info'],

              location: {
                lat: data['lat'],
                long: data['lng'],
                address: data['address'],
                city: data['city'],
                country: data['country'],

              },
              facilities: data['amenities'] || [],
            }
          end
        end
      end
    end
  end
end
