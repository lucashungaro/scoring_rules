class Rule
  attr_accessor :points

  def initialize(points, condition)
    @points = points
    @condition = condition
  end

  def evaluate(instance)
    @condition.evaluate(instance) * @points
  end
end