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
              amenities: data['amenities'],
              images: transform_images(data['images']),
              booking_conditions: data['booking_conditions']
            }
          end

          private

          def transform_images(images)
            return {} unless images

            transformed = {}
            images.each do |category, image_list|
              transformed[category] = image_list.map do |image|
                {
                  link: image['link'],
                  description: image['caption']
                }
              end
            end
            transformed
          end
        end
      end
    end
  end
end
