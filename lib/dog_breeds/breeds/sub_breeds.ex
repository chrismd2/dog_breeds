defmodule DogBreeds.Breeds.SubBreeds do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_breeds" do
    field :name, :string
    field :parent_breed, :string
    field :image_count, :integer
    field :images, {:array, :binary}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sub_breeds, attrs) do
    sub_breeds
    |> cast(attrs, [:name, :parent_breed, :image_count, :images])
    |> validate_required([:name, :image_count, :images])
  end
end
