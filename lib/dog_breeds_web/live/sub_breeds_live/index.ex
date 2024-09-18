defmodule DogBreedsWeb.SubBreedsLive.Index do
  use DogBreedsWeb, :live_view

  alias DogBreeds.Breeds

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> stream_configure(:sub_breeds_collection, dom_id: & &1.name)
      |> stream(:sub_breeds_collection, Breeds.list_sub_breeds())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"breed" => breed} = _params) do
    socket
    |> assign(:page_title, "Edit Sub breeds")
    |> assign(:sub_breeds, Breeds.breed_data(breed))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sub breeds")
    |> assign(:sub_breeds, socket.assigns.streams.sub_breeds_collection.inserts)
  end

  @impl true
  def handle_info({DogBreedsWeb.SubBreedsLive.FormComponent, {:saved, sub_breeds}}, socket) do
    {:noreply, stream_insert(socket, :sub_breeds_collection, sub_breeds)}
  end
end
