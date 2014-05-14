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
end
