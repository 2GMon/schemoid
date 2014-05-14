require_relative '../schemoid_eval'

class SchemoidEvalTest
  include SchemoidEval
end

describe "SchemoidEval" do
  before(:all) do
    @schemoid_eval = SchemoidEvalTest.new
  end

  it "eval_letはlambdaを返す" do
    @schemoid_eval.eval_let(
      [:let, [[:x, 3], [:y, 2]], [:+, :x, :y]], []
    ).should eq([[:lambda, [:x, :y], [:+, :x, :y]], 3, 2])
  end
end
