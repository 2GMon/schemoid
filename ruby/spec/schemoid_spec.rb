require_relative '../schemoid'

describe "Schemoid#evalが" do
  before(:all) do
    @schemoid = Schemoid.new
  end

  it "引数にimmediate_valueを与えられて呼び出された時、引数を返す" do
    @schemoid.eval(1).should eq(1)
    @schemoid.eval("a").should eq("a")
  end

  it "引数にリストを与えられて呼び出された時、リストを評価・適応した結果を返す" do
    @schemoid.eval([:+, 1, 2]).should eq(3)
    @schemoid.eval([:+, [:/, [:*, 1, 1, 2], [:-, 4, 2]], 1]).should eq(2)
    @schemoid.eval([[:lambda, [:x], [:+, :x, 1]], 2]).should eq(3)
    @schemoid.eval([[:lambda, [:x], [:+, :x, [[:lambda, [:x], :x], 2]]], 3]).should eq(5)
    @schemoid.eval([:let, [[:x, 3], [:y, 2]], [:+, :x, :y]]).should eq(5)
    @schemoid.eval([:if, [:>, 3, 2], 1, 0]).should eq(1)
    @schemoid.eval([:let, [[:x, 1], [:y, 1]], [:if, [:!=, :x, :y], 0, -1]]).should eq(-1)
  end
end
