require_relative '../schemoid'

describe "Schemoid#evalが" do
  before(:all) do
    @schemoid = Schemoid.new
  end

  it "引数にimmediate_valueを与えられて呼び出された時、引数を返す" do
    @schemoid.eval(1).should eq(1)
    @schemoid.eval(:+).should eq(:+)
  end

  it "引数にリストを与えられて呼び出された時、リストを評価・適応した結果を返す" do
    @schemoid.eval([:+, 1, 2]).should eq(3)
    @schemoid.eval([:+, [:/, [:*, 1, 1, 2], [:-, 4, 2]], 1]).should eq(2)
  end
end
