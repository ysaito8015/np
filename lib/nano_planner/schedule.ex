defmodule NanoPlanner.Schedule do
  @moduledoc """
  The Schedule context.
  """

  import Ecto.Query, warn: false
  alias NanoPlanner.Repo

  alias NanoPlanner.Schedule.PlanItem

  @doc """
  Returns the list of plan_items.

  ## Examples

      iex> list_plan_items()
      [%PlanItem{}, ...]

  """
  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
    |> Repo.all()
    |> PlanItem.convert_datetime
  end

  @doc """
  Gets a single plan_item.

  Raises `Ecto.NoResultsError` if the Plan item does not exist.

  ## Examples

      iex> get_plan_item!(123)
      %PlanItem{}

      iex> get_plan_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plan_item!(id), do: Repo.get!(PlanItem, id)

  @doc """
  Creates a plan_item.

  ## Examples

      iex> create_plan_item(%{field: value})
      {:ok, %PlanItem{}}

      iex> create_plan_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plan_item(attrs \\ %{}) do
    %PlanItem{}
    |> PlanItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plan_item.

  ## Examples

      iex> update_plan_item(plan_item, %{field: new_value})
      {:ok, %PlanItem{}}

      iex> update_plan_item(plan_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plan_item(%PlanItem{} = plan_item, attrs) do
    plan_item
    |> PlanItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plan_item.

  ## Examples

      iex> delete_plan_item(plan_item)
      {:ok, %PlanItem{}}

      iex> delete_plan_item(plan_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plan_item(%PlanItem{} = plan_item) do
    Repo.delete(plan_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plan_item changes.

  ## Examples

      iex> change_plan_item(plan_item)
      %Ecto.Changeset{data: %PlanItem{}}

  """
  def change_plan_item(%PlanItem{} = plan_item, attrs \\ %{}) do
    PlanItem.changeset(plan_item, attrs)
  end
end
