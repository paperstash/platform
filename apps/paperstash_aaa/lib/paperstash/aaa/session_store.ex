defmodule PaperStash.SessionStore do
  @moduledoc ~S"""
  """

  use GenServer

  #
  # Client
  #

  @spec create(PaperStash.User.t) :: {:ok, PaperStash.Session.id} | no_return
  @doc "Synchronously creates a new session for `user`."
  def create(%PaperStash.User{} = user) do
    {:ok, id} = GenServer.call(__MODULE__, {:create, user.id})
    id
  end

  @spec find(PaperStash.Session.id) :: Session.t | nil
  @doc "Looks up a session with `id."
  def find(id) do
    case :ets.lookup(__MODULE__, id) do
      [{^id, {session, timestamp}}] ->
        now = :os.system_time(:seconds)

        if (session.ttl + timestamp) <= now do
          session
        else
          # Expired.
          nil
        end

      [] ->
        nil
    end
  end


  @spec invalidate(PaperStash.Session.id) :: :ok
  @doc "Invalidates a session with `id`."
  def invalidate(id) do
    GenServer.call(__MODULE__, {:invalidate, id})
  end

  @doc "Asynchronously prunes expired sessions."
  def vacuum do
    GenServer.call(__MODULE__, :vacuum)
  end

  #
  # Server
  #

  defstruct [:table]

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    # TODO(mtwilliams): Tune this based on real performance...
    table = :ets.new(__MODULE__, [:named_table, :protected, write_concurrency: true, read_concurrency: true])
    {:ok, %__MODULE__{table: table}}
  end

  def handle_call({:create, user}, _, state) do
    now = :os.system_time(:seconds)
    session = PaperStash.Session.new(user)
    :ets.insert(state.table, {session.id, {session, now}})
    {:reply, {:ok, session.id}, state}
  end

  def handle_call({:invalidate, id}, _, state) do
    :ets.delete(state.table, id)
    {:reply, :ok, state}
  end

  def handle_call(:vacuum, _, state) do
    Task.start_link(fn -> vacuum(state.table) end)
    {:reply, :ok, state}
  end

  # TODO(mtwilliams): Persist on termination.

  defp vacuum(table), do: vacuum(table, :ets.first(table))
  defp vacuum(table, :"$end_of_table"), do: :ok
  defp vacuum(table, session) do
    case :ets.lookup(table, session) do
      [{^session, {session, timestamp}}] ->
        now = :os.system_time(:seconds)

        if (session.ttl + timestamp) >= now do
          # Expired.
          :ets.delete(table, session.id)
        end

      _ ->
        :ok
    end

    vacuum(table, :ets.next(table, session))
  end
end
