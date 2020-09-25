defmodule NanoPlanner.Schedule do
  import Ecto.Query, warn: false
  alias NanoPlanner.Repo

  alias NanoPlanner.Schedule.PlanItem

  def list_plan_items do
    PlanItem
    |> order_by(asc: :starts_at, asc: :ends_at, asc: :id)
    |> Repo.all()
    |> convert_datetime()
  end

  def get_plan_item!(id) do
    Repo.get!(PlanItem, id)
    |> convert_datetime()
  end

  def build_plan_item do
    time0 = beginning_of_hour()

    %PlanItem{
      starts_at: Timex.shift(time0, hours: 1),
      ends_at: Timex.shift(time0, hours: 2)
    }
  end

  defp beginning_of_hour do
    Timex.set(current_time(), minute: 0, second: 0, microsecond: {0, 0})
  end

  defp current_time do
    Timex.now(time_zone())
  end

  defp time_zone do
    Application.get_env(:nano_planner, :default_time_zone)
  end

  def create_plan_item(attrs) do
    #attrs = %{attrs | "starts_at" => Timex.Timezone.convert(Timex.parse!(attrs["starts_at"], "{RFC3339}"), "Etc/UTC")}
    #attrs = %{attrs | "ends_at" => Timex.Timezone.convert(Timex.parse!(attrs["ends_at"], "{RFC3339}"), "Etc/UTC")}
    item = %PlanItem{}
    fields = [:name, :description, :starts_at, :ends_at]
    cs = Ecto.Changeset.cast(item, attrs, fields)
    Repo.insert!(cs)
  end

  def change_plan_item(%PlanItem{} = item) do
    PlanItem.changeset(item, %{})
  end

  defp convert_datetime(items) when is_list(items) do
    Enum.map(items, &convert_datetime(&1))
  end

  defp convert_datetime(%PlanItem{} = item) do
    alias Timex.Timezone

    Map.merge(item, %{
      starts_at: Timezone.convert(item.starts_at, time_zone()),
      ends_at: Timezone.convert(item.ends_at, time_zone())
    })
  end

  defp convert_to_utc(attrs) do
    alias Timex.Timezone

    Map.merge(attrs, %{
      "starts_at" => attrs["starts_at"]
      |> Timezone.convert("Etc/UTC"),
      "ends_at" => attrs["ends_at"]
      |> Timezone.convert("Etc/UTC")
    })
  end
end
