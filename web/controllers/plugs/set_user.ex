defmodule Discuss.Plugs.SetUser do
    import Plug.Conn
    alias Discuss.{Repo, User}

    def init(_opts), do: []

    def call(conn, _params) do
        user_id = get_session(conn, :user_id)
        cond do
            user = user_id && Repo.get(User, user_id) ->
                assign(conn, :user, user)
            true ->
                assign(conn, :user, nil)
        end
    end
end