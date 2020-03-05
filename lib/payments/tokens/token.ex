defmodule Payments.Tokens.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :branch_id, :integer
    field :client_token, :string
    field :cmr_id, :integer

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:cmr_id, :branch_id, :client_token])
    |> validate_required([:cmr_id, :branch_id, :client_token])
  end
end
