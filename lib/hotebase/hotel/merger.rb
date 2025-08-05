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
            lng: any(:location, :lng),
            address: any(:location, :address),
            country: any(:location, :country),
            city: any(:location, :city)
          }.to_json,
          image_data: merge_images.to_json,
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

      def merge_images
        all_images = fetch(:images).compact

        combined = all_images.each_with_object({}) do |image_hash, result|
          image_hash.each do |category, images|
            category_key = category.to_sym
            result[category_key] ||= []
            result[category_key].concat(images)
          end
        end

        combined.transform_values { |images| images.uniq { |image| image[:link] } }
      end
    end
  end
end
