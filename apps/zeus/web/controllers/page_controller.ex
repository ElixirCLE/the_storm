defmodule Zeus.PageController do
  use Zeus.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
