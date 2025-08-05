# frozen_string_literal: true

module Hotebase
  module Hotel
    module Stores
      class DataWrapper < Hash
        def initialize(data)
          super()
          @data = data
        end

        def [](key)
          # if its a string, chomp it
          value = @data[key.to_s] || @data[key.to_sym]
          return value.strip if value.is_a?(String)
          return value.map(&:strip!) if array_of_string(value)

          value
        end

        private

        def array_of_string(value)
          return false unless value.is_a?(Array)

          # Check if the first element is a string, no need to check all elements
          value.first.is_a?(String)
        end
      end
    end
  end
end
