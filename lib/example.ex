defmodule Example do
  defmodule State do
    defstruct [:step1, :step2]
  end

  def run() do
    data1 = %{
      "Comment" => "Example",
      "StartAt" => "TheFirst",
      "States" => %{
        "TheFirst" => %{
          "Type" => "Task",
          "Resource" => "Start",
          "TransitionEvent" => ":next",
          "Next" => "TheSecond"
        },
        "TheSecond" => %{
          "Type" => "Task",
          "Resource" => "End",
          "End" => true
        }
      }
    }

    mod1 = Runtime.get_module(MyUniqueStateMachine, data1)

    data2 = %{
      "Comment" => "Example",
      "StartAt" => "TheFirst",
      "States" => %{
        "TheFirst" => %{
          "Type" => "Task",
          "Resource" => "Start2",
          "TransitionEvent" => ":next",
          "Next" => "TheSecond"
        },
        "TheSecond" => %{
          "Type" => "Task",
          "Resource" => "End2",
          "End" => true
        }
      }
    }

    mod2 = Runtime.get_module(MyUniqueStateMachine2, data2)

    comp1 = Code.compile_quoted(mod1)
    comp2 = Code.compile_quoted(mod2)

    Enum.each(comp1, fn {mod, _} ->
      Code.ensure_loaded!(mod)
      mod.start_link(%State{})
    end)

    Enum.each(comp2, fn {mod, _} ->
      Code.ensure_loaded!(mod)
      mod.start_link(%State{})
    end)
  end
end
