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
                lng: data['lng'],
                address: data['address'],
                city: data['city'],
                country: data['country'],
              },

              amenities: {
                general: [],
                room: normalize_amenities(data['amenities'])
              },

              images: normalize_images(data['images']),

              booking_conditions: []
            }
          end

          private

          def normalize_amenities(amenities)
            return [] unless amenities.is_a?(Array)
            
            amenities.map do |amenity|
              amenity.strip.downcase.gsub(/\s+/, ' ')
            end
          end

          def normalize_images(images)
            return { rooms: [], site: [], amenities: [] } unless images.is_a?(Hash)

            {
              rooms: normalize_image_array(images['rooms']),
              site: [],
              amenities: normalize_image_array(images['amenities'])
            }
          end

          def normalize_image_array(image_array)
            return [] unless image_array.is_a?(Array)

            image_array.map do |image|
              {
                link: image['url'],
                description: image['description']
              }
            end
          end
        end
      end
    end
  end
end
