module SchemoidEnvironment
  def extend_environment(parameters, arguments, environment)
      h = Hash.new
      parameters.zip(arguments).each{|key, value| h[key] = value}
      new_environment = environment.unshift(h)
  end

  def lookup_value(value, environment)
    env = environment.find{|env| env.key?(value)}
    env[value]
  end
end
