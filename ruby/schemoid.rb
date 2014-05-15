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

  def initialize
    @environment = [{:true => true, :false => false}]
  end

  def eval(expression, environment = @environment)
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
        lambda_expression = eval_let(expression)
        result = eval(lambda_expression, environment)
      elsif expression[0] == :letrec
        lambda_expression, new_environment = eval_letrec(expression, environment)
        result = eval(lambda_expression, new_environment)
      elsif expression[0] == :if
        condition = eval(expression[1], environment)
        if condition
          new_expression = expression[2]
        else
          new_expression = expression[3]
        end
        result = eval(new_expression, environment)
      elsif expression[0] == :define
        if expression[1].is_a?(Array)
          variable = car(expression[1])
          parameter = cdr(expression[1])
          body = expression[2]
          value = [:lambda, parameter, body]
        else
          variable = expression[1]
          value    = expression[2]
        end
        extend_environment!([variable], [eval(value, environment)], environment)
      elsif expression[0] == :cond
        if_expression = eval_cond(expression[1..-1])
        result = eval(if_expression, environment)
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
