require_relative '../schemoid_type'

class SchemoidTypeTest
  include SchemoidType
end

describe "SchemoidType#list?が呼び出された時" do
  before(:all) do
    @schemoid_type = SchemoidTypeTest.new
  end

  it "引数がリストならtrueを返す" do
    @schemoid_type.list?([1, 2]).should eq(true)
  end

  it "引数がリストでないならfalseを返す" do
    @schemoid_type.list?(3).should eq(false)
  end
end

describe "SchemoidType#immediate_value?が呼び出された時" do
  before(:all) do
    @schemoid_type = SchemoidTypeTest.new
  end

  it "引数が即値ならtrueを返す" do
    @schemoid_type.immediate_value?(3).should eq(true)
    @schemoid_type.immediate_value?("a").should eq(true)
  end

  it "引数が即値でないならfalseを返す" do
    @schemoid_type.immediate_value?([1, 2]).should eq(false)
    @schemoid_type.immediate_value?(:+).should eq(false)
  end
end
