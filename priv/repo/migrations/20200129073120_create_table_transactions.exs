defmodule Payments.Repo.Migrations.CreateTableTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :string, null: false, primary_key: true
      add :amount, :float, null: false
      add :tax_amount, :float
      add :merchant_account_id, :string, null: false
      add :order_id, :string
      add :type, :string
      add :currency_iso_code, :string
      add :add_ons, {:array, :map}
      add :escrow_status, :string
      add :disputes, {:array, :map}
      add :credit_card, :map
      add :subscription_id, :string
      add :subscription_details, :map
      add :payment_instrument_type, :string
      add :disbursement_details, :map
      add :processor_authorization_code, :string
      add :status_history, {:array, :map}
      add :user_name, :string


      timestamps()
    end

  end
end
