module Hotebase
  module Hotel
    class Warehouse
      SOURCES = [
        Hotebase::Hotel::Stores::AcmeRepo,
      ]

      def initialize(sources = SOURCES)
        @sources = sources.map(&:new)
      end

      def consolidate
    end
  end
end
