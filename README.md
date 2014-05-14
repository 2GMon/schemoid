schemoid
========
勉強用に作っているSchemeもどきです。

Ruby
====
```ruby
require_relative './schemoid'

puts schemoid = Schemoid.new.eval([:+, 1, 2]) # => 3
```
