defmodule ReservamosChallengeWeb.CityController do
  use ReservamosChallengeWeb, :controller
  use PhoenixSwagger

  alias ReservamosChallenge.Locations

  swagger_path :index do
    get "/api/cities"
    description "Lista de ciudades"
    parameter :query, :query, :string, "Nombre de la ciudad", required: false
    response 200, "Success", :City
  end

  def index(conn, params) do
    query = Map.get(params, "query", "")
    cities = Locations.search_cities(query)
    json(conn, cities)
  end
end
