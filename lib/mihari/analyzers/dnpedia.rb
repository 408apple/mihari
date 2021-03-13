# frozen_string_literal: true

require "dnpedia"

module Mihari
  module Analyzers
    class DNPedia < Base
      attr_reader :query, :title, :description, :tags

      def initialize(query, title: nil, description: nil, tags: [])
        super()

        @query = query
        @title = title || "DNPedia domain lookup"
        @description = description || "query = #{query}"
        @tags = tags
      end

      def artifacts
        lookup || []
      end

      private

      def api
        @api ||= ::DNPedia::API.new
      end

      def lookup
        res = api.search(query)
        rows = res["rows"] || []
        rows.map do |row|
          [row["name"], row["zoneid"]].join(".")
        end
      end
    end
  end
end
