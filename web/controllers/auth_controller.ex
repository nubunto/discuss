defmodule Discuss.AuthController do
    use Discuss.Web, :controller
    alias Discuss.User

    plug Ueberauth

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
        user_params = %{
            token: auth.credentials.token,
            email: auth.info.email,
            provider: provider
        }
        changeset = User.changeset(%User{}, user_params)
        signin(conn, changeset)
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: topic_path(conn, :index))
    end

    defp signin(conn, changeset) do
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome!")
                |> put_session(:user_id, user.id)
                |> redirect(to: topic_path(conn, :index))
            {:error, %{errors: [email: {"has already been taken", _rest}]} = changeset} ->
                user = Repo.get_by(User, email: changeset.changes.email)
                conn
                |> put_flash(:info, "Welcome back!")
                |> put_session(:user_id, user.id)
                |> redirect(to: topic_path(conn, :index))
            {:error, reason} ->
                IO.inspect(reason)
                conn
                |> put_flash(:error, "Error signing in")
                |> redirect(to: topic_path(conn, :index))
        end
    end

end