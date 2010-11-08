require "scoring_ruleset/metaid"
require "scoring_ruleset/ruleset"
require "scoring_ruleset/rule"
require "scoring_ruleset/condition"

module ScoringRuleset
  module ClassMethods
    def scoring_ruleset
      raise(ArgumentError, "Ruleset needs a block with the rules") unless block_given?
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