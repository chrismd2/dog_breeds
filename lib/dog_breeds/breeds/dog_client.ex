defmodule DogBreeds.Breeds.DogClient do
  @uri "https://dog.ceo/api/breed"

  def get_breeds() do
    url = @uri <> "s/list/all"

    Finch.build(:get, url)
    |> Finch.request!(DogBreeds.Finch)
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("message")
  end

  def all_breeds() do
    breeds_map = get_breeds()

    all_parent_breeds(breeds_map) ++ all_sub_breeds(breeds_map)
  end

  def all_parent_breeds(breeds_map \\ get_breeds()) do
    Map.keys(breeds_map)
  end

  def all_sub_breeds(breeds_map \\ get_breeds()) do
    Enum.reduce(
      breeds_map,
      [],
      fn {parent_breed, sub_breeds}, accumulated_list -> accumulated_list ++ Enum.map(sub_breeds, & "#{parent_breed}-#{&1}") end
    )
  end

  @doc """
  Fetch list of image links from API
  """
  def get_breed_image_links(parent_breed, sub_breed \\ nil) do
    url = if sub_breed && sub_breed != "" do
      @uri <> "/#{parent_breed}/#{sub_breed}/images"
    else
      @uri <> "/#{parent_breed}/images"
    end

    message = Finch.build(:get, url)
    |> Finch.request!(DogBreeds.Finch)
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("message")

    is_list(message) && message || []
  end
end
