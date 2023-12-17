module Mihari
  module Models
    module Searchable
      #
      # @param [Mihari::Structs::Filters::Search] filter
      #
      # @return [Array<Mihari::Models::Rule>]
      #
      def search_by_filter(filter)
        limit = filter.limit.to_i
        raise ArgumentError, "limit should be bigger than zero" unless limit.positive?

        page = filter.page.to_i
        raise ArgumentError, "page should be bigger than zero" unless page.positive?

        offset = (page - 1) * limit

        relation = build_relation(filter)
        relation.limit(limit).offset(offset).order(created_at: :desc)
      end

      #
      # @param [Mihari::Structs::Filters::Search] filter
      #
      # @return [Array<Mihari::Models::Rule>]
      #
      def count_by_filter(filter)
        relation = build_relation(filter)
        relation.distinct(:id).count
      end

      private

      #
      # @param [Mihari::Structs::Filters::Search] filter
      #
      def build_relation(filter)
        filter.q.empty? ? all : search(filter.q)
      end
    end
  end
end
