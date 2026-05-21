defmodule SkillPotWeb.PageControllerTest do
  use SkillPotWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "One skill library."
  end
end
