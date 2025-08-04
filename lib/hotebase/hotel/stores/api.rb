# frozen_string_literal: true

module Hotebase
  module Hotel
    module Stores
      class Api
        def map
          raise NotImplementedError, 'You must implement the map method'
        end

        def fetch_all
          get.map do |data|
            data = DataWrapper.new(data)
            map data
          end
        end

        private

        def base_url
          BASE_URL
        end

        def get
          HTTP.get(self.base_url).then do |response|
            raise "Error fetching data from #{url}" unless response.status.success?

            JSON.parse(response.body.to_s)
          end
        end

        def entity
          self.class::ENTITY
        end
      end
    end
  end
end
