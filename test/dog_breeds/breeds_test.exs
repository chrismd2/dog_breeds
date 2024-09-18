defmodule DogBreeds.BreedsTest do
  use DogBreeds.DataCase

  alias DogBreeds.Breeds

  describe "sub_breeds" do
    alias DogBreeds.Breeds.SubBreeds

    import DogBreeds.BreedsFixtures

    @invalid_attrs %{name: nil, parent_breed: nil, image_count: nil, images: nil}

    test "list_sub_breeds/0 returns all sub_breeds" do
      sub_breeds = sub_breeds_fixture()
      assert Breeds.list_sub_breeds() == [sub_breeds]
    end

    test "get_sub_breeds!/1 returns the sub_breeds with given id" do
      sub_breeds = sub_breeds_fixture()
      assert Breeds.get_sub_breeds!(sub_breeds.id) == sub_breeds
    end

    test "create_sub_breeds/1 with valid data creates a sub_breeds" do
      valid_attrs = %{name: "some name", parent_breed: "some parent_breed", image_count: 42, images: []}

      assert {:ok, %SubBreeds{} = sub_breeds} = Breeds.create_sub_breeds(valid_attrs)
      assert sub_breeds.name == "some name"
      assert sub_breeds.parent_breed == "some parent_breed"
      assert sub_breeds.image_count == 42
      assert sub_breeds.images == []
    end

    test "create_sub_breeds/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Breeds.create_sub_breeds(@invalid_attrs)
    end

    test "update_sub_breeds/2 with valid data updates the sub_breeds" do
      sub_breeds = sub_breeds_fixture()
      update_attrs = %{name: "some updated name", parent_breed: "some updated parent_breed", image_count: 43, images: []}

      assert {:ok, %SubBreeds{} = sub_breeds} = Breeds.update_sub_breeds(sub_breeds, update_attrs)
      assert sub_breeds.name == "some updated name"
      assert sub_breeds.parent_breed == "some updated parent_breed"
      assert sub_breeds.image_count == 43
      assert sub_breeds.images == []
    end

    test "update_sub_breeds/2 with invalid data returns error changeset" do
      sub_breeds = sub_breeds_fixture()
      assert {:error, %Ecto.Changeset{}} = Breeds.update_sub_breeds(sub_breeds, @invalid_attrs)
      assert sub_breeds == Breeds.get_sub_breeds!(sub_breeds.id)
    end

    test "delete_sub_breeds/1 deletes the sub_breeds" do
      sub_breeds = sub_breeds_fixture()
      assert {:ok, %SubBreeds{}} = Breeds.delete_sub_breeds(sub_breeds)
      assert_raise Ecto.NoResultsError, fn -> Breeds.get_sub_breeds!(sub_breeds.id) end
    end

    test "change_sub_breeds/1 returns a sub_breeds changeset" do
      sub_breeds = sub_breeds_fixture()
      assert %Ecto.Changeset{} = Breeds.change_sub_breeds(sub_breeds)
    end
  end
end
