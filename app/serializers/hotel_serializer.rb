module Hotebase
  module Serializers
    class HotelSerializer
      include CollectionSerializable

      def initialize(hotel)
        @hotel = hotel
      end

      EXCEPT_ATTRIBUTES = %i[id pub_id location_data image_data created_at updated_at booking_conditions amenities_data].freeze

      def serialize
        hotel_attributes = @hotel.attributes.except(*EXCEPT_ATTRIBUTES)
        location = JSON.parse(@hotel.location_data, symbolize_names: true)
        amenities = JSON.parse(@hotel.amenities_data, symbolize_names: true)
        booking_conditions = JSON.parse(@hotel.booking_conditions)
        images = JSON.parse(@hotel.image_data, symbolize_names: true)

        {
          id: @hotel.pub_id,
          **hotel_attributes,
          location:,
          amenities:,
          booking_conditions:,
          images:
        }
      end
    end
  end
end
