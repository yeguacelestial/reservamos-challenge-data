defmodule ReservamosChallenge.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservamosChallenge.Locations` context.
  """

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        country: "some country",
        name: "some name"
      })
      |> ReservamosChallenge.Locations.create_city()

    city
  end
end
