defmodule PaymentsWeb.SubscriptionController do
  use PaymentsWeb, :controller
  alias Payments.Payment
  alias Payments.Transactions.Transaction

  #create subscription to charge on regular basis i.e weekly, monthly, yearly
  def create_subscription(params) do
    case   Braintree.Subscription.create(params) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
    end
  end

  #update subscription
  def update_subscription(subscription_id, params, opts \\ []) do
    case   Braintree.Subscription.update(subscription_id, params, opts) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
    end
  end

  #find subscription
  def find_subscription(subscription_id) do
    case   Braintree.Subscription.find(subscription_id) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
    end
  end

  #retry_charge subscription
  def retry_charge_subscription(subscription_id, params) do
    case   Braintree.Subscription.retry_charge(subscription_id, params) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
    end
  end

  #cancel subscription
  def cancel_subscription(subscription_id) do
    case   Braintree.Subscription.cancel(subscription_id) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
    end
  end

end
