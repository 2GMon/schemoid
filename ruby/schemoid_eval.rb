module SchemoidEval
  include SchemoidEnvironment

  def eval_lambda(expression, environment)
    parameters = expression[1]
    body = expression[2]
    [:closure, parameters, body, environment]
  end

  def eval_let(expression)
    parameters, arguments, body = let_to_parameters_arguments_body(expression)
    new_expression = [[:lambda, parameters, body]] + arguments
  end

  def eval_letrec(expression, environment)
    parameters, arguments, body = let_to_parameters_arguments_body(expression)
    lambda_expression = [[:lambda, parameters, body]] + arguments

    tmp_environment = Hash.new
    parameters.each do |parameter|
      tmp_environment[parameter] = :dummy
    end
    new_environment = extend_environment(tmp_environment.keys, tmp_environment.values, environment)
    arguments_value = arguments.map{|argument| eval(argument, new_environment)}
    set_extend_environment!(parameters, arguments_value, new_environment)

    [lambda_expression, new_environment]
  end

  def eval_cond(expression)
    if expression == []
      ''
    else
      e = expression[0]
      p = e[0]
      c = e[1]
      if p == :else
        p = :true
      end
      [:if, p, c, eval_cond(expression[1..-1])]
    end
  end

  private
  def let_to_parameters_arguments_body(expression)
    [expression[1].map{|e| e[0]}, expression[1].map{|e| e[1]}, expression[2]]
  end
end
