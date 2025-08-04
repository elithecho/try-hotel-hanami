# frozen_string_literal: true

module Hotebase
  module Hotel
    module Stores
      class Api
        def self.base_url
          BASE_URL
        end

        def self.fetch_all
          get("#{base_url}")
        end

        private

        def self.resource_name
          name.split('::').last.downcase.pluralize
        end
      end
    end
  end
end
