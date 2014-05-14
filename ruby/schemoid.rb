require_relative 'schemoid_type'
require_relative 'schemoid_list'
require_relative 'schemoid_function'
require_relative 'schemoid_environment'

class Schemoid
  include SchemoidType
  include SchemoidList
  include SchemoidFunction
  include SchemoidEnvironment

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
        parameters = expression[1]
        body = expression[2]
        result = [:closure, parameters, body, environment]
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
