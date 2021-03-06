defmodule CodeFund.Users do
  @roles [Admin: "admin", Developer: "developer", Sponsor: "sponsor"]
  import Ecto.Query
  alias CodeFund.Repo
  alias CodeFund.Schema.User

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    CodeFund.Schema.User
    |> Repo.get!(id)
  end

  def get_by_role(role) do
    from(u in User, where: ^role in u.roles) |> Repo.all()
  end

  def roles, do: @roles

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def has_role?(existing_roles, target_roles) do
    Enum.any?(target_roles, fn role ->
      Enum.member?(existing_roles, role)
    end)
  end
end
