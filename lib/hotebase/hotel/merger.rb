module Hotebase
  module Hotel
    class Merger
      def merge(*hotels)
        @hotels = hotels

        {
          pub_id: any(:pub_id),
          destination_id: any(:destination_id),
          name: longest(:name),
          description: longest(:description),
          location_data: {
            lat: any(:location, :lat),
            long: any(:location, :long),
            address: any(:location, :address),
            country: any(:location, :country),
            city: any(:location, :city)
          }.to_json
        }
      end

      private

      # Returns the longest value for the given keys across all sources
      def longest(*keys)
        values = fetch(*keys)
        values.max_by(&:length)
      end

      # When any source is acceptable
      def any(*keys)
        fetch(*keys).first
      end

      # Only returns non-nil values
      def fetch(*keys)
        @hotels.map { |h| h.dig(*keys) }.compact || []
      end
    end
  end
end
