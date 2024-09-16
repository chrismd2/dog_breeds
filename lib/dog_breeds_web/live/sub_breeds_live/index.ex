defmodule DogBreedsWeb.SubBreedsLive.Index do
  use DogBreedsWeb, :live_view

  alias DogBreeds.Breeds
  alias DogBreeds.Breeds.SubBreeds

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :sub_breeds_collection, Breeds.list_sub_breeds())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sub breeds")
    |> assign(:sub_breeds, Breeds.get_sub_breeds!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sub breeds")
    |> assign(:sub_breeds, %SubBreeds{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sub breeds")
    |> assign(:sub_breeds, nil)
  end

  @impl true
  def handle_info({DogBreedsWeb.SubBreedsLive.FormComponent, {:saved, sub_breeds}}, socket) do
    {:noreply, stream_insert(socket, :sub_breeds_collection, sub_breeds)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sub_breeds = Breeds.get_sub_breeds!(id)
    {:ok, _} = Breeds.delete_sub_breeds(sub_breeds)

    {:noreply, stream_delete(socket, :sub_breeds_collection, sub_breeds)}
  end
end
