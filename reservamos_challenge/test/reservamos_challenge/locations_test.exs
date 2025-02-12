defmodule ReservamosChallenge.LocationsTest do
  use ReservamosChallenge.DataCase

  alias ReservamosChallenge.Locations

  describe "cities" do
    alias ReservamosChallenge.Locations.City

    import ReservamosChallenge.LocationsFixtures

    @invalid_attrs %{name: nil, country: nil}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Locations.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Locations.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{name: "some name", country: "some country"}

      assert {:ok, %City{} = city} = Locations.create_city(valid_attrs)
      assert city.name == "some name"
      assert city.country == "some country"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{name: "some updated name", country: "some updated country"}

      assert {:ok, %City{} = city} = Locations.update_city(city, update_attrs)
      assert city.name == "some updated name"
      assert city.country == "some updated country"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_city(city, @invalid_attrs)
      assert city == Locations.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Locations.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Locations.change_city(city)
    end
  end
end
