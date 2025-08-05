# frozen_string_literal: true
require_relative '../api'

module Hotebase
  module Hotel
    module Stores
      module Paperflies
        class Repo < ::Hotebase::Hotel::Stores::Api
          BASE_URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies'

          def map(data)
            {
              pub_id: data['hotel_id'],
              destination_id: data['destination_id'],
              name: data['hotel_name'],
              description: data['details'],
              location: {
                address: data.dig('location', 'address'),
                country: data.dig('location', 'country')
              },
              amenities: flatten_amenities(data['amenities']),
              images: normalize_images(data['images']),
              booking_conditions: data['booking_conditions']
            }
          end

          private

          def flatten_amenities(amenities)
            general = amenities['general']&.map(&:strip) || []
            room = amenities['room']&.map(&:strip) || []

            AmenitiesDict.sort(general + room)
          end

          def normalize_images(images)
            return { rooms: [], site: [], amenities: [] } if images.nil?

            {
              rooms: normalize_image_array(images['rooms']),
              site: normalize_image_array(images['site']),
              amenities: normalize_image_array(images['amenities'])
            }
          end

          def normalize_image_array(image_array)
            return [] unless image_array.is_a?(Array)

            image_array.map do |image|
              {
                link: image['link'],
                description: image['caption']
              }
            end
          end
        end
      end
    end
  end
end
