defmodule SkillPotWeb.Components.Cards do
  @moduledoc """
  Card components
  """
  use Phoenix.Component

  attr :shadow, :boolean, default: false
  attr :border, :boolean, default: false
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <div class={[
      "card bg-base-200 p-6",
      @border && "card-border border-base-300",
      @shadow && "shadow"
    ]}>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
