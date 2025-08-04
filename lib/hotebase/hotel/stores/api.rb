# frozen_string_literal: true

module Hotebase
  module Hotel
    module Stores
      class Api
        def base_url
          BASE_URL
        end

        def fetch_all
          get.map do |data|
            entity.build(data)
          end
        end

        private

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
