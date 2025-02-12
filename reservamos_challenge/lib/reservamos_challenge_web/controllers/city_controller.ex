defmodule ReservamosChallengeWeb.CityController do
  use ReservamosChallengeWeb, :controller
  use PhoenixSwagger

  alias ReservamosChallenge.Locations
  alias NimbleCSV.RFC4180, as: CSV

  swagger_path :index do
    get "/api/cities"
    description "Lista de ciudades"
    parameter :query, :query, :string, "Nombre de la ciudad", required: false
    response 200, "Success", :City
  end

  defp load_rooms_data do
    "rooms_data.csv"
    |> File.stream!()
    |> CSV.parse_stream(headers: true)
  end

  def index(conn, params) do
    query = Map.get(params, "query", "")
    cities = Locations.search_cities(query)
    rooms_data = load_rooms_data()

    enriched_cities = Enum.map(cities, fn city ->
      #city_name = String.downcase(String.trim(city["city_name"]))
      filtered_rooms = Enum.filter(rooms_data, fn row -> Enum.at(row, 4) == city["city_name"] end)
      Map.put(city, "rooms_data", filtered_rooms)
    end)

    json(conn, enriched_cities)
  end
end
