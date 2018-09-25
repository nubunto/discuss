defmodule Discuss.LayoutView do
  use Discuss.Web, :view

  def has_user(conn) do
    not is_nil(conn.assigns[:user])
  end
end
