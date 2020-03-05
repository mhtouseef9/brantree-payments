defmodule Payments.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Payments.Transactions.Transaction
  @primary_key false
  schema "transactions" do
    field :id, :string, primary_key: false, null: false
    field :user_name, :string
    field :amount, :float, null: false
    field :tax_amount, :float
    field :merchant_account_id, :string, null: false
    field :order_id, :string
    field :type, :string
    field :currency_iso_code, :string
    field :add_ons, {:array, :map}
    field :escrow_status, :string
    field :disputes, {:array, :map}
    field :credit_card, :map
    field :subscription_id, :string
    field :subscription_details, :map
    field :payment_instrument_type, :string
    field :disbursement_details, :map
    field :processor_authorization_code, :string
    field :status_history, {:array, :map}

    timestamps()
  end

  @doc false
  def changeset(%Transaction{} = transaction, attrs) do
    transaction
    |> cast(attrs, [:id, :user_name, :amount, :tax_amount, :merchant_account_id, :order_id, :type, :currency_iso_code, :add_ons, :escrow_status, :disputes, :credit_card, :subscription_id, :payment_instrument_type, :disbursement_details, :processor_authorization_code, :status_history])
    |> validate_required([:id, :merchant_account_id, :amount])
  end
end
