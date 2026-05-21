defmodule SkillPotWeb.Components.Modals do
  @moduledoc """
  Shared modal components.
  """
  use Phoenix.Component
  use Gettext, backend: SkillPotWeb.Gettext
  alias Phoenix.LiveView.JS

  @doc """
  Renders a modal.

  ## Examples

      <.modal id="confirm-modal">
        This is a modal.
      </.modal>

  JS commands may be passed to the `:on_cancel` to configure
  the closing/cancel event, for example:

      <.modal id="confirm" on_cancel={JS.navigate(~p"/posts")}>
        This is another modal.
      </.modal>

  """
  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}

  attr :closeable, :boolean, default: true
  attr :max_width, :string, default: "md:max-w-3xl"

  slot :inner_block, required: true
  slot :title

  def modal(assigns) do
    ~H"""
    <.conditional_portal id={"modal-portal-#{@id}"} target="#modal-root">
      <dialog
        :if={@show}
        id={@id}
        phx-hook="Modal"
        phx-mounted={
          @show &&
            JS.ignore_attributes("open")
            |> JS.dispatch("open-dialog", to: "##{@id}")
            |> JS.focus_first(to: "##{@id}-container")
        }
        phx-remove={
          JS.dispatch("close-dialog", to: "##{@id}")
          |> JS.pop_focus()
          |> JS.transition("dummy-class-to-delay-push-navigate",
            to: "##{@id}",
            time: 300
          )
        }
        data-cancel={@on_cancel}
        data-closeable={@closeable && "true"}
        class="modal"
      >
        <div class={["modal-box p-0 border bg-base-200 border-base-300 text-left", @max_width]}>
          <form :if={@closeable && @title in [nil, []]} method="dialog">
            <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
          </form>
          <header
            :if={@title != []}
            class="flex items-center justify-between px-6 py-4 border-b rounded-t border-base-300"
          >
            <h3 class="text-left text-lg font-semibold text-base-content">
              {render_slot(@title)}
            </h3>
            <form :if={@closeable} method="dialog">
              <button class="btn btn-sm btn-circle btn-ghost">✕</button>
            </form>
          </header>

          <.focus_wrap id={"#{@id}-container"} class="p-6 space-y-6">
            {render_slot(@inner_block)}
          </.focus_wrap>
        </div>

        <form method="dialog" class="modal-backdrop backdrop-blur-sm">
          <button :if={@closeable}>{gettext("close")}</button>
        </form>
      </dialog>
    </.conditional_portal>
    """
  end

  defp conditional_portal(assigns) do
    if SkillPot.test?() do
      ~H"{render_slot(@inner_block)}"
    else
      ~H"""
      <.portal id={"modal-portal-#{@id}"} target="#modal-root">
        {render_slot(@inner_block)}
      </.portal>
      """
    end
  end
end
