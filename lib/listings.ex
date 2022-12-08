defmodule Centrex.Listings do
  alias Centrex.Listings.Listing

  def create_changeset(%Listing{} = listing, attrs \\ %{}) do
    listing
    |> Ecto.Changeset.cast(attrs, [:price_history, :links_history, :address])
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address])
    |> Ecto.Changeset.apply_action(:insert)
  end
end
