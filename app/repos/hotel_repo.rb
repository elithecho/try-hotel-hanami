# frozen_string_literal: true

module Hotebase
  module Repos
    class HotelRepo < Hotebase::DB::Repo
      PER_PAGE = 20

      def by_id(id)
        where(id: id).one
      end

      def total_count(query)
        queried(query).count
      end

      # Assumed scaling needs, add pagination
      def all(query = { page: 1, per_page: PER_PAGE })
        queried(query).to_a
      end

      def upsert(bulk_data)
        hotels.dataset
          .insert_conflict({
            target: [:pub_id],
          })
          .multi_insert(bulk_data)
      end

      private

      def queried(query)
        if query[:id]
          hotels.where(pub_id: query[:id])
        elsif query[:destination_id]
          hotels.where(destination_id: query[:destination_id])
        else
          hotels
        end
      end
    end
  end
end
