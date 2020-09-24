defmodule NanoPlannerWeb.PlanItemController do
  use NanoPlannerWeb, :controller
  alias NanoPlanner.Schedule

  def index(conn, _params) do
    plan_items = Schedule.list_plan_items()
    render(conn, "index.html", plan_items: plan_items)
  end

  def new(conn, _params) do
    plan_item = Schedule.build_plan_item
    changeset = Schedule.change_plan_item(plan_item)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _params) do
    redirect(conn, to: Routes.plan_item_path(conn, :index))
  end

  def show(conn, params) do
    plan_item = Schedule.get_plan_item!(params["id"])
    render(conn, "show.html", plan_item: plan_item)
  end
end
