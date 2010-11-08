require "scoring_rules/metaid"
require "scoring_rules/ruleset"
require "scoring_rules/rule"
require "scoring_rules/condition"

module ScoringRules
  module ClassMethods
    def scoring_rules
      raise(ArgumentError, "You must supply a block with the rules") unless block_given?
      self.ruleset = Ruleset.new
      yield self.ruleset
    end
  end

  module InstanceMethods
    def calculate_score
      self.class.ruleset.evaluate(self)
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods

    receiver.meta_eval { attr_accessor :ruleset }
  end
end