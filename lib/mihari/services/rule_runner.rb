# frozen_string_literal: true

module Mihari
  module Services
    class RuleRunner
      include Dry::Monads[:result, :try]

      # @return [Mihari::Services::RuleProxy]
      attr_reader :rule

      def initialize(rule)
        @rule = rule
      end

      #
      # @return [Boolean]
      #
      def diff?
        model = Mihari::Rule.find(rule.id)
        model.data != rule.data.deep_stringify_keys
      rescue ActiveRecord::RecordNotFound
        false
      end

      def update_or_create
        rule.model.save
      end

      #
      # @return [Mihari::Alert, nil]
      #
      def run
        rule.analyzer.run
      end

      #
      # @return [Dry::Monads::Result::Success<Mihari::Alert, nil>, Dry::Monads::Result::Failure]
      #
      def result
        Try[StandardError] { run }.to_result
      end
    end
  end
end