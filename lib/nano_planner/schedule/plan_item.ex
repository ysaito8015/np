defmodule NanoPlanner.Schedule.PlanItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plan_items" do
    field :name, :string
    field :description, :string
    field :starts_at, :utc_datetime
    field :ends_at, :utc_datetime

    timestamps([type: :utc_datetime])
  end

  @doc false
  def changeset(plan_item, attrs) do
    plan_item
    |> cast(attrs, [])
    |> validate_required([])
  end

  def convert_datetime(items) do
    alias Timex.Timezone

    time_zone = Application.get_env(:nano_planner, :default_time_zone)

    Enum.map items, fn(item) ->
      Map.merge(item, %{
        starts_at: Timezone.convert(item.starts_at, time_zone),
        ends_at: Timezone.convert(item.ends_at, time_zone)
      })
    end
  end
end
