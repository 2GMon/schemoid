require_relative 'schemoid_type'
require_relative 'schemoid_list'
require_relative 'schemoid_function'
require_relative 'schemoid_environment'
require_relative 'schemoid_eval'

class Schemoid
  include SchemoidType
  include SchemoidList
  include SchemoidFunction
  include SchemoidEnvironment
  include SchemoidEval

  def eval(expression, environment = [])
    if !list?(expression)
      if immediate_value?(expression)
        result = expression
      elsif PRIMITIVE_FUNCTIONS[expression]
        result = expression
      else
        result = lookup_value(expression, environment)
      end
    else
      if expression[0] == :lambda
        closure = eval_lambda(expression, environment)
        result = closure
      elsif expression[0] == :let
        lambda_expression = eval_let(expression, environment)
        result = eval(lambda_expression, environment)
      else
        function  = eval(car(expression), environment)
        arguments = cdr(expression).map{|exp| eval(exp, environment)}
        result = apply(function, arguments)
      end
    end
    result
  end

  def apply(function, arguments)
    if PRIMITIVE_FUNCTIONS[function]
      PRIMITIVE_FUNCTIONS[function].call(*arguments)
    else
      parameters  = function[1]
      body        = function[2]
      environment = function[3]

      new_environment = extend_environment(parameters, arguments, environment)
      eval(body, new_environment)
    end
  end
end
