defmodule DogBreeds.Breeds do
  @moduledoc """
  The Breeds context.
  """

  import Ecto.Query, warn: false
  alias DogBreeds.Repo

  alias DogBreeds.Breeds.SubBreeds
  alias DogBreeds.Breeds.DogClient

  @doc """
  Returns the list of sub_breeds.

  ## Examples

      iex> list_sub_breeds()
      [%SubBreeds{}, ...]

  """
  def list_sub_breeds do
    DogClient.get_breeds()
    |> format_breeds()
    |> Enum.map(
      fn breed ->
        changeset = %SubBreeds{}
        |> SubBreeds.changeset(breed)

        Map.merge(changeset.data, changeset.changes)
        |> Map.put(:id, breed.name)
      end
    )
  end

  defp format_breeds(breeds_map) do
    parent_breeds = breeds_map
    |> DogClient.all_parent_breeds()
    |> Enum.map( &
      %{
        name: &1,
        parent_breed: "",
        image_count: -1,
        images: []
      }
    )

    sub_breeds = breeds_map
    |> DogClient.all_sub_breeds()
    |> Enum.map( &
      %{
        name: &1 |> String.split("-") |> List.last(),
        parent_breed: &1 |> String.split("-") |> List.first(),
        image_count: -1,
        images: []
      }
    )

    parent_breeds ++ sub_breeds
  end


  @doc """
  Gets a single sub_breeds.

  Raises `Ecto.NoResultsError` if the Sub breeds does not exist.

  ## Examples

      iex> get_sub_breeds!(123)
      %SubBreeds{}

      iex> get_sub_breeds!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_breeds!(id), do: Repo.get!(SubBreeds, id)

  @doc """
  Creates a sub_breeds.

  ## Examples

      iex> create_sub_breeds(%{field: value})
      {:ok, %SubBreeds{}}

      iex> create_sub_breeds(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_breeds(attrs \\ %{}) do
    %SubBreeds{}
    |> SubBreeds.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_breeds.

  ## Examples

      iex> update_sub_breeds(sub_breeds, %{field: new_value})
      {:ok, %SubBreeds{}}

      iex> update_sub_breeds(sub_breeds, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_breeds(%SubBreeds{} = sub_breeds, attrs) do
    sub_breeds
    |> SubBreeds.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_breeds.

  ## Examples

      iex> delete_sub_breeds(sub_breeds)
      {:ok, %SubBreeds{}}

      iex> delete_sub_breeds(sub_breeds)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_breeds(%SubBreeds{} = sub_breeds) do
    Repo.delete(sub_breeds)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_breeds changes.

  ## Examples

      iex> change_sub_breeds(sub_breeds)
      %Ecto.Changeset{data: %SubBreeds{}}

  """
  def change_sub_breeds(%SubBreeds{} = sub_breeds, attrs \\ %{}) do
    SubBreeds.changeset(sub_breeds, attrs)
  end
end
