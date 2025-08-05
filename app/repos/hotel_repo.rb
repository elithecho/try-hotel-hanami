# frozen_string_literal: true

module Hotebase
  module Repos
    class HotelRepo < Hotebase::DB::Repo
      def by_id(id)
        where(id: id).one
      end

      def all
        hotels.to_a
      end

      def upsert(bulk_data)
        hotels.dataset
          .insert_conflict({
            target: [:pub_id],
          })
          .multi_insert(bulk_data)
      end
    end
  end
end
