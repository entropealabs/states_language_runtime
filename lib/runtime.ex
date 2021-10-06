defmodule Runtime do
  @moduledoc "This is where you would define your state machine DSL"
  def get_module(name, data) do
    quote do
      defmodule unquote(name) do
        use StatesLanguage, data: unquote(data)

        defmodule State do
          defstruct [:step1, :step2]
        end

        require Logger

        def handle_resource("Start", _, "TheFirst", data) do
          Logger.info("Start in State1")
          {:ok, data, [{:next_event, :internal, :next}]}
        end

        def handle_resource("Start2", _, "TheFirst", data) do
          Logger.info("Start2 in State1")
          {:ok, data, [{:next_event, :internal, :next}]}
        end

        def handle_resource("End", _, "TheSecond", data) do
          Logger.info("End in State2")
          {:ok, data, [{:next_event, :internal, :end}]}
        end

        def handle_resource("End2", _, "TheSecond", data) do
          Logger.info("End2 in State2")
          {:ok, data, [{:next_event, :internal, :end}]}
        end
      end
    end
  end
end
