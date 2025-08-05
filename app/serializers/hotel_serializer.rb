module Hotebase
  module Serializers
    class HotelSerializer
      include CollectionSerializable

      def initialize(hotel)
        @hotel = hotel
      end

      EXCEPT_ATTRIBUTES = %i[id location_data image_data created_at updated_at].freeze

      def serialize
        hotel_attributes = @hotel.attributes.except(*EXCEPT_ATTRIBUTES)
        location = JSON.parse(@hotel.location_data, symbolize_names: true)

        {
          id: @hotel.pub_id,
          pub_id: @hotel.pub_id,
          **hotel_attributes,
          location: {
            lat: location[:lat],
            long: location[:long],
            address: location[:address],
            city: location[:city],
            state: location[:state],
          }
        }
      end
    end
  end
end
