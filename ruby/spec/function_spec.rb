require_relative '../schemoid'

describe "組み込み関数" do
  before(:all) do
    @schemoid_function = Schemoid.new
  end

  it "+が引数全ての和を返す" do
    @schemoid_function.apply(:+, [1, 2]).should eq(3)
    @schemoid_function.apply(:+, [2, 3, 4]).should eq(9)
    @schemoid_function.apply(:+, [2, 3, -4, -1]).should eq(0)
  end

  it "-が引数最初の値から、残りの値を全て引いた数を返す" do
    @schemoid_function.apply(:-, [1, 2]).should eq(-1)
    @schemoid_function.apply(:-, [8, 3, 4]).should eq(1)
    @schemoid_function.apply(:-, [2, 3, -4, -1]).should eq(4)
  end

  it "*が引数全ての積を返す" do
    @schemoid_function.apply(:*, [1, 2]).should eq(2)
    @schemoid_function.apply(:*, [8, 3, 0]).should eq(0)
    @schemoid_function.apply(:*, [2, 3, -4, -1]).should eq(24)
  end

  it "/が引数最初の値を残りの値全てで割った数を返す" do
    @schemoid_function.apply(:/, [1, 2]).should eq(0)
    @schemoid_function.apply(:/, [1.0, 2]).should eq(0.5)
    @schemoid_function.apply(:/, [8, 3, 1]).should eq(2)
    @schemoid_function.apply(:/, [8, -4, -1]).should eq(2)
  end

  it ">は左辺の方が右辺より大きい時にtrueを返す" do
    @schemoid_function.apply(:>, [2, 1]).should eq(true)
    @schemoid_function.apply(:>, ["b", "a"]).should eq(true)
  end

  it ">は左辺の方が右辺より大きくない時にfalseを返す" do
    @schemoid_function.apply(:>, [-1, 1]).should eq(false)
    @schemoid_function.apply(:>, [1, 1]).should eq(false)
    @schemoid_function.apply(:>, ["A", "x"]).should eq(false)
  end

  it ">=は左辺のが右辺以上の時にtrueを返す" do
    @schemoid_function.apply(:>=, [2, 1]).should eq(true)
    @schemoid_function.apply(:>=, [3, 3]).should eq(true)
  end

  it ">=は左辺の方が右辺より小さい時にfalseを返す" do
    @schemoid_function.apply(:>=, [-1, 1]).should eq(false)
    @schemoid_function.apply(:>=, ["A", "x"]).should eq(false)
  end

  it "<は左辺の方が右辺より小さい時にtrueを返す" do
    @schemoid_function.apply(:<, [1, 3]).should eq(true)
    @schemoid_function.apply(:<, ["a", "d"]).should eq(true)
  end

  it "<は左辺の方が右辺より小さくない時にfalseを返す" do
    @schemoid_function.apply(:<, [1, 1]).should eq(false)
    @schemoid_function.apply(:<, [1, 0]).should eq(false)
    @schemoid_function.apply(:<, ["t", "a"]).should eq(false)
  end

  it "<=は左辺のが右辺以下の時にtrueを返す" do
    @schemoid_function.apply(:<=, [1, 1]).should eq(true)
    @schemoid_function.apply(:<=, [2, 3]).should eq(true)
  end

  it "<=は左辺の方が右辺より大きい時にfalseを返す" do
    @schemoid_function.apply(:<=, [1, 0]).should eq(false)
    @schemoid_function.apply(:<=, ["x", "a"]).should eq(false)
  end

  it "==は左辺と右辺が等しい時にtrueを返す" do
    @schemoid_function.apply(:==, [1, 1]).should eq(true)
    @schemoid_function.apply(:==, ["a", "a"]).should eq(true)
  end

  it "==は左辺と右辺が異なる時にfalseを返す" do
    @schemoid_function.apply(:==, [1, 0]).should eq(false)
    @schemoid_function.apply(:==, ["x", "a"]).should eq(false)
  end

  it "!=は左辺と右辺が異なる時にtrueを返す" do
    @schemoid_function.apply(:!=, [0, 1]).should eq(true)
    @schemoid_function.apply(:!=, ["A", "a"]).should eq(true)
  end

  it "!=は左辺と右辺が等しい時にfalseを返す" do
    @schemoid_function.apply(:!=, [1, 1]).should eq(false)
    @schemoid_function.apply(:!=, ["a", "a"]).should eq(false)
  end
end
