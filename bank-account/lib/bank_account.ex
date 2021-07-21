defmodule BankAccount do
  use GenServer
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start_link(__MODULE__, :ok, [])
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.call(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def handle_call(:balance, _from, %{balance: balance} = account) do
    {:reply, balance, account}
  end

  def handle_call({:update, amount}, _from, %{balance: balance}) do
    new_amount = balance + amount
    {:reply, new_amount, %{balance: new_amount}}
  end
end
