module SchemoidEval
  def eval_let(expression, environment)
    parameters = expression[1].map{|e| e[0]}
    arguments  = expression[1].map{|e| e[1]}
    body       = expression[2]
    new_expression = [[:lambda, parameters, body]] + arguments
  end
end
