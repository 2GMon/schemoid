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
