require_relative './schemoid'

class SchemoidRepl
  def initialize
    @schemoid = Schemoid.new
    @prompt = '>>> '
    @second_prompt = '>   '

    repl
  end

  def repl
    while true
      print @prompt
      line = gets or return
      while line.count('(') > line.count(')')
        print @second_prompt
        next_line = gets or return
        line += next_line
      end
      redo if line =~ /\A\s*\z/m
      begin
        val = @schemoid.eval(@schemoid.parse(line))
      rescue Exception => e
        puts e.to_s
        redo
      end
      puts pp(val)
    end
  end

  def pp(expression)
    if expression.is_a?(Symbol) || expression.is_a?(Numeric)
      expression.to_s
    elsif expression == nil
      'nil'
    elsif expression.is_a?(Array) && expression[0] == :closure
      parameters, body, environment = expression[1], expression[2], expression[3]
      "(closure #{pp(parameters)} #{pp(body)})"
    elsif expression.is_a?(Array) && expression[0] == :lambda
      parameters, body = expression[1], expression[2]
      "(lambda #{pp(parameters)} #{pp(body)})"
    elsif expression.is_a?(Hash)
      '{' + expression.map{|k, v| pp(k) + ':' + pp(v)}.join(', ') + '}'
    elsif expression.is_a?(Array)
      '(' + expression.map{|e| pp(e)}.join(', ') + ')'
    else
      exp.to_s
    end
  end
end

SchemoidRepl.new
