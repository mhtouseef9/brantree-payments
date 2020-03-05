defmodule PaymentsWeb.TransactionController do
  use PaymentsWeb, :controller
  alias Payments.Payment
  alias Payments.Transactions.Transaction

#server side functions
  #generate a client_token to initiate client sdk to get payment information
  def generate_client_token(cmr_id, branch_id, %{merchant_account_id: merchant_account_id} = params) do
    case Braintree.ClientToken.generate(params) do
      {:ok, token} -> Payment.create_token(%{client_token: token, cmr_id: cmr_id, branch_id: branch_id})
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end

  #creating a sale transaction
  def create_transaction(%{amount: amount, payment_method_nonce: payment_method_nonce} = params) do
    case Braintree.Transaction.sale(params) do
      {:ok, transaction} -> generate_transaction(transaction)
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end
  defp generate_transaction(params) do
    params = Map.from_struct(params)    #converts struct to map (that struct is returned from creating transaction)

    #we have to fetch transactions on the base of user name, Its is present in object of status_history field
    #writting expression is tough, so we got that user name and stored in a separate field , easy fetching by simple comparison now

    user_name = List.last(params.status_history)["user"]    #getting user name of transaction
    params = Map.put(params, :user_name,  user_name)  #putting that user name to map to insert in database
    Payment.create_transaction(params)
  end

  #fetches transactions by
  def get_transactions_by_user(%{user_name: user_name} = params) do
    case Payment.get_transactions_by_user(user_name) do
      [] -> {:ok, "There is no transaction against #{user_name}"}
      [%Transaction{} | _] = transactions ->  {:ok, transactions}
      {:error, error} -> {:error, error}
       _ -> {:error, "unexpected error occurred"}
    end
  end

  #transaction can be voided only if transaction_status is authorized or submitted_for_settlement or settlement_pending
  def void_transaction(transaction_id) do
    case Braintree.Transaction.void(transaction_id) do
      {:ok, transaction} -> {:ok, transaction}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end

  #transaction can be refunded only if transaction_status is settled
  def refund_transaction(%{transaction_id: id, amount: amount} = params) do
    case Braintree.Transaction.refund(id, %{amount: amount}) do
      {:ok, transaction} -> {:ok, transaction}
      {:error, error} -> {:error, error}
    end
  end

#client side functions
  #create customer
  def create_customer(params) do
    case Braintree.Customer.create(params) do
      {:ok, customer} -> {:ok, customer}
      {:error, error} -> {:error, error}
      _ -> {:error, "unexpected error occurred"}
    end
  end
  #create payment_method
  def create_payment_method(%{customer_id: customer_id} = params) do
    case Braintree.PaymentMethod.create(params) do
      {:ok, payment_method} -> {:ok, payment_method}
      {:error, error} -> {:error, error}
      _ -> {:error, "unexpected error occurred"}
    end
  end
  #create create_payment_method_nonce
  def create_payment_method_nonce(payment_method_token) do
    case Braintree.PaymentMethodNonce.create(payment_method_token) do
      {:ok, nonce} -> {:ok, nonce}
      {:error, error} -> {:error, error}
      _ -> {:error, "unexpected error occurred"}
    end
  end



#get requests

  def get_brain_tree_customer(customer_id) do
    case Braintree.Customer.find(customer_id) do
      {:ok, customer} -> {:ok, customer}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end
  def get_brain_tree_payment_method(token) do
    case Braintree.PaymentMethod.find(token) do
      {:ok, payment_method} -> {:ok, payment_method}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end
  def get_brain_tree_paypal_account(token) do
    case Braintree.PaypalAccount.find(token) do
      {:ok, paypal_account} -> {:ok, paypal_account}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end
  def get_brain_tree_transaction(transaction_id) do
    case Braintree.Transaction.find(transaction_id) do
      {:ok, transaction} -> {:ok, transaction}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end
  def get_brain_tree_subscription(subscription_id) do
    case Braintree.Subscription.find(subscription_id) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, error} -> {:error, error}
      _ -> {:error, ["unexpected error occurred"]}
    end
  end

end
