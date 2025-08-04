# frozen_string_literal: true

module Hotebase
  module Relations
    class Hotel < Hotebase::DB::Relation
      schema :hotel, infer: true
    end
  end
end
