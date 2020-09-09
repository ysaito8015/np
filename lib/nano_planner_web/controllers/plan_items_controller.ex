defmodule NanoPlannerWeb.PlanItemsController do
  use NanoPlannerWeb, :controller

  def index(conn, _params) do
    plan_items = NanoPlanner.Repo.all(NanoPlanner.PlanItem)
    render conn, "index.html", plan_items: plan_items
  end
end
