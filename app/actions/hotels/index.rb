module Hotebase
  module Actions
    module Hotels
      class Index < Hanami::Action
        include Deps['repos.hotel_repo']

        def handle(_req, res)

          hotels = hotel_repo.all

          res.status = 200
          res.format = :json
          res.body = Serializers::HotelSerializer.serialize_collection(hotels)
        end
      end
    end
  end
end
