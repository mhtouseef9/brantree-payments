defmodule Payments.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :cmr_id, :integer
      add :branch_id, :integer
      add :client_token, :text

      timestamps()
    end

  end
end
