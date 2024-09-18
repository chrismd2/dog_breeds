defmodule DogBreedsWeb.SubBreedsLiveTest do
  use DogBreedsWeb.ConnCase

  import Phoenix.LiveViewTest
  import DogBreeds.BreedsFixtures

  @create_attrs %{name: "some name", parent_breed: "some parent_breed", image_count: 42, images: []}
  @update_attrs %{name: "some updated name", parent_breed: "some updated parent_breed", image_count: 43, images: []}
  @invalid_attrs %{name: nil, parent_breed: nil, image_count: nil, images: []}

  defp create_sub_breeds(_) do
    sub_breeds = sub_breeds_fixture()
    %{sub_breeds: sub_breeds}
  end

  describe "Index" do
    setup [:create_sub_breeds]

    test "lists all sub_breeds", %{conn: conn, sub_breeds: sub_breeds} do
      {:ok, _index_live, html} = live(conn, ~p"/sub_breeds")

      assert html =~ "Listing Sub breeds"
      assert html =~ sub_breeds.name
    end

    test "saves new sub_breeds", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_breeds")

      assert_patch(index_live, ~p"/sub_breeds/new")

      assert index_live
             |> form("#sub_breeds-form", sub_breeds: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_breeds-form", sub_breeds: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_breeds")

      html = render(index_live)
      assert html =~ "Sub breeds created successfully"
      assert html =~ "some name"
    end

    test "updates sub_breeds in listing", %{conn: conn, sub_breeds: sub_breeds} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_breeds")

      assert index_live |> element("#sub_breeds-#{sub_breeds.id} a", "Edit") |> render_click() =~
               "Edit Sub breeds"

      assert_patch(index_live, ~p"/sub_breeds/#{sub_breeds}/edit")

      assert index_live
             |> form("#sub_breeds-form", sub_breeds: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_breeds-form", sub_breeds: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_breeds")

      html = render(index_live)
      assert html =~ "Sub breeds updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes sub_breeds in listing", %{conn: conn, sub_breeds: sub_breeds} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_breeds")

      assert index_live |> element("#sub_breeds-#{sub_breeds.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sub_breeds-#{sub_breeds.id}")
    end
  end

  describe "Show" do
    setup [:create_sub_breeds]

    test "displays sub_breeds", %{conn: conn, sub_breeds: sub_breeds} do
      {:ok, _show_live, html} = live(conn, ~p"/sub_breeds/#{sub_breeds}")

      assert html =~ "Show Sub breeds"
      assert html =~ sub_breeds.name
    end

    test "updates sub_breeds within modal", %{conn: conn, sub_breeds: sub_breeds} do
      {:ok, show_live, _html} = live(conn, ~p"/sub_breeds/#{sub_breeds}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sub breeds"

      assert_patch(show_live, ~p"/sub_breeds/#{sub_breeds}/show/edit")

      assert show_live
             |> form("#sub_breeds-form", sub_breeds: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#sub_breeds-form", sub_breeds: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/sub_breeds/#{sub_breeds}")

      html = render(show_live)
      assert html =~ "Sub breeds updated successfully"
      assert html =~ "some updated name"
    end
  end
end
