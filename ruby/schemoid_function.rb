module SchemoidFunction
  PRIMITIVE_FUNCTIONS = {
    :+ => ->(*arguments){arguments.reduce(0){|sum, n| sum += n}},
    :- => ->(*arguments){arguments[1..-1].reduce(arguments[0]){|sub, n| sub -= n}},
    :* => ->(*arguments){arguments.reduce(1){|prod, n| prod *= n}},
    :/ => ->(*arguments){arguments[1..-1].reduce(arguments[0]){|div, n| div /= n}},
    :% => ->(a, b){a % b},
    :> => ->(a, b){a > b},
    :>= => ->(a, b){a >= b},
    :< => ->(a, b){a < b},
    :<= => ->(a, b){a <= b},
    :== => ->(a, b){a == b},
    :!= => ->(a, b){a != b},
    :nil => [],
    :null? => ->(list){list == []},
    :cons => ->(a, b){[a] + b},
    :car => ->(list){list[0]},
    :cdr => ->(list){list[1..-1]},
    :list => ->(*list){list},
  }
end
