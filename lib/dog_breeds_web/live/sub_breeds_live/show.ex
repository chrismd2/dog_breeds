defmodule DogBreedsWeb.SubBreedsLive.Show do
  use DogBreedsWeb, :live_view

  alias DogBreeds.Breeds

  @impl true
  def mount(%{"breed" => breed} = _params, _session, socket) do
    socket = socket
    |> assign(:name, breed)
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"breed" => breed, "parent_breed" => parent_breed} = _params, _, socket) do
    breed_data = Breeds.breed_data(%{
      name: breed,
      parent_breed: parent_breed,
     })
    {
      :noreply,
      socket
      |> assign(:name, breed)
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:name, breed_data.name)
      |> assign(:parent_breed, breed_data.parent_breed)
      |> assign(:image_count, breed_data.image_count)
      |> assign(:images, breed_data.images)
    }
  end

  defp page_title(:show), do: "Show Sub breeds"
  defp page_title(:edit), do: "Edit Sub breeds"
end
