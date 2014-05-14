module SchemoidType
  def list?(expression)
    expression.is_a?(Array)
  end

  def immediate_value?(expression)
    if expression.is_a?(Numeric)
      true
    elsif expression.is_a?(String)
      true
    else
      false
    end
  end
end
