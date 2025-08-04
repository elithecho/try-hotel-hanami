module Hotebase
  module Hotel
    class Warehouse
      SOURCES = [
        Hotebase::Hotel::Stores::Acme::Repo,
        Hotebase::Hotel::Stores::Paperflies::Repo,
        Hotebase::Hotel::Stores::Patagonia::Repo,
      ]

      def initialize(sources = SOURCES)
        @sources = sources.map(&:new)
      end

      def consolidate
        all_data = @sources.map(&:fetch_all).flatten!
        grouped = all_data.group_by { |data| data[:pub_id] }

        puts "Consolidated Data:"
        puts grouped

        grouped.map do |pub_id, data|
          # TODO: merge data with logic
          # upsert logic
        end
      end
    end
  end
end
