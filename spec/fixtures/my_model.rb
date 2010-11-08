class MyModel
  def followers
    r = OpenStruct.new
    r.count = 300
    r
  end

  def can_remove?
    true
  end

  def age
    20
  end

  def is_new_user?
    true
  end
end