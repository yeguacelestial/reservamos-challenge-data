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
    min_price = Map.get(params, "min_price", nil) |> parse_float()
    max_price = Map.get(params, "max_price", nil) |> parse_float()
    min_rating = Map.get(params, "min_rating", nil) |> parse_float()
    amenities_filter = Map.get(params, "amenities", "") |> String.split(",")

    cities = Locations.search_cities(query)
    rooms_data = load_rooms_data()

    enriched_cities = Enum.map(cities, fn city ->
      filtered_rooms = Enum.filter(rooms_data, fn row ->
        city_match = Enum.at(row, 4) == city["city_name"]
        state_match = Enum.at(row, 5) == city["state"]
        country_match = Enum.at(row, 6) == city["country"]
        price_match = if min_price || max_price, do: match_price(Enum.at(row, 2), min_price, max_price), else: true
        rating_match = if min_rating, do: match_rating(Enum.at(row, 14), min_rating), else: true
        amenities_match = if amenities_filter != [""], do: match_amenities(Enum.at(row, 7), amenities_filter), else: true
        city_match and state_match and country_match and price_match and rating_match and amenities_match
      end)

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

  defp parse_float(value) when is_binary(value), do: Float.parse(value) |> elem(0)
  defp parse_float(_), do: nil

  defp match_price(price, min_price, max_price) do
    price = parse_float(price)
    (is_nil(min_price) or price >= min_price) and (is_nil(max_price) or price <= max_price)
  end

  defp match_rating(rating, min_rating) do
    rating = parse_float(rating)
    is_nil(min_rating) or rating >= min_rating
  end

  defp match_amenities(amenities_json, amenities_filter) do
    amenities = Jason.decode!(amenities_json)
    Enum.all?(amenities_filter, fn amenity -> amenity in amenities end)
  end
end
