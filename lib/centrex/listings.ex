defmodule Centrex.Listings do
  alias Centrex.Listings.Listing
  alias Centrex.Repo

  def track_listing(address, price, link, type) do
    %Listing{}
    |> Ecto.Changeset.cast(
      %{
        "address" => address,
        "price_history" => [price],
        "links_history" => [link],
        "type" => type
      },
      [:price_history, :links_history, :address, :type],
      empty_value: ["", []]
    )
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address, :type])
    |> Ecto.Changeset.unique_constraint(:address, name: :listings_pkey)
    |> Repo.insert()
  end

  def update_listing(%Listing{price_history: [price | _], links_history: [link | _]}, price, link) do
    {:error, :no_change}
  end

  def update_listing(
        %Listing{price_history: price_history, links_history: links_history} = listing,
        price,
        link
      ) do
    listing
    |> Ecto.Changeset.cast(
      %{
        "price_history" => [price | price_history],
        "links_history" => [link | links_history]
      },
      [:price_history, :links_history]
    )
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address, :type])
    |> Ecto.Changeset.unique_constraint(:address, name: :listings_pkey)
    |> Repo.update()
  end

  def create_changeset(%Listing{} = listing, attrs \\ %{}) do
    listing
    |> Ecto.Changeset.cast(attrs, [:price_history, :links_history, :address])
    |> Ecto.Changeset.validate_required([:price_history, :links_history, :address])
    |> Ecto.Changeset.apply_action(:insert)
  end
end
