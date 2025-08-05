# frozen_string_literal: true
require "http"

module Hotebase
  module Hotel
    module Stores
      class Api
        def initialize(remote_data = {})
          @remote_data = remote_data
        end

        def map
          raise NotImplementedError, "You must implement the map method"
        end

        def fetch_all
          remote_data.map do |data|
            data = DataWrapper.new(data)
            map data
          end
        end

        private

        def remote_data
          return call_api if @remote_data.empty?

          @remote_data
        end

        # Error in a single source should not halt the entire process.
        def call_api
          HTTP.get(base_url).then do |response|
            unless response.status.success?
              Hanami.logger.warn "Failed to fetch data from #{base_url}: #{response.status}"
              return []
            end

            JSON.parse(response.body.to_s)
          end
        rescue StandardError => e
          Hanami.logger.error "An error occurred while fetching data from #{base_url}: #{e.message}"
          []
        end

        def base_url
          self.class::BASE_URL
        rescue NameError
          raise NotImplementedError, "You must implement the BASE_URL constant"
        end
      end
    end
  end
end
