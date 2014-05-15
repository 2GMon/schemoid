module SchemoidEnvironment
  def extend_environment(parameters, arguments, environment)
    h = Hash.new
    parameters.zip(arguments).each{|key, value| h[key] = value}
    [h] + environment
  end

  def lookup_value(value, environment)
    env = environment.find{|env| env.key?(value)}
    env[value]
  end
end
