defmodule GenX.CommonTest.Test do
  use ExUnit.Case

  test "invoking CT tests from ExUnit" do
    assert run([MyTest])
  end

  def run(suites) do
    logdir = binary_to_list(File.join([File.dirname(__FILE__), "log"]))
    CommonTest.run logdir: logdir, suite: suites,
       extra: [multiply: 1, scale: false]
  end
end

defmodule MyTest do
  use CommonTest.Suite
  alias CommonTest, as: CT

  test "simple test" do
    1=1
  end

  test "simple test with a config", config: config do
    CT.pal("~p",[config])
    ^config=config
  end

  group "my group", :sequence do
    test "another test" do
      1=1
    end
  end

  group "another group", [:shuffle, :sequence] do
    test "interesting test" do
      1=1
    end
  end

  test "with elixir config" do
    CT.ensure :multiply
    1 = CT.get_config(:multiply)
    CT.ensure :scale
    false = CT.get_config(:scale)
   end

end

