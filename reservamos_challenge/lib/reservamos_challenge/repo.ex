defmodule ReservamosChallenge.Repo do
  use Ecto.Repo,
    otp_app: :reservamos_challenge,
    adapter: Ecto.Adapters.Postgres
end
