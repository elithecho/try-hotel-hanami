# frozen_string_literal: true
require "http"

module Hotebase
  module Hotel
    module Stores
      class Api
        def map
          raise NotImplementedError, "You must implement the map method"
        end

        def fetch_all
          get.map do |data|
            data = DataWrapper.new(data)
            map data
          end
        end

        private

        def get
          HTTP.get(base_url).then do |response|
            raise "Error fetching data from #{url}" unless response.status.success?

            JSON.parse(response.body.to_s)
          end
        end

        def base_url
          self.class::BASE_URL
        end
      end
    end
  end
end
