module Hotebase
  module Hotel
    module Stores
      class AmenitiesDict
        # Buids a dictionary of amenities with their normalized names and categories.
        AMENITIES = {
          'general' => ["outdoor pool", "indoor pool", "wifi", "business center", "childcare", "parking", "bar", "dry cleaning", "breakfast", "concierge"],
          'room' => ["aircon", "tv", "coffee machine", "kettle", "hair dryer", "iron", "bathtub", "minibar"],
        }

        SYNONYMS = {
          'business center' => ['business center', 'BusinessCenter'],
          'dry cleaning' => ['dry cleaning', 'DryCleaning'],
          'bathtub' => ['Tub', 'bathtub'],
        }

        def self.sort(amenities)
          result = { general: [], room: [] }
          return result unless amenities.is_a?(Array) && amenities.any?

          amenities.each do |amenity|
            dict = new(amenity)
            category = dict.category
            normalized = dict.normal_name
            result[category.to_sym] << normalized if category && normalized
          end

          result
        end

        def initialize(amenity)
          @amenity = amenity.to_s.strip
          @normalized = normal_name
        end

        def normal_name
          return @normalized if @normalized

          SYNONYMS.each do |normalized_name, synonyms|
            if synonyms.any? { |synonym| synonym.downcase == @amenity.downcase }
              @normalized = normalized_name
              return @normalized
            end
          end

          @normalized = @amenity.downcase
        end

        def category
          AMENITIES.each do |cat, amenities|
            return cat if amenities.include?(normal_name)
          end
          nil
        end
      end
    end
  end
end
