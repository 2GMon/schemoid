module SchemoidEnvironment
  def extend_environment(parameters, arguments, environment)
    new_environment = generate_enviroment(parameters, arguments)
    [new_environment] + environment
  end

  def extend_environment!(parameters, arguments, environment)
    new_environment = generate_enviroment(parameters, arguments)
    environment.unshift(new_environment)
  end

  def lookup_value(value, environment)
    env = environment.find{|env| env.key?(value)}
    env[value]
  end

  def set_extend_environment!(parameters, arguments, environment)
    parameters.zip(arguments).each do |parameter, argument|
      environment[0][parameter] = argument
    end
  end

  private
  def generate_enviroment(parameters, arguments)
    h = Hash.new
    parameters.zip(arguments).each{|key, value| h[key] = value}
    h
  end
end
