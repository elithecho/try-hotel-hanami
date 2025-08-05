# frozen_string_literal: true

module Hotebase
  module Repos
    class HotelRepo < Hotebase::DB::Repo
      def by_id(id)
        where(id: id).one
      end

      def upsert(pub_id, data)
        existing = by_id(pub_id)

        if existing
          # Update existing record
          existing.update(data)
        else
          # Insert new record
          create(data.merge(id: pub_id))
        end
      end
    end
  end
end
