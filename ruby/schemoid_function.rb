module SchemoidFunction
  PRIMITIVE_FUNCTIONS = {
    :+ => ->(*arguments){arguments.reduce(0){|sum, n| sum += n}},
    :- => ->(*arguments){arguments[1..-1].reduce(arguments[0]){|sub, n| sub -= n}},
    :* => ->(*arguments){arguments.reduce(1){|prod, n| prod *= n}},
    :/ => ->(*arguments){arguments[1..-1].reduce(arguments[0]){|div, n| div /= n}},
  }
end
