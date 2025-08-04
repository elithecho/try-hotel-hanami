# frozen_string_literal: true

module Hotebase
  module Repos
    class HotelRepo < Hotebase::DB::Repo
      def by_id(id)
        where(id: id).one
      end
    end
  end
end
