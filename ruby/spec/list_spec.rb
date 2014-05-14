require_relative '../schemoid_list'

class SchemoidListTest
  include SchemoidList
end

describe "SchemoidList#carが呼び出された時" do
  before(:all) do
    @schemoid_list = SchemoidListTest.new
  end

  it "引数に与えられたリストの先頭を返す" do
    @schemoid_list.car([1, 2, 3]).should eq(1)
  end
end

describe "SchemoidList#cdrが呼び出された時" do
  before(:all) do
    @schemoid_list = SchemoidListTest.new
  end

  it "引数に与えられたリストのtailを返す" do
    @schemoid_list.cdr([1, 2, 3]).should eq([2, 3])
    @schemoid_list.cdr([4, [3, 2]]).should eq([[3, 2]])
  end
end
