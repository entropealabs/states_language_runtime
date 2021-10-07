defmodule Runtime do
  @moduledoc "This is where you would define your state machine DSL"
  def get_module(name, data) do
    quote do
      defmodule unquote(name) do
        use StatesLanguage, data: unquote(data)

        require Logger

        def handle_resource(<<"Call:", number::binary>>, _, "TheFirst", data) do
          Logger.info("Starting with # #{number} in The First")
          {:ok, data, [{:next_event, :internal, :next}]}
        end

        def handle_resource(<<"Hold:", length::binary>>, _, "TheFirst", data) do
          Logger.info("Holding for #{length} seconds in TheFirst")
          {:ok, data, [{:next_event, :internal, :next}]}
        end

        def handle_resource("Hangup", _, "TheSecond", data) do
          Logger.info("Hangup in TheSecond")
          {:ok, data, [{:next_event, :internal, :end}]}
        end

        def handle_resource("Hangup2", _, "TheSecond", data) do
          Logger.info("Hangup2 in TheSecond")
          {:ok, data, [{:next_event, :internal, :end}]}
        end
      end
    end
  end
end
