class Ruleset
  def initialize
    @rules = []
  end

  def add_points(criteria)
    create_rule(criteria)
  end

  def remove_points(criteria)
    create_rule(criteria, :multiplier => -1)
  end

  def evaluate(instance)
    @rules.inject(0) do |memo, rule|
      memo += rule.evaluate(instance)
    end
  end

  private
    def create_rule(criteria, options = {})
      options[:multiplier] = 1 unless options[:multiplier]
      points = criteria.delete(:points) || 1
      validade_conditions(criteria)
      condition = build_condition_from_criteria(criteria)
      rule = Rule.new(points * options[:multiplier], condition)
      add_rule(rule)
    end

    def build_condition_from_criteria(criteria)
      condition_data = criteria.shift
      Condition.new(condition_data[0], condition_data[1])
    end

    def validade_conditions(criteria)
      valid_keys = [:if, :unless, :each]
      keys = criteria.keys

      raise(ArgumentError, "Each rule should have a condition") if keys.size == 0

      unknown_keys = keys - [valid_keys].flatten
      raise(ArgumentError, "Unknown key(s): #{unknown_keys.join(", ")}") unless unknown_keys.empty?

      raise(ArgumentError, "Each rule should have only one condition") if keys.size > 1
    end

    def add_rule(rule)
      @rules << rule
    end
end