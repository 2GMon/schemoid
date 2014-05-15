schemoid
========
勉強用に作っているSchemeもどきです。

Ruby
====
```ruby
require_relative './schemoid'

puts schemoid = Schemoid.new.eval([:+, 1, 2]) # => 3
puts schemoid = Schemoid.new.eval([[:lambda, [:x], [:+, :x, [[:lambda, [:x], :x], 2]]], 3]) # => 5
puts schemoid = Schemoid.new.eval([:let, [[:x, 3], [:y, 2]], [:+, :x, :y]]) # => 5
puts schemoid = Schemoid.new.eval([:if, [:>, 3, 2], 1, 0]) # => 1
```

* repl
```
ruby schemoid_repl.rb
```
