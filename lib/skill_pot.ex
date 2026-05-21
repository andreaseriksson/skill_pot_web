defmodule SkillPot do
  @moduledoc """
  SkillPot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def env, do: Application.get_env(:skill_pot, :env)
  def test?, do: Application.get_env(:skill_pot, :env) == :test
  def dev?, do: Application.get_env(:skill_pot, :env) == :dev
  def prod?, do: Application.get_env(:skill_pot, :env) == :prod
end
