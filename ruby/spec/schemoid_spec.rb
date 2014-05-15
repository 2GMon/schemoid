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
    @schemoid.eval([:let, [[:x, 2]], [:let, [[:fun, [:lambda, [], :x]]], [:let, [[:x, 1]], [:fun]]]]).should eq(2)
    @schemoid.eval(
      [:letrec,
       [[:fact,
         [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]],
       [:fact, 0]]).should eq(1)
    @schemoid.eval(
      [:letrec,
       [[:fact,
         [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]],
       [:fact, 4]]).should eq(24)
    @schemoid.eval(
      [:cond,
       [[:>, 1, 1], 1],
       [[:>, 2, 1], 2],
       [[:>, 3, 1], 3],
       [:else, -1]]).should eq(2)
  end

  it "defineによってlambda式を定義できる" do
    schemoid = Schemoid.new
    schemoid.eval([:define, :id, [:lambda, [:x], [:*, :x, 2]]])
    schemoid.eval([:id, 3]).should eq(6)
    schemoid.eval([:define, [:id2, :x], [:*, :x, :x]])
    schemoid.eval([:id2, 2]).should eq(4)

    schemoid = Schemoid.new
    schemoid.eval([:define, [:three_or_five, :n], [:if, [:==, 0, [:%, :n, 3]], :n, [:if, [:==, 0, [:%, :n, 5]], :n, 0]]])
    schemoid.eval([:three_or_five, 2]).should eq(0)
    schemoid.eval([:three_or_five, 3]).should eq(3)
    schemoid.eval([:three_or_five, 4]).should eq(0)
    schemoid.eval([:three_or_five, 5]).should eq(5)
    schemoid.eval([:three_or_five, 6]).should eq(6)
    schemoid.eval([:three_or_five, 7]).should eq(0)
    schemoid.eval([:three_or_five, 8]).should eq(0)
    schemoid.eval([:three_or_five, 9]).should eq(9)
    schemoid.eval([:three_or_five, 10]).should eq(10)
    schemoid.eval([:letrec, [[:fact, [:lambda, [:n], [:if, [:<, :n, 3], 0, [:+, [:three_or_five, :n], [:fact, [:-, :n, 1]]]]]]], [:fact, 9]]).should eq(23)

    schemoid = Schemoid.new
    schemoid.eval([:define, [:three_or_five, :n],
                   [:cond,
                    [[:==, 0, [:%, :n, 3]], :n],
                    [[:==, 0, [:%, :n, 5]], :n],
                    [:else, 0]
                   ]
                  ])
    schemoid.eval([:letrec, [[:fact, [:lambda, [:n], [:if, [:<, :n, 3], 0, [:+, [:three_or_five, :n], [:fact, [:-, :n, 1]]]]]]], [:fact, 9]]).should eq(23)
  end

  it "parseによってSchemeのように書ける" do
    @schemoid.eval(@schemoid.parse('(+ 1 2)')).should eq(3)
    @schemoid.eval(@schemoid.parse('((lambda (x) (+ x 1)) 2)')).should eq(3)
  end
end
