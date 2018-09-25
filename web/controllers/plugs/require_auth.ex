defmodule Discuss.Plugs.RequireAuth do
    import Plug.Conn
    import Phoenix.Controller

    alias Discuss.Router.Helpers

    def init(_opts) do
    end

    def call(conn, _params) do
        if is_nil conn.assigns[:user] do
            conn
            |> put_flash(:error, "You must be logged in to see this resource.")
            |> redirect(to: Helpers.topic_path(conn, :index))
            |> halt()
        else
            conn
        end
    end
end