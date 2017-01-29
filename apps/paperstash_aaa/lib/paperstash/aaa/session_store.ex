defmodule PaperStash.SessionStore do
  @moduledoc ~S"""
  """

  use GenServer

  #
  # Client
  #

  @spec create(PaperStash.User.t) :: {:ok, PaperStash.Session.t} | no_return
  @doc "Synchronously creates a new session for `user`."
  def create(%PaperStash.User{} = user) do
    {:ok, session} = GenServer.call(__MODULE__, {:create, user.id})
    session
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

  @spec invalidate_for_user(PaperStash.User.t) :: :ok
  @doc "Invalidates all sessions for a particular `user`."
  def invalidate_for_user(%PaperStash.User{} = user) do
    GenServer.call(__MODULE__, {:invalidate_for_user, user.id})
  end

  @doc "Asynchronously prunes expired sessions."
  def vacuum do
    GenServer.cast(__MODULE__, :vacuum)
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
    {:reply, {:ok, session}, state}
  end

  def handle_call({:invalidate, id}, _, state) do
    :ets.delete(state.table, id)
    {:reply, :ok, state}
  end

  def handle_call({:invalidate_for_user, id}, _, state) do
    :ets.select_delete(state.table, [{{:'_', {%{user: id}, :_}}, [], [true]}])
    {:reply, :ok, state}
  end

  def handle_cast(:vacuum, state) do
    now = :os.system_time(:seconds)
    ms = [{{:"$0", {%{ttl: :"$1"}, :"$2"}},
           [{:is_integer, :"$1"}, {:is_integer, :"$2"},
            {:<, {:+, :"$1", :"$2"}, now + 1}], [true]}]
    :ets.select_delete(state.table, ms)
    {:noreply, state}
  end

  # TODO(mtwilliams): Persist on termination.
end
