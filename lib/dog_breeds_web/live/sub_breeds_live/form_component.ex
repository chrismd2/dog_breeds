defmodule DogBreedsWeb.SubBreedsLive.FormComponent do
  use DogBreedsWeb, :live_component

  alias DogBreeds.Breeds

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage sub_breeds records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="sub_breeds-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:parent_breed]} type="text" label="Parent breed" />
        <.input field={@form[:image_count]} type="number" label="Image count" />
        <.input
          field={@form[:images]}
          type="select"
          multiple
          label="Images"
          options={[]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Sub breeds</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{sub_breeds: sub_breeds} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Breeds.change_sub_breeds(sub_breeds))
     end)}
  end

  @impl true
  def handle_event("validate", %{"sub_breeds" => sub_breeds_params}, socket) do
    changeset = Breeds.change_sub_breeds(socket.assigns.sub_breeds, sub_breeds_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sub_breeds" => sub_breeds_params}, socket) do
    save_sub_breeds(socket, socket.assigns.action, sub_breeds_params)
  end

  defp save_sub_breeds(socket, :edit, sub_breeds_params) do
    case Breeds.update_sub_breeds(socket.assigns.sub_breeds, sub_breeds_params) do
      {:ok, sub_breeds} ->
        notify_parent({:saved, sub_breeds})

        {:noreply,
         socket
         |> put_flash(:info, "Sub breeds updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sub_breeds(socket, :new, sub_breeds_params) do
    case Breeds.create_sub_breeds(sub_breeds_params) do
      {:ok, sub_breeds} ->
        notify_parent({:saved, sub_breeds})

        {:noreply,
         socket
         |> put_flash(:info, "Sub breeds created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
