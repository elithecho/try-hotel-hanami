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
              id: data['hotel_id'],
              destination_id: data['destination_id'],
              description: data['description'],
            }
          end
        end
      end
    end
  end
end
