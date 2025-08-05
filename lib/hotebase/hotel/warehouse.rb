# frozen_string_literal: true

require 'progress_bar'

module Hotebase
  module Hotel
    class Warehouse
      SOURCES = [
        Hotebase::Hotel::Stores::Acme::Repo,
        Hotebase::Hotel::Stores::Paperflies::Repo,
        Hotebase::Hotel::Stores::Patagonia::Repo,
      ]

      def initialize(
        sources: SOURCES,
        hotel_repo: Hotebase::Repos::HotelRepo.new,
        merger: Hotebase::Hotel::Merger.new
      )
        @sources = sources.map(&:new)
        @hotel_repo = hotel_repo
        @merger = merger
      end

      def fetch
        all_data = @sources.map(&:fetch_all).flatten!
        grouped = all_data.group_by { |data| data[:pub_id] }

        grouped.map do |pub_id, hotels|
          final_hotel = @merger.merge(*hotels)
          puts "Merging data for pub_id: #{pub_id}"
          puts "Final Hotel Data: #{final_hotel}"

          # upsert logic
        end
      end
    end
  end
end
