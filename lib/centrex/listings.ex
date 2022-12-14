defmodule Centrex.Listings do
  alias Centrex.Listings.Listing
  alias Centrex.Repo

  def create_listing(listing, attrs) do
    attrs = %{attrs | address: format_address(attrs.address)}

    listing
    |> Ecto.Changeset.cast(attrs, [:price_history, :links_history, :address, :type],
      empty_value: ["", []]
    )
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address, :type])
    |> Ecto.Changeset.unique_constraint(:address, name: :listings_pkey)
    |> Repo.insert()
    |> case do
      {:ok, listing} ->
        Centrex.ListingSupervisor.add_listing_to_supervisor(listing)
        {:ok, listing}

      error ->
        error
    end
  end

  def create_changeset(%Listing{} = listing, attrs \\ %{}) do
    listing
    |> Ecto.Changeset.cast(attrs, [:price_history, :links_history, :address])
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address])
    |> Ecto.Changeset.apply_action(:insert)
  end

  def format_address(address) do
    address
    |> String.trim()
    |> String.replace(",", "")
  end
end
