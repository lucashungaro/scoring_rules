class Condition
  def initialize(type, method)
    @type = type
    @method = method
  end

  def evaluate(instance)
    case @type
      when :if
        dispatch_pre_condition(instance)
      when :unless
        (dispatch_pre_condition(instance) - 1) * -1
      when :each
        dispatch_collection(instance)
    end
  end

  private
  def dispatch_pre_condition(instance)
    result = 0
    if @method.is_a?(Symbol)
      result = instance.send(@method) ? 1 : 0
    elsif @method.is_a?(Proc)
      result = instance.instance_exec(&@method) ? 1 : 0
    end
    result
  end

  def dispatch_collection(instance)
    result = instance.send(@method).count
  end
end