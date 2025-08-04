# frozen_string_literal: true

module Hotebase
  module Hotel
    module Stores
      class DataWrapper < Hash
        def initialize(data)
          @data = data
        end

        def [](key)
          # if its a string, chomp it
          value = @data[key.to_s] || @data[key.to_sym]
          return value.strip if value.is_a?(String)

          value
        end
      end
    end
  end
end
