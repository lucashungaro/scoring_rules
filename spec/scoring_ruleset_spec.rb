require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/my_model')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/rulesets')

describe ScoringRuleset do
  before(:each) do
    MyModel.send(:include, ScoringRuleset)
  end
  
  after(:each) do
    # reload the file to undefine the ruleset
    load File.expand_path(File.dirname(__FILE__) + '/fixtures/my_model.rb')    
  end
  
  context "contract" do   
    specify "ruleset needs a block with its rules" do
      doing {
        MyModel.class_eval {eval INVALID_RULESET_EMPTY}
      }.should raise_exception(ArgumentError)      
    end
     
    specify "every rule should accept only one condition" do
      doing {
        MyModel.class_eval {eval INVALID_RULESET_MANY_CONDITIONS}
      }.should raise_exception(ArgumentError)
    end
    
    specify "every rule should have a condition" do
      doing {
        MyModel.class_eval {eval INVALID_RULESET_NO_CONDITIONS}
      }.should raise_exception(ArgumentError)
    end
    
    specify "only accepted conditions are :if, :unless and :each" do
      doing {
        MyModel.class_eval {eval INVALID_RULESET_NON_EXISTENT_CONDITIONS}
      }.should raise_exception(ArgumentError)
    end
  end
  
  context "functionality" do
    it "should correctly calculate the object score according to the ruleset" do
      MyModel.class_eval {eval VALID_RULESET}
      obj = MyModel.new
      
      obj.calculate_score.should == 305
    end
  end
end