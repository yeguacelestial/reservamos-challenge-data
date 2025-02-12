defmodule ReservamosChallengeWeb.CityController do
  use ReservamosChallengeWeb, :controller

  alias ReservamosChallenge.Locations

  def index(conn, %{"query" => query}) do
    cities = Locations.search_cities(query)
    json(conn, cities)
  end
end
