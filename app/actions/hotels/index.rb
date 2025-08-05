module Hotebase
  module Actions
    module Hotels
      class Index < Hanami::Action
        include Deps['repos.hotel_repo']

        params do
          optional(:page).value(:integer, gt?: 0)
          optional(:per_page).value(:integer, gt?: 0, lteq?: 100)
          optional(:id).value(:string)
          optional(:destination_id).value(:integer)
        end

        def handle(req, res)
          halt 422 unless req.params.valid?

          query = {
            page: req.params[:page],
            id: req.params[:id],
            destination_id: req.params[:destination_id],
          }

          hotels = hotel_repo.all(**query)
          total = hotel_repo.total_count(query)

          res.status = 200
          res.format = :json
          res.body = {
            hotels: Serializers::HotelSerializer.serialize_collection(hotels),
            metadata: {
              total:,
              total_pages: 1,
            }
          }.to_json
        end
      end
    end
  end
end
