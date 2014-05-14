require_relative 'schemoid_type'
require_relative 'schemoid_list'
require_relative 'schemoid_function'

class Schemoid
  include SchemoidType
  include SchemoidList
  include SchemoidFunction

  def eval(expression)
    if !list?(expression)
      expression
    else
      function  = eval(car(expression))
      arguments = cdr(expression).map{|exp| eval(exp)}
      apply(function, arguments)
    end
  end

  def apply(function, arguments)
    PRIMITIVE_FUNCTIONS[function].call(*arguments)
  end
end
