defmodule ReservamosChallengeWeb.CityController do
  use ReservamosChallengeWeb, :controller
  use PhoenixSwagger

  alias ReservamosChallenge.Locations
  alias NimbleCSV.RFC4180, as: CSV
  alias Jason

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
      filtered_rooms = Enum.filter(rooms_data, fn row -> Enum.at(row, 4) == city["city_name"] end)
      formatted_rooms = Enum.map(filtered_rooms, fn room ->
        amenities = Enum.at(room, 7) |> Jason.decode!()
        %{
          url: Enum.at(room, 0),
          title: Enum.at(room, 1),
          price_per_night: Enum.at(room, 2),
          currency: Enum.at(room, 3),
          amenities: amenities,
          rating_overall: Enum.at(room, 14),
          total_reviews: Enum.at(room, 15)
        }
      end)
      Map.put(city, "rooms_data", formatted_rooms)
    end)

    json(conn, enriched_cities)
  end
end
