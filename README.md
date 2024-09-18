# DogBreeds

## Installation
Add this project to the local directory (ie `git clone https://github.com/chrismd2/dog_breeds`) and the package can be installed
by adding `dog_breeds` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
      {:dog_breeds, "~> 0.1.0", path: "./dog_breeds"},
  ]
end
```

Add routes to server this project is integrated with to existing routes
```elixir
  scope "/sub_breeds", DogBreedsWeb do
    pipe_through :browser

    live "/", SubBreedsLive.Index, :index
    live "/:breed/", SubBreedsLive.Show, :show
  end
```