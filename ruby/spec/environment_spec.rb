require_relative '../schemoid_environment'

class SchemoidEnvironmentTest
  include SchemoidEnvironment
end

describe "SchemoidEnvironment" do
  before(:all) do
    @schemoid_environment = SchemoidEnvironmentTest.new
  end

  it "extend_environmentは環境の先頭に新しい環境を追加する" do
    @schemoid_environment.extend_environment([:x], [1], []).should eq([{:x => 1}])
    @schemoid_environment.extend_environment(
      [:x, :y], [1, 0], []).should eq([{:x => 1, :y => 0}])
    @schemoid_environment.extend_environment(
      [:x, :y], [2, 3], [{:x => 1, :y => 0}]
    ).should eq([{:x => 2, :y => 3}, {:x => 1, :y => 0}])
  end

  it "lookup_valueは環境の先頭から値を探して、一番最初に見つかったものを返す" do
    @schemoid_environment.lookup_value(:x, [{:x => 1}]).should eq(1)
    @schemoid_environment.lookup_value(:x, [{:x => 2, :y => 3}, {:x => 1, :y => 0}]).should eq(2)
    @schemoid_environment.lookup_value(:y, [{:x => 2}, {:x => 1, :y => 0}]).should eq(0)
  end

  it "set_extend_environment!は先頭の環境を上書きする" do
    env = [{:x => 0}, {:x => 1, :y => 0}]
    @schemoid_environment.set_extend_environment!([:x], [1], env)
    env.should eq([{:x => 1}, {:x => 1, :y => 0}])

    env = [{:x => 0, :y => 1}, {:z => 0}]
    @schemoid_environment.set_extend_environment!([:x, :y], [1, 0], env)
    env.should eq([{:x => 1, :y => 0}, {:z => 0}])
  end
end
