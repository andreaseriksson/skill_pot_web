defmodule SkillPot.Schema do
  @moduledoc """
  This module can be included in Schema file and used
  like `use SkillPot.Schema` instead of `use Ecto.Schema`.
  That makes is possible to remove the specification about key type.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
    end
  end
end
