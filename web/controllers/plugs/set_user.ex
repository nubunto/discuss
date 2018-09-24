defmodule Discuss.Plugs.SetUser do
    import Plug.Conn
    import Phoenix.Controller

    alias Discuss.{Repo, User, Router.Helpers}

    def init(_opts), do: []

    def call(conn, _params) do
        
    end
end