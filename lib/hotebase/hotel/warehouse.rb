# frozen_string_literal: true

require 'progress_bar'

module Hotebase
  module Hotel
    class Warehouse
      SOURCES = [
        Hotebase::Hotel::Stores::Acme::Repo.new,
        Hotebase::Hotel::Stores::Paperflies::Repo.new,
        Hotebase::Hotel::Stores::Patagonia::Repo.new,
      ]

      def initialize(
        sources: SOURCES,
        hotel_repo: Hotebase::Repos::HotelRepo.new,
        merger: Hotebase::Hotel::Merger.new
      )
        @sources = sources
        @hotel_repo = hotel_repo
        @merger = merger
      end

      def fetch
        all_data = @sources.map(&:fetch_all).flatten!
        grouped = all_data.group_by { |data| data[:pub_id] }

        result = grouped.map do |_pub_id, hotels|
          @merger.merge(*hotels)
        end

        @hotel_repo.upsert(result)
      end
    end
  end
end
