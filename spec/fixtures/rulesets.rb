VALID_RULESET = <<-CODE
scoring_rules do |rule|
  rule.add_points    10, :if => lambda {self.age >= 18}
  rule.remove_points  5, :if => :can_remove?
  rule.add_points     5, :unless => lambda {self.is_new_user?}
  rule.add_points     1, :each => :followers
end
CODE

INVALID_RULESET_EMPTY = <<-CODE
scoring_rules
CODE

INVALID_RULESET_MANY_CONDITIONS = <<-CODE
scoring_rules do |rule|
  rule.add_points 10, :if => lambda {self.age >= 18}, :unless => lambda {true}
  rule.remove_points 5, :if => :can_remove?
end
CODE

INVALID_RULESET_NO_CONDITIONS = <<-CODE
scoring_rules do |rule|
  rule.add_points 10
  rule.remove_points 5, :if => :can_remove?
end
CODE

INVALID_RULESET_NON_EXISTENT_CONDITIONS = <<-CODE
scoring_rules do |rule|
  rule.add_points 10, :crazy => lambda {true}
  rule.remove_points 5, :if => :can_remove?
end
CODE