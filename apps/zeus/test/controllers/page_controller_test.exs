defmodule Zeus.PageControllerTest do
  use Zeus.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Choose a color"
  end
end
