defmodule DogBreeds.BreedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DogBreeds.Breeds` context.
  """

  @doc """
  Generate a sub_breeds.
  """
  def sub_breeds_fixture(attrs \\ %{}) do
    {:ok, sub_breeds} =
      attrs
      |> Enum.into(%{
        image_count: 42,
        images: [],
        name: "some name",
        parent_breed: "some parent_breed"
      })
      |> DogBreeds.Breeds.create_sub_breeds()

    sub_breeds
  end
end
